
--ADMIN STORY
GO
CREATE PROC activateVendors --a
@admin_username varchar(20),
@vendor_username varchar(20)
AS
BEGIN
IF (EXISTS(SELECT * FROM Vendor WHERE username=@vendor_username AND activated='0'))
UPDATE Vendor
SET activated='1',admin_username=@admin_username
FROM Vendor
WHERE username=@vendor_username
ELSE 
print 'This vendor account is already activated ' --|| MAYBE NO SUCH VENDOR ? :p <3 
END

GO
CREATE PROC inviteDeliveryPerson --b ,recheck
@delivery_username varchar(20), @delivery_email varchar(50)
AS
BEGIN
IF(@delivery_username NOT IN(SELECT username FROM Users )AND 
@delivery_email NOT IN(SELECT email FROM Users)) --updated (duplicates)
BEGIN
INSERT INTO Users(username,email) VALUES (@delivery_username,@delivery_email)
INSERT INTO Delivery_Person VALUES(@delivery_username,'0') --insert in the system as deactivated
END
END

GO
CREATE PROC reviewOrders --c
AS
SELECT * FROM Orders

GO
CREATE PROC updateOrderStatusInProcess --d
@order_no int
AS
UPDATE Orders
SET order_status='in process'
FROM Orders
WHERE order_no=@order_no

GO
CREATE PROC addDelivery --e
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
AS
IF(@admin_username IN (SELECT username FROM Admins))
INSERT INTO Delivery(time_duration, fees, username, delivery_type) --because ID can't be inserted so I 
VALUES (@time_duration,@fees,@admin_username,@delivery_type)
--delivery type eh elkalam?? 
--n7ottaha b3on Allah


GO
CREATE PROC assignOrdertoDelivery --f
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
BEGIN
	IF(@delivery_username IN(SELECT username FROM Delivery_Person) 
		AND @order_no IN(SELECT order_no FROM Orders)
		AND @admin_username IN(SELECT username FROM Admins)
		AND (NOT EXISTS (SELECT delivery_username,order_no FROM Admin_Delivery_Order 
						WHERE @delivery_username=delivery_username AND @order_no=order_no)
			)
		)
		BEGIN
			INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username) 
				VALUES (@delivery_username,@order_no,@admin_username)
		END
END

GO
CREATE PROC createTodaysDeal --g1
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME
AS
BEGIN
	IF(@admin_username IN(SELECT username FROM Admins))
		BEGIN
			INSERT INTO Todays_Deals (deal_amount, expiry_date, admin_username)
				VALUES(@deal_amount ,@expiry_date,@admin_username)
		END
END

GO 
CREATE PROC checkTodaysDealOnProduct	--g2
@serial_no INT,
@activeDeal BIT OUTPUT
AS
BEGIN
	IF ( EXISTS (
		SELECT *
		FROM Todays_Deals_Product TDP , Todays_Deals TD
		WHERE TDP.serial_no=@serial_no AND 
			TDP.deal_id=TD.deal_id AND 
			TD.expiry_date>CURRENT_TIMESTAMP 
		)
	)
		SET @activeDeal = '1'
	ELSE
		SET @activeDeal = '0'
END

GO
CREATE PROC addTodaysDealOnProduct	--g3
@deal_id INT, 
@serial_no INT
AS
BEGIN
	IF(@serial_no IN(SELECT serial_no FROM Product)AND
	@deal_id NOT IN(SELECT deal_id FROM Todays_Deals_Product)AND
	@deal_id IN(SELECT deal_id FROM Todays_Deals))
		INSERT INTO Todays_Deals_Product
			VALUES (@deal_id,@serial_no,CURRENT_TIMESTAMP)
END

GO
CREATE PROC removeExpiredDeal	--g4
@deal_iD int
AS
BEGIN
	DELETE FROM Todays_Deals
		WHERE deal_id=@deal_iD AND expiry_date<CURRENT_TIMESTAMP
END

GO
CREATE PROC createGiftCard	--h
@code VARCHAR(10),
@expiry_date DATETIME,
@amount INT,
@admin_username VARCHAR(20)
AS
BEGIN
	IF(@admin_username IN(SELECT username FROM Admins)AND
	@code NOT IN(SELECT code FROM Giftcard))
		INSERT INTO Giftcard
			VALUES(@code,@expiry_date,@amount,@admin_username)
END

GO
CREATE PROC removeExpiredGiftCard --I1
@code VARCHAR(10)
AS
BEGIN
	DECLARE @rempo INT
	SELECT @rempo=remaining_points
		FROM Admin_Customer_Giftcard
		WHERE code=@code

	UPDATE Customer  -- mesh sha8al
		SET points=points-@rempo			-- may try set points = (SELECT points....) - @rempo ?
		FROM Customer INNER JOIN Admin_Customer_Giftcard a ON username=a.customer_name
		WHERE a.code=@code

	DELETE FROM Admin_Customer_Giftcard
		WHERE code IN (SELECT code FROM Giftcard WHERE @code=code AND CURRENT_TIMESTAMP >expiry_date)

	DELETE FROM Giftcard
		WHERE CURRENT_TIMESTAMP >expiry_date AND @code =code
END

--i2





/*GO 
CREATE PROC removeExpiredGiftCard 
@code VARCHAR(10)
AS
DECLARE @todaysDate DATETIME
SELECT @todaysDate = GETDATE()
UPDATE Customer
SET points = points - (SELECT a.remaining_points
FROM Admin_Customer_Giftcard a
WHERE a.code = @code AND a.customer_name = username)
WHERE username  IN (
SELECT c.username , acg.remaining_points
FROM Customer c INNER JOIN Admin_Customer_Giftcard acg
ON c.username = acg.customer_name
INNER JOIN Giftcard gc 
ON gc.code = acg.code
WHERE gc.code = @code AND @todaysDate >=gc.expiry_date)
DELETE FROM Admin_Customer_Giftcard
WHERE code = @code
DELETE FROM Giftcard
WHERE code=@code AND @todaysDate >= expiry_date
*/

GO --ana mesh fahem howa 3ayez eh fa hal haza sa7i7
CREATE PROC checkGiftCardOnCustomer
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS

IF(EXISTS(SELECT customer_name FROM Admin_Customer_Giftcard WHERE code=@code))
SET @activeGiftCard='1'
ELSE
SET @activeGiftCard='0'




GO
CREATE PROC giveGiftCardtoCustomer --i3
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS
BEGIN
	DECLARE @points INT 
	SELECT @points = amount
		FROM Giftcard 
		WHERE code = @code

	INSERT INTO Admin_Customer_Giftcard
		VALUES(@code,@customer_name,@admin_username,@points);

	DECLARE @oldpoints INT
	SELECT @oldpoints =points
		FROM Customer
		WHERE username=@customer_name


	UPDATE Customer
	SET points = @oldpoints + @points
	WHERE  username = @customer_name   

END
--drop proc giveGiftCardtoCustomer