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

--khaled starts here...
CREATE PROC showProducts --a
AS
BEGIN
SELECT *
FROM Product
END

GO
CREATE PROC ShowProductsbyPrice --b
AS
BEGIN
SELECT *
FROM Product
ORDER BY final_price
END

GO
CREATE PROC searchbyname --c
@text varchar(20)
AS
BEGIN
SELECT *
FROM Product 
WHERE product_name=@text
END

GO
CREATE PROC showWishlistProduct --h
@customername varchar(20), @name varchar(20)
AS 
BEGIN
SELECT *
FROM Wishlist
WHERE username=@customername AND name=@name
END

GO
CREATE PROC  viewMyCart --i
@customer varchar(20)
AS 
BEGIN
SELECT p.*
FROM CustomerAddstoCartProduct c INNER JOIN Product p ON c.serial_no=p.serial_number
WHERE c.customer_name=@customer
END

GO
CREATE PROC makeOrder --j3  انها حقا لعينة يا جورج
@customername varchar(20)
AS
BEGIN
DECLARE @amo DECIMAL(10,2)
SET @amo=dbo.calculatepriceOrder (@customername)

INSERT INTO Orders(customer_name,total_amount)
VALUES(@customername,@amo)

DECLARE @orderNO INT
SELECT @orderNO=MAX(order_no)
FROM Orders

UPDATE Product
SET customer_order_id=@orderNO
FROM Product p INNER JOIN CustomerAddstoCartProduct c ON p.serial_number=c.c.serial_no
WHERE c.customer_name=@customername

EXEC emptyCart @customername
END

GO
CREATE PROC productsinorder --j4
@customername varchar(20), @orderID int
AS 
BEGIN
SELECT p.*
FROM Product p INNER JOIN Orders o ON p.customer_order_id=o.order_no
WHERE o.customer_name=@customername AND o.order_no=@orderID
END

GO
CREATE PROC cancelOrder --k
@orderid int
AS
BEGIN
IF order_status ='not processed' or order_status='in process'
DELETE FROM Orders
WHERE order_no=@orderid
ELSE
PRINT 'no can dosville baby doll'
END

GO
CREATE PROC returnProduct --l
@serialno int, @orderid int
AS
BEGIN
SELECT *
FROM Product p INNER JOIN Orders o ON o.order_no=p.customer_order_id
WHERE p.serial_number=@serialno AND p.customer_order_id=@orderid 
AND o.order_status='delivered'
END

GO
CREATE PROC ShowproductsIbought --m
@customername varchar(20)
AS
BEGIN
SELECT *
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
WHERE customer_username=@customername AND serial_number=@serialno
END

GO
CREATE PROC SpecifyAmount --o ana habed be nesbet 60%
@customername varchar(20), @orderID int, @cash decimal(10,2), @credit decimal(10,2)
AS
BEGIN 
IF @cash + @credit <total_amount
UPDATE Orders
SET cash_amount=@cash  ,credit_amount=@credit ,payement_type='partially'
WHERE customer_name=@customername AND order_no=@orderID
ELSE
UPDATE Orders
SET cash_amount=@cash  ,credit_amount=@credit ,payement_type='totally'
WHERE customer_name=@customername AND order_no=@orderID

UPDATE Customer
SET points=points+@credit --mesh 3aref ba2a 
END

GO
CREATE PROC ChooseCreditCard --p
@creditcard varchar(20), @orderid int
AS
BEGIN
UPDATE Orders
SET creditCard_number=@creditcard
WHERE order_no=@orderid
END

GO
CREATE PROC vewDeliveryTypes --q
AS 
BEGIN
SELECT delivery_type --aw fees we duration ma3rafsh
FROM Delivery
END

GO
CREATE PROC specifydeliverytype --r
@orderID int, @deliveryID INT
AS
BEGIN
UPDATE Orders
SET delivery_id=@deliveryID
WHERE order_no=@orderID
END

GO
CREATE PROC trackRemainingDays --s
@orderid int, @customername varchar(20), --el input customername malosh lazma
@days INT OUTPUT                      --fa homa 7atino leh
AS                                     --fa 8aleban ely ana 3amlo 8alat
BEGIN
SELECT @days=remaining_days
FROM Orders
WHERE order_no=@orderid AND customer_name=@customername
END

GO
CREATE PROC recommmend --t
@customername varchar(20)-- mesh ader akamel 
AS                         --انتظرونا في حلقة قادمة مع برنامج شبراوي للهبد
BEGIN
DECLARE @maxca1 VARCHAR(20)
DECLARE @maxca2 VARCHAR(20)
DECLARE @maxca3 VARCHAR(20)

(SELECT @maxca1=p.category
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername
GROUP BY p.category
HAVING COUNT(*)=(
SELECT MAX(count1)
FROM(SELECT DISTINCT COUNT(*) AS 'count1'
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername
GROUP BY p.category)AS Temp1))

(SELECT @maxca2=p.category
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername
GROUP BY p.category
HAVING COUNT(*)=(
SELECT MAX(count2)
FROM(SELECT DISTINCT COUNT(*) AS 'count2'
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername AND p.category<>@maxca1
GROUP BY p.category)AS Temp2))

(SELECT @maxca3=p.category
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername
GROUP BY p.category
HAVING COUNT(*)=(
SELECT MAX(count3)
FROM(SELECT DISTINCT COUNT(*) AS 'count3'
FROM CustomerAddstoCartProduct cap INNER JOIN Product p ON cap.serial_no=p.serial_number
WHERE cap.customer_name=@customername AND p.category<>@maxca1 AND p.category <>@maxca2
GROUP BY p.category)AS Temp3))

DECLARE @pro1 INT
DECLARE @pro2 INT 
DECLARE @pro3 INT

SELECT @pro1=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca1 AND ROWNUM <=1

IF @pro1<>NULL
(SELECT @pro2=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca2 AND ROWNUM <=1)

ELSE
BEGIN
(SELECT @pro1=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca2 AND ROWNUM <=1)
(SELECT @pro2=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca2 AND ROWNUM <=1 AND w.serial_no<>@pro1)
END
IF @pro2<>NULL
(SELECT @pro3=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1)

ELSE
BEGIN
IF @pro1<>NULL
BEGIN
(SELECT @pro2=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1 AND w.serial_no<>@pro1)
(SELECT @pro3=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1 AND w.serial_no<>@pro1 AND w.serial_no<>@pro2)
END
ELSE
BEGIN
(SELECT @pro1=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1)
(SELECT @pro2=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1 AND w.serial_no<>@pro1)
(SELECT @pro3=w.serial_no
FROM Wishlist_Product w INNER JOIN Product p ON w.serial_no=p.serial_number
WHERE p.category=@maxca3 AND ROWNUM <=1 AND w.serial_no<>@pro1 AND w.serial_no<>@pro2)

END
END

DECLARE @pro4 INT  --(2) ma3rafsh hatet3mel ezay
DECLARE @pro5 INT   --output nothing leh
DECLARE @pro6 INT   --6 products

DECLARE @name1 VARCHAR(20)
DECLARE @name2 VARCHAR(20)
DECLARE @name3 VARCHAR(20)

SELECT @name1=c1.customer_name --most similar ezay bardo
FROM CustomerAddstoCartProduct c ,CustomerAddstoCartProduct c1 
WHERE c.customer_name=@customername
END