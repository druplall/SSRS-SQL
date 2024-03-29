SELECT PU.UserId
	, PU.FirstName
	, PU.LastName
	, PU.Email
	, PU.Enabled
	, PU.BusinessUnitId
	, PU.LoginFailCount
	, PU.TokenCreatedDate
	, PUE.EventName
	, PUE.EventDate
	, PUE.EventDescription
FROM ProFieldUser PU
JOIN ProFieldUserEvent PUE
ON PU.UserId = PUE.UserId
WHERE PU.LastName LIKE 'James%'
AND PU.FirstName LIKE 'Shawn' 
ORDER BY PUE.EventDate DESC 