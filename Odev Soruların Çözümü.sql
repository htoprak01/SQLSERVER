
--Soru 1. �r�n� olmayan kategorilerin isimlerini listeleyin
Select * from Categories where CategoryID not in(Select CategoryID  from Products)

--Soru 2. Herhangi bir kategoriye dahil olmayan �r�nlerin isimlerini listeyin
select * from Products  where CategoryID is NULL

--Soru 3. T�m kategorileri ve t�m �r�nleri listeleyin
Select pd.ProductName,ct.CategoryName from Categories ct
left outer join Products pd on pd.CategoryID=ct.CategoryID


--Soru 4. �r�n� olmayan kategorileri ve kategorisi olmayan �r�nleri listeleyin
Select pd.ProductName,ct.CategoryName from Categories ct
left outer join Products pd on pd.CategoryID=ct.CategoryID
where pd.CategoryID is NULL 


--Soru 5. Sat�� yapan �al��anlar�n ka� adet �r�n sat��� yapt�klar�n�, �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, satt��� �r�n adedini 'Sat�� Adedi' ba�l�kl� kolonda olacak �ekilde listeleyin
Select 
empl.FirstName+' '+empl.LastName as Personel,
prod.ProductName as �r�n_Ad�,
sum(ordt.Quantity) as Sat��_Adedi
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by empl.FirstName,empl.LastName,prod.ProductName

--Soru 6. Sat�� yapan �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
--Soru 7. T�m �al��anlar�n ne kadarl�k sat�� yapt�klar�n� (toplam sat�� tutar�), �al��an�n ad ve soyad� aras�nda bir bo�luk olacak �ekilde 'Personel' isimli tek bir kolonda, yapt��� toplam sat�� tutar� 'Toplam Sat��' ba�l�kl� kolonda olacak �ekilde listeleyin
--6 ve 7 sorular�n cevab� 6 ve 7 sorularu ayn� diye d���nyorum--
Select 
empl.FirstName+' '+empl.LastName as Personel,
prod.ProductName as �r�n_Ad�,
sum(ordt.Quantity*ordt.UnitPrice) as Sat��_Tutar�
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by empl.FirstName,empl.LastName,prod.ProductName

--Soru 8. Hangi kategoriden toplam ne kadarl�k sipari� verilmi� listeleyin
Select 
catg.CategoryName CategoryName,
sum(ordt.Quantity) as Toplam_Sipari�_Adedi
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Categories] catg on catg.CategoryID=prod.CategoryID
Group by catg.CategoryName

--Soru 9. Hangi m��teri toplam ne kadarl�k sipari� vermi�
Select 
cust.CompanyName M�steri,
sum(ordt.Quantity*ordt.UnitPrice) as Toplam_Sipari�_Tutar�
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Customers] cust on cust.CustomerID=ordr.CustomerID
Group by cust.CompanyName

--Soru 10. Hangi m��teri hangi kategorilerden sipari� vermi� 
Select 
cust.CompanyName M�steri,
catg.CategoryName Category
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Customers] cust on cust.CustomerID=ordr.CustomerID
Left Outer Join [dbo].[Categories] catg on catg.CategoryID=prod.CategoryID
Group by cust.CompanyName,catg.CategoryName


--Soru 11. En �ok sat�lan �r�n�n tedarik�isi hangi firma
--Soru 13. En �ok sat�lan �r�n hangisi
--11 ve 13 sorular�n cevab�--
Select top 1
prod.ProductName En�ok_Sat�lan_�r�n,
supl.CompanyName Tedarik�i,
sum(ordt.Quantity) Toplam_Miktar
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Suppliers] supl on supl.SupplierID=prod.SupplierID
Group by prod.ProductName,supl.CompanyName 
Order by Toplam_Miktar DESC

--Soru 12. Hangi �r�nden ka� adet sat�lm��

Select 
prod.ProductName �r�n_Ad�,
sum(ordt.Quantity) Sat�lan_Adet

from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by prod.ProductName

--Soru 14. Stokta 20 birim alt�nda kalan �r�nlerin isimleri ve tedarik�i firma ad�n� listeleyin 

Select 
prod.ProductName �r�n,
supl.CompanyName Tedarik�i,
prod.UnitsInStock Stok_Durumu
from [dbo].[Products] prod
Left Outer Join [dbo].[Suppliers] supl on supl.SupplierID=prod.SupplierID
where prod.UnitsInStock<20