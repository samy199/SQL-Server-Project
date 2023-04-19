/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [UniqueID ]
      ,[ParcelID]
      ,[LandUse]
      ,[PropertyAddress]
      ,[SaleDate]
      ,[SalePrice]
      ,[LegalReference]
      ,[SoldAsVacant]
      ,[OwnerName]
      ,[OwnerAddress]
      ,[Acreage]
      ,[TaxDistrict]
      ,[LandValue]
      ,[BuildingValue]
      ,[TotalValue]
      ,[YearBuilt]
      ,[Bedrooms]
      ,[FullBath]
      ,[HalfBath]
  FROM [portfolio_project].[dbo].[NashvilleHousing ]
  
/*_convert date 
upadate soldasvacant 
extracts sub chrachters uesing substring 
parsename
replace 
charindex shearch by index */
select * from [NashvilleHousing ]
select column_name from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'NashvilleHousing'
select count(*) from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'NashvilleHousing'
select  PropertyAddress 
from [NashvilleHousing ]
where PropertyAddress is null 

select  ParcelID , count(*)
from [NashvilleHousing ]
group by ParcelID
order by 2 desc


select  SaleDate ,convert(date,SaleDate )
from [NashvilleHousing ]

--alter table Nashvillehousing 
--add date_convert date 
update [NashvilleHousing ]
set SaleDate = convert(date,SaleDate )




select a.ParcelID , a.PropertyAddress , b.ParcelID , b.PropertyAddress , isnull(a.PropertyAddress , b.PropertyAddress)
from [NashvilleHousing ] a
join [NashvilleHousing ] b 
on a.[ParcelID] =b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 

update a
set a.PropertyAddress = isnull(a.PropertyAddress , b.PropertyAddress)
from [NashvilleHousing ] a
join [NashvilleHousing ] b 
on a.[ParcelID] =b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null 



select substring(PropertyAddress , 1,CHARINDEX (',' , PropertyAddress)-1 ) , 
substring ( PropertyAddress , charindex(',' , PropertyAddress) +1 , len(PropertyAddress)  )
from [NashvilleHousing ] 


/*ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))*/




Select OwnerAddress
From NashvilleHousing


Select OwnerAddress ,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)




select distinct SoldAsVacant
from [NashvilleHousing ]



Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From NashvilleHousing

Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END



--remove duplicates 

with CTE as (
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From NashvilleHousing

)
--order by ParcelID


DELETE
From CTE
Where row_num > 1
Order by PropertyAddress





/*delete
from [NashvilleHousing ]
where  ParcelID  in 
(select ParcelID , count(*) from [NashvilleHousing] group by ParcelID having  count(*) >1 ) ;*/ 



--Delete Unused Columns
select * from [NashvilleHousing ]


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate