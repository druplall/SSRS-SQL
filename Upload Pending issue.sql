SELECT C.CustomerId
	, C.CustomerName
	, C.UtilityServiceID
	, C.CustomerNumber
	, C.CustomCIS2
	, C.SiteStatus
	, C.LegacyMeterSerial
	, C.NewMeterSerial
	, J.JobId
	, (SELECT Description FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title LIKE 'Pickup Customer%' ) AS 'EventType'
	, (SELECT EventDate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title LIKE 'Pickup Customer%' ) AS 'EventDate'
	--, (SELECT DisplayText FROM StatusLookup WHERE J.status = StatusLookup.Sequence) AS 'Status'
FROM Customer C
JOIN Job J
ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE C.NewMeterSerial IN ('009998042')

SELECT *
FROM JobEvent 
WHERE JobId = '6148550'

SELECT *
FROM CustomCustomerInfo
WHERE CustomerId = '5167010'
SELECT *
FROM Job
WHERE JobId = '6148550'
SELECT * FROM [dbo].[StatusLookup]



SELECT * 
FROM Customer
WHERE CustomerID = '5167010'

SELECT * FROM [dbo].[StatusLookup]