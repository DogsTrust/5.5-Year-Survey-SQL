select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q1 Does "Toby" currently have ANY mobility problems, for example occasional stiffness when getting out of bed, difficulty jumping into the car/onto a bed or sofa?
  COALESCE(s.hasMobilityProblems, '999') [Q1: Mobility Problems ID],
  CASE
    WHEN s.hasMobilityProblems = 0 THEN 'No'
    WHEN s.hasMobilityProblems = 1 THEN 'Yes'
    ELSE 'Not Sure'
  END [Q1: Mobility Problems Desc],
  --Q1.1 Is "Toby" currently receiving any medication/dietary supplements/other therapies or treatments to help him/her with his/her mobility?
  COALESCE(s.receivingMedication, '999') [Q1.1: Receiving Medication/Dietary Supplements/Other Therapies for Mobility ID], 
  CASE
    WHEN s.receivingMedication = 0 THEN 'No'
    WHEN s.receivingMedication = 1 THEN 'Yes'
    ELSE 'Not Sure'
  END [Q1.1: Receiving Medication/Dietary Supplements/Other Therapies for Mobility Desc],
  --Q2 How old was "Toby when he started having his/her mobility problems?
  s.ageMobilityProblemsOlderId [Q2: Age Mobility Problems Started ID],
  AMP.ageMobilityProblemsOlderName [Q2: Age Mobility Problems Started Desc],
  s.otherAgeMobilityProblemsOlder [Q2: Age Mobility Problems Started - Other (Please Specify)],
  --Q3a If you can, please list any medications that "Toby" is currently receiving for mobility problems.
  s.mobilityProblemsMedicationDetail [Q3a Mobility Medication Detail],
  --Q3b If you can, please list any medications that "Toby" is currently receiving for problems other than mobility.
  s.nonMobilityProblemsMedicationDetail [Q3b Non Mobility Medication Detail],
  --Q3c Please list any dietary supplements  that "Toby" is currently receiving.
  s.dietarySupplementsDetail [Q3c Dietary Supplements Detail],
  --Q3d Since I have owned him/her, "Toby" has had…
  /*---Acupunture---*/
  s.therapyTimingId_acupuncture [Q3d: Therapy Timing - Acupuncture ID],
  TTA.therapyTimingName [Q3d: Therapy Timing - Acupuncture Desc],
  /*---Hydrotherapy---*/
  s.therapyTimingId_hydrotherapy [Q3d: Therapy Timing - Hydrotherapy ID],
  TTH.therapyTimingName [Q3d: Therapy Timing - Hydrotherapy Desc],
  /*---Physiotherapy---*/
  s.therapyTimingId_physiotherapy [Q3d: Therapy Timing - Physiotherapy ID],
  TTP.therapyTimingName [Q3d: Therapy Timing - Physiotherapy Desc],
  /*---Massage---*/
  s.therapyTimingId_massage [Q3d: Therapy Timing - Massage ID],
  TTM.therapyTimingName [Q3d: Therapy Timing - Massage Desc],
  --Q3e Please use this space to tell us about any other treatments (for example stem cell therapy, laser, shock wave treatment) that you have used/are using to help "Toby" with his/her mobility problems…
  s.otherTreatmentsWithMobilityProblemsDetail [Q3e: Other Mobility Treatments Detail],
  --Q4 In the last week, on average, how far has "Toby" exercised each day?
  s.averageExeriseMileageId [Q4: Average Exercise Mileage ID],
  AEM.averageExeriseMileageName [Q4: Average Exercise Mileage Desc],
  --Q5 Are there particular days of the week upon which "Toby" has significantly more exercise? (Tick more than one box if necessary).
  pvtDoW.[1] [Q5: Monday],
  pvtDoW.[2] [Q5: Tuesday],
  pvtDoW.[3] [Q5: Wednesday],
  pvtDoW.[4] [Q5: Thursday],
  pvtDoW.[5] [Q5: Friday],
  pvtDoW.[6] [Q5: Saturday],
  pvtDoW.[7] [Q5: Sunday],
  pvtDoW.[8] [Q5: No - similar amount each day],
  --Q6 "Toby" is exercised most often over the following sort of terrain…
  pvtTET.[1] [Q6: On level grass],
  pvtTET.[2] [Q6: In woodland],
  pvtTET.[3] [Q6: On roads/pavements],
  pvtTET.[4] [Q6: Over rough hill ground],
  pvtTET.[5] [Q6: On sand],
  pvtTET.[6] [Q6: On pebbles],
  s.otherTerrainExerciseType [Q6: Other (please specify)],
  --Q7 At exercise, "Toby" usually spends most of his/her time…
  s.exerciseSpendsMostTimeId [Q7: Spends Most Time While Exercising ID],
  ESMT.exerciseSpendsMostTimeName [Q7: Spends Most Time While Exercising Desc],
  --Q8 Does "Toby" have his/her activity levels restricted when he/she is exercised?
  s.activityRestrictedWhenExercisedId [Q8: Activity Restricted When Exercised ID],
  ARWE.activityRestrictedWhenExercisedName [Q8: Activity Restricted When Exercised Desc],
  --Q9.1 How much do you think "Toby"'s mobility adversely influences his/her general well being?
  s.mobilityInfluencesWellBeingId [Q9.1: Mobility Influences Well Being ID],
  MIWB.mobilityInfluencesWellBeingName [Q9.1: Mobility Influences Well Being Desc],
  --Q10 How disabled is "Toby" by lameness?
  s.mobilityDisabledByLamenessId [Q10: Mobility Disabled By Lameness ID],
  MDBL.mobilityDisabledByLamenessName [Q10: Mobility Disabled By Lameness Desc],
  --Q11 How active is "Toby"?
  s.mobilityActiveLevelId [Q11: Mobility Active Level ID],
  MAL.mobilityActiveLevelName [Q11: Mobility Active Level Desc],
  --Q12 To what degree does "Toby" show stiffness after a 'lie down'?
  s.mobilityStiffnessAfterLieId [Q12: Mobility Stiffness After Lie Down ID],
  MSAL.mobilityStiffnessAfterLieName [Q12: Mobility Stiffness After Lie Down Desc],
  --Q13 How keen is "Toby" to exercise?
  s.mobilityKeenToExerciseId [Q13: Mobiliy Keenness To Exercise ID],
  MKTE.mobilityKeenToExerciseName [Q13: Mobiliy Keenness To Exercise Desc],
  --Q14 How would you rate "Toby"'s ability to exercise?
  s.mobilityAbilityToExerciseId [Q14: Mobility Ability To Exercise ID],
  MATE.mobilityAbilityToExerciseName [Q14: Mobility Ability To Exercise Desc],
  --Q15 To what extent is "Toby"'s mobility adversely affected immediately after exercise?
  s.mobilityAdversityAfterExerciseId [Q15: Mobility Adversely Affected After Exercise ID],
  MAAE.mobilityAdversityAfterExerciseName [Q15: Mobility Adversely Affected After Exercise Desc],
  --Q16 How often does "Toby" rest (stop/sit down) during exercise?
  s.mobilityRestDuringExerciseId [Q16: Mobility Rest Freq During Exercise ID],
  MRDE.mobilityRestDuringExerciseName [Q16: Mobility Rest Freq During Exercise Desc],
  --Q17 To what extent does cold, damp weather reduce "Toby"'s ability to exercise?
  s.mobilityWeatherImpactOnExerciseId [Q17: Mobility Cold, Damp Weather Impact on Exercise ID],
  MWIE.mobilityWeatherImpactOnExerciseName [Q17: Mobility Cold, Damp Weather Impact on Exercise Desc],
  --Q18 To what extent does stiffness reduce "Toby"'s ability to exercise?
  s.mobilityStiffnessImpactOnExerciseId [Q18: Mobility Impact of Stiffness on Exercise ID],
  MSIOE.mobilityStiffnessImpactOnExerciseName [Q18: Mobility Impact of Stiffness on Exercise Desc]
from survey5_5years s

--Q2 How old was "Toby when he started having his/her mobility problems?
left join referenceAgeMobilityProblemsOlder AMP
  on AMP.ageMobilityProblemsOlderId = s.ageMobilityProblemsOlderId
  
--Q3d Since I have owned him/her, "Toby" has had…
/*---Acupunture---*/
left join referenceTherapyTiming TTA  
  on TTA.therapyTimingId = s.therapyTimingId_acupuncture
/*---Hydrotherapy---*/
left join referenceTherapyTiming TTH
  on TTH.therapyTimingId = s.therapyTimingId_hydrotherapy
/*---Physiotherapy---*/
left join referenceTherapyTiming TTP
  on TTP.therapyTimingId = s.therapyTimingId_physiotherapy
/*---Massage---*/
left join referenceTherapyTiming TTM
  on TTM.therapyTimingId = s.therapyTimingId_massage
  
--Q4 In the last week, on average, how far has "Toby" exercised each day?
left join referenceAverageExeriseMileage AEM
  on AEM.averageExeriseMileageId = s.averageExeriseMileageId
  
  
--Q5 Are there particular days of the week upon which "Toby" has significantly more exercise? (Tick more than one box if necessary).
Left join 
	(Select 
		DoW.survey5_5YearsId ID,
		daysOfWeekName [Day Type],
		cast(DoW.daysOfWeekId as varchar) as 'Day'

	from survey5_5Years_referenceDaysOfWeek DoW

	inner join referenceDaysOfWeek refDoW

		on refDoW.daysOfWeekId = DoW.daysOfWeekId
	) DoW 
	PIVOT
	
	(min([Day Type]) For Day
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtDoW on pvtDoW.ID = s.survey5_5YearsId
  
--Q6 "Toby" is exercised most often over the following sort of terrain…
Left join 
	(Select 
		TET.survey5_5YearsId ID,
		terrainExerciseTypeName [Terrain Type],
		cast(TET.terrainExerciseTypeId as varchar) as 'Terrain'

	from survey5_5Years_referenceTerrainExerciseType TET

	inner join referenceTerrainExerciseType refTET

		on refTET.terrainExerciseTypeId = TET.terrainExerciseTypeId
	) TET 
	PIVOT
	
	(min([Terrain Type]) For Terrain
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtTET on pvtTET.ID = s.survey5_5YearsId
  
--Q7 At exercise, "Toby" usually spends most of his/her time…
left join referenceExerciseSpendsMostTime ESMT
  on ESMT.exerciseSpendsMostTimeId = s.exerciseSpendsMostTimeId
  
--Q8 Does "Toby" have his/her activity levels restricted when he/she is exercised?
left join referenceActivityRestrictedWhenExercised ARWE
  on ARWE.activityRestrictedWhenExercisedId = s.activityRestrictedWhenExercisedId
  
--Q9.1 How much do you think "Toby"'s mobility adversely influences his/her general well being?
left join referenceMobilityInfluencesWellBeing MIWB
  on MIWB.mobilityInfluencesWellBeingId = s.mobilityInfluencesWellBeingId
  
--Q10 How disabled is "Toby" by lameness?
left join referenceMobilityDisabledByLameness MDBL
  on MDBL.mobilityDisabledByLamenessId = s.mobilityDisabledByLamenessId
  
--Q11 How active is "Toby"?
left join referenceMobilityActiveLevel MAL
  on MAL.mobilityActiveLevelId = s.mobilityActiveLevelId
  
--Q12 To what degree does "Toby" show stiffness after a 'lie down'?
left join referenceMobilityStiffnessAfterLie MSAL
  on MSAL.mobilityStiffnessAfterLieId = s.mobilityStiffnessAfterLieId
  
 --Q13 How keen is "Toby" to exercise?
left join referenceMobilityKeenToExercise MKTE
  on MKTE.mobilityKeenToExerciseId = s.mobilityKeenToExerciseId
  
--Q14 How would you rate "Toby"'s ability to exercise?
left join referenceMobilityAbilityToExercise MATE
  on MATE.mobilityAbilityToExerciseId = s.mobilityAbilityToExerciseId
  
--Q15 To what extent is "Toby"'s mobility adversely affected immediately after exercise?
left join referenceMobilityAdversityAfterExercise MAAE
  on MAAE.mobilityAdversityAfterExerciseId = s.mobilityAdversityAfterExerciseId
  
--Q16 How often does "Toby" rest (stop/sit down) during exercise?
left join referenceMobilityRestDuringExercise MRDE 
  on MRDE.mobilityRestDuringExerciseId = s.mobilityRestDuringExerciseId
  
--Q17 To what extent does cold, damp weather reduce "Toby"'s ability to exercise?
left join referenceMobilityWeatherImpactOnExercise MWIE 
  on MWIE.mobilityWeatherImpactOnExerciseId = s.mobilityWeatherImpactOnExerciseId
  
--Q18 To what extent does stiffness reduce "Toby"'s ability to exercise?
left join referenceMobilityStiffnessImpactOnExercise MSIOE
  on MSIOE.mobilityStiffnessImpactOnExerciseId = s.mobilityStiffnessImpactOnExerciseId

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