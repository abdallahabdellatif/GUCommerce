---PROCEDURES AND FUNCTIONS
--CHECKO 3ALEHOM B DAMEER BLEEEZ
---REGISTRATION

--EXISTING USER
--GO

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
