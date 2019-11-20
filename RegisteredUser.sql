
CREATE PROC userLogin
@username VARCHAR(20), @password VARCHAR(20),@success BIT OUTPUT,@type INT OUTPUT
AS
BEGIN 
--DECLARE @s BIT 
--DECLARE @t SMALLINT
IF(EXISTS(
SELECT *
FROM Users
WHERE username=@username AND password=@password))
BEGIN
SET @success='1'
IF(EXISTS(SELECT * FROM Customer WHERE username=@username))
SET @type=0
ELSE IF(EXISTS(SELECT * FROM Vendor WHERE username=@username))
SET @type=1
ELSE IF(EXISTS(SELECT * FROM Admins WHERE username=@username))
SET @type=2
ELSE IF(EXISTS(SELECT * FROM Delivery_Person WHERE username=@username))
SET @type=3
print @success
print @type
End
ELSE
BEGIN
SET @success='0'
print @success
set @type=-1
print @type
END
END



GO
CREATE PROC addMobile --b
@username VARCHAR(20), 
@mobile_number VARCHAR(20)
AS
BEGIN 
if(not exists(select * from User_mobile_numbers where username=@username AND mobile_number=@mobile_number))
begin
INSERT INTO User_mobile_numbers 
VALUES(@mobile_number,@username)
end
select * from User_mobile_numbers where username=@username 
END

GO
CREATE PROC addAddress --c
@username VARCHAR(20), 
@address VARCHAR(100)
AS
BEGIN 
if(not exists(select * from User_Addresses where username=@username AND address=@address))
begin
INSERT INTO User_Addresses VALUES(@address,@username)
end
select * from User_Addresses where username=@username 
END

