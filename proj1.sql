---PROCEDURES AND FUNCTIONS
--CHECKO 3ALEHOM B DAMEER BLEEEZ
---REGISTRATION
CREATE PROC customerRegister --a ,hn hande zy elnetworks wla fakes?
@username VARCHAR(20),
@first_name VARCHAR(20), 
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS 
BEGIN 
-- INSERT INTO Customer(username,first_name,last_name,pass,email)
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES(@username,@first_name,@last_name,@password,@email)
INSERT INTO Customer(username,points)
VALUES (@username,0)
END

GO 
CREATE PROC vendorRegister --b
 @username VARCHAR(20),
 @first_name VARCHAR(20), 
 @last_name VARCHAR(20),
 @password VARCHAR(20),
 @email VARCHAR(50), 
 @company_name VARCHAR(20), 
 @bank_acc_no VARCHAR(20)
 AS
BEGIN 
 INSERT INTO Users(username,first_name,last_name,password,email)--,company_name,bank_acc_no)
 VALUES(@username,@first_name,@last_name,@password,@email)--,@company_name,@bank_acc_no)
 INSERT INTO Vendor(username,activated,company_name,bank_acc_no)
 VALUES (@username,'0',@company_name,@bank_acc_no)
END

--EXISTING USER
GO
CREATE FUNCTION userLogin(@username VARCHAR(20), @password VARCHAR(20)) --a function better than proc?
RETURNS @tuple TABLE(success BIT,type SMALLINT) -- Es wants to make smallint INT as in the MS2 to be SAFE
AS
BEGIN 
DECLARE @s BIT 
DECLARE @t SMALLINT
IF(EXISTS(
SELECT *
FROM Users
WHERE username=@username AND password=@password))
BEGIN
SET @s='1'
IF(EXISTS(SELECT * FROM Customer WHERE username=@username))
SET @t=0
ELSE IF(EXISTS(SELECT * FROM Vendor WHERE username=@username))
SET @t=1
ELSE IF(EXISTS(SELECT * FROM Admins WHERE username=@username))
SET @t=2
ELSE 
SET @t=3
End
ELSE
SET @s='0'
SET @t=-1 -- eshme3na 1 !?  :v :v 
INSERT INTO @tuple VALUES(@s,@t)
RETURN
END



GO
CREATE PROC addMobile --b
@username VARCHAR(20), 
@mobile_number VARCHAR(20)
AS
BEGIN 
INSERT INTO User_mobile_numbers 
VALUES(@mobile_number,@username)
END

GO
CREATE PROC addAddress --c
@username VARCHAR(20), 
@address VARCHAR(100)
AS
BEGIN 
INSERT INTO User_Address VALUES(@address,@username)
END


--AS A CUSTOMER
GO
CREATE FUNCTION	showProducts() ---a , mksl akmlha ama at2kd en elapproach sah
RETURNS @records TABLE(
serial_no INT,
product_name VARCHAR(20),
category VARCHAR(20),
product_description text,
final_price DECIMAL(10,2),
color VARCHAR (20),
available BIT ,
rate INT,
vendor_username VARCHAR(20)
)
AS
BEGIN 
RETURN -- DOES THIS WOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOORK ?????
END
--b,c zy (a) okhtohom ely fo2 el line da bzbt
--CREATE FUNCTION ShowProductsbyPrice       --b
--CREATE FUNCTION searchbyname @text VARCHAR(20)          --c
GO
CREATE PROC AddQuestion --d
@serial INT,@customer VARCHAR(20),@Question VARCHAR(50) --product customer question
AS
BEGIN
INSERT INTO Customer_Question_Product(serial_no,customer_name,question) 
VALUES(@serial,@customer,@Question)
END

GO
CREATE PROC addToCart --e1
@customername VARCHAR(20), 
@serial INT
AS 
BEGIN
INSERT INTO CustomerAddstoCartProduct VALUES (@serial,@customername)
END

GO
CREATE PROC removefromCart --e2
@customername VARCHAR(20), 
@serial INT
AS 
BEGIN
DELETE FROM CustomerAddstoCartProduct WHERE customer_name=@customername AND serial_no=@serial
END

GO
CREATE PROC createWishlist --f
@customername VARCHAR(20), 
@name VARCHAR(20)
AS
BEGIN 
INSERT INTO Wishlist VALUES(@customername,@name)
END

GO
CREATE PROC AddtoWishlist --g1
@customername VARCHAR(20), 
@wishlistname VARCHAR(20), 
@serial INT
AS
BEGIN 
INSERT INTO Wishlist_Product VALUES (@customername,@wishlistname,@serial)
END

GO
CREATE PROC removefromWishlist --g2
@customername varchar(20), 
@wishlistname varchar(20), 
@serial int
AS
BEGIN 
DELETE FROM Wishlist_Product 
WHERE wish_name=@wishlistname AND username=@customername AND serial_no=@serial
END

--h,i zy a,b,c naaw
-- CREATE FUNCTION showWishlistProduct    --h
-- CREATE FUNCTION viewMyCart           --I

GO
CREATE FUNCTION calculatepriceOrder(@customername varchar(20)) --j1 , customer is name or username? username
RETURNS DECIMAL(10,2)
AS
BEGIN 
DECLARE @sum DECIMAL (10,2)
SELECT @sum=SUM(P.price)
FROM CustomerAddstoCartProduct ac INNER JOIN Product P ON P.serial_no=ac.serial_no
WHERE ac.customer_name=@cutomername
RETURN @sum
END

GO
CREATE PROC emptyCart --j2
@customername varchar(20)
AS
BEGIN
DELETE FROM CustomerAddstoCartProduct 
WHERE customer_name=@customername
END

GO
--CREATE PROC makeOrder --j3 dunno msh ader

--j4 bardo zy a,b,c,h,j
--start with k from this and the other remaining shit
--m3 agmal tahyaty ,shokran
--zerbew elnwwwwwww
