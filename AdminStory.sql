--ADMIN STORY

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
INSERT INTO Users(username,email) VALUES (@delivery_username,@delivery_email)
INSERT INTO Delivery_Person VALUES(@delivery_username,'0') --insert in the system as deactivated

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
INSERT INTO Delivery(time_duration, fees, username, delivery_type) --because ID can't be inserted so I 
VALUES (@time_duration,@fees,@admin_username,@delivery_type)
--delivery type eh elkalam?? 
--n7ottaha b3on Allah


GO
CREATE PROC assignOrdertoDelivery --f ,, delivery window?? handled on Del_Per Story
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username) 
VALUES (@delivery_username,@order_no,@admin_username)

GO
CREATE PROC createTodaysDeal --g1
@deal_amount INT,
@admin_username VARCHAR(20),
@expiry_date DATETIME
AS
INSERT INTO Todays_Deals (deal_amount, expiry_date, admin_username)
VALUES(@deal_amount ,@expiry_date,@admin_username)

--g2,g3,g4,h,i left
--ESLAM Do the following:

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
INSERT INTO Giftcard
VALUES(@code,@expiry_date,@amount,@admin_username)
END

GO
CREATE PROC removeExpiredGiftCard --I1
@code VARCHAR(10)
AS
BEGIN

--TODOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO


END


GO
CREATE PROC giveGiftCardtoCustomer --i3
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS
BEGIN
DECLARE @cardAmount INT;
SELECT @cardAmount = amount
FROM Giftcard
WHERE code=@code;
INSERT INTO Admin_Customer_Giftcard
VALUES(@code,@customer_name,@admin_username,@cardAmount);	--Does this work ?
END

