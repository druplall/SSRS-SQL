SELECT CI.[Key], Count(*) AS 'Count Of Part Supplied Update'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'PartSuppliedCorrect'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE (CI.Value = 'N') 
GROUP BY CI.[Key]

SELECT CI.[Key], Count(*) AS 'Count Of Address Update'
FROM Customer C
LEFT JOIN CustomCustomerInfo CI ON CI.CustomerId = C.CustomerId AND CI.[Key] = 'AddressDetailCorrect'
LEFT JOIN Job J ON J.JobTrackingGuid = C.ActiveJobGuid
WHERE (CI.Value = 'N') 
GROUP BY CI.[Key]

