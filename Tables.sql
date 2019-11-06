--IMPORTANT NOTE !!

--WHEN DECLARING ATTRIBUTES OF A TABLE CHECK IF IT'S REFERED BY A PROCEDURE TO KNOW IT'S TYPE 
--AND IF IT'S A VARCHAR HOW MANY CHARACTERS IT HAS TO BE ACCEPTED BY A PROCEDURE

--DONT FORGET REFERENTIAL INTEGRITY
--DONT RUN ANY SHIT 
-- RUN ALL THE SHIT --AROUSY


CREATE TABLE Users(
username VARCHAR(20), 
password VARCHAR(20), 
first_name VARCHAR(20), 
last_name VARCHAR(20),  
email VARCHAR(50),
PRIMARY KEY (username)
);


CREATE TABLE User_mobile_numbers(
mobile_number VARCHAR(20), 
username VARCHAR(20),
PRIMARY KEY(mobile_number,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE User_Addresses(
address VARCHAR(20), 
username VARCHAR(20)
PRIMARY KEY(address,username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Customer(
username VARCHAR(20), 
points INT,							-- Not mentioned explicitly
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Admins(
username VARCHAR(20),
PRIMARY KEY(username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Vendor(
username VARCHAR(20), 
activated BIT,						-- Not mentioned explicitly
company_name VARCHAR(20), 
bank_acc_no VARCHAR(20), 
admin_username VARCHAR(20)
PRIMARY KEY (username),
FOREIGN KEY(username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(admin_username) REFERENCES Admins -- ON UPDATE CASCADE
			--WHAT SHOULD WE DO HERE if an Admin is DELETED !? TAKE CARE
);


CREATE TABLE Delivery_Person(
username VARCHAR(20), 
is_activated BIT --NOT MENTIONED EXPLICITLY
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Credit_Card(
number VARCHAR(20), -- how 20 ?!! shouldn't it be 16 !!!!? msh far2a ya esss -- ok :)
expiry_date VARCHAR(10),--what ?, 
--cvv_code VARCHAR(20)	--WHAT-- habda mny 	
cvv_code CHAR(3)	--IT should always be 3 and only 3 digits I Think !
PRIMARY KEY (number)
);



CREATE TABLE Delivery(
id INT IDENTITY, --Not mentioned explicitly
time_duration INT, 
fees DECIMAL (5,3), 
username VARCHAR(20),
-- delivery_type VARCHAR(20)  --exists in MS2 inputs , doesn't exist in ERD / Schema !!
PRIMARY KEY (id),
FOREIGN KEY (username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE -- IS THIS TRUE !?
);


CREATE TABLE Orders(
order_no INT IDENTITY, -- identity is true,right ??
order_date DATETIME, -- Not mentioned explicitly, 
total_amount decimal(10,2), -- not mentioned explicilty ;
-- but price is decimal(10,2) del_fees is decimal(5,3), others are either(10,2) or int, 
--(j) on page 3 ; specifes that price of an order is DECIMAL(10,2);
cash_amount DECIMAL(10,2), -- I think it is the as in (o) in page 4
credit_amount DECIMAL(10,2), -- I think it is the as in (o) in page 4
payment_type VARCHAR(20),  -- BALABIZO ;; WHAT IS THIS !!?
order_status VARCHAR(20), --Not mentioned explicitly 
remaining_days INT,  -- Mentioned in (s) in page 4 
time_limit VARCHAR(20) , 	--BALABIZO ;; WHAT IS THIS !!?
customer_name VARCHAR(20), 
delivery_id INT, 
creditCard_number VARCHAR(20),
PRIMARY KEY (order_no),
FOREIGN KEY (customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE, -- if a customer is deleted; then all his orders should be deleted ?
FOREIGN KEY (delivery_id) REFERENCES Delivery,-- ON DELETE CASCADE ON UPDATE CASCADE, -- is it so?,
FOREIGN KEY (creditCard_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE 
	-- I THINK THE LAST SHOULD BE NO ACTION ???
);


CREATE TABLE Product(
serial_no INT IDENTITY,
product_name VARCHAR(20),
category VARCHAR (20),
product_description text,
-- in eerd they have 2 att. price and final_price ; but in schema only final_price
final_price DECIMAL(10,2),	--On (a) and (c) in page 5
color VARCHAR (20), 		--on (a) page 5
available BIT , -- didn't mention type
rate INT, -- (n) in page 4
-- msh fahem asdak eh ya ess :D	 
-- إلى عرووووسي
-- 2asdi en l m3loma di gaya mn p4 fe MS_II.pdf fe l point rakam (n)
vendor_username VARCHAR(20), 
customer_username VARCHAR(20), 
customer_order_id INT,
PRIMARY KEY(serial_no),
FOREIGN KEY(vendor_username) REFERENCES Vendor ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cutsomer_username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE, 
-- fl schema msh m3mola dashed line enaha foreign key ezay ????!
-- YOU ARE RIGHT AROSI <3 
FOREIGN KEY(customer_order_id) REFERENCES Orders --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE CustomerAddstoCartProduct(
serial_no INT, 
customer_name VARCHAR (20),
PRIMARY KEY (serial_no,customer_name),
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Todays_Deals(
deal_id INT IDENTITY,
deal_amount INT,
expiry_date DATETIME,
admin_username VARCHAR(20),
PRIMARY KEY (deal_id),
FOREIGN KEY (admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Todays_Deals_Product(
deal_id INT,
serial_no INT,
issue_date datetime, ---- didn't state type
PRIMARY KEY (deal_id ,serial_no),
FOREIGN KEY (deal_id) REFERENCES Todays_Deals , --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE offer(
offer_id INT IDENTITY,
offer_amount INT,
expiry_date DATETIME,
PRIMARY KEY (offer_id)
);


CREATE TABLE offersOnProduct(
offer_id INT,
serial_no INT,
PRIMARY KEY (offer_id , serial_no),
FOREIGN KEY (offer_id) REFERENCES offer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Customer_Question_Product(
serial_no INT,
customer_name VARCHAR(20),
question VARCHAR(50), -----question type is not stated	-- see (d) in page 2
answer TEXT,	--TRUE (y) <3
PRIMARY KEY (serial_no ,customer_name),
FOREIGN KEY (serial_no) REFERENCES Product ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Wishlist(
username VARCHAR (20),
name VARCHAR (20),
PRIMARY KEY (username , name),
FOREIGN KEY (username) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Giftcard(
code VARCHAR(10),
expiry_date DATETIME,
amount INT, 
username VARCHAR(20),
PRIMARY KEY (code),
FOREIGN KEY (username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Wishlist_Product(
username VARCHAR (20),
wish_name VARCHAR (20),
serial_no INT,
PRIMARY KEY (username , wish_name , serial_no),
FOREIGN KEY (username , wish_name) REFERENCES WishList ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (serial_no) REFERENCES Product --ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Admin_Customer_Giftcard(
code VARCHAR(10),
customer_name VARCHAR (20),
admin_username VARCHAR(20),
PRIMARY KEY (code , customer_name ,admin_username),
FOREIGN KEY (code) REFERENCES Giftcard ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (customer_name) REFERENCES Customer , --ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (admin_username) REFERENCES Admins --ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Admin_Delivery_Order(
delivery_username VARCHAR (20),
order_no INT,
admin_username VARCHAR (20), 
delivery_window VARCHAR (50),	--(c) in page 7
PRIMARY KEY (delivery_username,order_no),
FOREIGN KEY (delivery_username) REFERENCES Delivery_person,-- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (order_no) REFERENCES Orders , -- ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (admin_username) REFERENCES Admins ON DELETE CASCADE ON UPDATE CASCADE);


CREATE TABLE Customer_CreditCard(
customer_name VARCHAR(20), 
cc_number VARCHAR (20),
PRIMARY KEY (customer_name,cc_number),
FOREIGN KEY (customer_name) REFERENCES Customer ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (cc_number) REFERENCES Credit_Card ON DELETE CASCADE ON UPDATE CASCADE
);


