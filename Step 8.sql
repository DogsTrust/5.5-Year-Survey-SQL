select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q155 "Toby" is taken for exercise (on and/or off lead) away from our household...
  COALESCE(s.puppyExercisedAwayFromHome, '999') [Q155 Exercise Away From Home ID],
  CASE
    WHEN s.puppyExercisedAwayFromHome = 0 THEN 'No'
    WHEN s.puppyExercisedAwayFromHome = 1 THEN 'Yes'
  END [Q155 Exercise Away From Home Desc],
  --Q156 On an average WEEKDAY, "Toby" is usually taken for exercise (on and/or off lead)…
  COALESCE(s.averageWeekdayExerciseLevelId, '999') [Q156 Average Times Taken For Exercise (Weekday) ID],
  ELWeekday.exerciseLevelTypeName [Q156 Average Times Taken For Exercise (Weekday) Desc],
  --Q157 On an average WEEKDAY the total amount of time that "Toby" is exercised either on or off lead is usually about...	
  COALESCE(s.averageWeekdayExerciseTimeId, '999') [Q157 Total Time Exercised On Average (Weekday) ID],
  TEWeekday.timeExercisedTypeName [Q157 Total Time Exercised On Average (Weekday) Desc],
  --Q158 Of this, the total amount of time "Toby" is on a short or long lead is...
  COALESCE(s.totalWeekdayExerciseOnLeadTimeId, '999') [Q158 Total Time on Lead (Weekday) ID],
  TEWeekday_lead.timeExercisedTypeName [Q158 Total Time on Lead (Weekday) Desc],
  --Q159 On an average WEEKEND day, "Toby" is usually taken for exercise (on and/or off lead)...
  COALESCE(s.averageWeekendExerciseLevelId, '999') [Q159 Average Times Taken For Exercise (Weekend) ID],
  ELWeekend.exerciseLevelTypeName [Q159 Average Times Taken For Exercise (Weekend) Desc],
  --Q160 On an average WEEKEND day the total amount of time that "Toby" is exercised either on or off lead is usually about...	
  COALESCE(s.averageWeekendExerciseTimeId, '999') [Q160 Total Time Exercised On Average (Weekend) ID],
  TEWeekend.timeExercisedTypeName [Q160 Total Time Exercised On Average (Weekend) Desc],
  --Q161 Of this, the total amount of time "Toby" is on a short or long lead is...
  COALESCE(s.totalWeekendExerciseOnLeadTimeId, '999') [Q161 Total Time on Lead (Weekend) ID],
  TEWeekend_lead.timeExercisedTypeName [Q161 Total Time on Lead (Weekend) Desc],
  --Q162 When "Toby" is on a lead, I mostly use...
  COALESCE(s.puppyLeadUseTypeId, '999') [Q162 Lead Type Used ID],
  PLU.puppyLeadUseTypeName [Q162 Lead Type Used Desc],
  s.otherFormOfAttachmentDetail [Q162 Lead Type Used (Other (Please Specify))],
  --Q163 When "Toby" is on a lead, his/her lead is usually...
  COALESCE(s.leadFitTypeId, '999') [Q163 Lead Fit Type ID],
  LFT.leadFitTypeName [Q163 Lead Fit Type Desc],
  s.otherLeadFitType [Q163 Lead Fit Type (Other (Please Specify))],
  --Q164 "Toby" chases sticks that are thrown for him/her...
  COALESCE(s.chasesSticksId, '999') [Q164 Chases Sticks ID],
  ChaseStick.chasesSticksName [Q164 Chases Sticks ID],
  --Q165 "Toby" finds sticks to play with, even if they are not thrown for him/her...
  COALESCE(s.findsSticksNotThrownId, '999') [Q165 Finds Sticks ID],
  FindStick.findsSticksNotThrownName [Q165 Finds Sticks Desc],
  --Q166 What does "Toby"'s breathing sound like when he/she is walking round the house?
  COALESCE(s.breathingWhenWalkingTypeId, '999') [Q166 Breathing Sound When Walking Round House ID],
  BWW.breathingWhenWalkingTypeName [Q166 Breathing Sound When Walking Round House Desc],
  s.otherBreathingWhenWalkingTypeName [Q166 Breathing Sound When Walking Round House (Other (Please Specify))],
  --Q167 Under what you would consider to be 'hot weather' conditions, what does "Toby"'s breathing sound like when he/she is exercising (for example on a walk or playing)?
  COALESCE(s.breathingWhenHotWeatherTypeId, '999') [Q167 Breathing Sound When Exersising In Hot Weather ID],
  BWHW.breathingWhenHotWeatherTypeName [Q167 Breathing Sound When Exersising In Hot Weather Desc],
  s.otherBreathingWhenHotWeatherTypeName [Q167 Breathing Sound When Exersising In Hot Weather (Other (Please Specify))],
  --Q168 Under what you would consider to be 'comfortable weather' conditions (not overly hot or cold), what does "Toby"'s breathing sound like when he/she is exercising (for example on a walk or playing)?
  COALESCE(s.breathingWhenComfortableWeatherTypeId, '999') [Q168 Breathing Sound When Exercising In Comfortable Weather ID],
  BWCW.breathingWhenComfortableWeatherTypeName [Q168 Breathing Sound When Exercising In Comfortable Weather Desc],
  s.otherBreathingWhenComfortableWeatherTypeName [Q168 Breathing Sound When Exercising In Comfortable Weather (Other (Please Specify))],
  --Q169 Comparing "Toby"'s enthusiasm for exercise on 'hot weather' days and on 'comfortable weather' days (not overly hot or cold), he/she has…
  COALESCE(s.enthusiasmForExerciseWeatherTypeId,'999') [Exercise Enthusiasm (Hot Weather vs Comfortable Weather) ID],
  EFW.enthusiasmForExerciseWeatherTypeName [Exercise Enthusiasm (Hot Weather vs Comfortable Weather) Desc]
from survey5_5years s

--Q156 On an average WEEKDAY, "Toby" is usually taken for exercise (on and/or off lead)…
left join referenceExerciseLevelType ELWeekday
  on ELWeekday.exerciseLevelTypeId = s.averageWeekdayExerciseLevelId
  
--Q157 On an average WEEKDAY the total amount of time that "Toby" is exercised either on or off lead is usually about...
left join referenceTimeExercisedType TEWeekday
  on TEWeekday.timeExercisedTypeId = s.averageWeekdayExerciseTimeId
  
--Q158 Of this, the total amount of time "Toby" is on a short or long lead is...
left join referenceTimeExercisedType TEWeekday_lead
  on TEWeekday_lead.timeExercisedTypeId = s.totalWeekdayExerciseOnLeadTimeId
  
--Q159 On an average WEEKEND day, "Toby" is usually taken for exercise (on and/or off lead)...
left join referenceExerciseLevelType ELWeekend
  on ELWeekend.exerciseLevelTypeId = s.averageWeekendExerciseLevelId
  
--Q160 On an average WEEKEND day the total amount of time that "Toby" is exercised either on or off lead is usually about...	
left join referenceTimeExercisedType TEWeekend
  on TEWeekend.timeExercisedTypeId = s.averageWeekendExerciseTimeId

--Q161 Of this, the total amount of time "Toby" is on a short or long lead is...
left join referenceTimeExercisedType TEWeekend_lead
  on TEWeekend_lead.timeExercisedTypeId = s.totalWeekendExerciseOnLeadTimeId
  
--Q162 When "Toby" is on a lead, I mostly use...
left join referencePuppyLeadUseType PLU 
  on PLU.puppyLeadUseTypeId = s.puppyLeadUseTypeId
  
--Q163 When "Toby" is on a lead, his/her lead is usually...
left join referenceLeadFitType LFT
  on LFT.leadFitTypeId = s.leadFitTypeId
  
--Q164 "Toby" chases sticks that are thrown for him/her...
left join referenceChasesSticks ChaseStick
  on ChaseStick.chasesSticksId = s.chasesSticksId
  
--Q165 "Toby" finds sticks to play with, even if they are not thrown for him/her...
left join referenceFindsSticksNotThrown FindStick
  on FindStick.findsSticksNotThrownId = s.findsSticksNotThrownId 
  
--Q166 What does "Toby"'s breathing sound like when he/she is walking round the house?
left join referenceBreathingWhenWalkingType BWW
  on BWW.breathingWhenWalkingTypeId = s.breathingWhenWalkingTypeId
  
--Q167 Under what you would consider to be 'hot weather' conditions, what does "Toby"'s breathing sound like when he/she is exercising (for example on a walk or playing)?
left join referenceBreathingWhenHotWeatherType BWHW
 on BWHW.breathingWhenHotWeatherTypeId = s.breathingWhenHotWeatherTypeId
 
--Q168 Under what you would consider to be 'comfortable weather' conditions (not overly hot or cold), what does "Toby"'s breathing sound like when he/she is exercising (for example on a walk or playing)?
left join referenceBreathingWhenComfortableWeatherType BWCW
  on BWCW.breathingWhenComfortableWeatherTypeId = s.breathingWhenComfortableWeatherTypeId
  
--Q169 Comparing "Toby"'s enthusiasm for exercise on 'hot weather' days and on 'comfortable weather' days (not overly hot or cold), he/she has…
left join referenceEnthusiasmForExerciseWeatherType EFW
  on EFW.enthusiasmForExerciseWeatherTypeId = s.enthusiasmForExerciseWeatherTypeId

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