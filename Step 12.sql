select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q70: Do you know how long "Toby" sleeps during the night-time
  COALESCE(s.PuppySleepNightUnsure,'999') [Q70: Puppy Sleep Hours Known (Night-Time) ID],
  CASE
    WHEN s.PuppySleepNightUnsure = 0 THEN 'No, I''m not sure how long'
    WHEN s.PuppySleepNightUnsure = 1 THEN 'Yes, approximately'
  END [Q70: Puppy Sleep Hours Known (Night-Time) Desc],
  --Q70.1: Max/Min Hours Sleep (Night-time)
  COALESCE(s.PuppySleepNightMaxHrs,'999') [Q70.1: Puppy Max Sleep Hours (Night-time)],
  COALESCE(s.PuppySleepNightMinHrs,'999') [Q70.1: Puppy Min Sleep Hours (Night-time)],
  --Q71: Do you know how long "Toby" sleeps during the day-time
  COALESCE(s.puppySleepDayUnsure,'999') [Q71: Puppy Sleep Hours Known (Day-Time) ID],
  CASE
    WHEN s.puppySleepDayUnsure = 0 THEN 'No, I''m not sure how long'
    WHEN s.puppySleepDayUnsure = 1 THEN 'Yes, approximately'
  END [Q71: Puppy Sleep Hours Known (Day-Time) Desc],
  --Q71.1: Max/Min Hours Sleep (Day-time)
  COALESCE(s.PuppySleepDayMaxHrs,'999') [Q71.1: Puppy Max Sleep Hours (Day-time)],
  COALESCE(s.PuppySleepDayMinHrs,'999') [Q71.1: Puppy Min Sleep Hours (Day-time)],
  --Q72: When "Toby" is asleep I have noticed he/she…
  pvtAN.[1] [Q72: Dreams a lot],
  pvtAN.[2] [Q72: Often snores very loudly when he/she is asleep],
  pvtAN.[3] [Q72: Looks as if he/she is chasing something],
  pvtAN.[4] [Q72: Has small twitching movements of his/her legs],
  pvtAN.[5] [Q72: Stops breathing sometimes],
  pvtAN.[6] [Q72: Is restless],
  pvtAN.[7] [Q72: Wakes up frequently/has disturbed sleep],
  pvtAN.[8] [Q72: I don't know, as I don't see him/her asleep much/at all],
  --pvtAN.[9] [Q72: Other (please specify)],
  s.otherAsleepNoticed [Q72: Other (please specify)],
  pvtAN.[10] [Q72: None of the above],
  --Q73: I notice that "Toby" tends to sleep…
  pvtSP.[1] [Q73: In a 'curled up' position],
  pvtSP.[2] [Q73: Stretched out on his/her side],
  pvtSP.[3] [Q73: On his/her back],
  pvtSP.[4] [Q73: With a toy/object in his/her mouth],
  pvtSP.[5] [Q73: With his/her head propped up (for example on the side of his/her bed)],
  pvtSP.[6] [Q73: I don't know, as I don't see him/her asleep much/at all],
  --pvtSP.[7] [Q73: Other (please specify)],
  s.otherSleepPosition [Q73: Other (please specify)],
  pvtSP.[8] [Q73: None of the above],
  --Q74: At the moment, "Toby" is settled to sleep at night...	
  COALESCE(s.settleMethodTypeId, '999') [Q74: Settled to Sleep Method ID],
  SMT.settleMethodTypeName [Q74: Settled to Sleep Method Desc],
  s.otherSettleMethodType [Q74: Settled to Sleep Method - Other (Please Specify)],
  --Q75: In general, during the last seven nights, "Toby" has slept...
  COALESCE(s.Last7NightsSleptShelterId,'999') [Q75: Last 7 Nights Sleep Shelter ID],
  LSNSS.last7NightsSleptShelterName [Q75: Last 7 Nights Sleep Shelter Desc],
  s.otherLast7MonthsSleptShelter [Q75: Last 7 Nights Sleep Shelter - Other (Please Specify)],
  --Q76: In general, during the last seven nights, "Toby" has slept…
  pvtSLNSL.[1] [Q76: On the floor],
  pvtSLNSL.[2] [Q76: On furniture (other than a bed)],
  pvtSLNSL.[3] [Q76: On a human bed],
  pvtSLNSL.[4] [Q76: In a crate/kennel],
  pvtSLNSL.[5] [Q76: On a dog bed],
  pvtSLNSL.[6] [Q76: I don't know],
  --pvtSLNSL.[7],
  s.OtherLast7NightsSleptLocation  [Q76: Other (please specify)],
  --Q77: We would like to know if "Toby" can get close to people if he/she chooses to during the night…
  COALESCE(s.NightAccessTypeId,'999') [Q77: Access To Humans At Night ID],
  CASE
    WHEN s.NightAccessTypeId = 0 THEN 'No'
    WHEN s.NightAccessTypeId = 1 THEN 'Yes (for example doors are open)'
  END [Q77: Access To Humans At Night Desc],
  --Q78: Does "Toby" usually choose to be close to people at night?
  COALESCE(s.usuallyTriesToSleepWithHuman,'999') [Q78: Chooses To Be Close To Humans At Night ID],
  CASE 
    WHEN s.usuallyTriesToSleepWithHuman = 0 THEN 'No'
    WHEN s.usuallyTriesToSleepWithHuman = 1 THEN 'Yes'
  END [Q78: Chooses To Be Close To Humans At Night Desc]
from survey5_5years s
--Q72: When "Toby" is asleep I have noticed he/she…
Left join 
	(Select 
		AN.survey5_5YearsId ID,
		asleepNoticedName [Behaviour Type],
		cast(AN.asleepNoticedId as varchar) as 'Behaviour'

	from survey5_5Years_referenceAsleepNoticed AN

	inner join referenceAsleepNoticed refAN

		on refAN.asleepNoticedId = AN.asleepNoticedId
	) AN 
	PIVOT
	
	(min([Behaviour Type]) For Behaviour
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvtAN on pvtAN.ID = s.survey5_5YearsId
--Q73: I notice that "Toby" tends to sleep…
Left join 
	(Select 
		SP.survey5_5YearsId ID,
		sleepPositionName [Position Type],
		cast(SP.sleepPositionId as varchar) as 'Position'

	from survey5_5Years_referencesleepPosition SP

	inner join referenceSleepPosition refSP

		on refSP.sleepPositionId = SP.sleepPositionId
	) SP 
	PIVOT
	
	(min([Position Type]) For Position
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtSP on pvtSP.ID = s.survey5_5YearsId
--Q74: At the moment, "Toby" is settled to sleep at night...
left join referenceSettleMethodType SMT
  on SMT.settleMethodTypeId = s.settleMethodTypeId
--Q75: In general, during the last seven nights, "Toby" has slept...
left join referenceLast7NightsSleptShelter LSNSS
  on LSNSS.last7NightsSleptShelterId = s.last7NightsSleptShelterId
--Q76: In general, during the last seven nights, "Toby" has slept…
Left join 
	(Select 
		SLNSL.survey5_5YearsId ID,
		last7NightsSleptLocationName [Location Type],
		cast(SLNSL.last7NightsSleptLocationId as varchar) as 'Location'

	from survey5_5Years_referenceLast7NightsSleptLocation SLNSL

	inner join referenceLast7NightsSleptLocation refSLNSL

		on refSLNSL.last7NightsSleptLocationId = SLNSL.last7NightsSleptLocationId
	) SLNSL 
	PIVOT
	
	(min([Location Type]) For Location
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtSLNSL on pvtSLNSL.ID = s.survey5_5YearsId
  

/*----- Generic ------*/
left join DTGenPupAdmin.dbo.ExcludedDogs adminGP
	on adminGP.DogID = s.dogId
--left join tblAboutMe tblAbtMe
--	on (tblAbtMe.userid = s.userId AND tblAbtMe.dogid = s.dogId AND tblAbtMe.dogId is not null and tblAbtMe.SixMonthPercComplete is not null)

/*--multi-dogs--*/
left join(
    Select userID from dogcore
    Group by userID   
    Having Count(*)>1
) multidogs on multidogs.userId = s.userId
order by dogid