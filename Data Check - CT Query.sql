SELECT C.customerid
	, C.PremiseNumber AS 'SDPID'
	, C.CustomerNumber AS 'Account Number'
	, C.CustomCIS2 AS 'Work Request'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.customerid AND CI.[Key] LIKE '%WorkOrderSource%' ) AS 'Source System'
	, C.UtilityServiceID AS 'Transaction Type'
	, C.SiteStatus
	, C.LegacyMeterSerial
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1') AS 'CT-1-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial2') AS 'CT-2-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial3') AS 'CT-3-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial4') AS 'CT-4-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial5') AS 'CT-5-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial6') AS 'CT-6-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial7') AS 'CT-7-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial8') AS 'CT-8-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceSerial9') AS 'CT-9-OLD'
	, (SELECT TOP 1 value FROM customCustomerInfo CI WHERE C.Customerid = CI.CustomerId AND CI.[Key] = 'LegacyDeviceRatio2') AS 'Ratio(as found)'
	, CASE WHEN C.NewMeterSerial = '' 
		THEN (SELECT TOP 1 value From CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId and CI.[KEY] LIKE 'newsocketapseri%') 
		ELSE C.NewMeterSerial END AS 'NewMeterNumber'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1') AS 'CT-1-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber2') AS 'CT-2-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber3') AS 'CT-3-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber4') AS 'CT-4-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber5') AS 'CT-5-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber6') AS 'CT-6-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber7') AS 'CT-7-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber8') AS 'CT-8-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber9') AS 'CT-9-NEW'
	, (SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceRatio1') AS 'Ratio (as left)'
FROM Customer C
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE LEN((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'LegacyDeviceSerial1')) > 0 OR LEN((SELECT TOP 1 value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[Key] = 'DeviceSerialNumber1')) > 0
AND J.EndTime BETWEEN @StartTime AND @EndTime
