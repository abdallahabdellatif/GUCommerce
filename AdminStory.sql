--ADMIN STORY

CREATE PROC activateVendors --a
@admin_username varchar(20),
@vendor_username varchar(20)
AS
BEGIN
IF (EXISTS(SELECT * FROM Vendor WHERE username=@vendor_username AND activated='0'))
UPDATE Vendor
SET activated='1',admin_username=@admin_username
FROM Vendor
WHERE username=@vendor_username
ELSE 
print 'This vendor account is already activated'
END

GO
CREATE PROC inviteDeliveryPerson --b ,recheck
@delivery_username varchar(20), @delivery_email varchar(50)
AS
INSERT INTO Users(username,email) VALUES (@delivery_username,@delivery_email)
INSERT INTO Delivery_Person VALUES(@delivery_username,'0') --insert in the system as deactivated

GO
CREATE PROC reviewOrders --c
AS
SELECT * FROM Orders

GO
CREATE PROC updateOrderStatusInProcess --d
@order_no int
AS
UPDATE Orders
SET order_status='in process'
FROM Orders
WHERE order_no=@order_no

GO
CREATE PROC addDelivery --e
@delivery_type varchar(20),
@time_duration int,
@fees decimal(5,3),
@admin_username varchar(20)
AS
INSERT INTO Delivery VALUES (@time_duration,@fees,@admin_username)--delivery type eh elkalam?? 


GO
CREATE PROC assignOrdertoDelivery --f ,, delivery window??
@delivery_username varchar(20),
@order_no int,
@admin_username varchar(20)
AS
INSERT INTO Admin_Delivery_Order(delivery_username,order_no,admin_username) 
VALUES (@delivery_username,@order_no,@admin_username)

GO
CREATE PROC createTodaysDeal --g1
@deal_amount int,
@admin_username varchar(20),
@expiry_date datetime
AS
INSERT INTO Todays_Deals
VALUES(@deal_amount ,@expiry_date,@admin_username)

--g2,g3,g4,h,i left