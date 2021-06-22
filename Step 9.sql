select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q1: In my house, "Toby" has access to floor surfaces that are…
  COALESCE(s.accessToFloorSurfacesId, '999') [Q1: Accessible Floor Surfaces ID],
  AFS.accessToFloorSurfacesName [Q1: Accessible Floor Surfaces Desc],
  s.otherAccessToFloorSurfaces [Q1: Accessible Floor Surfaces (Other (Please Specify))],
  --Q1a: "Toby" slips on the hard floor surfaces…
  COALESCE(s.slipsOnSurfacesFrequencyId, '999') [Q1a: Slips on Hard Surfaces Freq ID],
  SSF.slipsOnSurfacesFrequencyName [Q1a: Slips on Hard Surfaces Freq Desc],
  s.otherSlipsOnSurfacesFrequency [Q1a: Slips on Hard Surfaces Freq (Other (Please Specify))],
  --Q2a: "Toby" has taken part in agility classes or training…
  COALESCE(s.takenPartInAgilityClassesId, '999') [Q2a Taken Part in Agility Classes ID],
  TPAC.takenPartInAgilityClassesName [Q2a Taken Part in Agility Classes Desc],
  s.otherTakenPartInAgilityClasses [Q2a Taken Part in Agility Classes (Other (Please Specify))],
  --Q2ai/bi: "Toby" began agility training when aged…
  COALESCE(s.agilityClassesWhenAgedAt5_5YearsId, '999') [Q2ai/bi: Began Agility Classes Aged ID],
  ACA.agilityClassesWhenAgedAt5_5YearsName [Q2ai/bi: Began Agility Classes Aged Desc],
  --Q2aii/bii/ci/di: On average, "Toby" has agility training…
  COALESCE(s.agilityClassesFrequencyId, '999') [Q2aii/bii/ci/di: Agility Classes Freq ID],
  ACF.agilityClassesFrequencyName [Q2aii/bii/ci/di: Agility Classes Freq Desc],
  s.otherAgilityClassesFrequency [Q2aii/bii/ci/di: Agility Classes Freq (Other (Please Specify))],
  --Q2b/c: In "Toby"'s 4.5 year survey you told us he/she had never taken part in agility classes or training.  Has he/she attended any agility classes or training since then?
  COALESCE(s.agilityClassesAttendedFrequencySince4_5YearsId, '999') [Q2b/c: Agility Classes Attended Since 4.5 Year Survey Freq ID],
  ACS4_5.agilityClassesAttendedFrequencySince4_5YearsName [Q2b/c: Agility Classes Attended Since 4.5 Year Survey Freq Desc],
  s.otherAgilityClassesAttendedFrequencySince4_5YearsName [Q2b/c: Agility Classes Attended Since 4.5 Year Survey Freq (Other (Please Specify))],
  --Q2d: How often has "Toby" attended agility classes or training over the last year?
  COALESCE(s.agilityClassesAttendedFrequencyLastYearId, '999') [Q2d: Agility Classes Attended Last Year Freq ID],
  ACALY.agilityClassesAttendedFrequencyLastYearName [Q2d: Agility Classes Attended Last Year Freq Desc],
  s.otherAgilityClassesAttendedFrequencyLastYear [Q2d: Agility Classes Attended Last Year Freq (Other (Please Specify))],
  --Q3a: "Toby" has taken part in flyball classes or training…
  COALESCE(s.takenPartInFlyballClassesId, '999') [Q3a: Taken Part in Flyball Classes ID],
  TPFBC.takenPartInFlyballClassesName [Q3a: Taken Part in Flyball Classes Desc],
  s.otherTakenPartInFlyballClasses [Q3a: Taken Part in Flyball Classes (Other (Please Specify))],
  --Q3ai/bi: "Toby" began flyball training when aged…
  COALESCE(s.flyballClassesWhenAgedAt5_5YearsId, '999') [Q3ai/bi: Began Flyball Classes Aged ID],
  FBCA.flyballClassesWhenAgedAt5_5YearsName [Q3ai/bi: Began Flyball Classes Aged Desc],
  --Q3aii/bii/ci/di: On average, "Toby" has flyball training…
  COALESCE(s.flyballClassesFrequencyId, '999') [Q3aii/bii/ci/di: Flyball Class Freq ID],
  FBCF.flyballClassesFrequencyName [Q3aii/bii/ci/di: Flyball Class Freq Desc],
  s.otherFlyballClassesFrequency [Q3aii/bii/ci/di: Flyball Class Freq (Other (Please Specify))],
  --Q3b/c: In "Toby"'s 4.5 year survey you told us he/she had never taken part in flyball classes or training.  Has he/she attended any flyball classes or training since then?
  COALESCE(s.flyballClassesAttendedFrequencySince4_5YearsId, '999') [Q3b/c: Flyball Classes Attended Since 4.5 Year Survey Freq ID],
  FBCS4_5.flyballClassesAttendedFrequencySince4_5YearsName [Q3b/c: Flyball Classes Attended Since 4.5 Year Survey Freq Desc],
  s.otherFlyballClassesAttendedFrequencySince4_5YearsName [Q3b/c: Flyball Classes Attended Since 4.5 Year Survey Freq (Other (Please Specify))],
  --Q3d: How often has "Toby" attended flyball classes or training over the last year?
  COALESCE(s.flyballClassesAttendedFrequencyLastYearId, '999') [Q3d: Flyball Classes Attended Last Year Freq ID],
  FBALY.flyballClassesAttendedFrequencyLastYearName [Q3d: Flyball Classes Attended Last Year Freq Desc],
  s.otherFlyballClassesAttendedFrequencyLastYear [Q3d: Flyball Classes Attended Last Year Freq (Other (Please Specify))],
  --Q4a: "Toby" has taken part in canicross classes or training…
  COALESCE(s.takenPartInCanicrossClassesId, '999') [Q4a: Taken Part in Canicross Classes ID],
  TPCC.takenPartInCanicrossClassesName [Q4a: Taken Part in Canicross Classes Desc],
  s.otherTakenPartInCanicrossClasses [Q4a: Taken Part in Canicross Classes (Other (Please Specify))],
  --Q4ai/bi: "Toby" began canicross training when aged…
  COALESCE(s.canicrossClassesWhenAgedAt5_5YearsId, '999') [Q4ai/bi: Began Canicross Classes Aged ID],
  CCCA.canicrossClassesWhenAgedAt5_5YearsName [Q4ai/bi: Began Canicross Classes Aged Desc],
  --Q4aii/bii/ci/di: On average, "Toby" has canicross training…
  COALESCE(s.canicrossClassesFrequencyId, '999') [Q4aii/bii/ci/di: Canicross Class Freq ID],
  CCF.canicrossClassesFrequencyName [Q4aii/bii/ci/di: Canicross Class Freq Desc],
  s.otherCanicrossClassesFrequency [Q4aii/bii/ci/di: Canicross Class Freq (Other (Please Specify))],
  --Q4b/c: In "Toby"'s 4.5 year survey you told us he/she had never taken part in canicross classes or training.  Has he/she attended any canicross classes or training since then?
  COALESCE(s.canicrossClassesAttendedFrequencySince4_5YearsId, '999') [Q4b/c: Canicross Classes Attended Since 4.5 Year Survey Freq ID],
  CCCS4_5.canicrossClassesAttendedFrequencySince4_5YearsName [Q4b/c: Canicross Classes Attended Since 4.5 Year Survey Freq Desc],
  s.otherCanicrossClassesAttendedFrequencySince4_5YearsName [Q4b/c: Canicross Classes Attended Since 4.5 Year Survey Freq (Other (Plese Specify))],
  --Q4d: How often has "Toby" attended canicross classes or training over the last year?
  COALESCE(s.canicrossClassesAttendedFrequencyLastYearId, '999') [Q4d: Canicross Classes Attended Last Year Freq ID],
  CCALY.canicrossClassesAttendedFrequencyLastYearName [Q4d: Canicross Classes Attended Last Year Freq Desc],
  s.otherCanicrossClassesAttendedFrequencyLastYear [Q4d: Canicross Classes Attended Last Year Freq (Other (Please Specify))],
  --Q5: "Toby" takes part in other canine activities/sport/work (for example heelwork to music, assistance work (guide dog/hearing dog), gundog work, sheepdog trials/work)…
  COALESCE(s.takesPartInOtherCanineSportId, '999') [Q5: Takes Part in Other Canine Activities/Sport/Work ID],
  TPOCS.takesPartInOtherCanineSportName [Q5: Takes Part in Other Canine Activities/Sport/Work Desc],
  --Q5.1: Please use this space to provide more information about the activity/sport/work that "Toby" participates/participated in, including age that he/she started training and the average hours/week that he/she spends/spent participating in this activity.
  s.aboutActivityAndSportDetail [Q5.1: Activity and Sport Detail],
  --Q6: "Toby" jumps into and out of a car/van…
  COALESCE(s.jumpsOutOfCarFrequencyId, '999') [Q6: Jumps out of car Freq ID],
  JOOC.jumpsOutOfCarFrequencyName [Q6: Jumps out of car Freq Desc],
  s.otherJumpsOutOfCarFrequency [Q6: Jumps out of car Freq (Other (Please Specify))],
  --Q7: On an average day "Toby" walks up/down...
  COALESCE(s.averageDayStepsId, '999') [Q7: Average Steps Up per Day Freq ID], 
  ADS.averageDayStepsName [Q7: Average Steps Up per Day Desc],
  --Q8: "Toby" does not usually walk up/down stairs/steps because…
  COALESCE(s.averageDayStepsNoneReasonTypeId, '999') [Q8: Doesn't Walk Up Steps Reason ID],
  ADSNR.averageDayStepsNoneReasonTypeName [Q8: Doesn't Walk Up Steps Reason Desc],
  s.otherAverageDayStepsNoneReasonType [Q8: Doesn't Walk Up Steps Reason (Other (Please Specify))]
from survey5_5Years s

--Q1: In my house, "Toby" has access to floor surfaces that are…
left join referenceAccessToFloorSurfaces AFS
  on AFS.accessToFloorSurfacesId = s.accessToFloorSurfacesId
  
--Q1a: "Toby" slips on the hard floor surfaces…
left join referenceSlipsOnSurfacesFrequency SSF
  on SSF.slipsOnSurfacesFrequencyId = s.slipsOnSurfacesFrequencyId
  
--Q2a: "Toby" has taken part in agility classes or training…
left join referenceTakenPartInAgilityClasses TPAC
  on TPAC.takenPartInAgilityClassesId = s.takenPartInAgilityClassesId
  
--Q2ai: "Toby" began agility training when aged…
left join referenceAgilityClassesWhenAgedAt5_5Years ACA
  on ACA.agilityClassesWhenAgedAt5_5YearsId = s.agilityClassesWhenAgedAt5_5YearsId
  
--Q2aii: On average, "Toby" has agility training…
left join referenceAgilityClassesFrequency ACF
  on ACF.agilityClassesFrequencyId = s.agilityClassesFrequencyId
  
--Q2b: In "Toby"'s 4.5 year survey you told us he/she had never taken part in agility classes or training.  Has he/she attended any agility classes or training since then?
left join referenceAgilityClassesAttendedFrequencySince4_5Years ACS4_5
  on ACS4_5.agilityClassesAttendedFrequencySince4_5YearsId = s.agilityClassesAttendedFrequencySince4_5YearsId
  
--Q2d: How often has "Toby" attended agility classes or training over the last year?
left join referenceAgilityClassesAttendedFrequencyLastYear ACALY
  on ACALY.agilityClassesAttendedFrequencyLastYearId = s.agilityClassesAttendedFrequencyLastYearId
  
--Q3a: "Toby" has taken part in flyball classes or training…
left join referenceTakenPartInFlyballClasses TPFBC
  on TPFBC.takenPartInFlyballClassesId = s.takenPartInFlyballClassesId
  
--Q3ai: "Toby" began flyball training when aged…
left join referenceFlyballClassesWhenAgedAt5_5Years FBCA
  on FBCA.flyballClassesWhenAgedAt5_5YearsId = s.flyballClassesWhenAgedAt5_5YearsId
  
--Q3aii: On average, "Toby" has flyball training…
left join referenceFlyballClassesFrequency FBCF
  on FBCF.flyballClassesFrequencyId = s.flyballClassesFrequencyId
  
--Q3b: In "Toby"'s 4.5 year survey you told us he/she had never taken part in flyball classes or training.  Has he/she attended any flyball classes or training since then?
left join referenceFlyballClassesAttendedFrequencySince4_5Years FBCS4_5
  on FBCS4_5.flyballClassesAttendedFrequencySince4_5YearsId = s.flyballClassesAttendedFrequencySince4_5YearsId
  
--Q3d: How often has "Toby" attended flyball classes or training over the last year?
left join referenceFlyballClassesAttendedFrequencyLastYear FBALY
  on FBALY.flyballClassesAttendedFrequencyLastYearId = s.flyballClassesAttendedFrequencyLastYearId
  
--Q4a: "Toby" has taken part in canicross classes or training…
left join referenceTakenPartInCanicrossClasses TPCC
  on TPCC.takenPartInCanicrossClassesId = s.takenPartInCanicrossClassesId
  
--Q4ai: "Toby" began canicross training when aged…
left join referenceCanicrossClassesWhenAgedAt5_5Years CCCA
  on CCCA.canicrossClassesWhenAgedAt5_5YearsId = s.canicrossClassesWhenAgedAt5_5YearsId
  
--Q4aii: On average, "Toby" has canicross training…
left join referenceCanicrossClassesFrequency CCF
  on CCF.canicrossClassesFrequencyId = s.canicrossClassesFrequencyId
  
--Q4b: In "Toby"'s 4.5 year survey you told us he/she had never taken part in canicross classes or training.  Has he/she attended any canicross classes or training since then?
left join referenceCanicrossClassesAttendedFrequencySince4_5Years CCCS4_5
  on CCCS4_5.canicrossClassesAttendedFrequencySince4_5YearsId = s.canicrossClassesAttendedFrequencySince4_5YearsId
  
--Q4d: How often has "Toby" attended canicross classes or training over the last year?
left join referenceCanicrossClassesAttendedFrequencyLastYear CCALY
  on CCALY.canicrossClassesAttendedFrequencyLastYearId = s.canicrossClassesAttendedFrequencyLastYearId
  
--Q5: "Toby" takes part in other canine activities/sport/work (for example heelwork to music, assistance work (guide dog/hearing dog), gundog work, sheepdog trials/work)…
left join referenceTakesPartInOtherCanineSport TPOCS
  on TPOCS.takesPartInOtherCanineSportId = s.takesPartInOtherCanineSportId
   
--Q6: "Toby" jumps into and out of a car/van…
left join referenceJumpsOutOfCarFrequency JOOC
  on JOOC.jumpsOutOfCarFrequencyId = s.jumpsOutOfCarFrequencyId
  
--Q7: On an average day "Toby" walks up/down...
left join referenceAverageDaySteps ADS
  on ADS.averageDayStepsId = s.averageDayStepsId
  
--Q8: "Toby" does not usually walk up/down stairs/steps because…
left join referenceAverageDayStepsNoneReasonType ADSNR
  on ADSNR.averageDayStepsNoneReasonTypeId = s.averageDayStepsNoneReasonTypeId
   
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