select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q1 Approximately how many days is it since "Toby" met a new dog from outside the household…
  COALESCE(s.daysSinceMetDogOutsideHouseholdId, '999') [Q1: Days Since Met New Dog From Outside Household ID],
  DSM.daysSinceMetTypeName [Q1: Days Since Met New Dog From Outside Household Desc],
  --Q2 In the last seven days, "Toby" has met/come across..
  COALESCE(s.dogsOutsideHouseTypeId, '999') [Q2: Num New Dogs Met Last 7 Days ID],
  DOH.dogsOutsideHouseTypeName [Q2: Num New Dogs Met Last 7 Days ID],
  --Q3 The meeting(s) took place...
  pvtMLT.[1] [Q3: As the other dog entered my house],
  pvtMLT.[2] [Q3: Inside my house],
  pvtMLT.[3] [Q3: In my garden],
  s.otherMeetingLocationType [Q3: Somewhere else (please specify)],
  --Q4 In the last seven days, "Toby" has met/come across…
  pvtAoD.[1] [Q4: A puppy (aged up to approximately 6 months)],
  pvtAoD.[2] [Q4: A young dog],
  pvtAoD.[3] [Q4: An adult dog],
  pvtAoD.[4] [Q4: A senior/elderly dog],
  pvtAoD.[5] [Q4: I cannot guess the age(s) of the other dog(s)],
  --Q5 In the last seven days, the other dog(s) that "Toby" met was/were...
  pvtSoDM.[1] [Q5: About the same size as my dog when they met],
  pvtSoDM.[2] [Q5: Smaller than my dog when they met],
  pvtSoDM.[3] [Q5: Larger than my dog when they met],
  --Q6 The LAST TIME "Toby" met a new dog from outside the household, he/she...
  pvtRTND.[1] [Q6: Had a low/straight (relaxed) tail posture],
  pvtRTND.[2] [Q6: Had a raised tail posture],
  pvtRTND.[3] [Q6: Had a wagging tail],
  pvtRTND.[4] [Q6: Held tail down between his/her legs],
  pvtRTND.[5] [Q6: Was interested but stayed calm],
  pvtRTND.[6] [Q6: Was disinterested/didn't react/rested or slept],
  pvtRTND.[7] [Q6: Approached other dog slowly],
  pvtRTND.[8] [Q6: Ran up to other dog],
  pvtRTND.[9] [Q6: Sniffed at other dog],
  pvtRTND.[10] [Q6: Rolled other dog over],
  pvtRTND.[11] [Q6: Was rolled over by other dog],
  pvtRTND.[12] [Q6: Held/pinned down other dog],
  pvtRTND.[13] [Q6: Was held/pinned down by other dog],
  pvtRTND.[14] [Q6: Jumped up at other dog],
  pvtRTND.[15] [Q6: Tried to play],
  pvtRTND.[16] [Q6: Licked at the other dog's mouth],
  pvtRTND.[17] [Q6: Rolled on his/her back],
  pvtRTND.[18] [Q6: Barked at the dog],
  pvtRTND.[19] [Q6: Growled/snarled at the dog],
  pvtRTND.[20] [Q6: Froze or stayed still],
  pvtRTND.[21] [Q6: Trembled or shook],
  pvtRTND.[22] [Q6: Raised his/her hackles],
  pvtRTND.[23] [Q6: Pined, whined, or cried],
  pvtRTND.[24] [Q6: Hid/cowered],
  pvtRTND.[25] [Q6: Ran/pulled away],
  pvtRTND.[26] [Q6: Stayed close/came to/tried to get attention from me or other household member],
  pvtRTND.[27] [Q6: Toileted],
  pvtRTND.[28] [Q6: Tried to chase other dog],
  pvtRTND.[29] [Q6: Was chased by other dog],
  pvtRTND.[30] [Q6: Snapped at/bit other dog],
  pvtRTND.[31] [Q6: Was snapped at/bitten by other dog],
  pvtRTND.[32] [Q6: Mounted other dog],
  pvtRTND.[33] [Q6: Was mounted by other dog],
  pvtRTND.[34] [Q6: I don’t know/can’t remember],
  s.otherReactionToNewDogType [Q6: Other (please specify)],
  --Q7 The interaction/meeting between "Toby" and the other dog ended because...
  pvtELIOH.[1] [Q7: I left, moved or walked past with my dog],
  pvtELIOH.[2] [Q7: The other owner left, moved on or walked past with their dog],
  pvtELIOH.[3] [Q7: I picked up my dog],
  pvtELIOH.[4] [Q7: The other owner picked up their dog],
  pvtELIOH.[5] [Q7: My dog became tired],
  pvtELIOH.[6] [Q7: The other dog became tired],
  pvtELIOH.[7] [Q7: My dog was trying to get away from the other dog],
  pvtELIOH.[8] [Q7: The other dog was trying to get away from my dog],
  pvtELIOH.[9] [Q7: My dog was over-excited],
  pvtELIOH.[10] [Q7: The other dog was over-excited],
  pvtELIOH.[11] [Q7: My dog was barking],
  pvtELIOH.[12] [Q7: The other dog was barking],
  pvtELIOH.[13] [Q7: My dog was growling],
  pvtELIOH.[14] [Q7: The other dog was growling],
  pvtELIOH.[15] [Q7: My dog bit the other dog],
  pvtELIOH.[16] [Q7: The other dog bit my dog],
  s.otherEndLastIntOutsideHouseType [Q7: Other (please specify)],
  --Q8 Does "Toby" react in the same way to all new dogs he/she didn't previously know when outside of the household, or does this differ between dogs?
  COALESCE(s.reactionChangeId, '999') [Q8: Reaction Change to Dog Outside Household ID], 
  RC.reactionChangeName [Q8: Reaction Change to Dog Outside Household Desc],
  --Q9 Please describe how "Toby's" reactions vary when meeting different dogs...
  s.otherReactionToNewDogsChangeDetail [Q9: Reaction Change to Dog Outside Household Detial],
  --Q10 Approximately how many days is it since "Toby" met a dog that he/she knows?
  COALESCE(s.daysSinceMetKnownDogId, '999') [Q10: Days Since Met Known Dog ID],
  DSMKD.daysSinceMetKnownDogName [Q10: Days Since Met Known Dog Desc],
  --Q11 In the last seven days, how many dogs that "Toby" knows has he/she interacted with?
  COALESCE(s.numberKnownDogsMetId, '999') [Q11: Num Known Dogs Met Last 7 Days ID],
  NKDM.numberKnownDogsMetName [Q11: Num Known Dogs Met Last 7 Days Desc],
  --Q12 The LAST TIME "Toby" interacted with a familiar dog when outside of the household, he/she...
  pvtRTKDO.[1] [Q12: Had a low/straight (relaxed) tail posture],
  pvtRTKDO.[2] [Q12: Had a raised tail posture],
  pvtRTKDO.[3] [Q12: Had a wagging tail],
  pvtRTKDO.[4] [Q12: Held tail down between his/her legs],
  pvtRTKDO.[5] [Q12: Was interested but stayed calm],
  pvtRTKDO.[6] [Q12: Was disinterested/didn't react/rested or slept],
  pvtRTKDO.[7] [Q12: Approached other dog slowly],
  pvtRTKDO.[8] [Q12: Ran up to other dog],
  pvtRTKDO.[9] [Q12: Sniffed at other dog],
  pvtRTKDO.[10] [Q12: Rolled other dog over],
  pvtRTKDO.[11] [Q12: Was rolled over by other dog],
  pvtRTKDO.[12] [Q12: Held/pinned down other dog],
  pvtRTKDO.[13] [Q12: Tried to play],
  pvtRTKDO.[14] [Q12: Rolled on his/her back],
  pvtRTKDO.[15] [Q12: Barked at the dog],
  pvtRTKDO.[16] [Q12: Growled/snarled at the dog],
  pvtRTKDO.[17] [Q12: Froze or stayed still],
  pvtRTKDO.[18] [Q12: Trembled or shook],
  pvtRTKDO.[19] [Q12: Raised his/her hackles],
  pvtRTKDO.[20] [Q12: Pined, whined, or cried],
  pvtRTKDO.[21] [Q12: Hid/cowered],
  pvtRTKDO.[22] [Q12: Ran/pulled away],
  pvtRTKDO.[23] [Q12: Stayed close/came to/tried to get attention from me or other household member],
  pvtRTKDO.[24] [Q12: Toileted],
  pvtRTKDO.[25] [Q12: Tried to chase other dog],
  pvtRTKDO.[26] [Q12: Was chased by other dog],
  pvtRTKDO.[27] [Q12: Snapped at/bit other dog],
  pvtRTKDO.[28] [Q12: Was snapped at/bitten by other dog],
  pvtRTKDO.[29] [Q12: Mounted other dog],
  pvtRTKDO.[30] [Q12: Was mounted by other dog],
  pvtRTKDO.[31] [Q12: I don’t know/can’t remember],
  s.otherReactionToKnownDogOutsideType [Q12: Other (please specify)], 
  --Q13 The interaction/meeting between "Toby" and the other dog ended because...
  pvtELIK.[1] [Q13: I left, moved or walked past with my dog],
  pvtELIK.[2] [Q13: The other owner left, moved on or walked past with their dog],
  pvtELIK.[3] [Q13: I picked up my dog],
  pvtELIK.[4] [Q13: The other owner picked up their dog],
  pvtELIK.[5] [Q13: My dog became tired],
  pvtELIK.[6] [Q13: The other dog became tired],
  pvtELIK.[7] [Q13: My dog was trying to get away from the other dog],
  pvtELIK.[8] [Q13: The other dog was trying to get away from my dog],
  pvtELIK.[9] [Q13: My dog was over-excited],
  pvtELIK.[10] [Q13: The other dog was over-excited],
  pvtELIK.[11] [Q13: My dog was barking],
  pvtELIK.[12] [Q13: The other dog was barking],
  pvtELIK.[13] [Q13: My dog was growling],
  pvtELIK.[14] [Q13: The other dog was growling],
  pvtELIK.[15] [Q13: My dog bit the other dog],
  pvtELIK.[16] [Q13: The other dog bit my dog],
  s.otherEndLastIntKnownType [Q13: Other (please specify)],
  --Q14 Is there anything else that you would like to tell us about Toby's experiences with other dogs?
  s.otherExperienceWithOtherDogsDetail [Q14: Experience With Other Dogs Detail],
  --Q15 Normally, when I am walking "Toby" on a short lead and we meet a friendly-looking dog on the lead I would….
  COALESCE(s.normalBothShortLeadMeetingReaction2Id, '999') [Q15: Reaction to friendly-looking dog - both on lead ID],
  NBSLMR.normalBothShortLeadMeetingReaction2Name [Q15: Reaction to friendly-looking dog - both on lead Desc],
  s.otherNormalBothShortLeadMeetingReaction [Q15: Reaction to friendly-looking dog - both on lead (Other (Please Specify))],
  --Q16 Normally when "Toby" is on a short lead and we meet a friendly-looking dog off the lead I would….
  COALESCE(s.normalShortLeadMeetingReaction2Id, '999') [Q16: Reaction to friendly-looking dog - other dog off lead ID],
  NSLMR.normalShortLeadMeetingReaction2Name [Q16: Reaction to friendly-looking dog - other dog off lead Desc],
  s.otherNormalShortLeadMeetingReaction [Q16: Reaction to friendly-looking dog - other dog off lead (Other (Please Specify))],
  --Q17 Normally, when I am walking "Toby" off the lead and we meet a friendly-looking dog off the lead I would….
  COALESCE(s.normalOffLeadMeetingReaction2Id, '999') [Q17: Reaction to friendly-looking dog - both off lead ID],
  NOLMR.normalOffLeadMeetingReaction2Name [Q17: Reaction to friendly-looking dog - both off lead Desc],
  s.otherNormalOffLeadMeetingReaction [Q17: Reaction to friendly-looking dog - both off lead (Other (Please Specify))],
  --Q18 Please use the space below to describe how "Toby" gets on with the other dog(s) in your household. (If you do not have any other dogs in your household then please skip this question and move to step 8)…
  s.otherHowGetsOnWithDogsDetail [Q18: How Dog Gets On With Other Dogs Detail]
from survey5_5years s
--Q1 Approximately how many days is it since "Toby" met a new dog from outside the household…
left join referenceDaysSinceMetType DSM
  on DSM.daysSinceMetTypeId = s.daysSinceMetDogOutsideHouseholdId
--Q2 In the last seven days, "Toby" has met/come across..
left join referenceDogsOutsideHouseType DOH
  on DOH.dogsOutsideHouseTypeId = s.dogsOutsideHouseTypeId
--Q3 The meeting(s) took place...
Left join 
	(Select 
		MLT.survey5_5YearsId ID,
		meetingLocationTypeName [Location Type],
		cast(MLT.meetingLocationTypeId as varchar) as 'Location'

	from survey5_5Years_referenceMeetingLocationType MLT

	inner join referenceMeetingLocationType refMLT

		on refMLT.meetingLocationTypeId = MLT.meetingLocationTypeId
	) MLT 
	PIVOT
	
	(min([Location Type]) For Location
		IN ([1], [2], [3])
	) 
	pvtMLT on pvtMLT.ID = s.survey5_5YearsId

--Q4 In the last seven days, "Toby" has met/come across…
Left join 
	(Select 
		AoD.survey5_5YearsId ID,
		ageOfDogMetName [Age Type],
		cast(AoD.ageOfDogMetId as varchar) as 'Age'

	from survey5_5Years_referenceAgeOfDogMet AoD

	inner join referenceAgeOfDogMet refAoD

		on refAoD.ageOfDogMetId = AoD.ageOfDogMetId
	) AoD 
	PIVOT
	
	(min([Age Type]) For Age
		IN ([1], [2], [3], [4], [5])
	) 
	pvtAoD on pvtAoD.ID = s.survey5_5YearsId

--Q5 In the last seven days, the other dog(s) that "Toby" met was/were...
Left join 
	(Select 
		SoDM.survey5_5YearsId ID,
		sizeOfDogMet2Name [Size Type],
		cast(SoDM.sizeOfDogMet2Id as varchar) as 'Size'

	from survey5_5Years_referenceSizeOfDogMet2 SoDM

	inner join referenceSizeOfDogMet2 refSoDM

		on refSoDM.sizeOfDogMet2Id = SoDM.sizeOfDogMet2Id
	) SoDM 
	PIVOT
	
	(min([Size Type]) For Size
		IN ([1], [2], [3])
	) 
	pvtSoDM on pvtSoDM.ID = s.survey5_5YearsId
  
--Q6 The LAST TIME "Toby" met a new dog from outside the household, he/she...
Left join 
	(Select 
		RTND.survey5_5YearsId ID,
		reactionToNewDogTypeName [Reaction Type],
		cast(RTND.reactionToNewDogTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionToNewDogType RTND

	inner join referenceReactionToNewDogType refRTND

		on refRTND.reactionToNewDogTypeId = RTND.reactionToNewDogTypeId
	) RTND 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31], [32], [33], [34], [35])
	) 
	pvtRTND on pvtRTND.ID = s.survey5_5YearsId
--Q7 The interaction/meeting between "Toby" and the other dog ended because...
Left join 
	(Select 
		ELIOH.survey5_5YearsId ID,
		endLastIntOutsideHouseType2Name [Reason Type],
		cast(ELIOH.endLastIntOutsideHouseType2Id as varchar) as 'Reason'

	from survey5_5Years_referenceEndLastIntOutsideHouseType2 ELIOH

	inner join referenceEndLastIntOutsideHouseType2 refELIOH
  
		on refELIOH.endLastIntOutsideHouseType2Id = ELIOH.endLastIntOutsideHouseType2Id
	) ELIOH 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17])
	) 
	pvtELIOH on pvtELIOH.ID = s.survey5_5YearsId
--Q8 Does "Toby" react in the same way to all new dogs he/she didn't previously know when outside of the household, or does this differ between dogs?
left join referenceReactionChange RC
  on RC.reactionChangeId = s.reactionChangeId
--Q10 Approximately how many days is it since "Toby" met a dog that he/she knows?
left join referenceDaysSinceMetKnownDog DSMKD 
  on DSMKD.daysSinceMetKnownDogId = s.daysSinceMetKnownDogId
--Q11 In the last seven days, how many dogs that "Toby" knows has he/she interacted with?
left join referenceNumberKnownDogsMet NKDM
 on NKDM.numberKnownDogsMetId = s.numberKnownDogsMetId
--Q12 The LAST TIME "Toby" interacted with a familiar dog when outside of the household, he/she...
Left join 
	(Select 
		RTKDO.survey5_5YearsId ID,
		reactionToKnownDogOutsideTypeName [Reaction Type],
		cast(RTKDO.reactionToKnownDogOutsideTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionToKnownDogOutsideType RTKDO

	inner join referenceReactionToKnownDogOutsideType refRTKDO

		on refRTKDO.reactionToKnownDogOutsideTypeId = RTKDO.reactionToKnownDogOutsideTypeId
	) RTKDO 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31], [32])
	) 
	pvtRTKDO on pvtRTKDO.ID = s.survey5_5YearsId
--Q13 The interaction/meeting between "Toby" and the other dog ended because...
Left join 
	(Select 
		ELIK.survey5_5YearsId ID,
		endLastIntKnownType2Name [Reason Type],
		cast(ELIK.endLastIntKnownType2Id as varchar) as 'Reason'

	from survey5_5Years_referenceEndLastIntKnownType2 ELIK

	inner join referenceEndLastIntKnownType2 refELIK
  
		on refELIK.endLastIntKnownType2Id = ELIK.endLastIntKnownType2Id
	) ELIK 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17])
	) 
	pvtELIK on pvtELIK.ID = s.survey5_5YearsId
--Q15 Normally, when I am walking "Toby" on a short lead and we meet a friendly-looking dog on the lead I would….
left join referenceNormalBothShortLeadMeetingReaction2 NBSLMR
  on NBSLMR.normalBothShortLeadMeetingReaction2Id = s.normalBothShortLeadMeetingReaction2Id
--Q16 Normally when "Toby" is on a short lead and we meet a friendly-looking dog off the lead I would….
left join referenceNormalShortLeadMeetingReaction2 NSLMR
  on NSLMR.normalShortLeadMeetingReaction2Id = s.normalShortLeadMeetingReaction2Id
--Q17 Normally, when I am walking "Toby" off the lead and we meet a friendly-looking dog off the lead I would….
left join referenceNormalOffLeadMeetingReaction2 NOLMR
  on NOLMR.normalOffLeadMeetingReaction2Id = s.normalOffLeadMeetingReaction2Id

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