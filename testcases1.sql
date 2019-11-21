--ana a3adt a8ayar fy el inputs 3alshan atest 3edel

--a
EXEC activateVendors 'hana.aly' , 'eslam.mahmod'
--table vendor
SELECT * FROM Vendor

--b
EXEC inviteDeliveryPerson 'mohamed.tamer' , 'moha@gmail.com' 
--table user
SELECT * FROM Users
--table delivery person
SELECT * FROM Delivery_person

--c
EXEC reviewOrders
--table order
SELEcT * FROM Orders

SELECT * FROM Customer

--d
EXEC updateOrderStatusInProcess 1 -- 1 da ana ely 7ato howa al whatever order number you created

--e
EXEC addDelivery 'pick-up', 7, 10, 'hana.aly'
--table delivery
SELECT * FROM Delivery

--f
EXEC assignOrdertoDelivery 'mohamed.tamer' , 1 ,'hana.aly'
--table admin delivery order
SELECT * FROM Admin_Delivery_Order

--g1
EXEC createTodaysDeal 30 , 'hana.aly' , '2019-11-12' --or '2019/11/30'
--table todays deals
SELECT * FROM Todays_Deals

--g2
EXEC addTodaysDealOnProduct 1,3
--table todays deal on product
SELECT * FROM Todays_Deals_Product

--g3
DECLARE @ad BIT 
EXEC checkTodaysDealOnProduct 2 ,@ad OUTPUT
PRINT @ad

--g4
EXEC removeExpiredDeal 6
--table Todays_Deals
SELECT * FROM Todays_Deals

--h
EXEC createGiftCard 'G101' , '2019/12/30' ,100 , 'hana.aly'
--table Giftcard
SELECT * FROM Giftcard

--h2
EXEC createGiftCard 'G105' , '2019/11/3' ,100 , 'hana.aly'

--i1
EXEC giveGiftCardtoCustomer 'G105' , 'ammar.yasser' , 'hana.aly'
EXEC giveGiftCardtoCustomer 'G105' , 'ahmed.ashraf' , 'hana.aly'
--table admin customer giftcards
SELECT * FROM Admin_Customer_Giftcard 
--table customer(points)
SELECT c.username, c.points FROM Customer c

--i1 bardo
EXEC giveGiftCardtoCustomer 'G101' ,'ahmed.ashraf','hana.aly'

--i2
EXEC removeExpiredGiftCard 'G105'
--table Giftcard
SELECT * FROM Giftcard

--i2 again
EXEC removeExpiredGiftCard 'G102'
-- exec tables Giftcard , admin_customer_giftcard ,customer(points)

--i3
DECLARE @bit BIT
EXEC checkGiftCardOnCustomer 'G101',@bit OUTPUT
PRINT @bit
--again for input 'G1012' mafrod yetla3 0


select * from Customer

select * from Admins

select * from Giftcard

select * from Admin_Customer_Giftcard




