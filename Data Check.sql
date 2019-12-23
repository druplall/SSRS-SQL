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
	, CASE WHEN ((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1') = '' OR (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1') is null )
		THEN 'N'
		ELSE 'Y' END AS 'Validated Old CT''s ?'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceRatio1') AS 'Ratio (as found)'
	,  CASE WHEN ((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1') = '' OR (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1') is null )
		THEN 'N'
		ELSE 'Y' END AS 'Validated New CT''s ?'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio1') AS 'Ratio (as left)'
FROM Customer C 
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN JobEvent JE ON JE.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Assigned' and Description like '%Assigned to%')
LEFT JOIN JobEvent JEV ON JEV.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Job Completed' and Description like '%Duration%')
WHERE SiteStatus IN ('Certified','QAAccepted','QAReady','AOCReview') 
AND J.EndTime BETWEEN @StartTime AND @EndTime