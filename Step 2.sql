select
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q36 "Toby" has been surgically neutered (spayed or castrated)…
  s.neuterStatus5_5YearsId,
  ns5_5.neuterStatus5_5YearsName,
  --Q36a Have you previously given us information about 'Toby's' surgical neutering (spay or castration)?
  s.previousInformationNeuteringSurgicalId,
  pins.previousInformationNeuteringName,
  --Q36b Have you previously given us information about 'Toby's' chemical castration?
  s.previousInformationNeuteringChemicalId,
  pinc.previousInformationNeuteringName,
  --Q36.001 "Toby" was neutered (spayed or castrated)…
  pvtNR.[1] [Q36.001: Because I didn't want him/her to have puppies],
  pvtNR.[2] [Q36.001: To prevent sexual behaviour in the future],
  pvtNR.[3] [Q36.001: Because he/she had started to show sexual behaviour (mounting/humping)],
  pvtNR.[4] [Q36.001: To prevent unwanted aggressive behaviour in the future],
  pvtNR.[5] [Q36.001: Because he/she had started to show aggressive behaviour],
  pvtNR.[6] [Q36.001: To reduce the risk of future health problems],
  pvtNR.[7] [Q36.001: Because the vet recommended it],
  pvtNR.[8] [Q36.001: Because the breeder insisted],
  pvtNR.[9] [Q36.001: Because the rehoming centre insisted],
  s.otherNeuterReason5_5Years [Q36.001: Other (please specify)],
  --Q36.01 "Toby" was chemically castrated before he was surgically castrated...
  s.chemicalCastrationBeforeSurgicalId,
  ccbs.chemicalCastrationBeforeSurgicalName,
  --Q36.05 Have "Toby"'s testicles descended?
  s.testiclesDecendedId,
  td.testiclesDecendedName,
  --Q36.06 Have "Toby"'s retained testicles been the main reason, or a contributory reason to him not being neutered yet?
  s.retainedTesticlesForNonNeuterId,
  rtnn.retainedTesticlesForNonNeuterName,
  --Q36.07 One or both of "Toby"'s testicles had not descended at the time of his chemical castration…
  s.testiclesNotDecendedAtChemicalCastrationId,
  tndcc.testiclesNotDecendedAtCastrationName,
  --Q6 One or both of "Toby"'s testicles had not descended at the time of his surgical castration…
  s.testiclesNotDecendedAtSurgicalCastrationId,
  tndsc.testiclesNotDecendedAtCastrationName,
  --Q7 Was/were the undescended testicle(s) removed at the time of surgical castration?
  s.undescendedTesticlesRemovedAtCastrationId,
  utrc.undescendedTesticlesRemovedAtCastrationName,
  --If you have used any non-surgical forms of contraception for "Toby" in the last six months, please provide details here…
  s.nonSurgicalContraceptionDetails
from survey5_5Years s

--Q36 "Toby" has been surgically neutered (spayed or castrated)…
left join referenceNeuterStatus5_5Years ns5_5
  on ns5_5.neuterStatus5_5YearsId = s.neuterStatus5_5YearsId
  
--Q36a Have you previously given us information about 'Toby's' surgical neutering (spay or castration)?
left join referencePreviousInformationNeutering pins
  on pins.previousInformationNeuteringId = s.previousInformationNeuteringSurgicalId
  
--Q36b Have you previously given us information about 'Toby's' chemical castration?
left join referencePreviousInformationNeutering pinc
  on pinc.previousInformationNeuteringId = s.previousInformationNeuteringChemicalId
  
--Q36.001 "Toby" was neutered (spayed or castrated)…
Left join 
	(Select 
		NR.survey5_5YearsId ID,
		neuterReason4_5YearsName [Reason Type],
		cast(NR.neuterReason4_5YearsId as varchar) as 'Reason'

	from survey5_5Years_referenceNeuterReason4_5Years NR

	inner join referenceNeuterReason4_5Years refNR

		on refNR.neuterReason4_5YearsId = NR.neuterReason4_5YearsId
	) NR 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvtNR on pvtNR.ID = s.survey5_5YearsId
  
--Q36.01 "Toby" was chemically castrated before he was surgically castrated...
left join referenceChemicalCastrationBeforeSurgical ccbs
  on ccbs.chemicalCastrationBeforeSurgicalId = s.chemicalCastrationBeforeSurgicalId
  
--Q36.05 Have "Toby"'s testicles descended?
left join referenceTesticlesDecended td
  on td.testiclesDecendedId = s.testiclesDecendedId
  
--Q36.06 Have "Toby"'s retained testicles been the main reason, or a contributory reason to him not being neutered yet?
left join referenceRetainedTesticlesForNonNeuter rtnn
  on rtnn.retainedTesticlesForNonNeuterId = s.retainedTesticlesForNonNeuterId
  
--Q36.07 One or both of "Toby"'s testicles had not descended at the time of his chemical castration…
left join referenceTesticlesNotDecendedAtCastration tndcc
  on tndcc.testiclesNotDecendedAtCastrationId = s.testiclesNotDecendedAtChemicalCastrationId
  
--Q6 One or both of "Toby"'s testicles had not descended at the time of his surgical castration…
left join referenceTesticlesNotDecendedAtCastration tndsc
  on tndsc.testiclesNotDecendedAtCastrationId = s.testiclesNotDecendedAtSurgicalCastrationId
  
--Q7 Was/were the undescended testicle(s) removed at the time of surgical castration?
left join referenceUndescendedTesticlesRemovedAtCastration utrc
  on utrc.undescendedTesticlesRemovedAtCastrationId = s.undescendedTesticlesRemovedAtCastrationId
  
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