select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q17: Please read the statements below and choose the response most appropriate to "Toby"
  pvtAFR.[1] [Q17: My dog gets excited when there is food around],
  pvtAFR.[2] [Q17: My dog spends most of his/her walks off the lead],
  pvtAFR.[3] [Q17: My dog gets human leftovers in his/her food bowl],
  pvtAFR.[4] [Q17: My dog hangs around for titbits even if there is not much chance of getting them],
  pvtAFR.[5] [Q17: My dog is choosy about which titbits he/she eats],
  pvtAFR.[6] [Q17: My dog hangs around when I am preparing or eating human food],
  pvtAFR.[7] [Q17: My dog will turn down food if he/she is not hungry],
  pvtAFR.[8] [Q17: My dog finishes a meal straight away],
  pvtAFR.[9] [Q17: My dog inspects unfamiliar foods before deciding whether to eat them],
  pvtAFR.[10] [Q17: My dog runs around a lot],
  pvtAFR.[11] [Q17: After a meal my dog is still interested in eating],
  pvtAFR.[12] [Q17: My dog takes his/her time to eat a meal],
  pvtAFR.[13] [Q17: My dog eats titbits straight away],
  pvtAFR.[14] [Q17: My dog gets bits of human food when we are eating],
  --Q18: As before, please read the following statements and choose the option most appropriate response for "Toby".  The headings for the answers have changed for this section. 
  pvtFH.[1] [Q18: My dog would eat anything],
  pvtFH.[2] [Q18: My dog is very fit],
  pvtFH.[3] [Q18: My dog often gets human food],
  pvtFH.[4] [Q18: My dog gets an upset tummy on some foods],
  pvtFH.[5] [Q18: I think my dog could do with losing some weight],
  pvtFH.[6] [Q18: My dog's walks are mostly on the lead],
  pvtFH.[7] [Q18: I restrict my dog's exercise because of veterinary advice],
  pvtFH.[8] [Q18: I alter the food my dog gets in order to control his/her weight],
  pvtFH.[9] [Q18: My dog seems to be hungry all the time],
  pvtFH.[10] [Q18: My dog's walks involve a lot of energetic play or chasing],
  pvtFH.[11] [Q18: I am careful about my dog's weight],
  pvtFH.[12] [Q18: My dog is very greedy],
  pvtFH.[13] [Q18: I am happy with my dog's weight],
  pvtFH.[14] [Q18: I am careful to regulate the exercise my dog gets in order to keep him/her slim],
  pvtFH.[15] [Q18: My dog gets a lot of exercise],
  pvtFH.[16] [Q18: My dog gets no food at human mealtimes],
  pvtFH.[17] [Q18: My dog would eat non-food objects like stones, toys or socks],
  --Q19: In the last twelve months, my vet/vet nurse advised me that "Toby" was…
  pvtVWA.[1] [Q19: Underweight],
  pvtVWA.[2] [Q19: Overweight],
  pvtVWA.[3] [Q19: A healthy weight],
  pvtVWA.[4] [Q19: My vet/vet nurse did not mention his/her weight],
  pvtVWA.[5] [Q19: Not applicable - he/she has not been seen by a vet in the last twelve months],
  pvtVWA.[6] [Q19: I don't know/can't remember],
  --Q20: Most recently, "Toby" was considered by my vet/vet nurse to be…
  COALESCE(s.vetWeightAdviseMostRecentlyId, '999') [Q20: Most Recent Vet Weight Advice ID],
  VWAmr.vetWeightAdviseMostRecentlyName [Q20: Most Recent Vet Weight Advice Desc],
  --Q21: When my vet/vet nurse told me "Toby" was overweight I felt….
  pvtRVOWA.[1] [Q21: That the vet /vet nurse was incorrect],
  pvtRVOWA.[2] [Q21: That the vet/vet nurse was correct],
  pvtRVOWA.[3] [Q21: That the vet/vet nurse addressed this in a sensitive manner with me],
  pvtRVOWA.[4] [Q21: Offended],
  pvtRVOWA.[5] [Q21: Embarrassed],
  s.otherReactionVetOverWeightAdvise [Q21: Other (please specify)],
  --Q22: When my vet told me "Toby" was underweight I felt….
  pvtRVUWA.[1] [Q22: That the vet /vet nurse was incorrect],
  pvtRVUWA.[2] [Q22: That the vet/vet nurse was correct],
  pvtRVUWA.[3] [Q22: That the vet/vet nurse addressed this in a sensitive manner with me],
  pvtRVUWA.[4] [Q22: Offended],
  pvtRVUWA.[5] [Q22: Embarrassed],
  s.otherReactionVetUnderWeightAdvise [Q22: Other (please specify)],
  --Q23: My vet/vet nurse has advised me to feed "Toby" a diet food/'light'/'low fat' brand (as prevention OR treatment)…
  COALESCE(s.hasVetAdvisedDietFood, '999') [Q23: Vet Advised Diet ID],
  CASE 
    WHEN s.hasVetAdvisedDietFood = 0 THEN 'No' 
    WHEN s.hasVetAdvisedDietFood = 1 THEN 'Yes' 
  END [Q23: Vet Advised Diet Desc],
  --Q24: During the last twelve months, I have given "Toby" a diet food/'light'/'low fat' brand…
  COALESCE(s.dietFoodGivenId, '999') [Q24: Given Dog Low Fat Food Brand ID],
  DFG.dietFoodGivenName [Q24: Given Dog Low Fat Food Brand Desc],
  --Q25: Please use the space below to tell us which diet food/'light'/'low fat' brand you feed/fed "Toby"
  s.otherDietFoodDetail [Q25: Low Fat Food Brand Detail],
  --Q26: I chose not to purchase a diet/'light'/'low fat' food for "Toby" because…
  pvtDFNPR.[1] [Q26: I felt that he/she is not overweight],
  pvtDFNPR.[2] [Q26: I decided to decrease the amount of his/her current food that he/she is given],
  pvtDFNPR.[3] [Q26: I decided to increase his/her exercise instead],
  pvtDFNPR.[4] [Q26: The diet food was too expensive],
  s.otherDietFoodNotPurchasedReason [Q26: Other (please specify)],
  --Q27: My vet/vet nurse advised me to increase "Toby"'s exercise…
  COALESCE(s.hasVetAdvisedExercise, '999') [Q27: Vet Advised Exercise ID],
  CASE 
    WHEN s.hasVetAdvisedExercise = 0 THEN 'No' 
    WHEN s.hasVetAdvisedExercise = 1 THEN 'Yes' 
  END [Q27: Vet Advised Exercise Desc],
  --Q28: On my vet/vet nurse's advice, I increased "Toby"'s exercise…
  COALESCE(s.hasVetExerciseAdviseBeenTaken, '999') [Q28: Vet Exercise Advice Taken ID],
  CASE 
    WHEN s.hasVetExerciseAdviseBeenTaken = 0 THEN 'No' 
    WHEN s.hasVetExerciseAdviseBeenTaken = 1 THEN 'Yes' 
  END [Q28: Vet Exercise Advice Taken Desc],
  --Q29: My vet/vet nurse advised me to take "Toby" to a weight loss clinic….
  COALESCE(s.hasVetAdvisedWeightClinic, '999') [Q29: Vet Advised Weight Clinic ID],
  CASE 
    WHEN s.hasVetAdvisedWeightClinic = 0 THEN 'No' 
    WHEN s.hasVetAdvisedWeightClinic = 1 THEN 'Yes' 
  END [Q29: Vet Advised Weight Clinic Desc],
  --Q30: On my vet/vet nurse's advice, I took "Toby" to a weight loss clinic…
  COALESCE(s.hasVetWeightClinicAdviseBeenTaken, '999') [Q30: Vet Weight Clinic Advice Taken ID],
  CASE 
    WHEN s.hasVetWeightClinicAdviseBeenTaken = 0 THEN 'No' 
    WHEN s.hasVetWeightClinicAdviseBeenTaken = 1 THEN 'Yes' 
  END [Q30: Vet Weight Clinic Advice Taken Desc],
  --Q31: For me, the weight loss clinic sessions have been…
  /*---Informative---*/
  COALESCE(s.reactionToWeightLossClinicId_informative, '999') [Q31: Weight Clinic Response - Informative ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_informative = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_informative = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Informative Desc],
  /*---Dull---*/
  COALESCE(s.reactionToWeightLossClinicId_dull, '999') [Q31: Weight Clinic Response - Dull ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_dull = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_dull = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Dull Desc],
  /*---Embarrassing---*/
  COALESCE(s.reactionToWeightLossClinicId_embarrassing, '999') [Q31: Weight Clinic Response - Embarrassing ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_embarrassing = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_embarrassing = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Embarrassing Desc],
  /*---Fun---*/
  COALESCE(s.reactionToWeightLossClinicId_fun, '999') [Q31: Weight Clinic Response - Fun ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_fun = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_fun = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Fun Desc],
  /*---Useful in reducing his/her weight---*/
  COALESCE(s.reactionToWeightLossClinicId_useful, '999') [Q31: Weight Clinic Response - Useful in reducing weight ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_useful = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_useful = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Useful in reducing weight Desc],
  /*---Inconvenient for me---*/
  COALESCE(s.reactionToWeightLossClinicId_inconvenient, '999') [Q31: Weight Clinic Response - Inconvenient for me ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_inconvenient = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_inconvenient = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Inconvenient for me Desc],
  /*---Too early to assess---*/
  COALESCE(s.reactionToWeightLossClinicId_too, '999') [Q31: Weight Clinic Response - Too early to assess ID],
  CASE 
    WHEN s.reactionToWeightLossClinicId_too = 0 THEN 'No' 
    WHEN s.reactionToWeightLossClinicId_too = 1 THEN 'Yes' 
    ELSE 'Not Sure'
  END [Q31: Weight Clinic Response - Too early to assess Desc],
  --Q32: Is "Toby" still attending the weight loss clinic?
  COALESCE(s.stillAttendingWeightLossClinicId ,'999') [Q32: Still Attending Weight Clinic ID],
  SAWLC.stillAttendingWeightLossClinicName [Q32: Still Attending Weight Clinic Desc],
  s.otherCommentsAboutWeightLossClinicDetail [Q32: Other comments about the weight loss clinic (please specify)…],
  --Q33: I chose not to take "Toby" to a weight loss clinic because…
  pvtRNAWLC.[1] [Q33: I felt that he/she was not overweight],
  pvtRNAWLC.[2] [Q33: I decided to decrease the amount of his/her current food that he/she was given instead],
  pvtRNAWLC.[3] [Q33: I decided to change the type/brand of food that he/she was fed instead],
  pvtRNAWLC.[4] [Q33: I decided to increase his/her exercise instead],
  s.otherReasonNotAttendingWeightLossClinic [Q33: Other (please specify)]
from survey5_5Years s

--Q17: Please read the statements below and choose the response most appropriate to "Toby"
/*---My dog gets excited when there is food around---*/
Left join (select *
	          from (Select 
		                AFR.survey5_5YearsId ID,
		                cast(refAFRF.aroundFoodResponseFrequencyName as nvarchar(max)) [Freq Type],
		                cast(refAFR.aroundFoodResponseId as nvarchar(255)) as 'Freq'
                   from survey5_5Years_referenceAroundFoodResponse AFR
                   
                      inner join referenceAroundFoodResponse refAFR
                        on refAFR.aroundFoodResponseId = AFR.aroundFoodResponseId
                        
	                    inner join referenceAroundFoodResponseFrequency refAFRF
		                    on refAFRF.aroundFoodResponseFrequencyId = AFR.aroundFoodResponseFrequencyId
            ) AFR 
	    PIVOT(min([Freq Type]) For Freq
		        IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14]))
            
	 pvt ) pvtAFR on pvtAFR.ID = s.survey5_5YearsId
--Q18: As before, please read the following statements and choose the option most appropriate response for "Toby".  The headings for the answers have changed for this section. 
Left join (select *
	          from (Select 
		                FH.survey5_5YearsId ID,
		                cast(refFHTL.foodHealthTruthLevelName as nvarchar(max)) [Truth Type],
		                cast(refFH.foodHealthId as nvarchar(255)) as 'Truth'
                   from survey5_5Years_referenceFoodHealth FH
                   
                      inner join referenceFoodHealth refFH
                        on refFH.foodHealthId = FH.foodHealthId
                        
	                    inner join referenceFoodHealthTruthLevel refFHTL
		                    on refFHTL.foodHealthTruthLevelId = FH.foodHealthTruthLevelId
            ) FH 
	    PIVOT(min([Truth Type]) For Truth
		        IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17]))
            
	 pvt ) pvtFH on pvtFH.ID = s.survey5_5YearsId
--Q19: In the last twelve months, my vet/vet nurse advised me that "Toby" was…
Left join 
	(Select 
		VWA.survey5_5YearsId ID,
		vetWeightAdviseLast12MonthsName [Advice Type],
		cast(VWA.vetWeightAdviseLast12MonthsId as varchar) as 'Advice'

	from survey5_5Years_referenceVetWeightAdviseLast12Months VWA

	inner join referenceVetWeightAdviseLast12Months refVWA

		on refVWA.vetWeightAdviseLast12MonthsId = VWA.vetWeightAdviseLast12MonthsId
	) VWA 
	PIVOT
	
	(min([Advice Type]) For Advice
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtVWA on pvtVWA.ID = s.survey5_5YearsId
            
--Q20: Most recently, "Toby" was considered by my vet/vet nurse to be…
left join referenceVetWeightAdviseMostRecently VWAmr
  on VWAmr.vetWeightAdviseMostRecentlyId = s.vetWeightAdviseMostRecentlyId
--Q21: When my vet/vet nurse told me "Toby" was overweight I felt….
Left join 
	(Select 
		RVOWA.survey5_5YearsId ID,
		reactionVetOverWeightAdviseName [Advice Type],
		cast(RVOWA.reactionVetOverWeightAdviseId as varchar) as 'Advice'

	from survey5_5Years_referenceReactionVetOverWeightAdvise RVOWA

	inner join referenceReactionVetOverWeightAdvise refRVOWA

		on refRVOWA.reactionVetOverWeightAdviseId = RVOWA.reactionVetOverWeightAdviseId
	) RVOWA 
	PIVOT
	
	(min([Advice Type]) For Advice
		IN ([1], [2], [3], [4], [5])
	) 
	pvtRVOWA on pvtRVOWA.ID = s.survey5_5YearsId
--Q22: When my vet told me "Toby" was underweight I felt….
Left join 
	(Select 
		RVUWA.survey5_5YearsId ID,
		reactionVetUnderWeightAdviseName [Advice Type],
		cast(RVUWA.reactionVetUnderWeightAdviseId as varchar) as 'Advice'

	from survey5_5Years_referenceReactionVetUnderWeightAdvise RVUWA

	inner join referenceReactionVetUnderWeightAdvise refRVUWA

		on refRVUWA.reactionVetUnderWeightAdviseId = RVUWA.reactionVetUnderWeightAdviseId
	) RVUWA 
	PIVOT
	
	(min([Advice Type]) For Advice
		IN ([1], [2], [3], [4], [5])
	) 
	pvtRVUWA on pvtRVUWA.ID = s.survey5_5YearsId
--Q24: During the last twelve months, I have given "Toby" a diet food/'light'/'low fat' brand…
left join referenceDietFoodGiven DFG  
  on DFG.dietFoodGivenId = s.dietFoodGivenId
--Q25: Please use the space below to tell us which diet food/'light'/'low fat' brand you feed/fed "Toby"
--Q26: I chose not to purchase a diet/'light'/'low fat' food for "Toby" because…
Left join 
	(Select 
		DFNPR.survey5_5YearsId ID,
		dietFoodNotPurchasedReasonName [Reason Type],
		cast(DFNPR.dietFoodNotPurchasedReasonId as varchar) as 'Reason'

	from survey5_5Years_referenceDietFoodNotPurchasedReason DFNPR

	inner join referenceDietFoodNotPurchasedReason refDFNPR

		on refDFNPR.dietFoodNotPurchasedReasonId = DFNPR.dietFoodNotPurchasedReasonId
	) DFNPR 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4])
	) 
	pvtDFNPR on pvtDFNPR.ID = s.survey5_5YearsId
--Q32: Is "Toby" still attending the weight loss clinic?
left join referenceStillAttendingWeightLossClinic SAWLC 
  on SAWLC.stillAttendingWeightLossClinicId = s.stillAttendingWeightLossClinicId
--Q33: I chose not to take "Toby" to a weight loss clinic because…
Left join 
	(Select 
		RNAWLC.survey5_5YearsId ID,
		reasonNotAttendingWeightLossClinicName [Reason Type],
		cast(RNAWLC.reasonNotAttendingWeightLossClinicId as varchar) as 'Reason'

	from survey5_5Years_referenceReasonNotAttendingWeightLossClinic RNAWLC

	inner join referenceReasonNotAttendingWeightLossClinic refRNAWLC

		on refRNAWLC.reasonNotAttendingWeightLossClinicId = RNAWLC.reasonNotAttendingWeightLossClinicId
	) RNAWLC 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4])
	) 
	pvtRNAWLC on pvtRNAWLC.ID = s.survey5_5YearsId


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