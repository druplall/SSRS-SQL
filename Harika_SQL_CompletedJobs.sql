SELECT C.Customerid AS 'ProField ID'
	, C.LegacyMeterSerial AS 'Legacy Meter'
	, CASE WHEN C.NewMeterSerial = ''
		THEN (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.customerid AND CI.[Key] LIKE 'newsocketapseri%') 
		ELSE C.NewMeterSerial END AS 'New Meter'
	, C.UtilityServiceID AS 'Transaction'
	, C.CustomCIS2 AS 'WRNumber'
	, C.SiteStatus
	, J.EndTime AS 'Completed'
	, C.CustomerNumber AS 'Account Number'
	, C.PremiseNumber AS 'SDP ID'
	, C.CustomerName As 'Customer Name'
	, C.ServiceType AS 'Service Type'
	, C.District 
	, CIC.Value
	, C.Address
	, C.City
	, C.PostalCode 
	, C.Lat 
	, C.Lon 
	, C.GPSLatitude 
	, C.GPSLongitude 
	, C.AssignedTechId
FROM Customer C
LEFT JOIN Job J on J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN CustomCustomerInfo CIC ON CIC.CustomerId = C.CustomerId AND CIC.[Key] ='InstallationCompany'
WHERE C.SiteStatus = 'Certified'
ORDER BY J.EndTime ASC
