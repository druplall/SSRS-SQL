SELECT UtilityServiceID AS 'Transaction Type', 
COUNT(*) AS 'Count' FROM Customer
WHERE UtilityServiceID IN (
'PICKUP_RIC',
'PICKUP_SET',
'PICKUP_TURNONOFF')
GROUP BY UtilityServiceID

SELECT UtilityServiceID AS 'Transaction Type',
	CustomCIS2 AS 'WR',
	SiteStatus,
	CustomerNumber,
	PremiseNumber,
	Address,
	LegacyMeterSerial,
	CASE WHEN C.NewMeterSerial = ''
	  THEN (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.Customerid = C.CustomerId AND CI.[key] = 'NewSocketAPSerialNumber' )
	  ELSE C.NewMeterSerial END AS 'New Meter Serial#',
	  J.EndTime AS 'Completion Date'
	  , ISNULL(CONVERT(nvarchar,DATEDIFF(day,C.LastModifyDateTime,getDATE())),'N/A') as [Age In Days]
	, (SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE Customerid = C.CustomerId AND FieldName = 'ReviewerComments'  ORDER BY UpdatedDateTime DESC) AS 'AOC Comment'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
 WHERE UtilityServiceID IN (
'PICKUP_RIC',
'PICKUP_SET',
'PICKUP_TURNONOFF')
