
--Soru 1. Ürünü olmayan kategorilerin isimlerini listeleyin
Select * from Categories where CategoryID not in(Select CategoryID  from Products)

--Soru 2. Herhangi bir kategoriye dahil olmayan ürünlerin isimlerini listeyin
select * from Products  where CategoryID is NULL

--Soru 3. Tüm kategorileri ve tüm ürünleri listeleyin
Select pd.ProductName,ct.CategoryName from Categories ct
left outer join Products pd on pd.CategoryID=ct.CategoryID


--Soru 4. Ürünü olmayan kategorileri ve kategorisi olmayan ürünleri listeleyin
Select pd.ProductName,ct.CategoryName from Categories ct
left outer join Products pd on pd.CategoryID=ct.CategoryID
where pd.CategoryID is NULL 


--Soru 5. Satýþ yapan çalýþanlarýn kaç adet ürün satýþý yaptýklarýný, çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, sattýðý ürün adedini 'Satýþ Adedi' baþlýklý kolonda olacak þekilde listeleyin
Select 
empl.FirstName+' '+empl.LastName as Personel,
prod.ProductName as Ürün_Adý,
sum(ordt.Quantity) as Satýþ_Adedi
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by empl.FirstName,empl.LastName,prod.ProductName

--Soru 6. Satýþ yapan çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
--Soru 7. Tüm çalýþanlarýn ne kadarlýk satýþ yaptýklarýný (toplam satýþ tutarý), çalýþanýn ad ve soyadý arasýnda bir boþluk olacak þekilde 'Personel' isimli tek bir kolonda, yaptýðý toplam satýþ tutarý 'Toplam Satýþ' baþlýklý kolonda olacak þekilde listeleyin
--6 ve 7 sorularýn cevabý 6 ve 7 sorularu ayný diye düþünyorum--
Select 
empl.FirstName+' '+empl.LastName as Personel,
prod.ProductName as Ürün_Adý,
sum(ordt.Quantity*ordt.UnitPrice) as Satýþ_Tutarý
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by empl.FirstName,empl.LastName,prod.ProductName

--Soru 8. Hangi kategoriden toplam ne kadarlýk sipariþ verilmiþ listeleyin
Select 
catg.CategoryName CategoryName,
sum(ordt.Quantity) as Toplam_Sipariþ_Adedi
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Categories] catg on catg.CategoryID=prod.CategoryID
Group by catg.CategoryName

--Soru 9. Hangi müþteri toplam ne kadarlýk sipariþ vermiþ
Select 
cust.CompanyName Müsteri,
sum(ordt.Quantity*ordt.UnitPrice) as Toplam_Sipariþ_Tutarý
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Customers] cust on cust.CustomerID=ordr.CustomerID
Group by cust.CompanyName

--Soru 10. Hangi müþteri hangi kategorilerden sipariþ vermiþ 
Select 
cust.CompanyName Müsteri,
catg.CategoryName Category
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Customers] cust on cust.CustomerID=ordr.CustomerID
Left Outer Join [dbo].[Categories] catg on catg.CategoryID=prod.CategoryID
Group by cust.CompanyName,catg.CategoryName


--Soru 11. En çok satýlan ürünün tedarikçisi hangi firma
--Soru 13. En çok satýlan ürün hangisi
--11 ve 13 sorularýn cevabý--
Select top 1
prod.ProductName EnÇok_Satýlan_Ürün,
supl.CompanyName Tedarikçi,
sum(ordt.Quantity) Toplam_Miktar
from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Left Outer Join [dbo].[Suppliers] supl on supl.SupplierID=prod.SupplierID
Group by prod.ProductName,supl.CompanyName 
Order by Toplam_Miktar DESC

--Soru 12. Hangi üründen kaç adet satýlmýþ

Select 
prod.ProductName Ürün_Adý,
sum(ordt.Quantity) Satýlan_Adet

from [dbo].[Order Details] ordt
Left Outer Join  [dbo].[Orders] ordr on ordr.OrderID=ordt.OrderID
Left Outer Join [dbo].[Employees] empl on empl.EmployeeID=ordr.EmployeeID
Left Outer Join [dbo].[Products] prod on prod.ProductID=ordt.ProductID
Group by prod.ProductName

--Soru 14. Stokta 20 birim altýnda kalan ürünlerin isimleri ve tedarikçi firma adýný listeleyin 

Select 
prod.ProductName Ürün,
supl.CompanyName Tedarikçi,
prod.UnitsInStock Stok_Durumu
from [dbo].[Products] prod
Left Outer Join [dbo].[Suppliers] supl on supl.SupplierID=prod.SupplierID
where prod.UnitsInStock<20