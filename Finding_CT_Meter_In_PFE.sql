SELECT C.customerid
	, C.Address
	, C.SiteStatus
	, C.CustomCIS2
	, C.LegacyMeterSerial
	, CI.[KEY]
	, CI.Value
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON Ci.CustomerId = C.CustomerId AND CI.[KEY] = 'MeterPrefix'
WHERE C.SiteStatus IN ('Assigned', 'Unassigned') AND C.UtilityServiceID != 'METER_SET'
AND CI.Value IN (SELECT value FROM CustomCustomerInfo CT WHERE CT.[Key] = 'MeterPrefix' AND CT.Value LIKE '%CT%' )