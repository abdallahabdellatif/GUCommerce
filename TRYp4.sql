--Unregistered
INSERT INTO Users (username,password,email,first_name,last_name)
VALUES ('Admin1','Admin1','admin1@admin.com','es','sab');
INSERT INTO Admins (username)VALUES ('Admin1') ;


EXEC customerRegister 'eslam221','eslam','hegazy','1234','esl@gm.com'
EXEC vendorRegister 'Ar','Ahmed','Ahmed','1234','er@gm.com', 'alarousi','11111'
EXEC vendorRegister 'Ar','s','b','212312','sfdasf@gm.com', 's','asdfas' --error should be thrown
EXEC customerRegister 'Ar','s','b','212312','sfdasf@gm.com' --error should be thrown; problem detected ;
-- Inserted in Subclass (unwanted) but error due to Superclass ;; need to handle

SELECT * FROM Users U  LEFT OUTER JOIN User_Addresses UA ON U.username=UA.username LEFT OUTER JOIN User_mobile_numbers UM ON U.username = UM.username
SELECT * FROM Customer C LEFT OUTER JOIN Users U ON C.username=U.username
SELECT * FROM Admins A LEFT OUTER JOIN Users U ON A.username=U.username
SELECT * FROM Vendor V LEFT OUTER JOIN Users U ON V.username=U.username
SELECT * FROM Delivery_Person DP LEFT OUTER JOIN Users U ON DP.username=U.username
DELETE FROM  Customer WHERE username='Ar'
DELETE FROM  Users WHERE username='Ar'
--Registered:
SELECT * FROM dbo.userLogin ('eslam221','1234')
SELECT * FROM dbo.userLogin ('eslam221','wrongPassword')
SELECT * FROM dbo.userLogin ('Ar','wrongPassword')
SELECT * FROM dbo.userLogin ('Ar','1234')
SELECT * FROM dbo.userLogin ('Admin','1234')
SELECT * FROM dbo.userLogin ('aDMin1','AdMIn1');
INSERT INTO Users (username,password) VALUES('d1','d1')
INSERT INTO Delivery_Person(username) VALUES ('d1') 
SELECT * FROM dbo.userLogin ('D1','D1'); -- case Insensitive
SELECT * FROM dbo.userLogin ('D1','D1'); -- correct with no spaces
SELECT * FROM dbo.userLogin ('D1','D1   '); --spaces AFTER seem to have NO Effect in VARCHAR ?
SELECT * FROM dbo.userLogin ('D1',' D1'); --spaces BEFORE makes it false


EXEC addMobile 'eslam221','01201165760'
EXEC addMobile 'eslam221','01201165762'
SELECT * FROM Users U  LEFT OUTER JOIN User_Addresses UA ON U.username=UA.username LEFT OUTER JOIN User_mobile_numbers UM ON U.username = UM.username
EXEC addAddress 'eslam221','5TH BALABIZO, CAIRO, Egypt'


--Customer


--