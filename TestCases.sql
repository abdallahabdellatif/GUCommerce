
-- Customer​:

EXEC customerRegister  ​'ahmed.ashraf' ,​ ' ahmed',  ​ ​'ashraf',   ​ 'pass123', '​ahmed@yahoo.com'


EXEC vendorRegister  'eslam.mahmod', 'eslam' ​, 'mahmod',​ 'pass1234', 
'hopa@gmail.com' , 'Market',​ '132132513'

DECLARE @success bit  ,@type int 
EXEC userLogin  'eslam.mahmod' , 'pass123', @success OUTPUT , @type OUTPUT

DECLARE @success bit  ,@type int 
EXEC userLogin  'eslam.mahmod' , 'pass1234', @success OUTPUT , @type OUTPUT
																																											-- userLogin lazm ne7awelha procedure not a function w ykon leha output success w type
DECLARE @success bit  ,@type int 
EXEC userLogin  'ahmed.ashraf' , 'pass123', @success OUTPUT , @type OUTPUT

DECLARE @success bit  ,@type int 
EXEC userLogin  'ahmed.ashraf' , 'pass', @success OUTPUT , @type OUTPUT

EXEC addMobile 'ahmed.ashraf' , '01111211122'

EXEC addMobile 'ahmed.ashraf' , '0124262652'

EXEC addAddress 'ahmed.ashraf' , 'nasr city'   -- tested till here

EXEC showProducts      -- CHANGE IT TO PROCEDURE

EXEC ShowProductsbyPrice

EXEC Searchbyname 'blue'

EXEC AddQuestion 1, 'ahmed.ashraf', 'size?'

EXEC addToCart 'ahmed.ashraf' , 1
--/*
	SET IDENTITY_INSERT Product ON;
	INSERT INTO Product(serial_no, product_name, category, product_description, price, final_price, color, available, rate, vendor_username, customer_username ,customer_order_id)
	VALUES(2,'blue pen','Fashion','useful pen',10.0,10.0,'Blue',0,0,'hadeel.adel',null,null);
	SET IDENTITY_INSERT Product OFF;
--*/
EXEC addToCart 'ahmed.ashraf' , 2

EXEC removefromCart 'ahmed.ashraf' , 2

EXEC createWishlist 'ahmed.ashraf' , 'fashion'

EXEC AddtoWishlist 'ahmed.ashraf' , 'fashion' , 1
EXEC AddtoWishlist 'ahmed.ashraf' , 'fashion' , 2
EXEC removefromWishlist 'ahmed.ashraf' , 'fashion' , 1

EXEC showWishlistProduct 'ahmed.ashraf' , 'fashion'    -- no procedure for showWishlistProduct

EXEC viewMyCart 'ahmed.ashraf'   -- no procedure for viewMyCart
EXEC viewMyCart 'ammar.yasser'   -- no procedure for viewMyCart
DECLARE @price INT
EXEC calculatepriceOrder 'ahmed.ashraf' , @price OUTPUT         -- CHANGE IT TO PROCEDURE

--EXEC viewMyCart 'ammar.yasser'
EXEC Productsinorder 'ahmed.ashraf', 1   -- , orderID : The id of the last inserted order   
--EXEC viewMyCart 'ammar.yasser'
EXEC emptyCart 'ahmed.ashraf'         --- CHECK THE emptyCart PROCEDURE 

EXEC makeOrder 'ahmed.ashraf'
SELECT * FROM Orders
SELECT * FROM Customer
EXEC cancelOrder 2--6--5--3--2--1--6

--/*
EXEC addToCart 'ahmed.ashraf', 2
EXEC makeOrder 'ahmed.ashraf'
--*/
EXEC returnProduct 2 -- , orderID : The id of the order you have created

EXEC ShowproductsIbought 'ahmed.ashraf'

EXEC Rate	2 ,3 ,'ahmed.ashraf'

EXEC SpecifyAmount  'ahmed.ashraf' , 1 , null, 10.0
EXEC SpecifyAmount  'ahmed.ashraf' , 2 , 96, null

EXEC AddcreditCard '4444-5555-6666-9999' , '10/19/2028' , '232', 'ahmed.ashraf'  --customername varchar(20)

EXEC ChooseCreditCard     6     --creditcard varchar(20)mawgooda fl procedure as an input bs msh mwgooda fl testcases  

EXEC vewDeliveryTypes    -- 3adelt l procedure 3shan l output

EXEC Specifydeliverytype 6,1
EXEC Specifydeliverytype 4,1

DECLARE @days INT
EXEC trackRemainingDays 4 , 'ahmed.ashraf' , @days OUTPUT

EXEC Recommend 'ahmed.ashraf' 

-- VENDOR

EXEC postProduct 'eslam.mahmod' , 'pencil', 'stationary' , 'HB0.7' , 10.0 , 'red'

SELECT *
from Product

DELETE FROM Product where product_name = 'pencil'

EXEC vendorviewProducts 'eslam.mahmod'

EXEC EditProduct  'eslam.mahmod' , 2 ,'pencil','stationary', 'HB0.7',10.0 ,'blue'

EXEC deleteProduct 'eslam.mahmod' , 2

EXEC viewQuestions 'hadeel.adel'

EXEC answerQuestions 'hadeel.adel' , 1, 'ahmed.ashraf' , '40'

EXEC addOffer  2, '11/10/2019'

select * from offersOnProduct
select * from offer

EXEC applyOffer 'hadeel.adel' , 1,2

EXEC checkandremoveExpiredoﬀer 2

--EXEC  checkandremoveExpiredoﬀer    malhash test case


-- Delivery Personnel

EXEC acceptAdminInvitation 'mohamed.tamer'

EXEC deliveryPersonUpdateInfo 'mohamed.tamer' , 'mohamed', 'tamer', 'pass16' ,	'mohamed.tamer@guc.edu.eg'

EXEC viewmyorders 'mohamed.tamer' -- _no int  el errror el fl procedure ghalebn l mafrood order no

EXEC specifyDeliveryWindow 'mohamed.tamer' ,1, 'Today between 10 am and 3 pm'

EXEC updateOrderStatusOutforDelivery 2

EXEC updateOrderStatusDelivered 2

select *
from Delivery_Person

select * from Orders


select * from Giftcard
select * from Admin_Customer_Giftcard
select * from Customer
EXEC createGiftCard 'gx','2019-12-31',40,'hana.aly'
EXEC createGiftCard 'gy','2019-12-30',40,'hana.aly'
EXEC createGiftCard 'gz','2019-11-25',3,'hana.aly'
EXEC giveGiftCardtoCustomer 'G101', 'ahmed.ashraf','hana.aly'
EXEC giveGiftCardtoCustomer 'gx', 'ahmed.ashraf','hana.aly'
EXEC giveGiftCardtoCustomer 'gy', 'ahmed.ashraf','hana.aly'
EXEC giveGiftCardtoCustomer 'gz', 'ahmed.ashraf','hana.aly'
UPDATE CUSTOMER set points =183 WHERE username='ahmed.ashraf'
delete from Admin_Customer_Giftcard where code='g101' OR code='gx' OR code='gy'
UPDATE Giftcard SET username='hana.aly' WHERE code='G101'
UPDATE Giftcard SET expiry_date = '2020-1-1' WHERE code='g101'
UPDATE Admin_Customer_Giftcard SET remaining_points=40 WHERE code='gy'
