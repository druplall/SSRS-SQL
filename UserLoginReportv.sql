SELECT C.customerid
	, C.UtilityServiceID
	, C.CustomerNumber
	, C.PremiseNumber
	, C.CustomCIS2 AS 'WorkRequest'
	, (SELECT TOP 1 [EventDescription] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC ) AS 'DeviceEventDescription'
	, CONVERT (datetime, SWITCHOFFSET(Convert(datetimeoffset,( SELECT TOP 1 [EventDate] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC)), DATENAME(Tzoffset,SYSDATETIMEOFFSET()))) AS 'DeviceLoginTime'
	, (SELECT TOP 1 Description FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Assigned') AS 'Assigned'
	, (SELECT TOP 1 Description FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Assignment Received') AS 'Assignment Received'
	, (SELECT TOP 1 Description FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Job Started') AS 'Job Started'
	,(SELECT TOP 1 EventDate FROM JobEvent JE WHERE JE.JobId = J.JobId AND JE.Title = 'Job Completed') AS 'Job Completed'
	--, JE.Description AS 'JobAssignmentStatus'
	--, JE.EventDate AS 'JobAssignmentTime'
	--, (SELECT TOP 1 [EventDescription] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC ) AS 'DeviceEventDescription'
	--, (SELECT TOP 1 [EventDate] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC ) AS 'DeviceLoginTime'
	--, CONVERT (datetime, SWITCHOFFSET(Convert(datetimeoffset,( SELECT TOP 1 [EventDate] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC)), DATENAME(Tzoffset,SYSDATETIMEOFFSET()))) AS 'DeviceLoginTime'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
--LEFT JOIN JobEvent JE ON JE.JobId = J.JobId
LEFT JOIN ProFieldCore.dbo.ProFieldUser PU ON PU.UserId = C.AssignedTechId
--LEFT JOIN ProFieldCore.dbo.ProFieldUserEvent PE ON PE.UserId = PU.UserId
WHERE C.AssignedTechId = '160803'
ORDER BY J.EndTime DESC
--ORDER BY CreatedDate DESC

SELECT * FROM ProFieldCore.dbo.ProFieldUserEvent WHERE USerid = '152442' ORDER BY EventDate DESC

SELECT * FROM Customer WHERE customerid = '13663947'
SELECT * FROM Job WHERE JobTrackingGuid = 'F1C53E1F-A3F0-42EB-A6FF-BAA931ADB222'
SELECT * FROM JobEvent WHERE JobId = '13887303'

SELECT * FROM ProFieldCore.dbo.ProFieldUser WHERE LastName = 'Moran'