select	ISNULL(CONVERT(nvarchar,DATEDIFF(day,j.EndTime,getDATE())),'N/A') as [Age In Days]
	, c.PremiseNumber as 'SDPID'
	, c.CustomerNumber as 'Account Number'
	, c.CustomerName
	, ISNULL(Address,'') +', '+ISNULL(City,'') as Address
	, C.UtilityServiceID
	, case when cciLegacyMeter.Value is not null then cciLegacyMeter.Value else c.LegacyMeterSerial end as [Legacy Meter Serial]
	, CASE WHEN C.NewMeterSerial = ''
		THEN (SELECT TOP 1 Value FROM CustomCustomerInfo CI WHERE CI.customerid = C.CustomerId AND CI.[KEY] LIKE 'newsocketap%')
		ELSE C.NewMeterSerial END AS 'New Meter Serial'
	, c.SiteStatus as [Site Status]
	, ISNULL(FORMAT(j.EndTime,'MM/dd/yyyy hh:mm:s tt'),'N/A') as [Job End Time]
	, c.CustomCIS2 as [Work Request ID]
	, c.CustomerId as [Customer ID]
	, case when (je.Description is null or je.Description='') then '' else SUBSTRING(je.Description, CHARINDEX('PDA', je.Description) + 3, 100) end as PDA
	, case when (jeInst.Description is null or jeInst.Description='') then '' else SUBSTRING(jeInst.Description, CHARINDEX(' to ', jeInst.Description) + 3, 100) end as [Installer Name]
	--, 
from Customer c 
Left join Job j on c.ActiveJobGUID = j.JobTrackingGUID 
Left join JobEvent je on je.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Assignment Received' and Description like '%PDA%')
Left join JobEvent jeInst on jeInst.JobEventId = (select MAX(JobEventId) from JobEvent where JobId=j.JobId and Title='Assigned' and Description like '%Assigned to%')
Left join CustomCustomerInfo cciLegacyMeter on cciLegacyMeter.CustomerId = c.CustomerId and cciLegacyMeter.[key]='LegacyMeterSerialDiffered'
where (j.Status=20 and c.SiteStatus='Assigned')
AND J.EndTime BETWEEN @StartTime AND @EndTime
ORDER BY J.EndTime DESC