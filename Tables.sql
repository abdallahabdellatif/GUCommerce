--IMPORTANT NOTE !!

--WHEN DECLARING ATTRIBUTES OF A TABLE CHECK IF IT'S REFERED BY A PROCEDURE TO KNOW IT'S TYPE 
--AND IF IT'S A VARCHAR HOW MANY CHARACTERS IT HAS TO BE ACCEPTED BY A PROCEDURE

--DONT FORGET REFERENTIAL INTEGRITY
--DONT RUN ANY SHIT 



CREATE TABLE Users(username VARCHAR(20), 
password VARCHAR(20), 
first_name VARCHAR(20), 
last_name VARCHAR(20), 
password VARCHAR(20), 
email VARCHAR(50));


CREATE TABLE User_mobile_numbers(mobile_number VARCHAR(20), 
username VARCHAR(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE User_Addresses(address VARCHAR(20), 
username VARCHAR(20)
PRIMARY KEY(address,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Customer(username VARCHAR(20), 
points INT,							-- Not mentioned explicitly
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admins(username VARCHAR(20),
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE Vendor(username VARCHAR(20), 
activated BIT,						-- Not mentioned explicitly
company_name VARCHAR(20), 
bank_acc_no VARCHAR(20), 
admin_username VARCHAR(20)
PRIMARY KEY (username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins ON DELETE	SET NULL ON UPDATE CASCADE
			--WHAT SHOULD WE DO HERE if an Admin is DELETED !? TAKE CARE
)

CREATE TABLE Delivery_Person(username VARCHAR(20), 
is_activated BIT --NOT MENTIONED EXPLICITLY
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
)
--------------

CREATE TABLE Credit_Card(number VARCHAR(20), -- how 20 ?!! shouldn't it be 16 !!!!?
expiry_date --what ?, 
cvv_code	--WHAT
PRIMARY KEY (number)
)
CREATE TABLE Delivery(id INT IDENTITY, --Not mentioned explicitly
time_duration INT, 
fees DECIMAL (5,3), 
username VARCHAR(20),
-- delivery_type VARCHAR(20)  --exists in MS2 inputs , doesn't exist in ERD / Schema !!
PRIMARY KEY (id)
FOREIGN KEY (username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE -- IS THIS TRUE !?
)
CREATE TABLE Orders(order_no INT IDENTITY, -- identity is true,right ??
order_date DATETIME -- Not mentioned explicitly, 
total_amount decimal(10,3), -- not mentioned explicilty ; but price is decimal(10,2) del_fees is decimal(5,3), others are either(10,2) or int, 
cash_amount DECIMAL(10,2), -- I think it is the as in (o) in page 4
credit_amount DECIMAL(10,2), -- I think it is the as in (o) in page 4
payment_type,  -- BALABIZO ;; WHAT IS THIS !!?
order_status VARCHAR(20), --Not mentioned explicitly 
remaining_days INT,  -- Mentioned in (s) in page 4 
time_limit , 	--BALABIZO ;; WHAT IS THIS !!?
customer_name VARCHAR(20), 
delivery_id INT, 
creditCard_number VARCHAR(20)
PRIMARY KEY (order_no),
FOREIGN KEY (customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE, -- if a customer is deleted; then all his orders should be deleted ?
FOREIGN KEY (delivery_id) REFERENCES Delivery ON DELETE CASCADE ON UPDATE CASCADE -- is it so?,
FOREIGN KEY (creditCard_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE 
	-- I THINK THE LAST SHOULD BE NO ACTION ???
)




CREATE TABLE Product(serial_no INT, 
product_name VARCHAR(20), 
category VARCHAR(20), 
product_description TEXT, -- IS 'TEXT'WRITTED THIS SAME WAY ?
final_price DECIMAL(10,2),-- IT is written in the MS2 as price not "final_price" !?, 
color VARCHAR(20), 
available BIT, --Not mentioned explicitly
rate INT, -- (n) in page 4 
vendor_username VARCHAR(20), 
customer_username VARCHAR(20), 
customer_order_id INT,
PRIMARY KEY (serial_no),
FOREIGN KEY(vendor_username) REFERENCES Vendor  ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(customer_order_id) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE
)



CREATE TABLE Product(
serial_number INT IDENTITY,
p_name VARCHAR(20),
price DECIMAL(10,2),
rate DECIMAL(2,2),
color VARCHAR(20), --woat?
image VARCHAR(20), --woat again?
description VARCHAR(100), --is it stated in procs?
category VARCHAR(20),
PRIMARY KEY(serial_number)
FOREIGN KEY (order_number) REFERENCES Orders ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cutsomer_username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE,
);




CustomerAddstoCartProduct(serial_no, customer_name)

CustomerAddstoCartProduct.serial_no References Product
CustomerAddstoCartProduct.customer_name References Customer
Todays_Deals(deal_id, deal_amount, expiry_date, admin_username)
----------------
Todays_Deals.admin_username References Admins
Todays_Deals_Product(deal_id, serial_no, issue_date)
---------------------
Todays_Deals_Product.deal_id References Todays_Deals
Todays_Deals_Product.serial_no References Product
offer(offer_id, offer_amount, expiry_date)
offersOnProduct(offer_id, serial_no)
-----------------------
offersOnProduct.offer_id References offer
offersOnProduct.serial_no References Product
Customer_Question_Product(serial_no, customer_name, question, answer)
------------ ------------------
Customer_Question_Product.serial_no References Product
Customer_Question_Product.customer_name References Customer
Wishlist(username, name)
-------------
Wishlist.username References Customer
Giftcard(code, expiry_date, amount, username)
-----------
Giftcard.username References Admins
Wishlist_Product(username, wish_name, serial_no)
---------------------------------------
Wishlist_Product.username References Wishlist
Wishlist_Product.wish_name References Wishlist
Wishlist_Product.serial_no References Product
Admin_Customer_Giftcard(code, customer_name, admin_username)
---------------------------- -------------------
Admin_Customer_Giftcard.code References Giftcard
Admin_Customer_Giftcard.customer_name References Customer
Admin_Customer_Giftcard.admin_username References Admins
Admin_Delivery_Order(delivery_username, order_no, admin_username, delivery_window)
----------------------------------- ---------------------
Admin_Delivery_Order.delivery_username References Delivery_person
Admin_Delivery_Order.order_no References orders
Admin_Delivery_Order.admin_username References Admins
Customer_CreditCard(customer_name, cc_number)
----------------------------------
Customer_CreditCard.customer_name References Customer
Customer_CreditCard.cc_number References Credit_Card