SELECT C.CustomerId 
	, C.CustomerName
	, C.Address
	, C.City
	, C.State
	, C.PostalCode
	, C.ServiceType
	, C.UtilityServiceID AS 'Transaction_Type'
	, C.CustomerNumber
	, C.PremiseNumber
	, C.CustomCIS2 AS 'WR'
	, C.SiteStatus 
	, C.LegacyMeterSerial
	--, (SELECT EventDate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Description LIKE 'Assigned%' ) AS 'Assigned_date'
	, JE.Title
	, JE.Description
	, JE.EventDate
FROM Customer C
INNER JOIN Job J
ON J.CustomerId = C.CustomerId
INNER JOIN JobEvent JE
ON JE.JobId = J.JobId
WHERE C.SiteStatus NOT IN ( 'Certified' , 'RTU', 'RTUEscalated')
ORDER BY Customerid, JE.EventDate ASC