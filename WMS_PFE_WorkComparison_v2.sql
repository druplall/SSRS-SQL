SELECT
	 C.CustomerId 
	, C.CustomerName
	, C.ServiceType
	, C.UtilityServiceID
	, C.SiteStatus
	, C.Address
	, C.city
	, C.State
	, C.PostalCode
	, CustomerNumber
	, C.CustomCIS2 AS 'WR#'
	, CASE WHEN J.EndTime > '2018-11-03 00:37:03.053'
		   THEN convert(varchar, dateadd(hour,-5,J.EndTime),100)
		   ELSE convert(varchar, dateadd(hour,-4,J.EndTime),100)
		   END AS  'TransactionDateTime'
	, C.LegacyMeterSerial
	, CASE WHEN C.NewMeterSerial = '' THEN
		(SELECT value From CustomCustomerInfo CI WHERE C.CustomerId = CI.CustomerId and CI.[KEY] LIKE 'newsocketapseri%')
		ELSE C.NewMeterSerial END AS 'NewMeterSerial'
	, PU.FirstName
	, PU.LastName
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.Customerid = CI.CustomerId and CI.[KEY] = 'EmployeeID') AS 'EmployeeID'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.Customerid = CI.CustomerId and CI.[KEY] = 'SupervisorName') AS 'SupervisorName'
	, (SELECT value FROM CustomCustomerInfo CI WHERE C.Customerid = CI.CustomerId and CI.[KEY] = 'SectionCode') AS 'SectionCode'
FROM Customer C
INNER JOIN Job J 
ON J.JobTrackingGuid = C.ActiveJobGuid
INNER JOIN ProFieldCore.dbo.ProFieldUser PU
ON PU.UserId = J.TechId
WHERE SiteStatus IN ('QAReady','QAAccepted','AOCReview','Certified')
ORDER BY J.EndTime DESC