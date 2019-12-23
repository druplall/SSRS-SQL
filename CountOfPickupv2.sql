SELECT UtilityServiceID AS 'Transaction Type', 
COUNT(*) AS 'Count' 
FROM Customer C
JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[KEY] = 'interfacesource'
WHERE UtilityServiceID IN (
'PICKUP_RIC',
'PICKUP_SET',
'PICKUP_TURNONOFF') OR (CI.[Value] = 'CPMS' AND UtilityServiceID = 'PICKUP_EXCHANGE')
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
	  , (SELECT concat(FirstName, ' ', LastName) FROM ProFieldCore.dbo.ProFieldUser WHERE C.AssignedTechId = UserId ) AS 'Installer'
	, (SELECT SectionDescription FROM ProFieldCore.dbo.ProFieldUserSupervisorMap WHERE UserId = C.AssignedTechId ) AS 'Section'
	, (SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE Customerid = C.CustomerId AND FieldName = 'ReviewerComments'  ORDER BY UpdatedDateTime DESC) AS 'AOC Comment'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN CustomCustomerInfo CI ON C.customerid = CI.CustomerId AND CI.[KEY] = 'interfacesource'
--LEFT JOIN CustomCustomerInfo CI2 ON CI2.CustomerId = C.CustomerId 
 WHERE UtilityServiceID IN (
'PICKUP_RIC',
'PICKUP_SET',
'PICKUP_TURNONOFF'
) OR (CI.[Value] = 'CPMS' AND UtilityServiceID = 'PICKUP_EXCHANGE')
ORDER BY J.EndTime DESC

