SELECT PU.FirstName
	, PU.LastName
	, PU.UserId
	, PU.Email
	, PUE.EventName
	, PUE.EventDate 
	, PUE.EventDescription
FROM ProFieldCore.dbo.ProFieldUser PU
LEFT JOIN ProFieldCore.dbo.ProFieldUserEvent PUE ON PUE.UserId = PU.UserId
WHERE LastName = 'Ruplall' AND EventName NOT IN ('NewAssignedCustomersSync') 
ORDER BY PUE.EventDate DESC

SELECT PU.FirstName
	, PU.LastName
	, PU.Email
	, PUE.EventName
	, PUE.EventDate 
	, PUE.EventDescription
FROM ProFieldCore.dbo.ProFieldUser PU
LEFT JOIN ProFieldCore.dbo.ProFieldUserEvent PUE ON PUE.UserId = PU.UserId
WHERE LastName = 'Moran' AND EventName NOT IN ('NewAssignedCustomersSync') AND EventName = 'Login'
ORDER BY PUE.EventDate DESC