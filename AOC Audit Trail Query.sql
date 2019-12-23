SELECT TOP 10 * FROM AOC_AUDIT
SELECT TOP 10 * FROM AuditTrails 

SELECT * FROM Customer WHERE customerid = '5566627'
SELECT * FROM AOC_AUDIT WHERE CustomerId = '5566627'

SELECT C.PremiseNumber AS 'SDPID'
	, C.CustomerNumber AS 'Account Number'
	, C.CustomCIS2 AS 'WorkRequest'
	, C.UtilityServiceID AS 'Transaction Type'
	, C.SiteStatus
	, C.LegacyMeterSerial
	, CASE WHEN C.NewMeterSerial = '' 
		THEN (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] LIKE 'newsocketapseri%')
		ELSE C.NewMeterSerial END AS 'NewMeterSerial' 
	, AA.FieldName
	, AA.PreviousValue
	, AA.UpdatedValue
	, AA.UpdatedDateTime
	, AA.ModifiedBy
FROM Customer C
LEFT JOIN AOC_AUDIT AA ON C.CustomerId = AA.CustomerId AND AA.FieldName LIKE 'Reviewer%'
WHERE C.SiteStatus LIKE 'AOC%'
ORDER BY AA.UpdatedDateTime DESC