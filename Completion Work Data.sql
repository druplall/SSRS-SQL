SELECT C.customerid
	, C.PremiseNumber AS 'SDPID'
	, C.CustomerNumber AS 'Account Number'
	, C.CustomerName 
	, C.Address
	, C.CustomCIS2 AS 'Work Request'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] LIKE '%WorkOrderSource%' ) AS 'Source System'
	, C.UtilityServiceID AS 'Transaction Type'
	, C.SiteStatus
	, C.LegacyMeterSerial
	, CASE WHEN C.NewMeterSerial = '' 
		THEN (SELECT TOP 1 value From CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId and CI.[KEY] LIKE 'newsocketapseri%') 
		ELSE C.NewMeterSerial END AS 'NewMeterNumber'
	, JE.Description AS 'Lead Technician'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] = 'EmployeeID' ) AS 'Crew ID''s'
	, JEV.Title
	, J.StartTime
	, J.EndTime
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] = 'InspectCTPTFlag' ) AS 'Validated CT Info ?'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] = 'CT' ) AS 'Catpured CT Info ?'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] = 'NewMeterType' ) AS 'New Meter Type'
FROM Customer C 
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN JobEvent JE ON JE.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Assigned' and Description like '%Assigned to%')
LEFT JOIN JobEvent JEV ON JEV.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Job Completed' and Description like '%Duration%')
WHERE SiteStatus IN ('Certified','QAAccepted','QAReady','AOCReview') 
ORDER BY C.CustomerId DESC

--SELECT * FROM JobEvent WHERE  JobId ='13290895'
SELECT * FROM CustomCustomerInfo WHERE Customerid = '13107622'