SELECT C.Customerid
	, UtilityServiceID
	, CustomCIS2 AS 'WR'
	, SiteStatus
	, CustomerNumber
	, PremiseNumber
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='AddressDetailCorrect' ) AS 'Is the Address correct ?'
	, Address AS 'Orginal_Address'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='UpdatedAddress' ) AS 'New_Address'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='PartSuppliedCorrect' ) AS 'Is the Part Supplied correct ?'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='NewMeterPartsupplied' ) AS 'Orginal_Part_Supplied'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.customerid = C.Customerid AND CI.[Key] ='CapturedPartSupplied' ) AS 'New Part Supplied'
	,  CONVERT (datetime, SWITCHOFFSET(Convert(datetimeoffset, (SELECT TOP 1 EndTime FROM Job J WHERE J.JobTrackingGuid = C.ActiveJobGuid)), DATENAME(Tzoffset,SYSDATETIMEOFFSET()))) AS 'Job Completion'
	, DATEDIFF(HOUR,(SELECT Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Job Completed'), (SELECT Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched')) AS 'Duration in QAReady (H''s)'
	, CASE WHEN DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed')) is null
		THEN (DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Failure')))
		ELSE DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed')) END AS 'Duration in QAAccepted (H''s)'
	, CASE WHEN DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')) is NULL
		THEN (DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Failure'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')))
		ELSE DATEDIFF(HOUR,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')) END AS 'Duration in AOC Review (H''s)'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'AddressDetailCorrect'
LEFT JOIN CustomCustomerInfo CI2 ON CI2.CustomerId = C.CustomerId AND CI2.[Key] = 'PartSuppliedCorrect'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE CI.Value = 'N' OR CI2.Value = 'N'
--AND C.Customerid = '14907373'

SELECT * FROM Customer WHERE Customerid = '14916432'
SELECT * FROM Job WHERE JobTrackingGuid = '588808C6-856B-4159-A622-DF72D717F439'
SELECT * FROM JobEvent WHERE jobid = '15213978'

SELECT DATEDIFF(DAY,'2019-11-06 20:00:02.707', '2019-11-02 04:42:55.037')

--SET test = ''

--SELECT address from customer where customerid = '5011364'