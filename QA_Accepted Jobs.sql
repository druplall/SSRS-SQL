SELECT C.UtilityServiceID AS 'Transaction Type'
	, C.CustomCIS2 AS 'WR'
	, C.SiteStatus
	, C.CustomerNumber
	, C.PremiseNumber
	, C.Address
	, C.LegacyMeterSerial
	, CASE WHEN C.NewMeterSerial = ''
		THEN (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.customerid AND CI.[Key] LIKE 'newmeter%')
		ELSE C.NewMeterSerial END AS 'NewMeterSerial'
	, C.LastModifyDateTime
	, ISNULL(CONVERT(nvarchar,DATEDIFF(day,C.LastModifyDateTime,getDATE())),'N/A') as [Age In Days]
	, (SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE Customerid = C.CustomerId AND FieldName = 'ReviewerComments'  ORDER BY UpdatedDateTime DESC) AS 'AOC Comment'
FROM Customer C
WHERE SiteStatus IN ('QAReady','QAAccepted')
ORDER BY LastModifyDateTime DESC



SELECT JE.EventDate
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN JobEvent JE ON J.JobId = JE.JobId
WHERE C.Customerid = '14910935'
