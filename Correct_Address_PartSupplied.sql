SELECT C.Customerid
	, UtilityServiceID
	, CustomCIS2 AS 'WR'
	, SiteStatus
	, CustomerNumber
	, PremiseNumber
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='AddressDetailCorrect' ) AS 'Is the Address correct ?'
	, Address AS 'Orginal_Address'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='UpdatedAddress' ) AS 'New_Address'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='PartSuppliedCorrect' ) AS 'Is the Part Supplied correct ?'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='NewMeterPartsupplied' ) AS 'Orginal_Part_Supplied'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='CapturedPartSupplied' ) AS 'New Part Supplied'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'AddressDetailCorrect'
LEFT JOIN CustomCustomerInfo CI2 ON CI2.CustomerId = C.CustomerId AND CI2.[Key] = 'PartSuppliedCorrect'
WHERE CI.Value = 'N' OR CI2.Value = 'N'
