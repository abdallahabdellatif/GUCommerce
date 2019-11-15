--Unregistered
EXEC customerRegister 'eslam221','eslam','hegazy','1234','esl@gm.com'
EXEC vendorRegister 'Ar','Ahmed','Ahmed','1234','er@gm.com', 'alarousi','11111'
EXEC vendorRegister 'Ar','s','b','212312','sfdasf@gm.com', 's','asdfas' --error should be thrown
EXEC customerRegister 'Ar','s','b','212312','sfdasf@gm.com' --error should be thrown; problem detected ;
-- Inserted in Subclass (unwanted) but error due to Superclass ;; need to handle

SELECT * FROM Users U  LEFT OUTER JOIN User_Addresses UA ON U.username=UA.username LEFT OUTER JOIN User_mobile_numbers UM ON U.username = UM.username
SELECT * FROM Customer C LEFT OUTER JOIN Users U ON C.username=U.username
SELECT * FROM Admins A LEFT OUTER JOIN Users U ON A.username=U.username
SELECT * FROM Vendor V LEFT OUTER JOIN Users U ON V.username=U.username
DELETE FROM  Customer WHERE username='Ar'
DELETE FROM  Users WHERE username='Ar'
--Registered:
SELECT * FROM dbo.userLogin ('eslam221','1234')
SELECT * FROM dbo.userLogin ('eslam221','wrongPassword')
SELECT * FROM dbo.userLogin ('Ar','wrongPassword')
SELECT * FROM dbo.userLogin ('Ar','1234')