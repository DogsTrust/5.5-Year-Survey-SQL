select 
    s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
	--Q1 Approximately how many days is it since "Toby" met a new adult he/she didn't previously know when they visited the household...
	s.daysMetSinceMetNewAdultTypeId [Q1 Days Since Met New Adult In Household ID],
	dsm1.daysSinceMetTypeName [Q1 Days Since Met New Adult In Household Desc],
	--Q2 The LAST TIME an adult that "Toby" had not met before visited the household, "Toby"..
	pvtltanb.[1] [Q2 Had a low/straight (relaxed) tail posture],
	pvtltanb.[2] [Q2 Had a raised tail posture],
	pvtltanb.[3] [Q2 Had a wagging tail],
	pvtltanb.[4] [Q2 Held tail down between his/her legs],
	pvtltanb.[5] [Q2 Approached the person slowly],
	pvtltanb.[6] [Q2 Ran up to the person],
	pvtltanb.[7] [Q2 Rolled on his/her back],
	pvtltanb.[8] [Q2 Was interested but stayed calm],
	pvtltanb.[9] [Q2 Was disinterested/didn't react/rested or slept],
	pvtltanb.[10] [Q2 Became excited],
	pvtltanb.[11] [Q2 Tried to play (for example brought them a toy/ball)],
	pvtltanb.[12] [Q2 Barked at the person],
	pvtltanb.[13] [Q2 Growled at the person],
	pvtltanb.[14] [Q2 Froze or stayed still],
	pvtltanb.[15] [Q2 Trembled or shook], 
	pvtltanb.[16] [Q2 Raised his/her hackles],
	pvtltanb.[17] [Q2 Snarled/raised upper lip at the person],
	pvtltanb.[18] [Q2 Cowered/hid or tried to hide],
	pvtltanb.[19] [Q2 Pulled/ran away or tried to run away],
	pvtltanb.[20] [Q2 Stayed close/came to/tried to get attention from me or other household member],
	pvtltanb.[21] [Q2 Weed/urinated],
	pvtltanb.[22] [Q2 Tried to chase the person],
	pvtltanb.[23] [Q2 Jumped up at the person],
	pvtltanb.[24] [Q2 Snapped at the person],
	pvtltanb.[25] [Q2 Bit the person],
	pvtltanb.[26] [Q2 Tried to mount the person],
	pvtltanb.[27] [Q2 I don’t know/can’t remember],
	--pvtltanb.[28],
	s.otherReactionLastTimeAdultNotBeforeType [Q2 Other (please specify)],
	--Q3 Does "Toby" react in the same way to all adults when they visit the household or does this differ between people, for example based on gender?
	s.reactionAllAdultsVisitingTypeId [Q3 Same Reaction To Adults Inside the Household ID],
	rc.reactionChangeName [Q3 Same Reaction To Adults Inside the Household Desc],
	--Q4 Please describe how "Toby's" reactions vary when meeting different adults when they visit the household...
	s.otherReactionAdultsVisitingType [Q4 Changes in Reaction to Adults In Household Detail],
	--Q5 Approximately how many days is it since "Toby" met a new adult he/she didn't previously know when outside of the household...
	s.daysMetSinceMetNewAdultNotKnownTypeId [Q5 Days Since Met New Adult Outside Household ID],
	dsm2.daysSinceMetTypeName [Q5 Days Since Met New Adult Outside Household Desc],
	--Q6 The LAST TIME "Toby" met an unfamiliar adult when out of the household, he/she...
	pvtltauf.[1] [Q6 Had a low/straight (relaxed) tail posture],
	pvtltauf.[2] [Q6 Had a raised tail posture],
	pvtltauf.[3] [Q6 Had a wagging tail],
	pvtltauf.[4] [Q6 Held tail down between his/her legs],
	pvtltauf.[5] [Q6 Approached the person slowly],
	pvtltauf.[6] [Q6 Ran up to the person],
	pvtltauf.[7] [Q6 Rolled on his/her back],
	pvtltauf.[8] [Q6 Was interested but stayed calm],
	pvtltauf.[9] [Q6 Was disinterested/didn't react/rested or slept],
	pvtltauf.[10] [Q6 Became excited],
	pvtltauf.[11] [Q6 Tried to play (for example brought them a toy/ball)],
	pvtltauf.[12] [Q6 Barked at the person],
	pvtltauf.[13] [Q6 Growled at the person],
	pvtltauf.[14] [Q6 Froze or stayed still],
	pvtltauf.[15] [Q6 Trembled or shook],
	pvtltauf.[16] [Q6 Raised his/her hackles],
	pvtltauf.[17] [Q6 Snarled/raised upper lip at the person],
	pvtltauf.[18] [Q6 Cowered/hid or tried to hide],
	pvtltauf.[19] [Q6 Pulled/ran away or tried to run away],
	pvtltauf.[20] [Q6 Stayed close/came to/tried to get attention from me or other household member],
	pvtltauf.[21] [Q6 Weed/urinated],
	pvtltauf.[22] [Q6 Tried to chase the person],
	pvtltauf.[23] [Q6 Jumped up at the person],
	pvtltauf.[24] [Q6 Snapped at the person],
	pvtltauf.[25] [Q6 Bit the person],
	pvtltauf.[26] [Q6 Tried to mount the person],
	pvtltauf.[27] [Q6 I don’t know/can’t remember],
	--pvtltauf.[28] [Q6 ],
	s.otherReactionLastTimeAdultUnfamilarType [Q6 Other (please specify)],
	--Q7 Does "Toby" react in the same way to all new adults when outside of the household, or does this differ between people, for example based on gender?
	s.reactionsVaryAllAdultsVisitingTypeId [Q7 Same Reaction To Adults Outside the Household ID],
	rc1.reactionChangeName [Q7 Same Reaction To Adults Outside the Household Desc],
	--Q8 Please describe how "Toby's" reactions vary when meeting different adults when outside of the household...
	s.otherReactionOutsideAdultsVisitingType [Q8 Changes in Reaction to Adults Outside Household Detail],
	--Q9 In the last three months, (excluding children living in our household), "Toby" has met…
	pvtcmoh.[1] [Q9 No children],
	pvtcmoh.[2] [Q9 A baby],
	pvtcmoh.[3] [Q9 A toddler to 4 year old child],
	pvtcmoh.[4] [Q9 A child or children aged 5-10 years],
	pvtcmoh.[5] [Q9 A child or children aged 11-15 years],
	pvtcmoh.[6] [Q9 A child or children that I couldn't guess the age/ages of],
	pvtcmoh.[7] [Q9 I don’t know/can’t remember],
	--Q9a Excluding children living in our household, the age category of the child that "Toby" last met was…
	pvtaolcm.[1] [Q9a No children],
	pvtaolcm.[2] [Q9a A baby],
	pvtaolcm.[3] [Q9a A toddler to 4 year old child],
	pvtaolcm.[4] [Q9a A child or children aged 5-10 years],
	pvtaolcm.[5] [Q9a A child or children aged 11-15 years], 
	pvtaolcm.[6] [Q9a A child or children that I couldn't guess the age/ages of],
	pvtaolcm.[7] [Q9a I don’t know/can’t remember],
	--Q10 Approximately how many days is it since "Toby" met a baby/toddler to 4 year old child/child aged 5-10 years/a child aged 11-15 years, other than any living in the household...
	s.daysSinceMetBabyTypeId [Q10 Days Since Met Baby ID],
	dsm3.daysSinceMetTypeName [Q10 Days Since Met Baby Desc],
	s.daysSinceMetToddlerTo4TypeId [Q10 Days Since Met Toddler to 4 Year Old ID],
	dsm4.daysSinceMetTypeName [Q10 Days Since Met Toddler to 4 Year Old Desc],
	s.daysSinceMet5To10TypeId [Q10 Days Since Met 5 to 10 Year Old ID],
	dsm5.daysSinceMetTypeName [Q10 Days Since Met 5 to 10 Year Old Desc],
	s.daysSinceMet11To15TypeId [Q10 Days Since Met 11 to 15 Year Old ID],
	dsm6.daysSinceMetTypeName [Q10 Days Since Met 11 to 15 Year Old Desc],
	s.daysSinceMetUnknownAgesTypeId [Q10 Days Since Met Unknown Age ID],
	dsm7.daysSinceMetTypeName [Q10 Days Since Met Unknown Age Desc],
	--Q11 The LAST TIME "Toby" met a baby/toddler to 4 year old child/child aged 5-10 years/a child aged 11-15 years other than any living in the household, he/she...
	/*---baby---*/
	pvttlmb.[1] [Q11 (Baby) Had a low/straight (relaxed) tail posture],
	pvttlmb.[2] [Q11 (Baby) Had a raised tail posture],
	pvttlmb.[3] [Q11 (Baby) Had a wagging tail],
	pvttlmb.[4] [Q11 (Baby) Held tail down between his/her legs],
	pvttlmb.[5] [Q11 (Baby) Approached the child slowly],
	pvttlmb.[6] [Q11 (Baby) Ran up to the child ],
	pvttlmb.[7] [Q11 (Baby) Rolled on his/her back],
	pvttlmb.[8] [Q11 (Baby) Was interested but stayed calm],
	pvttlmb.[9] [Q11 (Baby) Was disinterested/didn't react/rested or slept],
	pvttlmb.[10] [Q11 (Baby) Became excited],
	pvttlmb.[11] [Q11 (Baby) Tried to play (for example brought them a toy/ball)],
	pvttlmb.[12] [Q11 (Baby) Barked at the child],
	pvttlmb.[13] [Q11 (Baby) Growled at the child],
	pvttlmb.[14] [Q11 (Baby) Froze or stayed still],
	pvttlmb.[15] [Q11 (Baby) Trembled or shook],
	pvttlmb.[16] [Q11 (Baby) Raised his/her hackles],
	pvttlmb.[17] [Q11 (Baby) Snarled/raised upper lip at the child],
	pvttlmb.[18] [Q11 (Baby) Cowered/hid or tried to hide],
	pvttlmb.[19] [Q11 (Baby) Pulled/ran away or tried to run away],
	pvttlmb.[20] [Q11 (Baby) Stayed close/came to/tried to get attention from me or other household member],
	pvttlmb.[21] [Q11 (Baby) Weed/urinated],
	pvttlmb.[22] [Q11 (Baby) Tried to chase the child],
	pvttlmb.[23] [Q11 (Baby) Jumped up at the child],
	pvttlmb.[24] [Q11 (Baby) Snapped at the child],
	pvttlmb.[25] [Q11 (Baby) Bit the child],
	pvttlmb.[26] [Q11 (Baby) Tried to mount the child],
	pvttlmb.[27] [Q11 (Baby) I don’t know/can’t remember],
	--pvttlmb.[28] [Q11 (Baby) ],
	s.otherTimeMetBabyOutsideHouseholdType [Q11 (Baby) Other (please specify)],
	/*---toddler to 4 year old child---*/
	pvttlmTto4.[1] [Q11 (Toddler to 4) Had a low/straight (relaxed) tail posture],
	pvttlmTto4.[2] [Q11 (Toddler to 4) Had a raised tail posture],
	pvttlmTto4.[3] [Q11 (Toddler to 4) Had a wagging tail],
	pvttlmTto4.[4] [Q11 (Toddler to 4) Held tail down between his/her legs],
	pvttlmTto4.[5] [Q11 (Toddler to 4) Approached the child slowly],
	pvttlmTto4.[6] [Q11 (Toddler to 4) Ran up to the child],
	pvttlmTto4.[7] [Q11 (Toddler to 4) Rolled on his/her back],
	pvttlmTto4.[8] [Q11 (Toddler to 4) Was interested but stayed calm], 
	pvttlmTto4.[9] [Q11 (Toddler to 4) Was disinterested/didn't react/rested or slept],
	pvttlmTto4.[10] [Q11 (Toddler to 4) Became excited],
	pvttlmTto4.[11] [Q11 (Toddler to 4) Tried to play (for example brought them a toy/ball)],
	pvttlmTto4.[12] [Q11 (Toddler to 4) Barked at the child],
	pvttlmTto4.[13] [Q11 (Toddler to 4) Growled at the child],
	pvttlmTto4.[14] [Q11 (Toddler to 4) Froze or stayed still],
	pvttlmTto4.[15] [Q11 (Toddler to 4) Trembled or shook],
	pvttlmTto4.[16] [Q11 (Toddler to 4) Raised his/her hackles],
	pvttlmTto4.[17] [Q11 (Toddler to 4) Snarled/raised upper lip at the child],
	pvttlmTto4.[18] [Q11 (Toddler to 4) Cowered/hid or tried to hide],
	pvttlmTto4.[19] [Q11 (Toddler to 4) Pulled/ran away or tried to run away],
	pvttlmTto4.[20] [Q11 (Toddler to 4) Stayed close/came to/tried to get attention from me or other household member], 
	pvttlmTto4.[21] [Q11 (Toddler to 4) Weed/urinated],
	pvttlmTto4.[22] [Q11 (Toddler to 4) Tried to chase the child],
	pvttlmTto4.[23] [Q11 (Toddler to 4) Jumped up at the child],
	pvttlmTto4.[24] [Q11 (Toddler to 4) Snapped at the child],
	pvttlmTto4.[25] [Q11 (Toddler to 4) Bit the child],
	pvttlmTto4.[26] [Q11 (Toddler to 4) Tried to mount the child],
	pvttlmTto4.[27] [Q11 (Toddler to 4) I don’t know/can’t remember],
	--pvttlmTto4.[28],
	s.otherTimeMetToddlerTo4OutsideHouseholdType [Q11 (Toddler to 4) Other (please specify)],
	/*---child aged 5-10 years---*/
	pvttlm5to10.[1] [Q11 (5 to 10) Had a low/straight (relaxed) tail posture],
	pvttlm5to10.[2] [Q11 (5 to 10) Had a raised tail posture],
	pvttlm5to10.[3] [Q11 (5 to 10) Had a wagging tail],
	pvttlm5to10.[4] [Q11 (5 to 10) Held tail down between his/her legs],
	pvttlm5to10.[5] [Q11 (5 to 10) Approached the child slowly],
	pvttlm5to10.[6] [Q11 (5 to 10) Ran up to the child],
	pvttlm5to10.[7] [Q11 (5 to 10) Rolled on his/her back],
	pvttlm5to10.[8] [Q11 (5 to 10) Was interested but stayed calm],
	pvttlm5to10.[9] [Q11 (5 to 10) Was disinterested/didn't react/rested or slept],
	pvttlm5to10.[10] [Q11 (5 to 10) Became excited],
	pvttlm5to10.[11] [Q11 (5 to 10) Tried to play (for example brought them a toy/ball)],
	pvttlm5to10.[12] [Q11 (5 to 10) Barked at the child],
	pvttlm5to10.[13] [Q11 (5 to 10) Growled at the child],
	pvttlm5to10.[14] [Q11 (5 to 10) Froze or stayed still],
	pvttlm5to10.[15] [Q11 (5 to 10) Trembled or shook],
	pvttlm5to10.[16] [Q11 (5 to 10) Raised his/her hackles],
	pvttlm5to10.[17] [Q11 (5 to 10) Snarled/raised upper lip at the child],
	pvttlm5to10.[18] [Q11 (5 to 10) Cowered/hid or tried to hide],
	pvttlm5to10.[19] [Q11 (5 to 10) Pulled/ran away or tried to run away],
	pvttlm5to10.[20] [Q11 (5 to 10) Stayed close/came to/tried to get attention from me or other household member],
	pvttlm5to10.[21] [Q11 (5 to 10) Weed/urinated],
	pvttlm5to10.[22] [Q11 (5 to 10) Tried to chase the child],
	pvttlm5to10.[23] [Q11 (5 to 10) Jumped up at the child],
	pvttlm5to10.[24] [Q11 (5 to 10) Snapped at the child],
	pvttlm5to10.[25] [Q11 (5 to 10) Bit the child],
	pvttlm5to10.[26] [Q11 (5 to 10) Tried to mount the child],
	pvttlm5to10.[27] [Q11 (5 to 10) I don’t know/can’t remember],
	--pvttlm5to10.[28],
	s.otherTimeMet5To10OutsideHouseholdType [Q11 (5 to 10) Other (please specify)],
	/*---child aged 11-15 years---*/
	pvttlm11to15.[1] [Q11 (11 to 15) Had a low/straight (relaxed) tail posture],
	pvttlm11to15.[2] [Q11 (11 to 15) Had a raised tail posture],
	pvttlm11to15.[3] [Q11 (11 to 15) Had a wagging tail],
	pvttlm11to15.[4] [Q11 (11 to 15) Held tail down between his/her legs],
	pvttlm11to15.[5] [Q11 (11 to 15) Approached the child slowly],
	pvttlm11to15.[6] [Q11 (11 to 15) Ran up to the child],
	pvttlm11to15.[7] [Q11 (11 to 15) Rolled on his/her back],
	pvttlm11to15.[8] [Q11 (11 to 15) Was interested but stayed calm],
	pvttlm11to15.[9] [Q11 (11 to 15) Was disinterested/didn't react/rested or slept],
	pvttlm11to15.[10] [Q11 (11 to 15) Became excited],
	pvttlm11to15.[11] [Q11 (11 to 15) Tried to play (for example brought them a toy/ball)],
	pvttlm11to15.[12] [Q11 (11 to 15) Barked at the child],
	pvttlm11to15.[13] [Q11 (11 to 15) Growled at the child],
	pvttlm11to15.[14] [Q11 (11 to 15) Froze or stayed still],
	pvttlm11to15.[15] [Q11 (11 to 15) Trembled or shook],
	pvttlm11to15.[16] [Q11 (11 to 15) Raised his/her hackles],
	pvttlm11to15.[17] [Q11 (11 to 15) Snarled/raised upper lip at the child],
	pvttlm11to15.[18] [Q11 (11 to 15) Cowered/hid or tried to hide],
	pvttlm11to15.[19] [Q11 (11 to 15) Pulled/ran away or tried to run away],
	pvttlm11to15.[20] [Q11 (11 to 15) Stayed close/came to/tried to get attention from me or other household member],
	pvttlm11to15.[21] [Q11 (11 to 15) Weed/urinated],
	pvttlm11to15.[22] [Q11 (11 to 15) Tried to chase the child],
	pvttlm11to15.[23] [Q11 (11 to 15) Jumped up at the child],
	pvttlm11to15.[24] [Q11 (11 to 15) Snapped at the child],
	pvttlm11to15.[25] [Q11 (11 to 15) Bit the child],
	pvttlm11to15.[26] [Q11 (11 to 15) Tried to mount the child],
	pvttlm11to15.[27] [Q11 (11 to 15) I don’t know/can’t remember],
	--pvttlm11to15.[28],
	s.otherTimeMet11To15OutsideHouseholdType [Q11 (11 to 15) Other (please specify)],
	/*---child unknown age---*/
	pvttlmunk.[1] [Q11 (Unknown) Had a low/straight (relaxed) tail posture],
	pvttlmunk.[2] [Q11 (Unknown) Had a raised tail posture],
	pvttlmunk.[3] [Q11 (Unknown) Had a wagging tail],
	pvttlmunk.[4] [Q11 (Unknown) Held tail down between his/her legs], 
	pvttlmunk.[5] [Q11 (Unknown) Approached the child slowly],
	pvttlmunk.[6] [Q11 (Unknown) Ran up to the child],
	pvttlmunk.[7] [Q11 (Unknown) Rolled on his/her back],
	pvttlmunk.[8] [Q11 (Unknown) Was interested but stayed calm],
	pvttlmunk.[9] [Q11 (Unknown) Was disinterested/didn't react/rested or slept],
	pvttlmunk.[10] [Q11 (Unknown) Became excited],
	pvttlmunk.[11] [Q11 (Unknown) Tried to play (for example brought them a toy/ball)],
	pvttlmunk.[12] [Q11 (Unknown) Barked at the child],
	pvttlmunk.[13] [Q11 (Unknown) Growled at the child],
	pvttlmunk.[14] [Q11 (Unknown) Froze or stayed still],
	pvttlmunk.[15] [Q11 (Unknown) Trembled or shook],
	pvttlmunk.[16] [Q11 (Unknown) Raised his/her hackles],
	pvttlmunk.[17] [Q11 (Unknown) Snarled/raised upper lip at the child],
	pvttlmunk.[18] [Q11 (Unknown) Cowered/hid or tried to hide],
	pvttlmunk.[19] [Q11 (Unknown) Pulled/ran away or tried to run away],
	pvttlmunk.[20] [Q11 (Unknown) Stayed close/came to/tried to get attention from me or other household member],
	pvttlmunk.[21] [Q11 (Unknown) Weed/urinated],
	pvttlmunk.[22] [Q11 (Unknown) Tried to chase the child],
	pvttlmunk.[23] [Q11 (Unknown) Jumped up at the child],
	pvttlmunk.[24] [Q11 (Unknown) Snapped at the child],
	pvttlmunk.[25] [Q11 (Unknown) Bit the child],
	pvttlmunk.[26] [Q11 (Unknown) Tried to mount the child],
	pvttlmunk.[27] [Q11 (Unknown) I don’t know/can’t remember],
	--pvttlmunk.[28],
	s.otherTimeMetUnknownAgesOutsideHouseholdType [Q11 (Unknown) Other (please specify)],
	--Q12 Does "Toby" react in the same way to all children/babies that he/she meets, or does this differ between children/babies?
	/*---baby---*/
	s.reactionChildrenMetBabyTypeId [Q12 Same Reaction To Children Outside the Household (Baby) ID],
	rc3.reactionChangeName[Q12 Same Reaction To Children Outside the Household (Baby) Desc],
	/*---toddler to 4 year old child---*/
	s.reactionChildrenMetToddlerTo4TypeId [Q12 Same Reaction To Children Outside the Household (Toddler to 4) ID],
	rc5.reactionChangeName [Q12 Same Reaction To Children Outside the Household (Toddler to 4) Desc],
	/*---child aged 5-10 years---*/
	s.reactionChildrenMet5To10TypeId [Q12 Same Reaction To Children Outside the Household (5 to 10) ID],
	rc6.reactionChangeName [Q12 Same Reaction To Children Outside the Household (5 to 10) Desc],
	/*---child aged 11-15 years---*/
	s.reactionChildrenMet11To15TypeId [Q12 Same Reaction To Children Outside the Household (11 to 15) ID],
	rc7.reactionChangeName [Q12 Same Reaction To Children Outside the Household (11 to 15) Desc],
	/*---child unknown age---*/
	s.reactionChildrenMetUnknownAgesTypeId [Q12 Same Reaction To Children Outside the Household (Unknown Age) ID],
	rc8.reactionChangeName [Q12 Same Reaction To Children Outside the Household (Unknown Age) Desc],
	--Q13 Please describe how "Toby's" reactions vary when meeting different chldren/babies...
	s.otherReactionChildrenMetBabyType [Q13 Changes in Reaction to Children Outside Household (Baby) Detail],
	s.otherReactionChildrenMetToddlerTo4Type [Q13 Changes in Reaction to Children Outside Household (Toddler-4) Detail],
	s.otherReactionChildrenMet5To10Type [Q13 Changes in Reaction to Children Outside Household (5-10) Detail],
	s.otherReactionChildrenMet11To15Type [Q13 Changes in Reaction to Children Outside Household (11-15) Detail],
	s.otherReactionChildrenMetUnknownAgesType [Q13 Changes in Reaction to Children Outside Household (Unknown) Detail]
from survey5_5years s

--Q1 Approximately how many days is it since "Toby" met a new adult he/she didn't previously know when they visited the household...
left join referenceDaysSinceMetType dsm1
	on dsm1.daysSinceMetTypeId = s.daysMetSinceMetNewAdultTypeId

--Q2 The LAST TIME an adult that "Toby" had not met before visited the household, "Toby"..
Left join 
	(Select 
		ltanb.survey5_5YearsId ID,
		reactionLastTimeAdultNotBeforeTypeName [Reaction Type],
		cast(ltanb.reactionLastTimeAdultNotBeforeTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeAdultNotBeforeType ltanb

	inner join referenceReactionLastTimeAdultNotBeforeType refltanb

		on refltanb.reactionLastTimeAdultNotBeforeTypeId = ltanb.reactionLastTimeAdultNotBeforeTypeId
	) Reaction 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvtltanb on pvtltanb.ID = s.survey5_5YearsId

--Q3 Does "Toby" react in the same way to all adults when they visit the household or does this differ between people, for example based on gender?
left join referenceReactionChange rc
	on rc.reactionChangeId = s.reactionAllAdultsVisitingTypeId

--Q5 Approximately how many days is it since "Toby" met a new adult he/she didn't previously know when outside of the household...
left join referenceDaysSinceMetType dsm2
	on dsm2.daysSinceMetTypeId = s.daysMetSinceMetNewAdultNotKnownTypeId

--Q6 The LAST TIME "Toby" met an unfamiliar adult when out of the household, he/she...
Left join 
	(Select 
		ltauf.survey5_5YearsId ID,
		reactionLastTimeAdultNotBeforeTypeName [Reaction Type],
		cast(ltauf.reactionLastTimeAdultNotBeforeTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeAdultUnfamilarType ltauf

	inner join referenceReactionLastTimeAdultNotBeforeType refltauf

		on refltauf.reactionLastTimeAdultNotBeforeTypeId = ltauf.reactionLastTimeAdultNotBeforeTypeId
	) Reaction 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvtltauf on pvtltauf.ID = s.survey5_5YearsId

--Q7 Does "Toby" react in the same way to all new adults when outside of the household, or does this differ between people, for example based on gender?
left join referenceReactionChange rc1
	on rc1.reactionChangeId = s.reactionsVaryAllAdultsVisitingTypeId

--Q9 In the last three months, (excluding children living in our household), "Toby" has met…
Left join 
	(Select 
		cmoh.survey5_5YearsId ID,
		childrenMetOutsideHouseholdTypeName [Child Type],
		cast(cmoh.childrenMetOutsideHouseholdTypeId as varchar) as 'Child'

	from survey5_5Years_referenceChildrenMetOutsideHouseholdType cmoh

	inner join referenceChildrenMetOutsideHouseholdType refcmoh

		on refcmoh.childrenMetOutsideHouseholdTypeId = cmoh.childrenMetOutsideHouseholdTypeId
	) Reaction 
	PIVOT
	
	(min([Child Type]) For Child
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtcmoh on pvtcmoh.ID = s.survey5_5YearsId

--Q9a Excluding children living in our household, the age category of the child that "Toby" last met was…
Left join 
	(Select 
		aolcm.survey5_5YearsId ID,
		ageOfChildLastMetName [Child Type],
		cast(aolcm.ageOfChildLastMetId as varchar) as 'Child'

	from survey5_5Years_referenceAgeOfChildLastMet aolcm

	inner join referenceAgeOfChildLastMet refaolcm

		on refaolcm.ageOfChildLastMetId = aolcm.ageOfChildLastMetId
	) aolcm 
	PIVOT
	
	(min([Child Type]) For Child
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtaolcm on pvtaolcm.ID = s.survey5_5YearsId

--Q10 Approximately how many days is it since "Toby" met a baby/toddler to 4 year old child/child aged 5-10 years/a child aged 11-15 years, other than any living in the household...
Left join referenceDaysSinceMetType dsm3
	on dsm3.daysSinceMetTypeId = s.daysSinceMetBabyTypeId

Left join referenceDaysSinceMetType dsm4
	on dsm4.daysSinceMetTypeId = s.daysSinceMetToddlerTo4TypeId

Left join referenceDaysSinceMetType dsm5
	on dsm5.daysSinceMetTypeId = s.daysSinceMet5To10TypeId

Left join referenceDaysSinceMetType dsm6
	on dsm6.daysSinceMetTypeId = s.daysSinceMet11To15TypeId

Left join referenceDaysSinceMetType dsm7
	on dsm7.daysSinceMetTypeId = s.daysSinceMetUnknownAgesTypeId

--Q11 The LAST TIME "Toby" met a baby/toddler to 4 year old child/child aged 5-10 years/a child aged 11-15 years other than any living in the household, he/she...
/*---baby---*/
Left join 
	(Select 
		tlmb.survey5_5YearsId ID,
		reftlmb.lastTimeMetChildrenOutsideHouseholdTypeName [Reaction Type],
		cast(tlmb.lastTimeMetChidrenOutsideHouseholdTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeMetBabyOutsideHouseholdType tlmb

	inner join referenceLastTimeMetChildrenOutsideHouseholdType reftlmb

		on reftlmb.lastTimeMetChildrenOutsideHouseholdTypeId = tlmb.lastTimeMetChidrenOutsideHouseholdTypeId
	) tlmb 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvttlmb on pvttlmb.ID = s.survey5_5YearsId
/*---toddler to 4 year old child---*/
Left join 
	(Select 
		tlmTto4.survey5_5YearsId ID,
		reftlmTto4.lastTimeMetChildrenOutsideHouseholdTypeName [Reaction Type],
		cast(tlmTto4.lastTimeMetChidrenOutsideHouseholdTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeMetToddlerTo4OutsideHouseholdType tlmTto4

	inner join referenceLastTimeMetChildrenOutsideHouseholdType reftlmTto4

		on reftlmTto4.lastTimeMetChildrenOutsideHouseholdTypeId = tlmTto4.lastTimeMetChidrenOutsideHouseholdTypeId
	) tlmTto4 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvttlmTto4 on pvttlmTto4.ID = s.survey5_5YearsId
/*---child aged 5-10 years---*/
Left join 
	(Select 
		tlm5to10.survey5_5YearsId ID,
		reftlm5to10.lastTimeMetChildrenOutsideHouseholdTypeName [Reaction Type],
		cast(tlm5to10.lastTimeMetChidrenOutsideHouseholdTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeMet5To10OutsideHouseholdType tlm5to10

	inner join referenceLastTimeMetChildrenOutsideHouseholdType reftlm5to10

		on reftlm5to10.lastTimeMetChildrenOutsideHouseholdTypeId = tlm5to10.lastTimeMetChidrenOutsideHouseholdTypeId
	) tlm5to10 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvttlm5to10 on pvttlm5to10.ID = s.survey5_5YearsId
/*---child aged 11-15 years---*/
Left join 
	(Select 
		tlm11to15.survey5_5YearsId ID,
		reftlm11to15.lastTimeMetChildrenOutsideHouseholdTypeName [Reaction Type],
		cast(tlm11to15.lastTimeMetChidrenOutsideHouseholdTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeMet11To15OutsideHouseholdType tlm11to15

	inner join referenceLastTimeMetChildrenOutsideHouseholdType reftlm11to15

		on reftlm11to15.lastTimeMetChildrenOutsideHouseholdTypeId = tlm11to15.lastTimeMetChidrenOutsideHouseholdTypeId
	) tlm11to15 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvttlm11to15 on pvttlm11to15.ID = s.survey5_5YearsId
/*---child unknown age---*/
Left join 
	(Select 
		tlmunk.survey5_5YearsId ID,
		reftlmunk.lastTimeMetChildrenOutsideHouseholdTypeId [Reaction Type],
		cast(tlmunk.lastTimeMetChidrenOutsideHouseholdTypeId as varchar) as 'Reaction'

	from survey5_5Years_referenceReactionLastTimeMetUnknownAgesOutsideHouseholdType tlmunk

	inner join referenceLastTimeMetChildrenOutsideHouseholdType reftlmunk

		on reftlmunk.lastTimeMetChildrenOutsideHouseholdTypeId = tlmunk.lastTimeMetChidrenOutsideHouseholdTypeId
	) tlmunk 
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28])
	) 
	pvttlmunk on pvttlmunk.ID = s.survey5_5YearsId

--Q12 Does "Toby" react in the same way to all children/babies that he/she meets, or does this differ between children/babies?
/*---baby---*/
left join referenceReactionChange rc3
	on rc3.reactionChangeId = s.reactionChildrenMetBabyTypeId
/*---toddler to 4 year old child---*/
left join referenceReactionChange rc5
	on rc5.reactionChangeId = s.reactionChildrenMetToddlerTo4TypeId
/*---child aged 5-10 years---*/
left join referenceReactionChange rc6
	on rc6.reactionChangeId = s.reactionChildrenMet5To10TypeId
/*---child aged 11-15 years---*/
left join referenceReactionChange rc7
	on rc7.reactionChangeId = s.reactionChildrenMet11To15TypeId
/*---child unknown age---*/
left join referenceReactionChange rc8
	on rc8.reactionChangeId = s.reactionChildrenMetUnknownAgesTypeId


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
where s.dogId = 3507 or s.dogId = 3509
order by dogid