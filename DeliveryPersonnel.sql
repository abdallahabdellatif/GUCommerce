
--a
CREATE PROC acceptAdminInvitation
@delivery_username VARCHAR(20)
AS
BEGIN
UPDATE Delivery_Person
SET is_activated='1'
WHERE username=@delivery_username
END;

GO
--b
CREATE PROC deliveryPersonUpdateInfo
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
BEGIN
UPDATE Users
SET first_name=@first_name,
last_name=@last_name,
password=@password,
email=@email
WHERE username=@username
END;

GO
CREATE PROC viewmyorders	--NEW C
@deliveryperson varchar(20)	--todoooo : there was something wrong in MS2 ; Some Mysterious another input !?
AS
BEGIN
SELECT O.*
FROM  Orders O INNER JOIN  Admin_Delivery_Order ADO ON O.order_no = ADO.order_no
WHERE ADO.delivery_username = @deliveryperson
END

GO
--c
CREATE PROC specifyDeliveryWindow
@delivery_username VARCHAR(20),
@order_no INT,
@delivery_window VARCHAR(50)
AS
BEGIN
UPDATE Admin_Delivery_Order
SET delivery_window=@delivery_window
WHERE order_no=@order_no AND delivery_username=@delivery_username
END

GO
--d
CREATE PROC updateOrderStatusOutforDelivery
@order_no INT
AS
BEGIN
UPDATE Orders
SET order_status='out for delivery'
WHERE order_no=@order_no
END

GO 
--e
CREATE PROC updateOrderStatusDelivered
@order_no INT
AS
BEGIN
UPDATE Orders
SET order_status='delivered'
WHERE order_no=@order_no
END