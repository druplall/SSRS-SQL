SELECT C.CustomCIS2 AS 'Work_Request_Number'
	, C.CustomerId AS 'PFE_Work_Order_Number'
	, C.SiteStatus AS 'Status'
	, C.UtilityServiceID AS 'Transcation_Type'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] LIKE 'EmployeeID') AS 'WMS_Employee_Number'
	, (SELECT TOP 1 JE.Description FROM JobEvent JE WHERE J.JobId = JE.JobId AND JE.Title LIKE 'Assigned') AS 'Installer'
	, C.PremiseNumber AS 'SDP_ID'
	, CONVERT(varchar,(SELECT TOP 1  JE.EventDate FROM JobEvent JE WHERE J.JobId = JE.JobId AND JE.Title LIKE 'Job Completed'),110) AS 'Install Date'
	, CONVERT(varchar,(SELECT TOP 1  JE.EventDate FROM JobEvent JE WHERE J.JobId = JE.JobId AND JE.Title LIKE 'Job Started'),108) AS 'Start Time'
	, CONVERT(varchar,(SELECT TOP 1  JE.EventDate FROM JobEvent JE WHERE J.JobId = JE.JobId AND JE.Title LIKE 'Job Completed'),108) AS 'End Time'
	, C.Address
	, C.City
	, C.ServiceType
	, C.District
	, C.RouteNumber
	, C.CustomerNumber
	, C.CustomerName
	, C.LegacyMeterSerial
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] LIKE 'MeterPrefix') AS 'Legacy_Meter_Model'
	, C.LegacyMeterReading4 AS 'Legacy_Meter_Demand_Found'
	, C.LegacyMeterReading5 AS 'Legacy_Meter_Demand_Left'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] LIKE 'OldMeterNICNumber') AS 'Legacy_Module_ID'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] LIKE 'NewMeterModuleNumber') AS 'New_Meter_LAN_ID'
	, C.GPSLatitude
	, C.GPSLongitude
FROM Customer C
INNER JOIN Job J 
ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE C.SiteStatus IN ('QAReady', 'QAAccepted', 'Certified')
AND C.LastModifyDateTime BETWEEN '2018-11-26 00:00:31.200' AND '2018-11-27 23:59:31.200'
--C.SiteStatus IN ('DNI','RTU', 'QAReady', 'QAAccepted', 'Certified', 'AOCReview')

