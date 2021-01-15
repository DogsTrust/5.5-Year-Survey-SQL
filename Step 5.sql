select 
  s.dogId,
	s.userId,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q15: "Toby" is insured…
  COALESCE(s.dogInsured, '999') [Q15: Dog Insured Id],
  CASE
    WHEN s.dogInsured = 0 THEN 'No'
    WHEN s.dogInsured = 1 THEN 'Yes'
  END [Q15: Dog Insured Desc],
  --Q15.5 "Toby" is not insured because…
  pvtrfni.[1] [Q15.5: I would rather not say],
  pvtrfni.[2] [Q15.5: I do not feel it is necessary],
  pvtrfni.[3] [Q15.5: I have had a previous negative experience with pet insurance],
  pvtrfni.[4] [Q15.5: I feel insurance is too expensive],
  pvtrfni.[5] [Q15.5: I could not decide on an insurance company],
  pvtrfni.[6] [Q15.5: I set aside money to cover any treatments he/she may need],
  pvtrfni.[7] [Q15.5: He/she has a condition that I suspect would not be covered by insurance],
  pvtrfni.[8] [Q15.5: I could not find an insurance company that would cover a condition that he/she has],
  pvtrfni.[9] [Q15.5: I could not find an insurance company that would cover him/her for another reason (for example his/her breed)],
  pvtrfni.[10] [Q15.5: I am concerned that the policy would increase in price if I make a claim],
  s.otherReasonForNoInsurance [Q15.5: Other (please specify)],
  --Q16 "Toby" is insured (tick all that apply)
  pvtit.[1] [Q16: For health/veterinary bills],
  pvtit.[2] [Q16: For third party cover],
  pvtit.[3] [Q16: With a short term or temporary policy],
  pvtit.[4] [Q16: With an annual policy],
  pvtit.[5] [Q16: With a lifelong/lifetime insurance policy],
  pvtit.[6] [Q16: I am not sure of the details of his/her insurance],
  pvtit.[7] [Q16: I don't know/can't remember],
  s.otherInsuranceType [Q16: Other insurance (please specify)],
  --Q17 My choice of insurance company was based on…
  pvtric.[1] [Q17: Reputation of company],
  pvtric.[2] [Q17: Recommendation from someone],
  pvtric.[3] [Q17: Cost of insurance (per month or year)],
  pvtric.[4] [Q17: Insurance excess that I would need to pay if claiming],
  pvtric.[5] [Q17: Maximum amount payable for a single condition],
  pvtric.[6] [Q17: Maximum amount payable in a single year],
  pvtric.[7] [Q17: Ongoing cover for conditions claimed for],
  s.otherReasonInsuranceCompany [Q17: Other (please specify)],
  --Q18 "Toby"''s veterinary treatment/investigation of problems (since I have owned him/her) has…
  pvtvip.[1] [Q18: Been possible/improved due to having insurance for vet bills],
  pvtvip.[2] [Q18: Been influenced due to not having insurance for vet bills],
  pvtvip.[3] [Q18: Been unaffected, despite not having insurance for vet bills],
  pvtvip.[4] [Q18: Resulted in one (or more) insurance claims, paid to my satisfaction],
  pvtvip.[5] [Q18: Resulted in one (or more) insurance claims, not paid to my satisfaction],
  pvtvip.[6] [Q18: Resulted in an ongoing claim],
  pvtvip.[7] [Q18: Not applicable - no problems have warranted an insurance claim]

from survey5_5Years s

--Q15.5 "Toby" is not insured because…
Left join 
	(Select 
		rfni.survey5_5YearsId ID,
		reasonForNoInsuranceName [Reason Type],
		cast(rfni.reasonForNoInsuranceId as varchar) as 'Reason'

	from survey5_5Years_referenceReasonForNoInsurance rfni

	inner join referenceReasonForNoInsurance refrfni

		on refrfni.reasonForNoInsuranceId = rfni.reasonForNoInsuranceId
	) rfni 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10])
	) 
	pvtrfni on pvtrfni.ID = s.survey5_5YearsId
  
--Q16 "Toby" is insured (tick all that apply)
Left join 
	(Select 
		it.survey5_5YearsId ID,
		insuranceTypeName [Insurance Type],
		cast(it.insuranceTypeId as varchar) as 'Insurance'

	from survey5_5Years_referenceInsuranceType it

	inner join referenceInsuranceType refit

		on refit.insuranceTypeId = it.insuranceTypeId
	) it 
	PIVOT
	
	(min([Insurance Type]) For Insurance
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtit on pvtit.ID = s.survey5_5YearsId

--Q17 My choice of insurance company was based on…
Left join 
	(Select 
		ric.survey5_5YearsId ID,
		reasonInsuranceCompanyName [Reason Type],
		cast(ric.reasonInsuranceCompanyId as varchar) as 'Reason'

	from survey5_5Years_referenceReasonInsuranceCompany ric

	inner join referenceReasonInsuranceCompany refric

		on refric.reasonInsuranceCompanyId = ric.reasonInsuranceCompanyId
	) ric 
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtric on pvtric.ID = s.survey5_5YearsId

--Q18 "Toby"''s veterinary treatment/investigation of problems (since I have owned him/her) has…
Left join 
	(Select 
		vip.survey5_5YearsId ID,
		vetInvestigationProblemsName [Investigation Type],
		cast(vip.vetInvestigationProblemId as varchar) as 'Investigation'

	from survey5_5Years_referenceVetInvestigationProblem vip

	inner join referenceVetInvestigationProblems refvip

		on refvip.vetInvestigationProblemsId = vip.vetInvestigationProblemId
	) vip 
	PIVOT
	
	(min([Investigation Type]) For Investigation
		IN ([1], [2], [3], [4], [5], [6], [7])
	) 
	pvtvip on pvtvip.ID = s.survey5_5YearsId


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