SELECT C.customerid
	, C.UtilityServiceID
	, C.CustomerNumber
	, C.PremiseNumber
	, C.CustomCIS2 AS 'WorkRequest'
	, PU.FirstName
	, PU.LastName
	, JE.Description AS 'JobAssignmentStatus'
	, JE.EventDate AS 'JobAssignmentTime'
	, (SELECT TOP 1 [EventDescription] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC ) AS 'DeviceEventDescription'
	, (SELECT TOP 1 [EventDate] FROM ProFieldCore.dbo.ProFieldUserEvent PU WHERE PU.UserId = C.AssignedTechId AND [EventName] = 'DeviceLogin' ORDER BY EventDate DESC ) AS 'DeviceLoginTime'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
LEFT JOIN JobEvent JE ON JE.JobId = J.JobId
LEFT JOIN ProFieldCore.dbo.ProFieldUser PU ON PU.UserId = C.AssignedTechId
--LEFT JOIN ProFieldCore.dbo.ProFieldUserEvent PE ON PE.UserId = PU.UserId
WHERE C.CustomCIS2 = '4839896'
ORDER BY CreatedDate DESC
--084058

SELECT D.* 
	, DE.*
FROM ProFieldCore.dbo.ProFieldDevice D
LEFT JOIN ProFieldCore.dbo.ProFieldDeviceEvent DE ON D.DeviceId = DE.DeviceId
WHERE DE.UserId = '152442'
ORDER BY D.LastConnect DESC

SELECT * FROM ProFieldCore.dbo.ProFieldUserEvent
WHERE Userid = '152442' ORDER BY EventDate DESC

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT PUD.UserDeviceId
	, PUD.UserId
	, PD.*
  FROM [ProFieldCore].[dbo].[ProFieldUserDevice] PUD
  LEFT JOIN ProFieldCore.dbo.ProFieldDevice PD ON  PD.DeviceId = PUD.DeviceId 
  WHERE PUD.Userid = '152442'
 -- ORDER BY PD.LastConnect DESC

 SELECT * FROM ProFieldCore.dbo.ProFieldUserEvent

 SELECT DeviceId, MAX(LastConnect) FROM PRoFieldCore.dbo.ProFieldDevice GROUP BY DeviceId


SELECT *
FROM ProFieldCore.dbo.ProFieldUser
WHERE LastName = 'RUPLALL'

SELECT * FROM JobEvent WHERE Jobid = '13887340'
SELECT * FROM ProFieldCore.dbo.ProFieldUserDevice WHERE Deviceid = '084058'

SELECT * FROM ProFieldCore.dbo.ProFieldUserEvent WHERE Userid = '152442'  ORDER BY EventDate DESC;