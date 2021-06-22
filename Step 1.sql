select
  s.dogId,
	s.userId ,
	s.survey5_5YearsId [5.5y Survey ID],	
	Cast(s.surveyCreationDate as DATE) [Survey Creation Date],
	CASE WHEN multidogs.userId Is NuLL then 'No' Else 'Yes' END MultipleDogs,
	COALESCE(adminGP.ReasonForExclusion,'') [Reason Dog Excluded],
  --Q1 In the last six months, I have taken "Toby" to a veterinary practice…
  s.vetVisitPrev6MthType [Q1: Vet Visit Last 6 Months ID],
  VetVisL6m.vetVisitPrev6MthTypeName [Q1: Vet Visit Last 6 Months Desc],
  --Q1a The vet...
  pvtva.[1] [Q1a: Carried out a routine health check],
  pvtva.[2] [Q1a: Inserted a microchip],
  pvtva.[3] [Q1a: Provided or administered flea and/or worm prevention],
  pvtva.[4] [Q1a: Provided or administered flea and/or worm treatment],
  pvtva.[5] [Q1a: Carried out an examination or treatment for another ailment/condition],
  pvtva.[6] [Q1a: Carried out an operation that required a general anaesthetic],
  pvtva.[7] [Q1a: Vaccinated my dog],
  pvtva.[8] [Q1a: Other reason for a visit, for example for weighing. (Please specify…) ID],
  s.otherVetActionType [Q1a: Other reason for a visit, for example for weighing. (Please specify…) Desc],
  --Q2 During the last six months, my dog has been administered worming products...
  s.wormingFrequencyId [Q2: Worming Frequency (Last 6 Months) ID],
  wf.wormingFrequencyName [Q2: Worming Frequency (Last 6 Months) Desc],
  s.otherWormingFrequencyName [Q2: Worming Frequency (Last 6 Months: Other (Please Specify)],
  --Q2a The worming product(s) that my dog has been administered is/are (if you have used more than one worming product please let us know the timeframe/frequency that you used each product for)…
  s.otherWormingProductsDetail [Q2a: Worming Product Detail],
  s.otherWormingProductsDetailRemembered [Q2a: Worming Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherWormingProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q2a: Worming Product Detail: Can't remember Desc], 
  --Q2b The treatment(s) was/were…
  pvttpt_worm.[1] [Q2b: To treat an existing problem],
  pvttpt_worm.[2] [Q2b: To prevent any problems],
  --Q3 During the last six months, the number of times that my dog has been administered flea control products is...
  s.treatmentAdministeredFrequencyId_fleas [Q3: Flea Treatment Frequency (Last 6 Months) ID],
  taf_flea.treatmentAdministeredFrequencyName [Q3: Flea Treatment Frequency (Last 6 Months) Desc],
  s.otherTreatmentAdministeredFrequencyName_fleas [Q3: Flea Treatment Frequency (Last 6 Months): Other (Please Specify)],
  --Q3a The flea control product(s) that my dog has been administered is/are (if you have used more than one flea control product please let us know the timeframe/frequency that you used each product for)…
  s.otherFleasProductsDetail[Q3a: Flea Control Product Detail],
  s.otherFleasProductsDetailRemembered [Q3a: Flea Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherFleasProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q3a: Flea Product Detail: Can't remember Desc],
  --Q3b The treatment was/were…
  pvttpt_fleas.[1] [Q3b: To treat an existing problem],
  pvttpt_fleas.[2] [Q3b: To prevent any problems],
  --Q4 During the last six months, the number of times that my dog has been administered tick control products is...
  s.treatmentAdministeredFrequencyId_ticks [Q4: Tick Treatment Frequency (Last 6 Months) ID],
  taf_tick.treatmentAdministeredFrequencyName [Q4: Tick Treatment Frequency (Last 6 Months) Desc],
  s.otherTreatmentAdministeredFrequencyName_ticks [Q4: Tick Treatment Frequency (Last 6 Months): Other (Please Specify)],
  --Q4a The tick control product(s) that my dog has been administered is/are (if you have used more than one tick product please let us know the timeframe/frequency that you used each product for)…
  s.otherTicksProductsDetail [Q4a: Tick Control Product Detail],
  s.otherTicksProductsDetailRemembered [Q4a: Tick Product Detail: Can't remember ID],
  CASE 
    WHEN s.otherTicksProductsDetailRemembered = 0 THEN 'I don''t know/can''t remember'
  END [Q4a: Tick Product Detail: Can't remember Desc],
  --Q4b The treatment was/were…
  pvttpt_ticks.[1] [Q6.6.1: To treat an existing problem],
  pvttpt_ticks.[2] [Q6.6.1: To prevent any problems],
  --Q5 My dog was most recently vaccinated…
  s.mostRecentlyVaccinatedId [Q5: Most Recently Vaccinated ID],
  lv.lastVaccDateName [Q5: Most Recently Vaccinated Desc],
  --Q5a My dog has not been vaccinated because…
  s.notVaccinatedReasonId [Q5a: Reason Not Vaccinated (Last 12 Months) ID],
  rnv.notVaccinatedReasonName [Q5a: Reason Not Vaccinated (Last 12 Months) Desc],
  s.otherNotVaccinatedReason [Q5a: Reason Not Vaccinated (Last 12 Months): Other (Please Specify)],
  --Q5b I am happy to provide a photo/scan of my dog’s vaccination records…
  s.ableToScanVaccRecords [Q5b: Able to Scan Vaccination Card ID],
  scvc.ableToScanVaccCardTypeName [Q5b: Able to Scan Vaccination Card Desc],
  --Q5c My dog’s last vaccination was for…
  pvtvreas.[1] [Q5c: I don't know/can't remember],
  pvtvreas.[2] [Q5c: Canine Distemper],
  pvtvreas.[3] [Q5c: Hepatitis],
  pvtvreas.[4] [Q5c: Parvovirus],
  pvtvreas.[5] [Q5c: Leptospirosis],
  pvtvreas.[6] [Q5c: Rabies],
  pvtvreas.[7] [Q5c: Kennel cough (KC/Bordetella bronchiseptica)],
  pvtvreas.[8] [Q5c: Other(s) (please list all) ID],
  s.otherVaccReasonName [Q5c: Other(s) (please list all) Desc],
  --Q5d During the two days following my dog’s most recent vaccination, he/she…
  pvtlastvacrct.[1] [Q5d: Was only vaccinated today or yesterday],
  pvtlastvacrct.[2] [Q5d: Seemed as normal with no ill effects],
  pvtlastvacrct.[3] [Q5d: Was off his/her food],
  pvtlastvacrct.[4] [Q5d: Developed a lump or swelling on the vaccination site],
  pvtlastvacrct.[5] [Q5d: Showed a general skin reaction (for example irritation or hair loss)],
  pvtlastvacrct.[6] [Q5d: Seemed lethargic or "off colour"],
  pvtlastvacrct.[7] [Q5d: Had a change of behaviour],
  pvtlastvacrct.[8] [Q5d: Had vomiting or diarrhoea],
  pvtlastvacrct.[9] [Q5d: Had an other adverse response (please specify) ID],
  s.otherReactionToVaccinationType [Q5d: Had an other adverse response (please specify) Desc],
  --Q5di Please provide more details if you are happy to do so
  s.otherRecentVaccinationDetails [Q5di: Adverse Response Detail],
  --Q5dii After which of these vaccines, did your dog have a reaction…
  pvtlastvaccrctto.[1] [Q5dii: The canine distemper/parvovirus/canine hepatitis booster],
  pvtlastvaccrctto.[2] [Q5dii: Leptospirosis],
  pvtlastvaccrctto.[3] [Q5dii: Rabies],
  pvtlastvaccrctto.[4] [Q5dii: Kennel cough],
  pvtlastvaccrctto.[5] [Q5dii: I don't know/can't remember],
  pvtlastvaccrctto.[6] [Q5dii: Other (please specify) ID],
  s.otherVaccReactionName [Q5dii: Other (please specify) Desc],
  --Q6 In the last three months, my dog has had...
  pvthp.[1] [Q6: No health problems],
  pvthp.[2] [Q6: A lack of appetite],
  pvthp.[3] [Q6: A cough or sneeze],
  pvthp.[4] [Q6: An ear problem (for example scratching ear more than usual)],
  pvthp.[5] [Q6: A skin problem (for example itching, lumps, swellings, rashes)],
  pvthp.[6] [Q6: An eye problem (for example conjunctivitis)],
  pvthp.[7] [Q6: A tooth/mouth problem (excluding loss of milk teeth)],
  pvthp.[8] [Q6: Intermittent lameness/limb problem (for example, 'bunny hopping' from time to time)],
  pvthp.[9] [Q6: Persistent lameness/limb problem],
  pvthp.[10] [Q6: Fracture or break in a leg(s)],
  pvthp.[11] [Q6: Dislocation of a joint],
  pvthp.[12] [Q6: A cut or wound],
  pvthp.[13] [Q6: Another small injury],
  pvthp.[14] [Q6: An injury caused by catching/carrying/picking up/playing with a stick],
  pvthp.[15] [Q6: A period of being lethargic/quieter than usual/not him/herself],
  pvthp.[16] [Q6: One or more instances of collapsing whilst gently walking],
  pvthp.[17] [Q6: One or more instances of collapsing whilst exercising/playing],
  pvthp.[18] [Q6: One or more instances when he/she has seemed to temporarily stop breathing whilst asleep],
  pvthp.[19] [Q6: Vomiting/sickness],
  pvthp.[20] [Q6: Difficulty swallowing and/or keeping food down/choking/gagging/regurgitating food],
  pvthp.[21] [Q6: A dog bite],
  pvthp.[22] [Q6: One or more instances of noisy breathing (for example snoring/snorting/wheezing)],
  pvthp.[23] [Q6: One or more instances of heavy/laboured breathing whilst exercising/playing],
  pvthp.[24] [Q6: One or more instances of heavy/laboured breathing whilst gently walking],
  pvthp.[25] [Q6: Fleas],
  pvthp.[26] [Q6: Worms],
  pvthp.[27] [Q6: Anal gland problems (rubbing bottom along ground)],
  pvthp.[28] [Q6: A problem with his/her tail (for example 'limber tail', 'cold tail', 'swimmers tail', stiff/droopy/limp tail)],
  pvthp.[29] [Q6: Other injuries or illness (please give full details) ID],
  s.otherHealthProblemType [Q6: Other injuries or illness (please give full details) Desc],
  --Q6a Sorry to hear your dog has been unwell/injured. Could you please tell me how long he/she was/has been poorly for?
  --Q6b Is he/she better now?
  --Q6c Have you seen a vet for this?
  --Q6d What was the cause of the cut/wound?
  --Q6di How was the wound treated?
  --Q6dii The wound…
  --Q6diii Following these problems, to help my dog’s wound to heal, a vet/vet nurse…
  --Q6e During the last three months, approximately how many times has this happened?
  --Q6ei Did your dog see a vet for this?
  --Q6f During the last three months, approximately how many times has this happened?
  --Q6fi Did your dog see a vet for this?
  --Q6g During the last three months, approximately how many times has this happened?
  --Q6gi Did your dog see a vet for this?
  --Q6h During the last three months, approximately how many times has this happened?
  --Q6hi Did your dog see a vet for this?
  --Q6i During the last three months, approximately how many times has this happened?
  --Q6ii Did your dog see a vet for this?
  --Q6j During the last three months, approximately how many times has this happened?
  --Q6ji Did your dog see a vet for this?
  --Q6k Which of these leg(s) were broken?
  --Q6ki My dog's leg break(s) occurred because he/she…
  --Q7 I notice that my dog has flatulence/gas/farts/passes wind...
  s.frequencyOfFartsId [Q7: Fart Frequency ID],
  fof.frequencyOfFartsName [Q7: Fart Frequency Desc],
  --Q8 I notice that my dog has constipation…
  s.frequencyOfConstipationId [Q8: Constipation Frequency ID],
  foc.frequencyOfConstipationName [Q8: Constipation Frequency Desc],
  --Q9 I notice that my dog has diarrhoea…
  s.frequencyOfDiarrhoeaId [Q9: Diarrhoea Frequencey ID],
  fod.frequencyOfDiarrhoeaName [Q9: Diarrhoea Frequencey Desc],
  --Q10 My dog has other tummy/diet-related problems that I am aware of….
  s.otherDietProblemsId [Q10: Other Dietary Problems ID],
  odp.otherDietProblemsName [Q10: Other Dietary Problems Desc],
  --Q10a Please provide further information about these tummy/diet-related problems in the space below….
  s.otherTummy [Q10a: Other Dietary Problems Detail],
  --Q11 Within the last six months, have you seen any ticks on your dog?
  s.noticedTicksId [Q11: Noticed Ticks In Past 6 Months ID],
  CASE 
    WHEN s.noticedTicksId = 1 THEN 'No'
    WHEN s.noticedTicksId = 2 THEN 'Yes'
    WHEN s.noticedTicksId = 3 THEN 'I don''t know/can''t remember'
  END [Q11: Noticed Ticks In Past 6 Months Desc],
  --Q12 Within the last six months, my dog has had his/her anal glands squeezed/expressed/emptied…
  s.analGlandTreatmentFrequencyId [Q12: Frequency Anal Glands Emptied (Last 6 Months) ID],
  agtf.analGlandTreatmentFrequencyName [Q12: Frequency Anal Glands Emptied (Last 6 Months) Desc],
  --Q12a My dog's anal glands were squeezed/expressed/emptied by…
  pvtagtt.[1] [Q12a: A vet/vet nurse],
  pvtagtt.[2] [Q12a: Another canine professional (for example dog groomer)],
  pvtagtt.[3] [Q12a: By a household member (if not a vet/vet nurse/canine professional)],
  pvtagtt.[4] [Q12a: Other (please specify) ID],
  s.otherAnalGlandTreatmentTypeName [Q12a: Other (please specify) Desc],
  --Q13 On a scale of 0 to 5 my dog's eyesight seems to be…
  s.eyesightScaleId [Q26: Eyesight Level ID],
  es.eyesightScaleName [Q26: Eyesight Level Desc],
  --Q13a I think that my dog's eyesight is not excellent because…
  pvtepr.[1] [Q13a: My vet informed me],
  pvtepr.[2] [Q13a: He/she bumps into things sometimes],
  pvtepr.[3] [Q13a: He/she doesn't easily spot me when off lead on a walk],
  pvtepr.[4] [Q13a: He/she struggles to see treats/toys],
  pvtepr.[5] [Q13a: He/she struggles with negotiating steps/obstacles],
  pvtepr.[6] [Q13a: Other (please specify) ID],
  s.otherEyesightProblemReasonName [Q13a: Other (please specify) Desc],
  --Q14 On a scale of 0 to 5 my dog's hearing seems to be…
  s.hearingScaleId [Q14 Hearing Level ID],
  hs.hearingScaleName [Q14 Hearing Level Desc],
  --Q14a I think that my dog's hearing is not excellent because…
  pvthpr.[1] [Q14a: My vet informed me],
  pvthpr.[2] [Q14a: He/she is easily startled],
  pvthpr.[3] [Q14a: He/she has poor recall],
  pvthpr.[4] [Q14a: He/she barks excessively],
  pvthpr.[5] [Q14a: He/she is difficult to wake up],
  pvthpr.[6] [Q14a: He/she does not react to sounds, when I would expect him/her to react],
  pvthpr.[7] [Q14a: He/she struggles with negotiating steps/obstacles],
  pvthpr.[8] [Q14a: Other (please specify) ID],
  s.otherHearingProblemReasonName [Q14a: Other (please specify) Desc],
  --Q15 Please use the space below to tell us any information about possible adverse effects (side effects) that your dog has experienced when administered medication (if possible, please specify which medication and your dog's reaction)
  s.possibleMedicationAdverseEffectsDetail [Q15 Adverse Effect to Medication Detail],
  --Q40  "Toby" has been given herbal and/or homeopathic medication(s) that were prescribed by a vet and/or bought at a veterinary practice…
  s.homeopathicPrescriptionFrequencyId [Q40: Frequency Prescribed Homeopathic Medication Given ID],
  HPF.homeopathicPrescriptionFrequencyName [Q40: Frequency Prescribed Homeopathic Medication Given Desc],
  --Q40.1 If you are willing, please use the space below to tell us which herbal and/or homeopathic medication(s) from your vet/veterinary practice you gave "Toby" and the reason(s) for using this(/these) for him/her
  s.homeopathicPrescriptionDetails [Q40.1: Homeopathic Prescription Details],
  --Q41  "Toby" has been given herbal and/or homeopathic medication(s) that were NOT prescribed by a vet or bought at a veterinary practice…
  s.homeopathicNonPrescriptionFrequencyId [Q41: Frequency Non-Prescribed Homeopathic Medication Given ID],
  HNPF.homeopathicNonPrescriptionFrequencyName [Q41: Frequency Non-Prescribed Homeopathic Medication Given Desc],
  --Q41.1 If you are willing, please use the space below to tell us which herbal and/or homeopathic medication(s) you gave "Toby" and the reason(s) for using this(/these) for him/her
  s.homeopathicNonPrescriptionDetails [Q41.1: Homeopathic Non-Prescription Details],
  --Q16 During the last 6 months, has your dog had any health issues whilst away and/or on return from a trip abroad (by ‘abroad’ we mean travelling outside your home area of UK/ROI, as applicable)?
  pvtAHI.[1] [Q16: Not applicable, he/she has not been abroad],
  pvtAHI.[2] [Q16: No, he/she has been abroad but had no health issues whilst there or on return],
  pvtAHI.[3] [Q16: He/she had health issues whilst on a trip abroad],
  pvtAHI.[4] [Q16: He/she has had health issues that started within 2 weeks of the end of a trip abroad],
  pvtAHI.[5] [Q16: I don't know/can't remember],
  --Q16a Please use the space below to tell us any information about the health issues that your dog had when on a trip abroad (if possible, please specify the problem(s), the sign(s), diagnosis and treatment if known)
  s.otherAbroadHealthIssuesDetail,
  --Q16b Please use the space below to tell us about the health issues that your dog had on return from a trip abroad (if possible, please specify the problem(s), the sign(s), diagnosis and treatment if known)
  s.otherAbroadReturnHealthIssuesDetail,
  --Q17 During the last seven days, I have seen my dog scratching, biting, licking, chewing, nibbling, rubbing (out of discomfort rather than 'normal rubbing or cleaning behaviour') him/herself… (Please use the diagrams that are located after this question, to help you identify each region.)
  pvtIAA.[1] [Q17: Face including chin, muzzle and side of face],
  pvtIAA.[2] [Q17: Ears],
  pvtIAA.[3] [Q17: Neck],
  pvtIAA.[4] [Q17: Back and base of tail],
  pvtIAA.[5] [Q17: Tail],
  pvtIAA.[6] [Q17: Paws (top or bottom, front or back)],
  pvtIAA.[7] [Q17: Back legs and thighs, excluding paws],
  pvtIAA.[8] [Q17: Flank],
  pvtIAA.[9] [Q17: Chest and sides],
  pvtIAA.[10] [Q17: Front legs and shoulders, excluding paws],
  pvtIAA.[11] [Q17: Tummy and groin],
  pvtIAA.[12] [Q17: Armpits],
  --Q18 During the last seven days, I have noticed… (Please use the diagrams that are located after this question, to help you identify each region.)
  /*----1 - face including chin, muzzle and side of face----*/
  pvtSAT1.[1] [Q18: Hair loss (1 - face)], 
  pvtSAT1.[2] [Q18: Spots or pimples (papules or pustules) (1 - face)], 
  pvtSAT1.[3] [Q18: Scabs/crusts (1 - face)], 
  pvtSAT1.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (1 - face)], 
  pvtSAT1.[5] [Q18: Redness of the skin (1 - face)], 
  pvtSAT1.[6] [Q18: Bleeding (1 - face)], 
  pvtSAT1.[7] [Q18: None of these - hair and skin appear normal (1 - face)],
  /*----2 - ears----*/
  pvtSAT2.[1] [Q18: Hair loss (2 - ears)], 
  pvtSAT2.[2] [Q18: Spots or pimples (papules or pustules) (2 - ears)], 
  pvtSAT2.[3] [Q18: Scabs/crusts (2 - ears)], 
  pvtSAT2.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (2 - ears)], 
  pvtSAT2.[5] [Q18: Redness of the skin (2 - ears)], 
  pvtSAT2.[6] [Q18: Bleeding (2 - ears)], 
  pvtSAT2.[7] [Q18: None of these - hair and skin appear normal (2 - ears)],
  /*----3 - neck----*/
  pvtSAT3.[1] [Q18: Hair loss (3 - neck)], 
  pvtSAT3.[2] [Q18: Spots or pimples (papules or pustules) (3 - neck)], 
  pvtSAT3.[3] [Q18: Scabs/crusts (3 - neck)], 
  pvtSAT3.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (3 - neck)], 
  pvtSAT3.[5] [Q18: Redness of the skin (3 - neck)], 
  pvtSAT3.[6] [Q18: Bleeding (3 - neck)], 
  pvtSAT3.[7] [Q18: None of these - hair and skin appear normal (3 - neck)],
  /*----4 - back and base of tail----*/
  pvtSAT4.[1] [Q18: Hair loss (4 - back and base of tail)], 
  pvtSAT4.[2] [Q18: Spots or pimples (papules or pustules) (4 - back and base of tail)], 
  pvtSAT4.[3] [Q18: Scabs/crusts (4 - back and base of tail)], 
  pvtSAT4.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (4 - back and base of tail)], 
  pvtSAT4.[5] [Q18: Redness of the skin (4 - back and base of tail)], 
  pvtSAT4.[6] [Q18: Bleeding (4 - back and base of tail)], 
  pvtSAT4.[7] [Q18: None of these - hair and skin appear normal (4 - back and base of tail)],
  /*----5 - tail ----*/
  pvtSAT5.[1] [Q18: Hair loss (5 - tail)], 
  pvtSAT5.[2] [Q18: Spots or pimples (papules or pustules) (5 - tail)], 
  pvtSAT5.[3] [Q18: Scabs/crusts (5 - tail)], 
  pvtSAT5.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (5 - tail)], 
  pvtSAT5.[5] [Q18: Redness of the skin (5 - tail)], 
  pvtSAT5.[6] [Q18: Bleeding (5 - tail)], 
  pvtSAT5.[7] [Q18: None of these - hair and skin appear normal (5 - tail)],
  /*----6 - paws (top or bottom, front or back)----*/
  pvtSAT6.[1] [Q18: Hair loss (6 - paws )], 
  pvtSAT6.[2] [Q18: Spots or pimples (papules or pustules) (6 - paws)], 
  pvtSAT6.[3] [Q18: Scabs/crusts (6 - paws)], 
  pvtSAT6.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (6 - paws)], 
  pvtSAT6.[5] [Q18: Redness of the skin (6 - paws)], 
  pvtSAT6.[6] [Q18: Bleeding (6 - paws)], 
  pvtSAT6.[7] [Q18: None of these - hair and skin appear normal (6 - paws)],
  /*----7 - back legs and thighs, excluding paws----*/
  pvtSAT7.[1] [Q18: Hair loss (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[2] [Q18: Spots or pimples (papules or pustules) (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[3] [Q18: Scabs/crusts (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[5] [Q18: Redness of the skin (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[6] [Q18: Bleeding (7 - back legs and thighs, excluding paws)], 
  pvtSAT7.[7] [Q18: None of these - hair and skin appear normal (7 - back legs and thighs, excluding paws)],
  /*----8 - flank----*/
  pvtSAT8.[1] [Q18: Hair loss (8 - flank)], 
  pvtSAT8.[2] [Q18: Spots or pimples (papules or pustules) (8 - flank)], 
  pvtSAT8.[3] [Q18: Scabs/crusts (8 - flank)], 
  pvtSAT8.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (8 - flank)], 
  pvtSAT8.[5] [Q18: Redness of the skin (8 - flank)], 
  pvtSAT8.[6] [Q18: Bleeding (8 - flank)], 
  pvtSAT8.[7] [Q18: None of these - hair and skin appear normal (8 - flank)],
  /*----9 - chest and sides----*/
  pvtSAT9.[1] [Q18: Hair loss (9 - chest and sides)], 
  pvtSAT9.[2] [Q18: Spots or pimples (papules or pustules) (9 - chest and sides)], 
  pvtSAT9.[3] [Q18: Scabs/crusts (9 - chest and sides)], 
  pvtSAT9.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (9 - chest and sides)], 
  pvtSAT9.[5] [Q18: Redness of the skin (9 - chest and sides)], 
  pvtSAT9.[6] [Q18: Bleeding (9 - chest and sides)], 
  pvtSAT9.[7] [Q18: None of these - hair and skin appear normal (9 - chest and sides)],
  /*----10 - front legs and shoulders, excluding paws----*/
  pvtSAT10.[1] [Q18: Hair loss (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[2] [Q18: Spots or pimples (papules or pustules) (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[3] [Q18: Scabs/crusts (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[5] [Q18: Redness of the skin (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[6] [Q18: Bleeding (10 - front legs and shoulders, excluding paws)], 
  pvtSAT10.[7] [Q18: None of these - hair and skin appear normal (10 - front legs and shoulders, excluding paws)],
  /*----11 - tummy and groin----*/
  pvtSAT11.[1] [Q18: Hair loss (11 - tummy and groin)], 
  pvtSAT11.[2] [Q18: Spots or pimples (papules or pustules) (11 - tummy and groin)], 
  pvtSAT11.[3] [Q18: Scabs/crusts (11 - tummy and groin)], 
  pvtSAT11.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (11 - tummy and groin)], 
  pvtSAT11.[5] [Q18: Redness of the skin (11 - tummy and groin)], 
  pvtSAT11.[6] [Q18: Bleeding (11 - tummy and groin)], 
  pvtSAT11.[7] [Q18: None of these - hair and skin appear normal (11 - tummy and groin)],
  /*----12 - armpits----*/
  pvtSAT12.[1] [Q18: Hair loss (12 - armpits)], 
  pvtSAT12.[2] [Q18: Spots or pimples (papules or pustules) (12 - armpits)], 
  pvtSAT12.[3] [Q18: Scabs/crusts (12 - armpits)], 
  pvtSAT12.[4] [Q18: Thickening of the skin and/or changes in colour to grey or black (12 - armpits)], 
  pvtSAT12.[5] [Q18: Redness of the skin (12 - armpits)], 
  pvtSAT12.[6] [Q18: Bleeding (12 - armpits)], 
  pvtSAT12.[7] [Q18: None of these - hair and skin appear normal (12 - armpits)],
  --Q19 Please use the space below to provide further information about your dog’s health/illnesses/medication that has not been covered elsewhere in this section…
  s.otherHealthIllnessesInjuries [Q19: Further Information]
from survey5_5Years s

--Q1 In the last six months, I have taken "Toby" to a veterinary practice…
left join referenceVetVisitPrev6MthType VetVisL6m
  on VetVisL6m.vetVisitPrev6MthTypeId = s.vetVisitPrev6MthType
  
-- Q1a: The vet...
Left join 
	(Select 
		va.survey5_5YearsId ID,
		vetActionTypeName [Action Type],
		cast(va.vetActionTypeId as varchar) as 'Action'

	   from survey5_5Years_referenceVetActionType va

	inner join  referenceVetActionType3 refva

		on refva.vetActionTypeId = va.vetActionTypeId
	) va
	PIVOT
	
	(min([Action Type]) For Action
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtva on pvtva.ID = s.survey5_5YearsID

--Q2 During the last six months, my dog has been administered worming products...
left join referenceWormingFrequency wf
  on wf.wormingFrequencyId = s.wormingFrequencyId
  
--Q2b The treatment(s) was/were…
Left join 
	(Select 
		tpt_worm.survey5_5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_worm.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5_5Years_referenceTreatmentProblemType_worming tpt_worm

	inner join  referenceTreatmentProblemType reftpt_worm

		on reftpt_worm.treatmentProblemTypeId = tpt_worm.treatmentProblemTypeId
	) tpt_worm
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_worm on pvttpt_worm.ID = s.survey5_5YearsID

--Q3 During the last six months, the number of times that my dog has been administered flea control products is...
left join referenceTreatmentAdministeredFrequency taf_flea
  on taf_flea.treatmentAdministeredFrequencyId = s.treatmentAdministeredFrequencyId_fleas
  
--Q3b The treatment was/were…
Left join 
	(Select 
		tpt_fleas.survey5_5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_fleas.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5_5Years_referenceTreatmentProblemType_fleas tpt_fleas

	inner join  referenceTreatmentProblemType reftpt_fleas

		on reftpt_fleas.treatmentProblemTypeId = tpt_fleas.treatmentProblemTypeId
	) tpt_fleas
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_fleas on pvttpt_fleas.ID = s.survey5_5YearsID
  
--Q4 During the last six months, the number of times that my dog has been administered tick control products is...
left join referenceTreatmentAdministeredFrequency taf_tick
  on taf_tick.treatmentAdministeredFrequencyId = s.treatmentAdministeredFrequencyId_ticks
  
--Q4b The treatment was/were…
Left join 
	(Select 
		tpt_ticks.survey5_5YearsId ID,
		treatmentProblemTypeName [Treatment Type],
		cast(tpt_ticks.treatmentProblemTypeId as varchar) as 'Treatment'

	   from survey5_5Years_referenceTreatmentProblemType_ticks tpt_ticks

	inner join  referenceTreatmentProblemType reftpt_ticks

		on reftpt_ticks.treatmentProblemTypeId = tpt_ticks.treatmentProblemTypeId
	) tpt_ticks
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2])
	) 
	pvttpt_ticks on pvttpt_ticks.ID = s.survey5_5YearsID

--Q5 My dog was most recently vaccinated…  
left join referenceLastVaccDate2Years lv
  on lv.lastVaccDateId = s.mostRecentlyVaccinatedId
  
--Q5a My dog has not been vaccinated because…
left join referenceNotVaccinatedReason2Years rnv
  on rnv.notVaccinatedReasonId = s.notVaccinatedReasonId
 
--Q5b I am happy to provide a photo/scan of my dog’s vaccination records…
left join referenceAbleToScanVaccCardType scvc
  on scvc.ableToScanVaccCardTypeId = s.ableToScanVaccRecords
  
--Q5c My dog’s last vaccination was for…
Left join 
	(Select 
		vreas.survey5_5YearsId ID,
		lastVaccReasonName [Reason Type],
		cast(vreas.lastVaccReasonId as varchar) as 'Reason'

	   from survey5_5Years_referenceLastVaccReason vreas

	inner join  referenceLastVaccReason refvreas

		on refvreas.lastVaccReasonId = vreas.lastVaccReasonId
	) vreas
	PIVOT
	
	(min([Reason Type]) For Reason
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
	) 
	pvtvreas on pvtvreas.ID = s.survey5_5YearsID
 
--Q5d During the two days following my dog’s most recent vaccination, he/she…
Left join 
	(Select 
		lastvacrct.survey5_5YearsId ID,
		reactionToVaccinationTypeName [Reaction Type],
		cast(lastvacrct.reactionToVaccinationTypeId as varchar) as 'Reaction'

	   from survey5_5Years_referenceReactionToVaccinationType lastvacrct

	inner join  referenceReactionToVaccinationType reflastvacrct

		on reflastvacrct.reactionToVaccinationTypeId = lastvacrct.reactionToVaccinationTypeId
	) lastvacrct
	PIVOT
	
	(min([Reaction Type]) For Reaction
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9])
	) 
	pvtlastvacrct on pvtlastvacrct.ID = s.survey5_5YearsID
  
--Q5dii After which of these vaccines, did your dog have a reaction…
Left join 
	(Select 
		lastvaccrctto.survey5_5YearsID ID,
		lastVaccReactionName [Vacc Type],
		cast(lastvaccrctto.lastVaccReactionId as varchar) as 'Vacc'

	   from survey5_5Years_referenceLastVaccReaction lastvaccrctto

	inner join  referenceLastVaccReaction reflastvaccrctto

		on lastvaccrctto.lastVaccReactionId = reflastvaccrctto.lastVaccReactionId
	) lastvaccrctto
	PIVOT
	
	(min([Vacc Type]) For Vacc
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtlastvaccrctto on pvtlastvaccrctto.ID = s.survey5_5YearsID
  
--Q6 In the last three months, my dog has had...
Left join 
	(Select 
		hp.survey5_5YearsId ID,
		healthProblemTypeName [Problem Type],
		cast(hp.healthProblemTypeId as varchar) as 'Problem'

	   from survey5_5Years_referenceHealthProblems hp

	inner join  referenceHealthProblems refhp

		on hp.healthProblemTypeId = refhp.healthProblemTypeId
	) hp
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19], [20], [21], [22], [23], [24], [25], [26], [27], [28], [29])
	) 
	pvthp on pvthp.ID = s.survey5_5YearsID
  
--Q7 I notice that my dog has flatulence/gas/farts/passes wind...
left join referenceFrequencyOfFarts fof
  on fof.frequencyOfFartsId = s.frequencyOfFartsId
  
--Q8 I notice that my dog has constipation…
left join referenceFrequencyOfConstipation foc
  on foc.frequencyOfConstipationId = s.frequencyOfConstipationId
  
--Q9 I notice that my dog has diarrhoea…
left join referenceFrequencyOfDiarrhoea fod
  on fod.frequencyOfDiarrhoeaId = s.frequencyOfDiarrhoeaId
  
--Q10 My dog has other tummy/diet-related problems that I am aware of….
left join referenceOtherDietProblems odp
  on odp.otherDietProblemsId = s.otherDietProblemsId

--Q12 Within the last six months, my dog has had his/her anal glands squeezed/expressed/emptied…
left join referenceAnalGlandTreatmentFrequency agtf
  on agtf.analGlandTreatmentFrequencyId = s.analGlandTreatmentFrequencyId
  
--Q12a My dog's anal glands were squeezed/expressed/emptied by…
Left join 
	(Select 
		agtt.survey5_5YearsId ID,
		analGlandTreatmentTypeName [Treatment Type],
		cast(agtt.analGlandTreatmentTypeId as varchar) as 'Treatment'

	   from survey5_5Years_referenceAnalGlandTreatmentType agtt

	inner join  referenceAnalGlandTreatmentType refagtt

		on agtt.analGlandTreatmentTypeId = refagtt.analGlandTreatmentTypeId
	) agtt
	PIVOT
	
	(min([Treatment Type]) For Treatment
		IN ([1], [2], [3], [4])
	) 
	pvtagtt on pvtagtt.ID = s.survey5_5YearsID  
  
--Q13 On a scale of 0 to 5 my dog's eyesight seems to be…
left join referenceEyesightScale es
  on es.eyesightScaleId = s.eyesightScaleId

--Q13a I think that my dog's eyesight is not excellent because…
Left join 
	(Select 
		epr.survey5_5YearsId ID,
		eyesightProblemReasonName [Problem Type],
		cast(epr.eyesightProblemReasonId as varchar) as 'Problem'

	   from survey5_5Years_referenceEyesightProblemReason epr

	inner join  referenceEyesightProblemReason refepr

		on epr.eyesightProblemReasonId = refepr.eyesightProblemReasonId
	) epr
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6])
	) 
	pvtepr on pvtepr.ID = s.survey5_5YearsID  
  
--Q14 On a scale of 0 to 5 my dog's hearing seems to be…
left join referenceHearingScale hs
  on hs.hearingScaleId = s.hearingScaleId
  
--Q14a I think that my dog's hearing is not excellent because…
Left join 
	(Select 
		hpr.survey5_5YearsId ID,
		hearingProblemReasonName [Problem Type],
		cast(hpr.hearingProblemReasonId as varchar) as 'Problem'

	   from survey5_5Years_referenceHearingProblemReason hpr

	inner join  referenceHearingProblemReason refhpr

		on hpr.hearingProblemReasonId = refhpr.hearingProblemReasonId
	) hpr
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5], [6], [7], [8])
  )
  pvthpr on pvthpr.ID = s.survey5_5YearsID  
  
--Q40  "Toby" has been given herbal and/or homeopathic medication(s) that were prescribed by a vet and/or bought at a veterinary practice…
left join referenceHomeopathicPrescriptionFrequency3 HPF
  on HPF.homeopathicPrescriptionFrequencyId = s.homeopathicPrescriptionFrequencyId
--Q41  "Toby" has been given herbal and/or homeopathic medication(s) that were NOT prescribed by a vet or bought at a veterinary practice…
left join referenceHomeopathicNonPrescriptionFrequency3 HNPF
  on HNPF.homeopathicNonPrescriptionFrequencyId = s.homeopathicNonPrescriptionFrequencyId
--Q16 During the last 6 months, has your dog had any health issues whilst away and/or on return from a trip abroad (by ‘abroad’ we mean travelling outside your home area of UK/ROI, as applicable)?
Left join 
	(Select 
		AHI.survey5_5YearsId ID,
		abroadHealthIssuesName [Problem Type],
		cast(AHI.abroadHealthIssuesId as varchar) as 'Problem'

	   from survey5_5Years_referenceAbroadHealthIssues AHI

	inner join  referenceAbroadHealthIssues refAHI

		on AHI.abroadHealthIssuesId = refAHI.abroadHealthIssuesId
	) AHI
	PIVOT
	
	(min([Problem Type]) For Problem
		IN ([1], [2], [3], [4], [5])
  )
  pvtAHI on pvtAHI.ID = s.survey5_5YearsID  
  
--Q17 During the last seven days, I have seen my dog scratching, biting, licking, chewing, nibbling, rubbing (out of discomfort rather than 'normal rubbing or cleaning behaviour') him/herself… (Please use the diagrams that are located after this question, to help you identify each region.)
left join (select * 
             from (select IAA.survey5_5YearsId as ID, 
                          cast(IAA.areaNoticedId as nvarchar(max)) as AreaNoticed,
                          cast(refIAA.irritatedAreaActionName as nvarchar(255)) as irritatedArea
                     from survey5_5Years_referenceIrritatedAreaAction IAA
                     join referenceIrritatedAreaAction refIAA on refIAA.irritatedAreaActionId = IAA.irritatedAreaActionId
                     join referenceAreaNoticed refAN on refAN.areaNoticedId = IAA.areaNoticedId
                  ) IAA
             pivot (
                    min(irritatedArea) for AreaNoticed in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
                   ) pvt
           ) pvtIAA on pvtIAA.ID = s.survey5_5YearsId

--Q18 During the last seven days, I have noticed… (Please use the diagrams that are located after this question, to help you identify each region.)
/*----1 - face including chin, muzzle and side of face----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 1) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT1 on pvtSAT1.ID = s.survey5_5YearsId
/*----2 - ears----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 2) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT2 on pvtSAT2.ID = s.survey5_5YearsId
/*----3 - neck----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 3) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT3 on pvtSAT3.ID = s.survey5_5YearsId
/*----4 - back and base of tail----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 4) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT4 on pvtSAT4.ID = s.survey5_5YearsId
/*----5 - tail ----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 5) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT5 on pvtSAT5.ID = s.survey5_5YearsId
/*----6 - paws (top or bottom, front or back)----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 6) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT6 on pvtSAT6.ID = s.survey5_5YearsId
/*----7 - back legs and thighs, excluding paws----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 7) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT7 on pvtSAT7.ID = s.survey5_5YearsId
/*----8 - flank----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 8) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT8 on pvtSAT8.ID = s.survey5_5YearsId
/*----9 - chest and sides----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 9) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT9 on pvtSAT9.ID = s.survey5_5YearsId
/*----10 - front legs and shoulders, excluding paws----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 10) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT10 on pvtSAT10.ID = s.survey5_5YearsId
/*----11 - tummy and groin----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 11) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT11 on pvtSAT11.ID = s.survey5_5YearsId
/*----12 - armpits----*/
left join (select 
              SAT.survey5_5YearsId ID,
              cast(SAT.symptomsAreaTypeId as nvarchar(max)) as SymptomAreaID,
              cast(refSAT.symptomsAreaTypeName as nvarchar(255)) as SymptomArea
            from survey5_5Years_referenceSymptomsAreaType SAT
              join referenceSymptomsAreaType refSAT on refSAT.symptomsAreaTypeId = SAT.symptomsAreaTypeId
              join referenceAreaNoticed refAN on refAN.areaNoticedId = SAT.areaNoticedId
            where SAT.areaNoticedId = 12) SAT
            pivot (
              min(SymptomArea) for SymptomAreaID in ([1],[2],[3],[4],[5],[6],[7])
                   
            ) pvtSAT12 on pvtSAT12.ID = s.survey5_5YearsId
--Q19 Please use the space below to provide further information about your dog’s health/illnesses/medication that has not been covered elsewhere in this section… 


/*----- Generic ------*/
left join DTGenPupAdmin.dbo.ExcludedDogs adminGP
	on adminGP.DogID = s.dogId
--left join tblAboutMe tblAbtMe
---	on (tblAbtMe.userid = s.userId AND tblAbtMe.dogid = s.dogId AND tblAbtMe.dogId is not null and tblAbtMe.SixMonthPercComplete is not null)

/*--multi-dogs--*/
left join(
    Select userID from dogcore
    Group by userID   
    Having Count(*)>1
) multidogs on multidogs.userId = s.userId