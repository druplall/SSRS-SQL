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
	, CASE WHEN J.CreatedDate > '2018-11-03 00:37:03.053'
		   THEN convert(varchar, dateadd(hour,-5,J.CreatedDate),100)
		   ELSE convert(varchar, dateadd(hour,-4,J.CreatedDate),100)
		END AS 'Created_Date'
	,  CASE WHEN J.StartTime > '2018-11-03 00:37:03.053'
		   THEN convert(varchar, dateadd(hour,-5,J.StartTime),100)
		   ELSE convert(varchar, dateadd(hour,-4,J.StartTime),100)
		END AS 'Start_Date'
	, CASE WHEN J.EndTime > '2018-11-03 00:37:03.053'
		   THEN convert(varchar, dateadd(hour,-5,J.EndTime),100)
		   ELSE convert(varchar, dateadd(hour,-4,J.EndTime),100)
		END AS 'End_Date'
FROM Customer C
Inner Join Job J 
ON C.ActiveJobGuid = J.JobTrackingGuid
--WHERE C.CustomCIS2 = '4595402'
ORDER BY J.CreatedDate DESC