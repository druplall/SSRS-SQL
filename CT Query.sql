SELECT C.CustomerNumber
	, C.customerId
	, C.PremiseNumber AS 'SDPID'
	, C.UtilityServiceID
	, C.SiteStatus
	, C.LegacyMeterSerial
	, CASE WHEN C.NewMeterSerial = ''
			THEN (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'NewSocketAPSerialNumber') 
			ELSE C.NewMeterSerial END AS 'NewMeterSerial'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'MeterLocation') AS 'MeterLocation'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'PartSupplied') AS 'PartSupplied'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceMfg') AS 'DeviceMfg'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial0') AS 'LegacyDeviceSerial0'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial1') AS 'LegacyDeviceSerial1'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial2') AS 'LegacyDeviceSerial2'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial3') AS 'LegacyDeviceSerial3'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial4') AS 'LegacyDeviceSerial4'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerial5') AS 'LegacyDeviceSerial5'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerialNumber') AS 'LegacyDeviceSerialNumber'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerialNumber2') AS 'LegacyDeviceSerialNumber2'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerialNumber3') AS 'LegacyDeviceSerialNumber3'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerialNumber4') AS 'LegacyDeviceSerialNumber4'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceSerialNumber5') AS 'LegacyDeviceSerialNumber5'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio1') AS 'LegacyDeviceRatio1'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio2') AS 'LegacyDeviceRatio2'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio3') AS 'LegacyDeviceRatio3'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio4') AS 'LegacyDeviceRatio4'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceRatio5') AS 'LegacyDeviceRatio5'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceSerialNumber') AS 'DeviceSerialNumber'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceSerialNumber2') AS 'DeviceSerialNumber2'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceSerialNumber3') AS 'DeviceSerialNumber3'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceSerialNumber4') AS 'DeviceSerialNumber4'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceSerialNumber5') AS 'DeviceSerialNumber5'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'LegacyDeviceMfg1') AS 'LegacyDeviceMfg1'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceRatio') AS 'DeviceRatio'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceRatio2') AS 'DeviceRatio2'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceRatio3') AS 'DeviceRatio3'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceRatio4') AS 'DeviceRatio4'
	, (SELECT value FROM CustomCustomerInfo CI WHERE CI.CustomerId = C.CustomerId AND CI.[KEY] LIKE 'DeviceRatio5') AS 'DeviceRatio5'
FROM Customer C
WHERE C.CustomerNumber IN (


SELECT *
FROM CustomCustomerInfo 
WHERE CustomerId = '2733986'