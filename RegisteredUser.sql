
CREATE FUNCTION userLogin(@username VARCHAR(20), @password VARCHAR(20)) --a function better than proc?
RETURNS @tuple TABLE(success BIT,type SMALLINT) -- Es wants to make smallint INT as in the MS2 to be SAFE
AS
BEGIN 
DECLARE @s BIT 
DECLARE @t SMALLINT
IF(EXISTS(
SELECT *
FROM Users
WHERE username=@username AND password=@password))
BEGIN
SET @s='1'
IF(EXISTS(SELECT * FROM Customer WHERE username=@username))
SET @t=0
ELSE IF(EXISTS(SELECT * FROM Vendor WHERE username=@username))
SET @t=1
ELSE IF(EXISTS(SELECT * FROM Admins WHERE username=@username))
SET @t=2
ELSE IF(EXISTS(SELECT * FROM Delivery_Person WHERE username=@username))
SET @t=3
End
ELSE
BEGIN
SET @s='0'
SET @t=-1 -- eshme3na 1 !?  :v :v 
END
INSERT INTO @tuple VALUES(@s,@t)
RETURN
END



GO
CREATE PROC addMobile --b
@username VARCHAR(20), 
@mobile_number VARCHAR(20)
AS
BEGIN 
INSERT INTO User_mobile_numbers 
VALUES(@mobile_number,@username)
END

GO
CREATE PROC addAddress --c
@username VARCHAR(20), 
@address VARCHAR(100)
AS
BEGIN 
INSERT INTO User_Address VALUES(@address,@username)
END

