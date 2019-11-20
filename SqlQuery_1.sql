GO
CREATE VIEW CartsProducts
AS
SELECT *
FROM Product p INNER JOIN CustomerAddstoCartProduct adc ON adc.seriaL_no=p.serial_no

GO
CREATE VIEW WishlistProducts
AS
Select * FROM Wishlist_Product wp INNER JOIN Product p ON wp.serial_no=p.serial_no

GO
CREATE PROCEDURE recommend
@customername varchar(20)
AS
BEGIN
DECLARE @maxca1 VARCHAR(20)
DECLARE @maxca2 VARCHAR(20)
DECLARE @maxca3 VARCHAR(20)
SET @maxca1='xx'
SET @maxca2='xx'
SET @maxca3='xx'
DECLARE @pro1 INT
DECLARE @pro2 INT 
DECLARE @pro3 INT
SET @pro1=-1
SET @pro2=-1
SET @pro3=-1 
IF(EXISTS(SELECT MAX(cp.category)
FROM CartsProducts cp
WHERE cp.customer_name=@customername ))
BEGIN
SELECT @maxca1=MAX(cp.category)
FROM CartsProducts cp
WHERE cp.customer_name=@customername 

DELETE FROM CartsProducts  
WHERE category=@maxca1 AND customer_name=@customername

   IF(EXISTS(SELECT MAX(cp.category)
   FROM CartsProducts cp
   WHERE cp.customer_name=@customername ))
   BEGIN
   SELECT @maxca2=MAX(cp.category)
   FROM CartsProducts cp
   WHERE cp.customer_name=@customername 

   DELETE FROM CartsProducts  
   WHERE category=@maxca2 AND customer_name=@customername

        IF(EXISTS(SELECT MAX(cp.category)
        FROM CartsProducts cp
        WHERE cp.customer_name=@customername ))
        BEGIN
        SELECT @maxca3=MAX(cp.category)
        FROM CartsProducts cp
        WHERE cp.customer_name=@customername 
		END
   END
End

  IF (EXISTS(Select wp.category,count(*) FROM WishlistProducts wp WHERE wp.category IN (@maxca1,@maxca2,@maxca3) GROUP by wp.category having COUNT(*)>=1))
  BEGIN
  SELECT @pro1=COUNT(wp.serial_no)
  FROM WishlistProduct wp
  WHERE wp.category IN (@maxca1,@maxca2,@maxca3)
  GROUP BY wp.serial_no
  HAVING COUNT(wp.serial_no)=(SELECT MAX(C.X) FROM (SELECT wp2.serial_no, COUNT(*) AS X FROM WishlistProducts wp2
  WHERE wp2.category IN(@maxca1,@maxca2,@maxca3)
  Group by wp2.serial_no)AS C)
  END

  DELETE FROM WishlistProduct
  WHERE serial_no=@pro1

  IF (EXISTS(Select wp.category,count(*) FROM WishlistProducts wp WHERE wp.category IN (@maxca1,@maxca2,@maxca3) GROUP by wp.category having COUNT(*)>=1))
  BEGIN
  SELECT @pro2=COUNT(wp.serial_no)
  FROM WishlistProduct wp
  WHERE wp.category IN (@maxca1,@maxca2,@maxca3)
  GROUP BY wp.serial_no
  HAVING COUNT(wp.serial_no)=(SELECT MAX(C.X) FROM (SELECT wp2.serial_no, COUNT(*) AS X FROM WishlistProducts wp2
  WHERE wp2.category IN(@maxca1,@maxca2,@maxca3)
  Group by wp2.serial_no)AS C)
  END

  DELETE FROM WishlistProduct
  WHERE serial_no=@pro2

  IF (EXISTS(Select wp.category,count(*) FROM WishlistProducts wp WHERE wp.category IN (@maxca1,@maxca2,@maxca3) GROUP by wp.category having COUNT(*)>=1))
  BEGIN
  SELECT @pro3=COUNT(wp.serial_no)
  FROM WishlistProduct wp
  WHERE wp.category IN (@maxca1,@maxca2,@maxca3)
  GROUP BY wp.serial_no
  HAVING COUNT(wp.serial_no)=(SELECT MAX(C.X) FROM (SELECT wp2.serial_no, COUNT(*) AS X FROM WishlistProducts wp2
  WHERE wp2.category IN(@maxca1,@maxca2,@maxca3)
  Group by wp2.serial_no)AS C)
  END
  --other 3 products


  --at the end
  SELECT *
  FROM Products
  WHERE serial_no IN (@pro1,@pro2,@pro3,@pro4,@pro5,@pro6)
END		