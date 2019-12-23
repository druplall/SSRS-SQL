SELECT C.PremiseNumber
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'EmployeeID%') AS 'Employee_ID'
	, CONCAT( CONVERT(varchar(8),C.LastModifyDateTime,112), RIGHT(REPLACE(CONVERT(varchar, C.LastModifyDateTime,120),':',''),6)) AS 'DATE_TIME'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'CT') AS 'CT'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial1') AS 'CT_Serial'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceMfg1') AS 'CT_Manufacture'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceBarcode') AS 'CT_Barcode'
	, C.LegacyMeterSerial
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'CT') AS 'Transcation_Type'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio2') AS 'Ratio'
FROM Customer C
WHERE C.SiteStatus LIKE 'AOC%'  
AND (SELECT value FROM CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId AND CI.[KEY] = 'MeterPrefix') LIKE '%CT%'
ORDER BY C.LastModifyDateTime DESC