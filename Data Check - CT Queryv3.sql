SELECT C.customerid
	, C.PremiseNumber AS 'SDPID'
	, C.CustomerNumber AS 'Account Number'
	, C.CustomCIS2 AS 'Work Request'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] LIKE '%WorkOrderSource%' ) AS 'Source System'
	, C.UtilityServiceID AS 'Transaction Type'
	, C.SiteStatus
	, C.LegacyMeterSerial
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerial1' OR CI.[Key] = 'LegacyDeviceSerial')) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerial1' OR CI.[Key] = 'LegacyDeviceSerial')) END AS 'CT-1-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceRatio1' OR CI.[Key] = 'LegacyDeviceRatio')) AS 'CT-1-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial2' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber2'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial2') END AS 'CT-2-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio2') AS 'CT-2-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial3' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber3'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial3') END AS 'CT-3-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio3') AS 'CT-3-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial4' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber4'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial4') END AS 'CT-4-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio4') AS 'CT-4-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial5' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber5'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial5') END AS 'CT-5-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio5') AS 'CT-5-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial6' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber6'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial6') END AS 'CT-6-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio6') AS 'CT-6-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial7' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber7'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial7') END AS 'CT-7-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio7') AS 'CT-7-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial8' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber8'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial8') END AS 'CT-8-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio8') AS 'CT-8-(as found)'
	, CASE WHEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial9' ) = ''
		THEN (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND (CI.[Key] = 'LegacyDeviceSerialNumber9'))
		ELSE (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial9') END AS 'CT-9-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio9') AS 'CT-9-(as found)'
	, CASE WHEN C.NewMeterSerial = '' 
		THEN (SELECT TOP 1 value From CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId and CI.[KEY] LIKE 'newsocketapseri%') 
		ELSE C.NewMeterSerial END AS 'NewMeterNumber'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND (CI.[Key] = 'DeviceSerialNumber1' OR CI.[Key] = 'DeviceSerialNumber')) AS 'CT-1-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND (CI.[Key] = 'DeviceRatio1' OR CI.[Key] = 'DeviceRatio')) AS 'CT-1-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber2') AS 'CT-2-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio2') AS 'CT-2-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber3') AS 'CT-3-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio3') AS 'CT-3-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber4') AS 'CT-4-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio4') AS 'CT-4-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber5') AS 'CT-5-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio5') AS 'CT-5-Ratio'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber6') AS 'CT-6-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio6') AS 'CT-6-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber7') AS 'CT-7-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio7') AS 'CT-7-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber8') AS 'CT-8-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio8') AS 'CT-8-(as left)'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber9') AS 'CT-9-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio9') AS 'CT-9-(as left)'
	, REPLACE(Replace((SELECT TOP 1 value FROM CustomCustomerInfo WHERE customerid = C.customerid AND [KEY] = 'InstallerComments'),char(13),''),char(10),'') AS 'Installer Comments'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE LEN((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND ( CI.[Key] = 'LegacyDeviceSerial1' OR CI.[Key] = 'LegacyDeviceSerialNumber') )) > 0 
OR LEN((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND ( CI.[Key] = 'DeviceSerialNumber1' OR CI.[Key] = 'DeviceSerialNumber') )) > 0
--AND J.EndTime BETWEEN @StartTime AND @EndTime