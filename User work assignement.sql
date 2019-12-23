USE ProFieldMeterMM
SELECT C.CustomerId
	, C.SiteStatus
	, C.LastModifyDateTime
	, J.JobId
	, JE.UserId
	, JE.Description
	, CONVERT(varchar, dateadd(hour,-5,JE.EventDate),100) AS 'Assigned_Date'
FROM Customer C 
LEFT JOIN Job J ON C.ActiveJobGuid = J.JobTrackingGuid
LEFT JOIN JobEvent JE ON JE.JobId = J.JobId
WHERE C.CustomCIS2 = '4691790'

--SELECT * FROM CustomCustomerInfo WHERE Customerid = '11120055'
USE ProFieldCore
SELECT UserId
	, FirstName
	, LastName
FROM ProFieldUser WHERE LastName = 'Bonfiglio' AND FirstName = 'Robert'

SELECT UserEventId
	, UserId
	, EventName
	, CONVERT(varchar, dateadd(hour,-5,EventDate),100) AS 'EventDate'
	, EventDescription
FROM ProFieldUserEvent WHERE UserId = '155299' --AND UserEventId = '2263824'