SELECT Top 200 C.CustomerId AS 'Customer Id' 
	, C.CustomerNumber AS 'SDPID'
	, C.CustomerNumber AS 'Account Number'
	, C.CustomCIS2 AS 'Work Request'
	, C.Address 
	, C.City
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'PartSupplied') AS 'Part Supplied'
	, C.UtilityServiceID AS 'Transaction Type'
	, C.SiteStatus
	, J.EndTime AS 'Job Completion Time'
	, PF.FirstName
	, PF.LastName
	, C.LegacyMeterSerial
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'LegacyMeterType') AS 'Legacy Meter Type'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'ModuleID') AS 'Legacy NIC/MAC Address'
	, CASE WHEN C.NewMeterSerial = ''
		THEN (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.Customerid AND [KEY] = 'NewSocketAPSerialNumber') 
		ELSE C.NewMeterSerial END 'New Meter Serial#'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'NewMeterType') AS 'New Meter Type'
	, (SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'NewMeterModuleNumber') AS 'New Meter NIC/MAC Address'
	-- Reviewer Comments
	, REPLACE(Replace((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'InstallerComments'),char(13),''),char(10),'') AS 'Installer Comments'
	, ISNULL((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'ReviewerComments'),'') AS 'Previous: Reviewer Comments'
	, ISNULL((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'ReviewerComments'),'') AS 'Updated: Reviewer Comments'
	, ISNULL ((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter Type'),'') AS 'Previous: New Meter Type'
	, ISNULL ((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter Type'),'') AS 'Updated: New Meter Type'
	, ISNULL ((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'LegacyMeter Type'),'') AS 'Previous: Legacy Meter Type'
	, ISNULL ((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'LegacyMeter Type'),'') AS 'Updated: Legacy Meter Type'
	, ISNULL ((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'Legacy Meter Serial'),'') AS 'Previous: Legacy Meter Serial'
	, ISNULL ((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'Legacy Meter Serial'),'') AS 'Updated: Legacy Meter Serial'
	, ISNULL ((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter As Found KW'),'') AS 'Previous: New Meter As Found KW'
	, ISNULL ((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter As Found KW'),'') AS 'Updated: New Meter As Found KW'
	, ISNULL ((SELECT TOP 1 PreviousValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter As Left KW'),'') AS 'Previous: New Meter As Left KW'
	, ISNULL ((SELECT TOP 1 UpdatedValue FROM AOC_AUDIT WHERE C.CustomerId = customerid AND FieldName = 'NewMeter As Left KW'),'') AS 'Updated: New Meter As Left KW'
	, ISNULL ((SELECT TOP 1 EventDate FROM JobEvent WHERE J.JobId = Jobid AND Description = 'Supervisor Approved'),'') AS 'Supervisor Approved Date'
	, ISNULL ((SELECT concat(firstname,' ', lastname) FROM ProFieldCore.dbo.ProFieldUser WHERE userid = (SELECT TOP 1 userid FROM JobEvent WHERE J.JobId = Jobid AND Description = 'Supervisor Approved')),'') AS 'Supervisor Approver'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSLegacyReadQAResult'),'') AS 'SGS Legacy Read QA Result'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSLegacySerialNumberQAResult'),'') AS 'SGS Legacy Serial Number QA Result'
	, ISNULL((SELECT TOP 1 SocketReviewStatus FROM JobImage WHERE JobId = J.JobId AND [Description] = 'Capture Socket Photo'),'') AS 'SGS Socket Photo QA Result'
	, ISNULL((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'SGSNewMeterSerialNumberQAResult'),'') AS 'SGS New Meter Serial Number QA Result'
FROM Customer C
LEFT JOIN Job J ON C.ActiveJobGuid = J.JobTrackingGuid
LEFT JOIN ProFieldCore.dbo.ProFieldUser PF ON PF.UserId = J.TechId
WHERE C.SiteStatus IN ('AOCReview','QAAccepted','Certified')
ORDER BY J.EndTime DESC

SELECT DISTINCT(sitestatus)
FROM Customer

SELECT * FROM Customer where customerid = '13566142'
SELECT * FROM Job WHERE JobTrackingGuid = '06E04B39-EF3F-40B2-B1A3-69B58C6AF45C'
SELECT * FROM JobEvent WHERE Jobid = '13945613'