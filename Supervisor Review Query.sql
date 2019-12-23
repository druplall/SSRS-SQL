SELECT C.customerid AS 'Customer ID'
	, C.PremiseNumber AS 'Premise Number'
	, C.CustomerNumber AS 'CSS Account'
	, C.Address
	, C.City
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'PartSupplied') AS 'Part Supplied'
	, J.EndTime AS 'Job Completion Time'
	, C.UtilityServiceID AS 'Work Order Type'
	, C.LegacyMeterSerial AS 'Legacy Meter Serial#'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'LegacyMeterType') AS 'Legacy Meter Type'
	, CASE WHEN C.NewMeterSerial = ''
		THEN (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.Customerid AND [KEY] = 'NewSocketAPSerialNumber') 
		ELSE C.NewMeterSerial END 'New Meter Serial#'
	, C.CustomCIS2 AS 'WMS WR Number'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'NewMeterType') AS 'New Meter Type'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'NewMeterModuleNumber') AS 'New Meter Module/NIC Serial#'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'TensionCode') AS 'HI/LO Tension Code'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'NewMeterStatus') AS 'As Left New Meter Status'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'MeterLockCode') AS 'As Left Meter Lock Code'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'MeterLocation') AS 'New Meter Location'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'ReviewerComments'),'') AS 'Reviewer Comments'
	, PF.FirstName
	, PF.LastName
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SectionDescription') AS 'Section Code'
	, REPLACE(Replace((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'InstallerComments'),char(13),''),char(10),'') AS 'Installer Comments'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSLegacyReadQAResult'),'') AS 'SGS Legacy Read QA Result'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSLegacySerialNumberQAResult'),'') AS 'SGS Legacy Serial Number QA Result'
	, ISNULL((SELECT TOP 1 SocketReviewStatus FROM JobImage WHERE JobId = J.JobId AND [Description] = 'Capture Socket Photo'),'') AS 'SGS Socket Photo QA Result'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSNewMeterSerialNumberQAResult'),'') AS 'SGS New Meter Serial Number QA Result'
	, CASE WHEN ((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1') = '' OR (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1') is null )
		THEN 'N'
		ELSE 'Y' END AS 'Validated Old CT''s ?'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceRatio1') AS 'Ratio (as found)'
	,  CASE WHEN ((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1') = '' OR (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1') is null )
		THEN 'N'
		ELSE 'Y' END AS 'Validated New CT''s ?'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio1') AS 'Ratio (as left)'
FROM Customer C
LEFT JOIN Job J ON C.ActiveJobGuid = J.JobTrackingGuid
LEFT JOIN ProFieldCore.dbo.ProFieldUser PF ON PF.UserId = J.TechId
--LEFT JOIN JobEvent JE ON JE.JobId = J.JobId AND J.EndTime is not null
--LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId
WHERE C.SiteStatus LIKE 'AOC%' --AND C.customerid = '13344667'
ORDER BY J.EndTime DESC

SELECT * FROM Customer WHERE Customerid = '11411652'
SELECT * FROM CustomCustomerInfo WHERE Customerid = '11411652'
SELECT * FROM Job WHERE JobTrackingGuid = '04777A40-F911-430B-83F4-4D81CA06AEA2'
