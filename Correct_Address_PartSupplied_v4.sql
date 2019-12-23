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
	, DATEDIFF(DAY,(SELECT Top 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Job Completed'), (SELECT Top 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched')) AS 'Duration in QAReady (H''s)'
	, CASE WHEN DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed')) is null
		THEN (DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Failure')))
		ELSE DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Batched'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed')) END AS 'Duration in QAAccepted (H''s)'
	, CASE WHEN DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')) is NULL
		THEN (DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Failure'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')))
		ELSE DATEDIFF(DAY,(SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'QA Passed'), (SELECT TOP 1 Eventdate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Supervisor Review')) END AS 'Duration in AOC Review (H''s)'
	, J.EndTime
	, (SELECT concat(FirstName, ' ', LastName) FROM ProFieldCore.dbo.ProFieldUser WHERE C.AssignedTechId = UserId ) AS 'Installer'
	, (SELECT value FROM CustomCustomerInfo CII WHERE CII.[Key] ='SectionDescription' AND CII.CustomerId = C.CustomerId  ) AS 'Section'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'AddressDetailCorrect'
LEFT JOIN CustomCustomerInfo CI2 ON CI2.CustomerId = C.CustomerId AND CI2.[Key] = 'PartSuppliedCorrect'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE (CI.Value = 'N' OR CI2.Value = 'N')
--AND J.EndTime BETWEEN @StartTime AND @EndTime
ORDER BY J.EndTime DESC

SELECT CI.[Key], Count(*) AS 'Count Of Address Update'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'UpdatedAddress'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
--WHERE (CI.Value is not null ) AND J.EndTime BETWEEN @StartTime AND @EndTime
GROUP BY CI.[Key]


SELECT CI.[Key], Count(*) AS 'Count Of Part Supplied Update'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'CapturedPartSupplied'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
--WHERE (CI.Value is not null ) AND J.EndTime BETWEEN @StartTime AND @EndTime
GROUP BY CI.[Key]