


-- a)

GO
CREATE PROC postProduct
@vendorUsername VARCHAR(20),
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description TEXT,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
INSERT INTO 
Product(vendor_username, product_name,category,product_description,final_price,color)
VALUES(@vendorUsername,@product_name,@category,@product_description,@price,@color)


-- b)

GO
CREATE PROC vendorviewProducts  --OUTPUT IS RECORDs
@vendorname VARCHAR(20)
AS
SELECT * 
FROM Vendor v INNER JOIN Product p
ON v.username = p.vendor_username
WHERE v.username = @vendorname


-- c)

GO
CREATE PROC EditProduct
@vendorname VARCHAR(20),
@serialnumber INT,
@product_name VARCHAR(20),
@category VARCHAR(20),
@product_description TEXT,
@price DECIMAL(10,2),
@color VARCHAR(20)
AS
BEGIN
UPDATE Product
SET vendor_username =@vendorname ,
--serial_number =  @serialnumber,    --- maynf3sh y update l primary key asl keda han3rf l product l han3mlo edit ezay
product_name = @product_name,
category = @category , 
product_description = @product_description , 
final_price = @price,
color = @color
WHERE serial_number = @serialnumber    -- hay update el product el nafs l serialnumber input??
END


-- d)

GO
CREATE PROC deleteProduct
@vendorname VARCHAR(20),
@serialnumber int
AS
DELETE FROM Product
WHERE serial_number = @serialnumber AND vendor_username = @vendorname


-- e)

GO
CREATE PROC viewQuestions
@vendorname VARCHAR(20)
AS
BEGIN
SELECT c.question
FROM Vendor v INNER JOIN Product p
ON v.username = p.vendor_username
INNER JOIN Customer_Question_Product c
ON c.serial_no = p.serial_number
WHERE v.username =@vendorname
END

-- f)

GO
CREATE PROC answerQuestions
@vendorname VARCHAR(20),
@serialno INT,
@customername VARCHAR(20),
@answer TEXT
AS
UPDATE Customer_Question_Product 
SET answer = @answer
FROM Product p INNER JOIN Customer_Question_Product c
ON c.serial_no = p.serial_number 
WHERE p.vendor_username = @vendorname AND p.serial_number = @serialno AND c.customer_name = @customername


-- g) w akhawatha

GO
CREATE PROC addOffer
@offeramount INT,
@expiry_date DATETIME
AS
INSERT INTO offer(offer_amount,expiry_date)            ---- MSH HANDLE HWAR ONE AT A TIME DA
VALUES(@offeramount,@expiry_date)


GO
CREATE PROC checkOfferonProduct
@serial INT,
@activeoffer BIT OUTPUT
AS
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


GO
CREATE PROC checkandremoveExpiredoffer
@offerid int
AS
DECLARE @expDate DATETIME
SELECT @expDate = expiry_date
FROM offer 
WHERE offer_id = @offerid
DECLARE @todaysDate DATETIME
SELECT @todaysDate = GETDATE()
IF @todaysDate > @expDate
BEGIN
DELETE FROM offer
WHERE offer_id = @offerid
END


GO
CREATE PROC applyOffer
@vendorname VARCHAR(20), 
@offerid INT,
@serial INT
AS
DECLARE @price DECIMAL(10,2)
DECLARE @offerAmount INT
SELECT @price = final_price , @offerAmount = offer_amount
FROM  Product p INNER JOIN offersOnProduct o
ON p.serial_number = o.serial_no
INNER JOIN offer oo
ON oo.offer_id = o.offer_id
WHERE p.vendor_username = @vendorname AND o.offer_id = @offerid           ---- MSH HANDLE HWAR ONE AT A TIME DA

DECLARE @newPrice INT
SET @newPrice = @price - @offerAmount

UPDATE Product
SET final_price = @newPrice
WHERE serial_number=@serial