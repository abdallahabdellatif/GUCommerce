--users
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('hana.aly','hana','aly','pass1','hana.aly@guc.edu.eg')
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('ammar.yasser','ammar','yasser','pass4','ammar.yasser@guc.edu.eg')
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('nada.sharaf','nada','sharaf','pass7','nada.sharaf@guc.edu.eg')
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('hadeel.adel','hadeel','adel','pass13','hadeel.adel@guc.edu.eg')
INSERT INTO Users(username,first_name,last_name,password,email)
VALUES('mohamed.tamer','mohamed','tamer','pass16','mohamed.tamer@guc.edu.eg')


--admin
INSERT INTO Admins(username)
VALUES('nada.sharaf')
INSERT INTO Admins(username)
VALUES('hana.aly')

--customer
INSERT INTO Customer
VALUES('ammar.yasser',15)

--cart
INSERT INTO CustomerAddstoCartProduct
VALUES(1,'ammar.yasser')

select *
from Vendor

--vendor
INSERT INTO Vendor
VALUES('hadeel.adel',1,'Dello',47449349234,'hana.aly')

--delivery person
INSERT INTO Delivery_Person
VALUES('mohamed.tamer',1)

--User Address	
INSERT INTO User_Addresses 
VALUES ('New Cairo' , 'hana.aly')
INSERT INTO User_Addresses
VALUES('Heliopolis' , 'hana.aly')

--User Mobile
INSERT INTO User_mobile_numbers
VALUES ('01111111111' ,'hana.aly')
INSERT INTO User_mobile_numbers
VALUES ('1211555411' ,'hana.aly')

-- Credit Card
INSERT INTO Credit_Card
VALUES ('4444-5555-6666-8888' , '2028-10-19' , '232')

--Delivery
INSERT INTO Delivery(delivery_type,time_duration,fees)
VALUES ('pick-up' , 7 , 10.0)
INSERT INTO Delivery(delivery_type,time_duration,fees)
VALUES ('regular' , 14 , 30.0)
INSERT INTO Delivery(delivery_type,time_duration,fees)
VALUES ('speedy' , 1 , 50.0)

--Product
SET IDENTITY_INSERT Product ON;
INSERT INTO Product(serial_no, product_name, category, product_description, price, final_price, color, available, rate, vendor_username, customer_username ,customer_order_id)
VALUES(1,'Bag','Fashion','backbag',100.0,100.0,'yellow',1,0,'hadeel.adel',null,null);
INSERT INTO Product(serial_no, product_name, category, product_description, price, final_price, color, available, rate, vendor_username, customer_username ,customer_order_id)
VALUES(3,'Blue pen','stationary','useful pen',10.0,10.0,'Blue',1,0,'hadeel.adel',null,null);
INSERT INTO Product(serial_no, product_name, category, product_description, price, final_price, color, available, rate, vendor_username, customer_username ,customer_order_id)
VALUES(4,'Blue pen','stationary','useful pen',10.0,10.0,'Blue',0,0,'hadeel.adel',null,null);
SET IDENTITY_INSERT Product OFF;

-- Todays Deals
SET IDENTITY_INSERT Todays_Deals ON;
INSERT INTO Todays_Deals(deal_id ,deal_amount ,expiry_date,admin_username)
VALUES (1,30,'2019-11-30','hana.aly')
INSERT INTO Todays_Deals(deal_id ,deal_amount ,expiry_date,admin_username)
VALUES (2,40,'2019-11-18','hana.aly')
INSERT INTO Todays_Deals(deal_id ,deal_amount ,expiry_date,admin_username)
VALUES (3,50,'2019-12-12','hana.aly')
INSERT INTO Todays_Deals(deal_id ,deal_amount ,expiry_date,admin_username)
VALUES (4,10,'2019-11-12','nada.sharaf')
SET IDENTITY_INSERT Todays_Deals OFF;

select *
from Todays_Deals

--TRUNCATE TABLE Todays_Deals_Product
--TRUNCATE TABLE Todays_Deals
-- Offer
SET IDENTITY_INSERT offer ON;
INSERT INTO offer(offer_id,offer_amount,expiry_date)
Values	(1,50,'2019-11-30')
SET IDENTITY_INSERT offer OFF;

--Wishlist
INSERT INTO Wishlist
VALUES ('ammar.yasser','fashion')

-- Wishlist product
INSERT INTO Wishlist_Product
VALUES('ammar.yasser','fashion',1)
INSERT INTO Wishlist_Product
VALUES('ammar.yasser','fashion',4)
TRUNCATE TABLE Wishlist_Product;
/*INSERT INTO Giftcard
VALUES('G101','18/11/2019',100, na2es le admin username bs msh mwgood fl insertion data) */

--Customer credit card
INSERT INTO Customer_CreditCard
VALUES('ammar.yasser','4444-5555-6666-8888')


