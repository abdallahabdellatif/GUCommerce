-- start 1:tables

GO
CREATE TABLE Users(
username VARCHAR(20), 
first_name VARCHAR(20), 
last_name VARCHAR(20),  
password VARCHAR(20),
email VARCHAR(50),
PRIMARY KEY (username),
CONSTRAINT email_unique UNIQUE(email)
);

CREATE TABLE User_mobile_numbers(
mobile_number VARCHAR(20), 
username VARCHAR(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) REFERENCES Users --ON DELETE CASCADE ON UPDATE CASCADE,
-- same mobile number may belong to more than one user ; so won't make it UNIQUE
);

CREATE TABLE User_Addresses(
address VARCHAR(100), 
username VARCHAR(20)
PRIMARY KEY(address,username),
FOREIGN KEY(username) REFERENCES Users -- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Customer(
username VARCHAR(20), 
points INT default 0 NOT NULL,
-- should we add default value 0 for points ?
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admins(
username VARCHAR(20),
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Vendor(
username VARCHAR(20) , 
activated BIT,						-- Not mentioned explicitly
company_name VARCHAR(20), 
bank_acc_no VARCHAR(20), 
admin_username VARCHAR(20),
PRIMARY KEY (username),
FOREIGN KEY(username) REFERENCES Users, --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins -- ON UPDATE CASCADE
--TODO : Trigger ?
--WHAT SHOULD WE DO HERE if an Admin is DELETED !? TAKE CARE
);

CREATE TABLE Delivery_Person(
username VARCHAR(20), 
is_activated BIT --NOT MENTIONED EXPLICITLY
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES Users  --ON DELETE CASCADE ON UPDATE CASCADE
);

GO
--drop trigger User_delete
CREATE TRIGGER User_delete
ON Users
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM User_mobile_numbers WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM User_Addresses WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Admins WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Vendor WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Customer WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Delivery_Person WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Users WHERE username IN (SELECT username FROM DELETED)
END

GO
CREATE TRIGGER User_update
ON Users
AFTER UPDATE
AS
BEGIN
IF UPDATE(username) 
	BEGIN
		UPDATE  User_mobile_numbers 
			SET username = inserted.username 
			FROM User_mobile_numbers,deleted,inserted 
			WHERE deleted.username= User_mobile_numbers.username
		UPDATE User_Addresses
			SET username = inserted.username
			FROM User_Addresses,deleted,inserted
			WHERE deleted.username=User_Addresses.username
		UPDATE Admins 
			SET username = inserted.username
			FROM Admins,deleted,inserted
			WHERE deleted.username=Admins.username
		UPDATE Vendor 
			SET username = inserted.username
			FROM Vendor,deleted,inserted
			WHERE deleted.username=Vendor.username
		UPDATE Customer 
			SET username = inserted.username
			FROM Customer,deleted,inserted
			WHERE deleted.username=Customer.username
		UPDATE Delivery_Person 
			SET username = inserted.username
			FROM Delivery_Person ,deleted,inserted
			WHERE deleted.username=Delivery_Person.username
	END
END

GO
--DROP TRIGGER Admin_delete
CREATE TRIGGER Admin_delete
ON Admins
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Vendor WHERE admin_username IN (SELECT username FROM DELETED)
	DELETE FROM Delivery WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Todays_Deals WHERE admin_username IN (SELECT username FROM DELETED)
	DELETE FROM Giftcard WHERE username IN (SELECT username FROM DELETED)
	DELETE FROM Admin_Customer_Giftcard WHERE admin_username IN (SELECT username FROM DELETED)
	DELETE FROM Admin_Delivery_Order WHERE admin_username IN (SELECT username FROM DELETED)
	DELETE FROM Admins WHERE username IN (SELECT username FROM DELETED)
--DELETE FROM Users WHERE username IN (SELECT username FROM DELETED)
END
GO


CREATE TRIGGER Admin_update
ON Admins
AFTER UPDATE
AS
BEGIN
IF UPDATE(username)
	BEGIN
		UPDATE Vendor 
			SET username = inserted.username
			FROM Vendor,deleted,inserted
			WHERE deleted.username=Vendor.username
		UPDATE Delivery 
			SET username = inserted.username
			FROM Delivery,deleted,inserted
			WHERE deleted.username=Delivery.username
		UPDATE Todays_Deals 
			SET admin_username = inserted.username
			FROM Todays_Deals,deleted,inserted
			WHERE deleted.username=Todays_Deals.admin_username
		UPDATE Giftcard 
			SET username = inserted.username
			FROM Giftcard,deleted,inserted
			WHERE deleted.username=Giftcard.username
		UPDATE Admin_Customer_Giftcard 
			SET admin_username = inserted.username
			FROM Admin_Customer_Giftcard ,deleted,inserted
			WHERE deleted.username=Admin_Customer_Giftcard.admin_username
		UPDATE Admin_Delivery_Order
			SET admin_username = inserted.username
			FROM Admin_Delivery_Order ,deleted,inserted
			WHERE deleted.username=Admin_Customer_Giftcard.admin_username
	END
END
GO


--drop trigger Customer_delete
CREATE TRIGGER Customer_delete
ON Customer
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM Orders WHERE customer_name IN (SELECT username FROM DELETED);
	DELETE FROM Product WHERE customer_username IN (SELECT username FROM DELETED);
	DELETE FROM CustomerAddstoCartProduct WHERE customer_name IN (SELECT username FROM DELETED);
	DELETE FROM Customer_Question_Product WHERE customer_name IN (SELECT username FROM DELETED);
	DELETE FROM Wishlist WHERE username IN (SELECT username FROM DELETED);
	DELETE FROM Admin_Customer_Giftcard WHERE customer_name IN (SELECT username FROM DELETED);
	DELETE FROM Customer_CreditCard WHERE customer_name IN (SELECT username FROM DELETED);
	DELETE FROM Customer WHERE username IN (SELECT username FROM DELETED)
END

GO
CREATE TRIGGER Customer_update
ON Customer
AFTER UPDATE
AS
BEGIN
IF UPDATE(username)
	BEGIN
		UPDATE Orders 
			SET customer_name = inserted.username
			FROM Orders,inserted,deleted
			WHERE deleted.username=Orders.customer_name
		UPDATE Product 
			SET customer_username = inserted.username
			FROM Product,inserted,deleted
			WHERE deleted.username = Product.customer_username
		UPDATE CustomerAddstoCartProduct
			SET customer_name = inserted.username
			FROM CustomerAddstoCartProduct ,inserted,deleted
			WHERE deleted.username=CustomerAddstoCartProduct.customer_name
		UPDATE Customer_Question_Product 
			SET customer_name = inserted.username
			FROM Customer_Question_Product ,inserted,deleted
			WHERE deleted.username=Customer_Question_Product.customer_name
		UPDATE Wishlist 
			SET username = inserted.username
			FROM Wishlist,inserted,deleted
			WHERE deleted.username = Wishlist.username	
		UPDATE Admin_Customer_Giftcard 
			SET customer_name = inserted.username
			FROM Admin_Customer_Giftcard, inserted,deleted
			WHERE deleted.username=Admin_Customer_Giftcard.customer_name
		UPDATE Customer_CreditCard 
			SET customer_name = inserted.username
			FROM Customer_CreditCard , inserted,deleted
			WHERE deleted.username=Customer_CreditCard.customer_name
	END
END

GO
CREATE TRIGGER Vendor_delete
ON Vendor
INSTEAD OF DELETE
AS
BEGIN
DELETE FROM Product WHERE vendor_username IN (SELECT username FROM DELETED)
DELETE FROM Vendor WHERE username IN (SELECT username FROM DELETED)
END

GO
CREATE TRIGGER Vendor_update
ON Vendor
AFTER UPDATE
AS
BEGIN
IF UPDATE(username)
	BEGIN
		UPDATE Product 
			SET vendor_username=inserted.username
			FROM Product,inserted,deleted
			WHERE deleted.username=Product.vendor_username
	END
END


GO
--drop trigger DeliveryPerson_delete
CREATE TRIGGER DeliveryPerson_delete
ON Delivery_Person
INSTEAD OF DELETE
AS
BEGIN
--is admin_delivery_order true to be deleted ?
DELETE FROM Admin_Delivery_Order WHERE delivery_username IN (SELECT username FROM DELETED)
DELETE FROM Delivery_Person WHERE username IN (SELECT username FROM DELETED)
END

GO
CREATE TRIGGER DeliveryPerson_update
ON Delivery_Person
AFTER UPDATE
AS
BEGIN
IF UPDATE(username)
	BEGIN
		UPDATE Admin_Delivery_Order 
			SET delivery_username=inserted.username
			FROM Admin_Delivery_Order, inserted, deleted
			WHERE deleted.username=Admin_Delivery_Order.delivery_username
	END
END


GO
CREATE TABLE Giftcard(
code VARCHAR(10),
expiry_date DATETIME,
amount INT, 
username VARCHAR(20),
PRIMARY KEY (code),
FOREIGN KEY (username) REFERENCES Admins
);

CREATE TABLE Credit_Card(
number VARCHAR(20),
expiry_date DATE,--what ?, 
cvv_code VARCHAR(4),
PRIMARY KEY (number)
);


CREATE TABLE Delivery(
id INT IDENTITY, --Not mentioned explicitly
time_duration INT NOT NULL, 
fees DECIMAL (5,3) NOT NULL, 
username VARCHAR(20),
delivery_type VARCHAR(20),  
-- should we make it 2nd attr; to MATCH FinalSchema ?
PRIMARY KEY (id),
FOREIGN KEY (username) REFERENCES Admins
);


CREATE TABLE Orders(
order_no INT IDENTITY, 
order_date DATETIME, 
total_amount decimal(10,2), 
cash_amount DECIMAL(10,2),
credit_amount DECIMAL(10,2),
payment_type VARCHAR(20), 
order_status VARCHAR(20) DEFAULT 'not processed' ,	
remaining_days INT,  -- Mentioned in (s) in page 4 
time_limit VARCHAR(20) , 	--BALABIZO ;; WHAT IS THIS !!?
Gift_Card_code_used VARCHAR(10),
customer_name VARCHAR(20), 
delivery_id INT, 
creditCard_number VARCHAR(20),
PRIMARY KEY (order_no),
FOREIGN KEY (Gift_Card_code_used) REFERENCES Giftcard ON DELETE SET NULL ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer,
FOREIGN KEY (delivery_id) REFERENCES Delivery ON DELETE SET NULL ON UPDATE CASCADE, -- is it so?,
FOREIGN KEY (creditCard_number) REFERENCES Credit_Card ON DELETE NO ACTION ON UPDATE CASCADE 
	-- I THINK THE LAST SHOULD BE NO ACTION ???
);

CREATE TABLE Product(
serial_no INT IDENTITY,
product_name VARCHAR(20),
category VARCHAR(20),
product_description VARCHAR(200),--text,
price DECIMAL (10,2),
final_price DECIMAL(10,2),	--On (a) and (c) in page 5
color VARCHAR (20), 		--on (a) page 5
available BIT , -- didn't mention type
rate INT, -- (n) in page +4+
vendor_username VARCHAR(20), 
customer_username VARCHAR(20), 
customer_order_id INT,
PRIMARY KEY(serial_no),
FOREIGN KEY(vendor_username) REFERENCES Vendor, --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_username) REFERENCES Customer, -- ON DELETE CASCADE ON UPDATE CASCADE, 
FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE 
);


CREATE TABLE CustomerAddstoCartProduct(
serial_no INT, 
customer_name VARCHAR (20),
PRIMARY KEY (serial_no,customer_name),
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Todays_Deals(
deal_id INT IDENTITY,
deal_amount INT,
expiry_date DATETIME,
admin_username VARCHAR(20),
PRIMARY KEY (deal_id),
FOREIGN KEY (admin_username) REFERENCES Admins --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Todays_Deals_Product(
deal_id INT,
serial_no INT,
PRIMARY KEY (deal_id ,serial_no),
FOREIGN KEY (deal_id) REFERENCES Todays_Deals ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE offer(
offer_id INT IDENTITY,
offer_amount INT,
expiry_date DATETIME,
PRIMARY KEY (offer_id)
);


CREATE TABLE offersOnProduct(
offer_id INT,
serial_no INT,
PRIMARY KEY (offer_id , serial_no),
FOREIGN KEY (offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Customer_Question_Product(
serial_no INT,
customer_name VARCHAR(20),
question VARCHAR(50), -----question type is not stated	-- see (d) in page 2
answer TEXT,	--TRUE (y) <3
PRIMARY KEY (serial_no ,customer_name),
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Wishlist(
username VARCHAR (20),
name VARCHAR (20),
PRIMARY KEY (username , name),
FOREIGN KEY (username) REFERENCES Customer -- ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Wishlist_Product(
username VARCHAR (20),
wish_name VARCHAR (20),
serial_no INT,
PRIMARY KEY (username , wish_name , serial_no),
FOREIGN KEY (username , wish_name) REFERENCES WishList ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin_Customer_Giftcard(
code VARCHAR(10),
customer_name VARCHAR (20),
admin_username VARCHAR(20),
remaining_points INT,	--added after finSch(3)
PRIMARY KEY (code , customer_name ,admin_username),
FOREIGN KEY (code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer , --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (admin_username) REFERENCES Admins --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Admin_Delivery_Order(
delivery_username VARCHAR (20),
order_no INT,
admin_username VARCHAR (20), 
delivery_window VARCHAR (50),	--(c) in page 7
PRIMARY KEY (delivery_username,order_no),
FOREIGN KEY (delivery_username) REFERENCES Delivery_person,-- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (order_no) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (admin_username) REFERENCES Admins --ON DELETE CASCADE ON UPDATE CASCADE);
);

CREATE TABLE Customer_CreditCard(
customer_name VARCHAR(20), 
cc_number VARCHAR (20),
PRIMARY KEY (customer_name,cc_number),
FOREIGN KEY (customer_name) REFERENCES Customer ,-- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
);

GO
--end 1:tables


--2: ADMIN

go


--addded proc for ms3

GO
CREATE PROC showUnactiveVendors
AS
BEGIN
	SELECT username AS 'Vendor Username' 
	FROM Vendor
	WHERE activated='0'
END

GO
CREATE PROC vendorExists
@vendor VARCHAR(20),
@out Int OUTPUT
AS
BEGIN
	if(exists(select * from Vendor where username=@vendor))
	SET @out=1
	ELSE
	SET @out=0
END


GO
CREATE PROC updateOrderStatusInProcess --d
@order_no int,
@out INT OUTPUT
AS
BEGIN
if(EXISTS(SELECT * FROM Orders WHERE order_no=@order_no))
BEGIN
	if((SELECT order_status FROM Orders WHERE @order_no=order_no)<>'in process')
	BEGIN
	SET @out=1
	UPDATE Orders
		SET order_status='in process'
		FROM Orders
		WHERE order_no=@order_no
	END
	ELSE
	SET @out=2
END
else
	SET @out=0
END


GO
CREATE PROC addTodaysDealOnProduct	
@deal_id INT, 
@serial_no INT,
@out INT OUTPUT
AS
BEGIN
	if(not exists(SELECT * FROM Todays_Deals_Product WHERE @deal_id=deal_id AND @serial_no=serial_no))
		BEGIN
		INSERT INTO Todays_Deals_Product
			VALUES (@deal_id,@serial_no)

		UPDATE Product
		SET final_price=price-(SELECT deal_amount FROM Todays_Deals WHERE deal_id=@deal_id)
		WHERE serial_no=@serial_no
		SET @out=1
		END
		else
		SET @out=0
END

GO 
CREATE PROC ProductExists
@serial_no INT,
@out int OUTPUT
AS
BEGIN

if(EXISTS(SELECT * FROM Product WHERE serial_no=@serial_no))
SET @out=1
else
set @out=0

END

GO
CREATE PROC TDealExists
@deal_id INT,
@out int OUTPUT
AS
BEGIN

if(EXISTS(SELECT * FROM Todays_Deals WHERE deal_id=@deal_id))
SET @out=1
else
set @out=0

END

GO 
CREATE PROC checkTodaysDealOnProduct	--g2
@serial_no INT,
@activeDeal INT OUTPUT
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
		BEGIN
			SET @activeDeal = 1
		END
	ELSE
		BEGIN
			SET @activeDeal = 0
		END
END


GO
CREATE PROC removeExpiredDeal	--g4
@deal_iD int ,
@out INT OUTPUT
AS
BEGIN
if(exists(SELECT * FROM Todays_Deals WHERE @deal_iD=deal_id AND expiry_date<CURRENT_TIMESTAMP))
	BEGIN
	UPDATE Product 
	SET final_price=price
	WHERE serial_no IN(SELECT tdp.serial_no FROM Todays_Deals_Product tdp INNER JOIN Todays_Deals td
	ON tdp.deal_id=td.deal_id
	WHERE td.deal_id=@deal_iD AND td.expiry_date<CURRENT_TIMESTAMP)

	DELETE FROM Todays_Deals_Product 
	WHERE deal_id=@deal_iD AND deal_id IN(SELECT tdp.deal_id FROM Todays_Deals_Product tdp INNER JOIN Todays_Deals td
	ON tdp.deal_id=td.deal_id
	WHERE td.deal_id=@deal_iD AND td.expiry_date<CURRENT_TIMESTAMP)

	DELETE FROM Todays_Deals
		WHERE deal_id=@deal_iD AND expiry_date<CURRENT_TIMESTAMP
	SET @out=1
	END
	ELSE
	SET @out=0
END

GO
CREATE PROC showAllProducts
AS
SELECT serial_no,product_name ,price,final_price
FROM Product

GO 
CREATE PROC showAllTDeals
As
SELECT deal_id,expiry_date
FROM Todays_Deals

GO
CREATE PROC whichUser
@user VARCHAR(20),
@out INT OUTPUT
AS
BEGIN

if(EXISTS(SELECT * FROM Customer WHERE username=@user))
SET @out=0
ELSE
	if(Exists(SELECT * FROM Vendor WHERE username=@user))
	SET @out=1
	ELSE
		SET @out=2

END
--ADMIN STORY
GO
CREATE PROC activateVendors --a
@admin_username varchar(20),
@vendor_username varchar(20)
AS
BEGIN
	UPDATE Vendor
		SET activated='1',admin_username=@admin_username
		FROM Vendor
		WHERE username=@vendor_username
END

GO
CREATE PROC inviteDeliveryPerson --b 
@delivery_username varchar(20), @delivery_email varchar(50)
AS
BEGIN
	INSERT INTO Users(username,email) VALUES (@delivery_username,@delivery_email)
	INSERT INTO Delivery_Person VALUES(@delivery_username,'0')
	
END

GO
CREATE PROC reviewOrders --c
AS
BEGIN
SELECT * FROM Orders
END

--GO
--CREATE PROC updateOrderStatusInProcess --d
--@order_no int
--AS
--BEGIN
--	UPDATE Orders
--		SET order_status='in process'
--		FROM Orders
--		WHERE order_no=@order_no
--END

GO
CREATE PROC addDelivery --e
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
AS
BEGIN
	IF(@admin_username IN (SELECT username FROM Admins))
		INSERT INTO Delivery(time_duration, fees, username, delivery_type) --because ID can't be inserted so I 
			VALUES (@time_duration,@fees,@admin_username,@delivery_type)
END

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

--GO 
--CREATE PROC checkTodaysDealOnProduct	--g2
--@serial_no INT,
--@activeDeal BIT OUTPUT
--AS
--BEGIN
--	IF ( EXISTS (
--		SELECT *
--		FROM Todays_Deals_Product TDP , Todays_Deals TD
--		WHERE TDP.serial_no=@serial_no AND 
--			TDP.deal_id=TD.deal_id AND 
--			TD.expiry_date>CURRENT_TIMESTAMP 
--		)
--	)
--		BEGIN
--			SET @activeDeal = '1'
--			print @activeDeal
--		END
--	ELSE
--		BEGIN
--			SET @activeDeal = '0'
--			print @activeDeal
--		END
--END

--GO
--CREATE PROC addTodaysDealOnProduct	--g3
--@deal_id INT, 
--@serial_no INT
--AS
--BEGIN
--	IF(@serial_no IN(SELECT serial_no FROM Product)AND
--	@deal_id NOT IN(SELECT deal_id FROM Todays_Deals_Product)AND
--	@deal_id IN(SELECT deal_id FROM Todays_Deals))
--		INSERT INTO Todays_Deals_Product
--			VALUES (@deal_id,@serial_no)
--END

--GO
--CREATE PROC removeExpiredDeal	--g4
--@deal_iD int
--AS
--BEGIN
--	DELETE FROM Todays_Deals
--		WHERE deal_id=@deal_iD AND expiry_date<CURRENT_TIMESTAMP

--END

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
	--check hena el time get el time we 7oto fy if
	UPDATE Customer
		SET points=c.points-a.remaining_points
		FROM Customer c INNER JOIN Admin_Customer_Giftcard a ON c.username=a.customer_name
		INNER JOIN Giftcard g ON a.code=g.code
		WHERE a.customer_name=c.username AND CURRENT_TIMESTAMP >g.expiry_date


	DELETE FROM Admin_Customer_Giftcard
		WHERE code IN (SELECT code FROM Giftcard WHERE @code=code AND CURRENT_TIMESTAMP >expiry_date)

	DELETE FROM Giftcard
		WHERE CURRENT_TIMESTAMP >expiry_date AND @code =code
END


GO 
CREATE PROC checkGiftCardOnCustomer	--i2
@code VARCHAR(10),
@activeGiftCard BIT OUTPUT
AS
BEGIN
	IF(EXISTS(SELECT customer_name FROM Admin_Customer_Giftcard WHERE code=@code))
		BEGIN
			SET @activeGiftCard='1'
		END
	ELSE
		BEGIN
			SET @activeGiftCard='0'
		END
END



GO
CREATE PROC giveGiftCardtoCustomer --i3
@code VARCHAR(10),
@customer_name VARCHAR(20),
@admin_username VARCHAR(20)
AS
BEGIN
	DECLARE @points INT 
	
	SELECT @points = gc.amount
		FROM Admins a INNER JOIN Giftcard gc
		ON a.username = gc.username
		WHERE a.username = @admin_username AND gc.code = @code

	UPDATE Customer
		SET points = points + @points
		WHERE  username = @customer_name   

	INSERT INTO Admin_Customer_Giftcard
		VALUES(@code,@customer_name,@admin_username,@points);

END




go


--end 2:admin


--start 3:cusotmer

go

CREATE PROC getPoints
@username VARCHAR(20),
@points INT OUTPUT
AS
BEGIN
SELECT @points= points
FROM Customer 
WHERE username=@username
END

GO
CREATE PROC showProducts --a
AS
BEGIN
	SELECT serial_no,product_name,product_description,price,final_price,color
		FROM Product
		where available='1'
END

GO
CREATE PROC ShowProductsbyPrice --b
AS
BEGIN
	SELECT serial_no,product_name,product_description,final_price as price,color
		FROM Product
		WHERE available='1'
		ORDER BY price		-- Check
END

GO
CREATE PROC  searchbyname --c
@text varchar(20)
AS
BEGIN
	SELECT product_name,product_description,price,final_price,color
		FROM Product 
		WHERE product_name LIKE @text+'%' OR product_name LIKE '%'+@text OR product_name LIKE '%'+@text+'%' AND available ='1'
END


GO
CREATE PROC AddQuestion --d
@serial INT,
@customer VARCHAR(20),
@Question VARCHAR(50) --product customer question
AS
BEGIN
	IF(NOT EXISTS (SELECT * from Customer_Question_Product WHERE serial_no=@serial AND customer_name=@customer))
		BEGIN
			INSERT INTO Customer_Question_Product(serial_no,customer_name,question) 
				VALUES(@serial,@customer,@Question)
		END
END

GO
CREATE PROC addToCart --e1
@customername VARCHAR(20), 
@serial INT,@out bit output
AS 
BEGIN
IF(NOT EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE customer_name=@customername AND serial_no=@serial))
	BEGIN
		INSERT INTO CustomerAddstoCartProduct VALUES (@serial,@customername)
		set @out='1'
	END
	else begin set @out='0' end

END

GO
CREATE PROC removefromCart --e2
@customername VARCHAR(20), 
@serial INT,@out bit output
AS 
BEGIN
	if(EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE customer_name=@customername AND serial_no=@serial))
		BEGIN
			DELETE FROM CustomerAddstoCartProduct 
				WHERE customer_name=@customername AND serial_no=@serial
			set @out='1'
		END
		else begin set @out='0' end

END

GO
CREATE PROC createWishlist --f
@customername VARCHAR(20), 
@name VARCHAR(20),@out bit output
AS
BEGIN 
	IF(NOT EXISTS (SELECT * FROM Wishlist WHERE username=@customername AND name=@name))
		BEGIN
			INSERT INTO Wishlist 
		    VALUES (@customername,@name)
             set @out='1'
		END
	else begin set @out='0' end
END

GO
GO
CREATE PROC AddtoWishlist --g1
@customername VARCHAR(20), 
@wishlistname VARCHAR(20), 
@serial INT ,@w_notexists bit output,@s_notexists bit output
AS
BEGIN 
	IF ( EXISTS (SELECT * FROM Wishlist WHERE username=@customername AND name=@wishlistname ))
		BEGIN
		set @w_notexists='1'
		IF (NOT EXISTS (SELECT * FROM Wishlist_Product WHERE username=@customername AND wish_name=@wishlistname and serial_no=@serial ) and exists(select * from Product where serial_no=@serial))
		BEGIN
			INSERT INTO Wishlist_Product 
			VALUES (@customername,@wishlistname,@serial)
			set @s_notexists='1'
		END
		else begin set @s_notexists='0' end
		end
		else begin set @w_notexists='0' set @s_notexists='0' end
END

GO
CREATE PROC removefromWishlist --g2
@customername varchar(20), 
@wishlistname varchar(20), 
@serial int ,@w_notexists bit output ,@s_notexists bit output
AS
BEGIN 
	IF (EXISTS(SELECT * FROM Wishlist WHERE username=@customername AND name=@wishlistname ))
		BEGIN
		set @w_notexists='1'
		IF (EXISTS (SELECT * FROM Wishlist_Product WHERE username=@customername AND wish_name=@wishlistname and serial_no=@serial ))
		begin
		set @s_notexists='1'
			DELETE FROM Wishlist_Product 
			WHERE wish_name=@wishlistname AND username=@customername AND serial_no=@serial
	    end
		else begin set @s_notexists='0' end
        END
		else begin set @w_notexists='0' set @s_notexists='0' end
END
go
CREATE PROC showMyWishlists
@customername varchar(20)
as
begin
SELECT WP.wish_name AS wish_name ,p.product_name AS product_name,p.product_description as product_description,p.price as price,p.final_price as final_price,p.color as color
		FROM  Wishlist_Product WP
		INNER JOIN Product p ON p.serial_no=WP.serial_no
		WHERE WP.username=@customername 
end
GO
CREATE PROC showWishlistProduct --h
@customername varchar(20), @name varchar(20)
AS 
BEGIN
	SELECT p.product_name,p.product_description,p.price,p.final_price,p.color
		FROM  Wishlist_Product WP
		INNER JOIN Product p ON p.serial_no=WP.serial_no
		WHERE WP.username=@customername AND WP.wish_name=@name
END

GO
CREATE PROC  viewMyCart --i
@customer varchar(20)
AS 
BEGIN
	SELECT p.product_name,p.product_description,p.price,p.final_price,p.color
		FROM CustomerAddstoCartProduct c INNER JOIN Product p ON c.serial_no=p.serial_no
		WHERE c.customer_name=@customer and p.available='1'
END


GO
CREATE PROC calculatepriceOrder --j1
@customername varchar(20),
@result DECIMAL(10,2) OUTPUT
AS
BEGIN 
	--DECLARE @sum DECIMAL (10,2)
	--SELECT @sum=SUM(P.price)
	SELECT @result=SUM(P.final_price)
		FROM CustomerAddstoCartProduct ac INNER JOIN Product P ON P.serial_no=ac.serial_no
		WHERE ac.customer_name=@customername
	IF (@result is null ) SET @result = 0
	print @result
	--RETURN @sum
END
--drop proc productsinorder

GO
CREATE PROC productsinorder --j2
@customername varchar(20), @orderID int
AS 
BEGIN
	--SELECT * FROM CustomerAddstoCartProduct
	--with tmp as (SELECT serial_no FROM CustomerAddstoCartProduct WHERE customer_name=@customername)
	UPDATE PRODUCT
		SET customer_username=@customername, customer_order_id=@orderID,available='0'
		WHERE serial_no IN (	SELECT serial_no
								FROM CustomerAddstoCartProduct
								WHERE customer_name=@customername
							)
	DELETE FROM CustomerAddstoCartProduct
		WHERE serial_no IN	(SELECT serial_no
								FROM CustomerAddstoCartProduct
								WHERE customer_name=@customername)
			AND	(customer_name <> @customername)

	DELETE FROM Wishlist_Product
		WHERE serial_no IN	(SELECT serial_no
								FROM CustomerAddstoCartProduct
								WHERE customer_name=@customername)

	SELECT * FROM Product WHERE serial_no IN (SELECT serial_no 
												FROM CustomerAddstoCartProduct
												WHERE customer_name=@customername )
	SELECT * FROM CustomerAddstoCartProduct
END

GO
CREATE PROC emptyCart --j3
@customername varchar(20)
AS
BEGIN
	DELETE FROM CustomerAddstoCartProduct 
	WHERE customer_name=@customername
END

GO
CREATE PROC isCartEmpty
@customername varchar(20),
@EMPTY BIT OUTPUT
AS
BEGIN
	IF (EXISTS (SELECT * FROM CustomerAddstoCartProduct WHERE customer_name=@customername))
		SET @EMPTY ='0'
	ELSE
		SET @EMPTY ='1'
END

GO

GO
CREATE PROC makeOrder --j4  انها حقا لعينة يا جورج
@customername varchar(20),
@ordernum int OUTPUT,
@amo DECIMAL (10,2) OUTPUT
AS
BEGIN			
		--DECLARE @amo DECIMAL(10,2)
		--SET @amo=dbo.calculatepriceOrder (@customername)
		EXEC calculatepriceOrder @customername, @amo OUTPUT
		INSERT INTO Orders(customer_name,total_amount, order_date) --, order_status)
			VALUES(@customername,@amo, CURRENT_TIMESTAMP) -- ,'not processed')

		--DECLARE @orderNO INT
		SELECT @ordernum=MAX(order_no)
			FROM Orders
		EXEC productsinorder @customername, @ordernum
		EXEC emptyCart @customername
END

GO
CREATE PROC viewOrders
@username VARCHAR(20)
AS
BEGIN
SELECT * FROM Orders WHERE customer_name=@username
END

GO
CREATE PROC orderBelong
@username VARCHAR(20),
@orderid INT,
@belong BIT OUTPUT
AS
BEGIN
	IF (EXISTS (SELECT * FROM Orders WHERE customer_name=@username AND order_no=@orderid))
		SET @belong='1';
	else
		set @belong='0';
END


GO
CREATE PROC cancelOrder --k
@orderid int,
@canceled BIT OUTPUT
AS
BEGIN

	DECLARE @username VARCHAR(20)
				SET @username = (SELECT customer_name
										FROM Orders
										WHERE order_no=@orderid)

	IF EXISTS (SELECT * FROM Orders 
				WHERE order_status ='not processed' OR order_status='in process' 
				AND order_no=@orderid)
		BEGIN
			SET @canceled= '1'
			DECLARE @GCU VARCHAR(10)
			IF (EXISTS (SELECT O.Gift_Card_code_used 
			FROM Orders O Inner JOIN Giftcard G ON G.code=O.Gift_Card_code_used
			WHERE O.order_no=@orderid AND G.expiry_date>CURRENT_TIMESTAMP AND O.Gift_Card_code_used IS NOT NULL ) )
			BEGIN
				DECLARE @points_amount INT
				declare @cash decimal(10,2) declare @credit decimal(10,2)
				SELECT @cash=cash_amount FROM Orders WHERE order_no=@orderid
				SELECT @credit=credit_amount FROM Orders WHERE order_no=@orderid
				IF (@cash IS NOT NULL AND @cash>0)
					begin
						SELECT @points_amount= total_amount - cash_amount
							FROM Orders
							WHERE order_no=@orderid
					end						
				else if (@credit IS NOT NULL AND @credit>0)
					begin
						SELECT @points_amount= total_amount - credit_amount
								FROM Orders
								WHERE order_no=@orderid
					end
				
				UPDATE Customer
					SET points = points + @points_amount
					WHERE username = @username
				DECLARE @code VARCHAR(10)
				SET @code = (SELECT Gift_Card_code_used FROM Orders WHERE order_no=@orderid)
				UPDATE Admin_Customer_Giftcard
					SET remaining_points = remaining_points+@points_amount
					WHERE code=@code AND customer_name=@username
			END
		ELSE IF ((SELECT Gift_Card_code_used
					FROM Orders O
					WHERE O.order_no=@orderid )IS NOT NULL ) 
			BEGIN
				DECLARE @usd VARCHAR(10)
				SELECT @usd=  Gift_Card_code_used FROM Orders O WHERE O.order_no=@orderid
				EXEC removeExpiredGiftCard @usd 
			END
		UPDATE Product
			SET customer_order_id=null,customer_username=null,available='1'
			WHERE customer_order_id=@orderid
		DELETE FROM Orders
			WHERE order_no=@orderid
		END
	ELSE
		BEGIN
			SET @canceled='0'
		END
END

GO
CREATE PROC returnProduct --l
@serialno int, @orderid int
AS
BEGIN
	--DECLARE @total_amount decimal(10,2) 
	DECLARE @cash_amount DECIMAL(10,2)
	DECLARE @credit_amount DECIMAL(10,2)
	--DECLARE @payment_type VARCHAR(20)
	DECLARE @order_status VARCHAR(20)
	--remaining_days INT
	DECLARE @time_limit VARCHAR(20)
	--DECLARE @Gift_Card_code_used VARCHAR(10)
	DECLARE @customer_name VARCHAR(20)
	DECLARE @delivery_id INT
	DECLARE @creditCard_number VARCHAR(20)

	DECLARE @serials table (serial_no INT)
	DECLARE @newordercart table (serial_no INT,customer_name VARCHAR(20))
	DECLARE @originalcart table (serial_no INT,customer_name VARCHAR(20))

	SELECT @cash_amount=cash_amount,@credit_amount=credit_amount,
	@order_status=order_status,@time_limit=time_limit,@customer_name=customer_name,
	@delivery_id=delivery_id,@creditCard_number=creditCard_number
		FROM Orders
		WHERE order_no=@orderid
		--AND order_status='delivered'
	
	
	INSERT INTO @newordercart (serial_no)
	SELECT serial_no FROM Product
		WHERE customer_order_id=@orderid and serial_no <> @serialno
	UPDATE @newordercart SET customer_name=@customer_name

	INSERT INTO @originalcart (serial_no)
		SELECT @serialno
			FROM CustomerAddstoCartProduct
			WHERE customer_name=@customer_name
	UPDATE @originalcart SET customer_name=@customer_name

	DELETE FROM CustomerAddstoCartProduct
		WHERE customer_name=@customer_name


	EXEC cancelOrder @orderid
	
	INSERT INTO CustomerAddstoCartProduct (serial_no,customer_name)
		SELECT * FROM @newordercart
	
	EXEC makeOrder @customer_name
	
	DECLARE @newOrder INT
	SELECT @newOrder =MAX(order_no)
		FROM Orders

	UPDATE Orders 
		SET order_status=@order_status,time_limit=@time_limit,
			delivery_id=@delivery_id,creditCard_number= @creditCard_number
		WHERE order_no=@newOrder
	EXEC SpecifyAmount @customer_name,@newOrder,@cash_amount,@credit_amount
	
	INSERT INTO CustomerAddstoCartProduct 
		SELECT * FROM @originalcart
END

GO
CREATE PROC ShowproductsIbought --m
@customername varchar(20)
AS
BEGIN
	SELECT serial_no, product_name, category, product_description, price, final_price, color
	FROM Product
	WHERE customer_username=@customername
END

GO
CREATE PROC rate --n
@serialno int, @rate int , @customername varchar(20)
AS
BEGIN
	UPDATE Product
	SET rate=@rate
	WHERE customer_username=@customername AND serial_no=@serialno

END

GO
CREATE PROC SpecifyAmount --o
@customername varchar(20), 
@orderID int, 
@cash decimal(10,2), @credit decimal(10,2),
@done BIT OUTPUT
AS
BEGIN 
	set @done = '0';
	IF (EXISTS (SELECT * FROM Orders WHERE order_no=@orderID AND payment_type IS NULL))
		BEGIN
			DECLARE @order_amount DECIMAL (10,2)
			SET @order_amount = (SELECT total_amount FROM Orders WHERE order_no=@orderID)
			IF @cash >0
				BEGIN
					
					IF (@cash < @order_amount)
						BEGIN
							IF ((SELECT points FROM Customer WHERE username=@customername) >= @order_amount-@cash  )
								BEGIN
									set @done = '1';
									DECLARE @code1 VARCHAR(10)
						
									SET @code1 =	(
										SELECT TOP 1 G.code
											FROM Giftcard G INNER JOIN Admin_Customer_Giftcard ACG ON G.code = ACG.code
											WHERE ACG.remaining_points >= @order_amount-@cash AND G.expiry_date>CURRENT_TIMESTAMP
											ORDER BY G.expiry_date 
											)
									UPDATE Customer
										SET points = points- (@order_amount-@cash) 
										WHERE username=@customername
									UPDATE Admin_Customer_Giftcard
										SET remaining_points = remaining_points - (@order_amount-@cash) 
										WHERE customer_name=@customername AND code=@code1
									UPDATE Orders
										SET Gift_Card_code_used = @code1
										WHERE order_no=@orderID
									UPDATE Orders
										SET cash_amount=@cash, payment_type='cash'
										WHERE customer_name=@customername AND order_no=@orderID
								END
						END
					ELSE
						begin
							set @done='1';
							UPDATE Orders
								SET cash_amount=@cash, payment_type='cash'
								WHERE customer_name=@customername AND order_no=@orderID
						end
				END
			ELSE IF @credit>0
				BEGIN
				--Will copy the code of Cash here ; change every cash->credit ; 
				--after completeing the part OF SET @code
					
					IF (@credit < @order_amount)
						BEGIN
							IF ((SELECT points FROM Customer WHERE username=@customername) >= @order_amount -@credit )
								BEGIN
									set @done = '1';
									DECLARE @code2 VARCHAR(10)
						
									SET @code2 =	(
										SELECT TOP 1 G.code
											FROM Giftcard G INNER JOIN Admin_Customer_Giftcard ACG ON G.code = ACG.code
											WHERE ACG.remaining_points >= @order_amount-@credit AND G.expiry_date>CURRENT_TIMESTAMP
											ORDER BY G.expiry_date 
											)
									UPDATE Customer
										SET points = points- (@order_amount-@credit) 
										WHERE username=@customername
									UPDATE Admin_Customer_Giftcard
										SET remaining_points = remaining_points - (@order_amount-@credit) 
										WHERE customer_name=@customername AND code=@code2
									UPDATE Orders
										SET Gift_Card_code_used = @code2
										WHERE order_no=@orderID
									UPDATE Orders
										SET credit_amount=@credit, payment_type='credit'
										WHERE customer_name=@customername AND order_no=@orderID
								END
						END
					ELSE
						BEGIN
							SET @done='1';
							UPDATE Orders
								SET credit_amount=@credit, payment_type='credit'
								WHERE customer_name=@customername AND order_no=@orderID
						END
				END
		END
END

GO
CREATE PROC AddCreditCard --p
@creditcardnumber varchar(20), 
@expirydate date , 
@cvv varchar(4), 
@customername varchar(20),@out bit output
AS
BEGIN
if(not exists(select * from Credit_Card where number=@creditcardnumber))
begin
	INSERT INTO Credit_Card
	VALUES (@creditcardnumber, @expirydate, @cvv);
	INSERT INTO Customer_CreditCard
	VALUES (@customername, @creditcardnumber);
	set @out='1'
	end
	else begin
	set @out='0'
	end
END

GO
CREATE PROC ChooseCreditCard --q
@creditcard varchar(20), @orderid int
AS
BEGIN
	DECLARE @cust VARCHAR(20)
	SELECT @cust =  customer_name FROM Orders WHERE order_no=@orderid
	IF (EXISTS (SELECT * FROM Credit_Card C INNER JOIN Customer_CreditCard CC ON C.number=CC.cc_number WHERE cc.customer_name=@cust))
		BEGIN
			UPDATE Orders
				SET creditCard_number=@creditcard
				WHERE order_no=@orderid
		END
END

GO
CREATE PROC vewDeliveryTypes --r
AS 
BEGIN
SELECT delivery_type as 'TYPE', time_duration as 'Duration in Days',fees 
FROM Delivery
END

GO
CREATE PROC specifydeliverytype --s
@orderID int, @deliveryID INT
AS
BEGIN
	DECLARE @dur int
	SELECT @dur = time_duration
		FROM Delivery
		WHERE id = @deliveryID

	UPDATE Orders
		SET delivery_id=@deliveryID,
			remaining_days =  @dur  -  DATEDIFF (DAY,order_date,CURRENT_TIMESTAMP)
		WHERE order_no=@orderID
END

GO
CREATE PROC trackRemainingDays --t
@orderid int, @customername varchar(20), --el input customername malosh lazma
@days INT OUTPUT                      --fa homa 7atino leh
AS                                     --fa 8aleban ely ana 3amlo 8alat
BEGIN
	SET NOCOUNT ON
	DECLARE @dur int
	DECLARE @Did INT

	SELECT @Did = delivery_id
		FROM Orders
		WHERE order_no= @orderid

	SELECT @dur = time_duration
		FROM Delivery
		WHERE id = @Did

	UPDATE Orders 
		SET remaining_days =  @dur  - DATEDIFF (DAY,order_date,CURRENT_TIMESTAMP)
		WHERE order_no=@orderid AND customer_name=@customername

	SELECT @days=remaining_days		-- can't we do this in the previous statement ?
		FROM Orders
		WHERE order_no=@orderid AND customer_name=@customername
	print @days
END

GO
create procedure recommend
@customername varchar(20)
AS
BEGIN

DECLARE @Product2serials TABLE(
serial int,num int);

INSERT INTO @Product2serials(serial,num)
select top 3 p.serial_no ,count(p.serial_no)
from Product p inner join Wishlist_product wp on p.serial_no=wp.serial_no
where p.category in (SELECT top 3 p.category
FROM Product p2 INNER JOIN CustomerAddstoCartProduct adc ON adc.seriaL_no=p2.serial_no
where adc.customer_name=@customername
group by p2.category
order by count(p2.category) desc)
group by p.serial_no
order by count(p.serial_no) desc;

INSERT INTO @Product2serials(serial,num)
select top 3 p.serial_no ,count(p.serial_no)
from Product p inner join Wishlist_Product wp on p.serial_no=wp.serial_no
where wp.username in(select top 3 cpp.customer_name 
  from CustomerAddstoCartProduct cpp
  where cpp.customer_name<>@customername and cpp.serial_no in(select cp.serial_no
  from CustomerAddstoCartProduct cp
  where cp.customer_name=@customername) 
  group by cpp.customer_name
  order by count(cpp.customer_name) desc)
  group by p.serial_no
  order by count(p.serial_no) desc;

  select DISTINCT p.serial_no,p.product_name,p.category,p.product_description,p.price,p.final_price,p.color
  from Product p inner join @Product2serials ps on p.serial_no=ps.serial
 
END



go

--end 3:customer


--start 4:delivery
go



CREATE PROC acceptAdminInvitation	--a
@delivery_username VARCHAR(20)
AS
BEGIN
	UPDATE Delivery_Person
		SET is_activated='1'
		WHERE username=@delivery_username
END;

GO
CREATE PROC deliveryPersonUpdateInfo	--b
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
BEGIN
	UPDATE Users
		SET first_name=@first_name,
			last_name=@last_name,
			password=@password,
			email=@email
			WHERE username=@username
END;

GO
CREATE PROC viewmyorders	--c
@deliveryperson varchar(20)
AS
BEGIN
	SELECT O.*
	FROM  Orders O INNER JOIN  Admin_Delivery_Order ADO ON O.order_no = ADO.order_no
	WHERE ADO.delivery_username = @deliveryperson
END

GO
--c
CREATE PROC specifyDeliveryWindow
@delivery_username VARCHAR(20),
@order_no INT,
@delivery_window VARCHAR(50)
AS
BEGIN
	UPDATE Admin_Delivery_Order
		SET delivery_window=@delivery_window
		WHERE order_no=@order_no AND delivery_username=@delivery_username
END

GO
CREATE PROC updateOrderStatusOutforDelivery	--d
@order_no INT
AS
BEGIN
	UPDATE Orders
		SET order_status='out for delivery'
		WHERE order_no=@order_no
END

GO 
CREATE PROC updateOrderStatusDelivered	--e
@order_no INT
AS
BEGIN
	UPDATE Orders
		SET order_status='delivered'
		WHERE order_no=@order_no
END

go
--end 4:delivery


--start 5:vendor


GO
CREATE PROC postProduct	--a
@vendorUsername VARCHAR(20),
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description VARCHAR(200),
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
BEGIN
INSERT INTO 
Product(vendor_username, product_name,category,product_description,price,final_price,color,available)
VALUES(@vendorUsername,@product_name,@category,@product_description,@price,@price,@color,1)

END


GO
CREATE PROC vendorviewProducts  --b
@vendorname VARCHAR(20)
AS
BEGIN
	SELECT p.* 
	FROM Vendor v INNER JOIN Product p
	ON v.username = p.vendor_username
	WHERE v.username = @vendorname
END


GO
CREATE PROC EditProduct	--c
@vendorname VARCHAR(20),
@serialnumber INT,
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description VARCHAR(200),
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
BEGIN
IF( EXISTS (SELECT serial_no vendor_username from Product Where serial_no = @serialnumber AND vendor_username = @vendorname))
BEGIN
	
	UPDATE Product
	SET product_name = @product_name,
	category = @category , 
	product_description = @product_description , 
	final_price = @price,
	color = @color
	WHERE serial_no = @serialnumber AND vendor_username = @vendorname
END
END



GO
CREATE PROC deleteProduct --d
@vendorname VARCHAR(20),
@serialnumber int
AS
BEGIN
	DELETE FROM Product
		WHERE serial_no = @serialnumber AND vendor_username = @vendorname

END


GO
CREATE PROC viewQuestions	--e
@vendorname VARCHAR(20)
AS
BEGIN
	SELECT c.*
	FROM Vendor v INNER JOIN Product p
	ON v.username = p.vendor_username
	INNER JOIN Customer_Question_Product c
	ON c.serial_no = p.serial_no
	WHERE v.username =@vendorname
END



GO
CREATE PROC answerQuestions	--f
@vendorname VARCHAR(20),
@serialno INT,
@customername VARCHAR(20),
@answer TEXT
AS
BEGIN
	UPDATE Customer_Question_Product 
		SET answer = @answer
		FROM Product p INNER JOIN Customer_Question_Product c
		ON c.serial_no = p.serial_no 
		WHERE p.vendor_username = @vendorname AND p.serial_no = @serialno AND c.customer_name = @customername
END

GO
CREATE PROC addOffer	--g1
@offeramount INT,
@expiry_date DATETIME
AS
BEGIN
	INSERT INTO offer(offer_amount,expiry_date)            
		VALUES(@offeramount,@expiry_date)
END

GO
CREATE PROC checkOfferonProduct	--g2
@serial INT,
@activeoffer BIT OUTPUT
AS
BEGIN
	DECLARE @number INT
	SELECT @number = COUNT(*)
		From offersOnProduct 
		WHERE serial_no = @serial
	IF @number = 0
		BEGIN
			SET @activeoffer = 0
			PRINT (@activeoffer)
		END
	ELSE
		BEGIN
			SET @activeoffer = 1
			PRINT (@activeoffer)
		END
END


GO
CREATE PROC checkandremoveExpiredoffer	--g3
@offerid int,
@successID BIT OUTPUT,
@successRemoved BIT OUTPUT
AS
BEGIN
IF(EXISTS(SELECT offer_id from offer where offer_id = @offerid))
BEGIN
	DECLARE @todaysDate DATETIME
	SELECT @todaysDate = GETDATE()
	UPDATE Product
		SET final_price = price
		WHERE serial_no IN
			(SELECT oo.serial_no
				FROM offer o INNER JOIN offersOnProduct oo
				ON o.offer_id = oo.offer_id
				WHERE oo.offer_id = @offerid AND @todaysDate >= o.expiry_date
			)
	DELETE 
		FROM offersOnProduct
		WHERE offer_id IN 
			( SELECT offer_id 
				FROM offer
				WHERE offer_id=@offerid AND @todaysDate>= expiry_date
			)
	DELETE 
		FROM offer
		WHERE @todaysDate>expiry_date AND offer_id=@offerid
	IF(NOT EXISTS(SELECT offer_id FROM offer where offer_id = @offerid))
		BEGIN
		SET @successRemoved = 1
		End
	ELSE
	SET @successRemoved = 0
END
ELSE
SET @successID = 0
END

GO
CREATE PROC applyOffer
@vendorname VARCHAR(20), 
@offerid INT,
@serial INT,
@successID BIT OUTPUT,
@successSerial BIT OUTPUT,
@Active BIT OUTPUT,
@MyProduct BIT OUTPUT
AS
BEGIN
IF(EXISTS ( SELECT serial_no,vendor_username from Product where serial_no = @serial AND vendor_username = @vendorname))
BEGIN
	SET @MyProduct = 1
	IF (NOT EXISTS (SELECT serial_no FROM offersOnProduct WHERE  serial_no = @serial))
	BEGIN
			SET @Active = 0
			IF (EXISTS ( SELECT serial_no FROM Product WHERE serial_no = @serial))
				BEGIN
				SET @successSerial = 1
				IF (EXISTS (SELECT offer_id FROM offer WHERE offer_id = @offerid))
					BEGIN
					SET @successID = 1
					DECLARE @price DECIMAL(10,2)
					DECLARE @offerAmount INT
			
					SELECT @offerAmount = offer_amount
						FROM offer
						WHERE offer_id = @offerid

					SELECT @price = price 
						FROM Product
						WHERE serial_no = @serial

					DECLARE @newPrice DECIMAL(10,2)
					
					IF (@price-@offerAmount<0) SET @newPrice = 0;
					ELSE SET @newPrice = @price - @offerAmount

					UPDATE Product
						SET final_price = @newPrice
						WHERE serial_no=@serial

					INSERT INTO offersOnProduct 
						VALUES (@offerid,@serial)
				END
				ELSE 
				SET @successID = 0
			END
			ELSE SET @successSerial = 0
	END
	ELSE SET @Active = 1
END
ELSE SET @MyProduct = 0
END

GO
CREATE PROC GetProduct
@vendorUsername VARCHAR(20),
@serialNumber INT,
@successSerial BIT OUTPUT
AS

BEGIN
	IF(EXISTS (SELECT serial_no , vendor_username FROM Product WHERE serial_no = @serialNumber AND vendor_username = @vendorUsername))
		BEGIN
		SET @successSerial = 1
		SELECT vendor_username,product_name,category,product_description,price,color
		FROM Product
		WHERE vendor_username = @vendorUsername AND serial_no = @serialNumber
		END
	ELSE
	SET @successSerial = 0
END


	GO
CREATE PROC GetProduct2
@vendorUsername VARCHAR(20),
@serialNumber INT
AS
BEGIN
SELECT vendor_username,product_name,category,product_description,price,color
FROM Product
WHERE vendor_username = @vendorUsername AND serial_no = @serialNumber
END

GO
CREATE PROC ShowOffers
AS
SELECT * 
from offer

GO
CREATE PROC ShowActiveOffers
AS
SELECT * 
from offersOnProduct

GO
CREATE Proc ViewProduct
@serial INT
AS
SELECT product_name , category, product_description,price,color 
FROM Product
WHERE serial_no = @serial

GO
CREATE PROC isAct
@username VARCHAR(20),
@act BIT OUTPUT
AS
BEGIN
IF (EXISTS (SELECT * FROM Vendor WHERE username=@username AND activated='1'))
	SET @act='1';
else
	SET @act='0';
END

--end 5:vendor


--start 6:unreg
go


CREATE PROC customerRegister --a ,hn hande zy elnetworks wla fakes?
@username VARCHAR(20),
@first_name VARCHAR(20), 
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),@out bit output,@outmail bit output
AS 
BEGIN 
-- INSERT INTO Customer(username,first_name,last_name,pass,email)
IF(not exists(select * from Users where username=@username))
begin
set @out='1'
if(not exists(select * from Users where email=@email))
begin
set @outmail='1'
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES(@username,@first_name,@last_name,@password,@email)
INSERT INTO Customer(username,points)
VALUES (@username,0)
end
else begin set @outmail='0' end
end
else begin set @out='0' set @outmail='1'end

END

GO 
CREATE PROC vendorRegister --b
 @username VARCHAR(20),
 @first_name VARCHAR(20), 
 @last_name VARCHAR(20),
 @password VARCHAR(20),
 @email VARCHAR(50), 
 @company_name VARCHAR(20), 
 @bank_acc_no VARCHAR(20),@out bit output,@outmail bit output
 AS
BEGIN 
IF(not exists(select * from Users where username=@username))
begin
set @out='1'
 if(not exists(select * from Users where email=@email))
 begin
 set @outmail='1'
 INSERT INTO Users(username,first_name,last_name,password,email)--,company_name,bank_acc_no)
 VALUES(@username,@first_name,@last_name,@password,@email)--,@company_name,@bank_acc_no)
 INSERT INTO Vendor(username,activated,company_name,bank_acc_no)
 VALUES (@username,'0',@company_name,@bank_acc_no)
 end
 else begin set @outmail='0' end
 end
 else begin set @out='0' set @outmail='1' end
 
END



go

--end 6:unreg



--start 7:reg
go


CREATE PROC userLogin
@username VARCHAR(20), @password VARCHAR(20),@success BIT OUTPUT,@type INT OUTPUT
AS
BEGIN 
	IF(EXISTS(
		SELECT *
			FROM Users
			WHERE username=@username AND password=@password)
		)
	BEGIN
		SET @success='1'
		IF(EXISTS(SELECT * FROM Customer WHERE username=@username))
			SET @type=0
		ELSE IF(EXISTS(SELECT * FROM Vendor WHERE username=@username))
			SET @type=1
		ELSE IF(EXISTS(SELECT * FROM Admins WHERE username=@username))
			SET @type=2
		ELSE IF(EXISTS(SELECT * FROM Delivery_Person WHERE username=@username))
			SET @type=3
		print @success
		print @type
	END
ELSE
	BEGIN
		SET @success='0'
		print @success
		set @type=-1
		print @type
	END
END

GO
CREATE PROC userType
@username VARCHAR(20), @type INT OUTPUT
AS
BEGIN 
	IF(EXISTS(
		SELECT *
			FROM Users
			WHERE username=@username)
		)
	BEGIN
		IF(EXISTS(SELECT * FROM Customer WHERE username=@username))
			SET @type=0
		ELSE IF(EXISTS(SELECT * FROM Vendor WHERE username=@username))
			SET @type=1
		ELSE IF(EXISTS(SELECT * FROM Admins WHERE username=@username))
			SET @type=2
		ELSE IF(EXISTS(SELECT * FROM Delivery_Person WHERE username=@username))
			SET @type=3
	END
ELSE
	BEGIN
		set @type=-1
	END
END

--GO
--CREATE PROC addMobile --b
--@username VARCHAR(20), 
--@mobile_number VARCHAR(20)
--AS
--BEGIN 
--	if(not exists(select * from User_mobile_numbers where username=@username AND mobile_number=@mobile_number))
--		BEGIN
--			INSERT INTO User_mobile_numbers 
--			VALUES(@mobile_number,@username)
--		END
--END

go
CREATE PROC addMobile --b
@username VARCHAR(20), 
@mobile_number VARCHAR(20),
@out INT OUTPUt
AS
BEGIN 
	if(not exists(select * from User_mobile_numbers where username=@username AND mobile_number=@mobile_number))
		BEGIN
		SET @out=1
			INSERT INTO User_mobile_numbers 
				VALUES(@mobile_number,@username)
		END
		ELSE
		SET @out=0
END

GO
CREATE PROC addAddress --c
@username VARCHAR(20), 
@address VARCHAR(100)
AS
BEGIN 
	IF(not exists(select * from User_Addresses where username=@username AND address=@address))
		BEGIN
			INSERT INTO User_Addresses VALUES(@address,@username)
		END
END



go
--end 7:reg