---PROCEDURES AND FUNCTIONS
--CHECKO 3ALEHOM B DAMEER BLEEEZ
---REGISTRATION
CREATE PROC customerRegister --a ,hn hande zy elnetworks wla fakes?
@username varchar(20),
@first_name varchar(20), 
@last_name varchar(20),
@password varchar(20),
@email varchar(50)
AS 
BEGIN 
INSERT INTO Customer(username,first_name,last_name,pass,email)
VALUES(@username,@first_name,@last_name,@password,@email)
END

GO 
CREATE PROC vendorRegister --b
 @username varchar(20),
 @first_name varchar(20), 
 @last_name varchar(20),
 @password varchar(20),
 @email varchar(50), 
 @company_name varchar(20), 
 @bank_acc_no varchar(20)
 AS
 BEGIN 
 INSERT INTO Customer(username,first_name,last_name,pass,email,company_name,bank_acc_no)
VALUES(@username,@first_name,@last_name,@password,@email,@company_name,@bank_acc_no)
END

--EXISTING USER
GO
CREATE FUNCTION userLogin(@username varchar(20), @password varchar(20)) --a function better than proc?
RETURNS @tuple TABLE(success BIT,type smallint)
AS
BEGIN 
DECLARE @s BIT 
DECLARE @t smallint
IF(EXISTS(
SELECT *
FROM Users
WHERE username=@username AND pass=@password))
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
SET @t=-1
INSERT INTO @tuple VALUES(@s,@t)
RETURN
END



GO
CREATE PROC addMobile --b
@username varchar(20), 
@mobile_number varchar(20)
AS
BEGIN 
INSERT INTO User_Phone VALUES(@username,@mobile_number)
END

GO
CREATE PROC addAddress --c
@username varchar(20), 
@address varchar(100)
AS
BEGIN 
INSERT INTO User_Address VALUES(@username,@address)
END


--AS A CUSTOMER
GO
CREATE FUNCTION	showProducts() ---a , mksl akmlha ama at2kd en elapproach sah
RETURNS @records TABLE(serial_number INT,p_name VARCHAR(20),price DECIMAL,rate DECIMAL,color VARCHAR(20),image VARCHAR(20),description VARCHAR(100),category VARCHAR(20))
AS
BEGIN 
RETURN
END
--b,c zy (a) okhtohom ely fo2 el line da bzbt
GO
CREATE PROC AddQuestion --d
@serial int ,@customer varchar(20),@Question varchar(50) --product customer question
AS
BEGIN
INSERT INTO Question(statement,serial_number,customer) VALUES(@Question,@serial,@customer)
END

GO
CREATE PROC addToCart --e1
@customername varchar(20), 
@serial int
AS 
BEGIN
INSERT INTO add_in_cart VALUES (@customername,@serial)
END

GO
CREATE PROC addToCart --e2
@customername varchar(20), 
@serial int
AS 
BEGIN
DELETE FROM add_in_cart WHERE customer_username=@customername AND product_sn=@serial
END

GO
CREATE PROC createWishlist --f
@customername varchar(20), @name varchar(20)ASBEGIN INSERT INTO Wishlist VALUES(@customername,@name)ENDGOCREATE PROC AddtoWishlist --g1@customername varchar(20), @wishlistname varchar(20), @serial intASBEGIN INSERT INTO containsWP VALUES (@wishlistname,@customername,@serial)ENDGOCREATE PROC AddtoWishlist --g2@customername varchar(20), @wishlistname varchar(20), @serial intASBEGIN DELETE FROM containsWP WHERE wishlist_name=@wishlistname AND customer_username=@customername AND product_sn=@serialEND--h,i zy a,b,c naawGOCREATE FUNCTION calculatepriceOrder(@customername varchar(20)) --j1 , customer is name or username?RETURNS DECIMAL(10,2)ASBEGIN DECLARE @sum DECIMAL (10,2)SELECT @sum=SUM(P.price)FROM add_in_cart ac INNER JOIN Product P ON P.serial_number=ac.product_snWHERE ac.customer_username=@cutomernameRETURN @sumENDGOCREATE PROC emptyCart --j2@customername varchar(20)ASBEGINDELETE FROM add_in_cart WHERE customer_username=@customernameENDGO--CREATE PROC makeOrder --j3 dunno msh ader--j4 bardo zy a,b,c,h,j--start with k from this and the other remaining shit--m3 agmal tahyaty ,shokran--zerbew elnwwwwwww