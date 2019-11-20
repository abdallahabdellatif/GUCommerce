TRUNCATE TABLE Customer
TRUNCATE TABLE Admins
TRUNCATE TABLE Users
TRUNCATE TABLE Delivery_Person
TRUNCATE TABLE Vendor
TRUNCATE TABLE User_mobile_numbers
TRUNCATE TABLE User_Addresses

-- Customer​:

EXEC customerRegister  ​'ahmed.ashraf' ,​ ' ahmed',  ​ ​'ashraf',   ​ 'pass123', '​ahmed@yahoo.com' 


EXEC vendorRegister  'eslam.mahmod', 'eslam' ​, 'mahmod',​ 'pass1234','hopa@gmail.com' , 'Market',​ '132132513'
--EXEC vendorRegister  'eslam.mahmo', 'eslam' ​, 'mahmod',​ 'pass1234','hopa@gmail.om' , 'Market',​ '132132513'

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

EXEC showProducts      --will not show distinct entries

EXEC ShowProductsbyPrice --same as above

EXEC Searchbyname 'blue' --same as above

EXEC AddQuestion 1, 'ahmed.ashraf', 'size?'

EXEC addToCart 'ahmed.ashraf' , 1

EXEC addToCart 'ahmed.ashraf' , 3

EXEC removefromCart 'ahmed.ashraf' , 3

EXEC createWishlist 'ahmed.ashraf' , 'fashion'

EXEC AddtoWishlist 'ahmed.ashraf' , 'fashion' , 1
EXEC AddtoWishlist 'ahmed.ashraf' , 'fashion' , 3

EXEC removefromWishlist 'ahmed.ashraf' , 'fashion' , 1

EXEC showWishlistProduct 'ahmed.ashraf' , 'fashion'  --product_desc  

EXEC viewMyCart 'ahmed.ashraf'   --product_desc
--------------------------------------till here done
DECLARE @price INT
EXEC calculatepriceOrder 'ahmed.ashraf' , @price OUTPUT         -- CHANGE IT TO PROCEDURE

EXEC Productsinorder 'ahmed.ashraf'    -- , orderID : The id of the last inserted order   

EXEC emptyCart 'ahmed.ashraf'         --- CHECK THE emptyCart PROCEDURE 

EXEC makeOrder 'ahmed.ashraf'       

EXEC cancelOrder 6

EXEC returnProduct 2 -- , orderID : The id of the order you have created

EXEC ShowproductsIbought 'ahmed.ashraf'

EXEC Rate	2 ,3 ,'ahmed.ashraf'

EXEC SpecifyAmount  'ahmed.ashraf' , 5 , null, 10.0
EXEC SpecifyAmount  'ahmed.ashraf' , 6 , 5.0, null

EXEC AddcreditCard '4444-5555-6666-8888' , '10/19/2028' , '232'  -- ,  customername varchar(20)  mawgooda fl procedure as an input bs msh mwgooda fl testcases

EXEC ChooseCreditCard     6     --creditcard varchar(20)mawgooda fl procedure as an input bs msh mwgooda fl testcases  

EXEC vewDeliveryTypes    -- 3adelt l procedure 3shan l output

EXEC Specifydeliverytype 6,1

DECLARE @days INT
EXEC trackRemainingDays 6 , 'ahmed.ashraf' , @days OUTPUT

EXEC Recommend 'ahmed.ashraf' 

-- VENDOR

EXEC postProduct 'eslam.mahmod' , 'pencil', 'stationary' , 'HB0.7' , 10.0 , 'red'

EXEC vendorviewProducts 'eslam.mahmod'

EXEC EditProduct  'eslam.mahmod' , 4 ,'pencil','stationary', 'HB0.7',10.0 ,'blue'

EXEC deleteProduct 'eslam.mahmod' , 4

EXEC viewQuestions 'hadeel.adel'

EXEC answerQuestions 'hadeel.adel' , 1, 'ahmed.ashraf' , '40'

EXEC addOffer  50, '11/10/2019'

EXEC applyOffer 'hadeel.adel' , 3 ,1 

EXEC checkandremoveExpiredoﬀer 3

--EXEC  checkandremoveExpiredoﬀer    malhash test case


-- Delivery Personnel

EXEC acceptAdminInvitation 'mohamed.tamer'

EXEC deliveryPersonUpdateInfo 'mohamed.tamer' , 'mohamed', 'tamer', 'pass16' ,	'mohamed.tamer@guc.edu.eg'

EXEC viewmyorders 'mohamed.tamer' -- _no int  el errror el fl procedure ghalebn l mafrood order no

EXEC specifyDeliveryWindow 'mohamed.tamer' ,1, 'Today between 10 am and 3 pm'

EXEC updateOrderStatusOutforDelivery 2

EXEC updateOrderStatusDelivered 2

