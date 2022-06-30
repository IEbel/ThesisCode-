* Encoding: UTF-8.

*create dataset with only 18+*

DATASET ACTIVATE DataSet3.
DATASET COPY  IEMerged_18jaar.
DATASET ACTIVATE  IEMerged_18jaar.
FILTER OFF.
USE ALL.
SELECT IF ((Q26_MW_leeftijd >= 18) & (Q14_LG_leeftijd >= 18)).
EXECUTE.
DATASET ACTIVATE  DataSet3.


SAVE OUTFILE='C:\Users\Inger\Documents\VU\Thesis\Data\IEMerged_18jaar.sav'
  /COMPRESSED.

*Create datasets with various attentionchecks failures*

RECODE Q2_LG_10.0 (4=1) (ELSE=0) INTO RQ2_LG_10.0.
VARIABLE LABELS  RQ2_LG_10.0 'if 4=1, else = 0'.
EXECUTE.

RECODE Q2_LG_10.2 (4=1) (ELSE=0) INTO RQ2_LG_10.2.
VARIABLE LABELS  RQ2_LG_10.2 'if 4=1, else = 0'.
EXECUTE.

RECODE Q2_LG_10.3 (1=1) (ELSE=0) INTO RQ2_LG_10.3.
VARIABLE LABELS  RQ2_LG_10.3 'if 1=1, else = 0'.
EXECUTE.

RECODE Q2_LG_10.4 (3=1) (ELSE=0) INTO RQ2_LG_10.4.
VARIABLE LABELS  RQ2_LG_10.4 'if 3 then 1, else 0'.
EXECUTE.

COMPUTE LG_PassedattentionChecks=SUM(RQ2_LG_10.0, RQ2_LG_10.2, RQ2_LG_10.3, RQ2_LG_10.4).
EXECUTE.


RECODE MWA1_1 (4=1) (ELSE=0) INTO RMWA1_1.
VARIABLE LABELS  RMWA1_1 'if 4=1, else = 0'.
EXECUTE.

RECODE MWA2_1 (4=1) (ELSE=0) INTO RMWA2_1.
VARIABLE LABELS  RMWA2_1 'if 4=1, else = 0'.
EXECUTE.

RECODE MWA3_1 (1=1) (ELSE=0) INTO RMWA3_1.
VARIABLE LABELS  RMWA3_1 'if 1=1, else = 0'.
EXECUTE.

RECODE MWA4_1 (3=1) (ELSE=0) INTO RMWA4_1.
VARIABLE LABELS  RMWA4_1 'if 3 then 1, else 0'.
EXECUTE.

COMPUTE MW_PassedattentionChecks=SUM(RMWA1_1 to RMWA4_1).
VARIABLE LABELS  MW_PassedattentionChecks 'COMPUTE MW_PassedattentionChecks=SUM(RMWA1_1 to '+
    'RMWA4_1)'.
EXECUTE.




DATASET COPY  IEMerged_4attentionchecksGoed.
DATASET ACTIVATE  IEMerged_4attentionchecksGoed.
FILTER OFF.
USE ALL.
SELECT IF ((LG_PassedattentionChecks = 4) & (MW_PassedattentionChecks = 4)).
EXECUTE.
DATASET ACTIVATE  IEMerged_18jaar.


SAVE OUTFILE='C:\Users\Inger\Documents\VU\Thesis\Data\IE variabelen en deleted cases\IEMerged_4attentionchecksGoed.sav'
  /COMPRESSED.

DATASET COPY  IEMerged_3attentionchecksGoed.
DATASET ACTIVATE  IEMerged_3attentionchecksGoed.
FILTER OFF.
USE ALL.
SELECT IF ((LG_PassedattentionChecks  >=  3) & (MW_PassedattentionChecks  >=  3)).
EXECUTE.
DATASET ACTIVATE  IEMerged_18jaar.


SAVE OUTFILE='C:\Users\Inger\Documents\VU\Thesis\Data\IE variabelen en deleted cases\IEMerged_3attentionchecksGoed.sav'
  /COMPRESSED.

DATASET COPY  IEMerged_2attentionchecksGoed.
DATASET ACTIVATE  IEMerged_2attentionchecksGoed.
FILTER OFF.
USE ALL.
SELECT IF ((LG_PassedattentionChecks  >=  2) & (MW_PassedattentionChecks  >=  2)).
EXECUTE.
DATASET ACTIVATE  IEMerged_18jaar.


SAVE OUTFILE='C:\Users\Inger\Documents\VU\Thesis\Data\IE variabelen en deleted cases\IEMerged_2attentionchecksGoed.sav'
  /COMPRESSED.

DATASET COPY  IEMerged_1attentionchecksGoed.
DATASET ACTIVATE  IEMerged_1attentionchecksGoed.
FILTER OFF.
USE ALL.
SELECT IF ((LG_PassedattentionChecks  >=  1) & (MW_PassedattentionChecks  >=  1)).
EXECUTE.
DATASET ACTIVATE  IEMerged_18jaar.


SAVE OUTFILE='C:\Users\Inger\Documents\VU\Thesis\Data\IE variabelen en deleted cases\IEMerged_1attentionchecksGoed.sav'
  /COMPRESSED.

*NEW ANALYSES WITH DELETED CASES*

DATASET ACTIVATE Merged_18jaar.
DATASET COPY  IEMerged_3attentionchecksGoed.
DATASET ACTIVATE  IEMerged_3attentionchecksGoed.
FILTER OFF.
USE ALL.
SELECT IF ((LG_PassedattentionChecks  >=  3) & (MW_PassedattentionChecks  >=  3)).
EXECUTE.
DATASET ACTIVATE  Merged_18jaar.

*descriptive statistics*

DATASET ACTIVATE IEMerged_4attentionchecksGoed.
DATASET DECLARE IEMerged_4attentionchecksGoed_LeiderAggregate.
AGGREGATE
  /OUTFILE='IEMerged_4attentionchecksGoed_LeiderAggregate'
  /BREAK=LG
  /Q13_LG_geslacht_mean=MEAN(Q13_LG_geslacht) 
  /Q14_LG_leeftijd_mean=MEAN(Q14_LG_leeftijd) 
  /Q15_LG_opleiding_mean=MEAN(Q15_LG_opleiding) 
  /Q16_LG_jaarOrganisatie_mean=MEAN(Q16_LG_jaarOrganisatie) 
  /Q17_LG_jaarTeam_mean=MEAN(Q17_LG_jaarTeam) 
  /Q18_LG_jaarFunctie_mean=MEAN(Q18_LG_jaarFunctie) 
  /Q19_LG_medewerkers_mean=MEAN(Q19_LG_medewerkers) 
  /LG15_DespotischLeider_1_mean=MEAN(LG15_DespotischLeider_1) 
  /LG15_DespotischLeider_2_mean=MEAN(LG15_DespotischLeider_2) 
  /LG15_DespotischLeider_3_mean=MEAN(LG15_DespotischLeider_3) 
  /LG15_DespotischLeider_4_mean=MEAN(LG15_DespotischLeider_4) 
  /LG15_DespotischLeider_5_mean=MEAN(LG15_DespotischLeider_5) 
  /LG15_DespotischLeider_6_mean=MEAN(LG15_DespotischLeider_6).

DATASET ACTIVATE IEMerged_4attentionchecksGoed_LeiderAggregate.
DESCRIPTIVES VARIABLES=Q13_LG_geslacht_mean Q14_LG_leeftijd_mean Q15_LG_opleiding_mean 
    Q16_LG_jaarOrganisatie_mean Q17_LG_jaarTeam_mean Q18_LG_jaarFunctie_mean Q19_LG_medewerkers_mean
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=Q13_LG_geslacht_mean Q15_LG_opleiding_mean
  /ORDER=ANALYSIS.

DATASET ACTIVATE IEMerged_4attentionchecksGoed.
DESCRIPTIVES VARIABLES=Q25_MW_geslacht Q26_MW_leeftijd Q27_MW_opleiding Q28_MW_jarenOrganisatie 
    Q29_MW_jarenTeam Q30_MW_jarenFunctie
  /STATISTICS=MEAN STDDEV MIN MAX.

FREQUENCIES VARIABLES=Q25_MW_geslacht Q27_MW_opleiding
  /ORDER=ANALYSIS.

*factor analysis* 

DATASET ACTIVATE IEMerged_4attentionchecksGoed_LeiderAggregate.
FACTOR
  /VARIABLES LG15_DespotischLeider_1_mean LG15_DespotischLeider_2_mean LG15_DespotischLeider_3_mean 
    LG15_DespotischLeider_4_mean LG15_DespotischLeider_5_mean LG15_DespotischLeider_6_mean
  /MISSING LISTWISE 
  /ANALYSIS LG15_DespotischLeider_1_mean LG15_DespotischLeider_2_mean LG15_DespotischLeider_3_mean 
    LG15_DespotischLeider_4_mean LG15_DespotischLeider_5_mean LG15_DespotischLeider_6_mean
  /PRINT INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.30)
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /CRITERIA ITERATE(25) DELTA(0)
  /ROTATION OBLIMIN
  /METHOD=CORRELATION.

DATASET ACTIVATE IEMerged_4attentionchecksGoed.
FACTOR
  /VARIABLES MW5_SelfConceptClar_1 MW5_SelfConceptClar_2 MW5_SelfConceptClar_3 
    MW5_SelfConceptClar_4 MW5_SelfConceptClar_5 MW5_SelfConceptClar_6 MW5_SelfConceptClar_7 
    MW5_SelfConceptClar_8 MW5_SelfConceptClar_9 MW5_SelfConceptClar_10 MW5_SelfConceptClar_11 
    MW5_SelfConceptClar_12 MW9_PsychSafety_1 MW9_PsychSafety_2 MW9_PsychSafety_3 MW9_PsychSafety_4 
    MW9_PsychSafety_5 MW9_PsychSafety_6 MW9_PsychSafety_7 MW4_UBOS_1 MW4_UBOS_2 MW4_UBOS_3 MW4_UBOS_4 
    MW4_UBOS_5 MW4_UBOS_6 MW4_UBOS_7 MW4_UBOS_8 MW4_UBOS_9 MW4_UBOS_10 MW4_UBOS_11 MW4_UBOS_12 
    MW4_UBOS_13 MW4_UBOS_14 MW4_UBOS_15
  /MISSING LISTWISE 
  /ANALYSIS MW5_SelfConceptClar_1 MW5_SelfConceptClar_2 MW5_SelfConceptClar_3 MW5_SelfConceptClar_4 
    MW5_SelfConceptClar_5 MW5_SelfConceptClar_6 MW5_SelfConceptClar_7 MW5_SelfConceptClar_8 
    MW5_SelfConceptClar_9 MW5_SelfConceptClar_10 MW5_SelfConceptClar_11 MW5_SelfConceptClar_12 
    MW9_PsychSafety_1 MW9_PsychSafety_2 MW9_PsychSafety_3 MW9_PsychSafety_4 MW9_PsychSafety_5 
    MW9_PsychSafety_6 MW9_PsychSafety_7 MW4_UBOS_1 MW4_UBOS_2 MW4_UBOS_3 MW4_UBOS_4 MW4_UBOS_5 
    MW4_UBOS_6 MW4_UBOS_7 MW4_UBOS_8 MW4_UBOS_9 MW4_UBOS_10 MW4_UBOS_11 MW4_UBOS_12 MW4_UBOS_13 
    MW4_UBOS_14 MW4_UBOS_15
  /PRINT INITIAL KMO EXTRACTION ROTATION
  /FORMAT BLANK(.30)
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /CRITERIA ITERATE(25) DELTA(0)
  /ROTATION OBLIMIN
  /METHOD=CORRELATION.

*reliability analysis DL* 

DATASET ACTIVATE IEMerged_4attentionchecksGoed_LeiderAggregate.
RELIABILITY
  /VARIABLES=LG15_DespotischLeider_1_mean LG15_DespotischLeider_2_mean LG15_DespotischLeider_3_mean 
    LG15_DespotischLeider_4_mean LG15_DespotischLeider_5_mean LG15_DespotischLeider_6_mean
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE
  /SUMMARY=TOTAL.

*recoding variables* 

DATASET ACTIVATE IEMerged_4attentionchecksGoed.
COMPUTE R_MW5_SelfConceptClar_1=6 - MW5_SelfConceptClar_1.
VARIABLE LABELS  R_MW5_SelfConceptClar_1 'COMPUTE R_MW5_SelfConceptClar_1=6 - '+
    'MW5_SelfConceptClar_1'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_2=6 - MW5_SelfConceptClar_2.
VARIABLE LABELS  R_MW5_SelfConceptClar_2 'COMPUTE R_MW5_SelfConceptClar_2=6 - '+
    'MW5_SelfConceptClar_2'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_3=6 - MW5_SelfConceptClar_3.
VARIABLE LABELS  R_MW5_SelfConceptClar_3 'COMPUTE R_MW5_SelfConceptClar_3=6 - '+
    'MW5_SelfConceptClar_3'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_4=6 - MW5_SelfConceptClar_4.
VARIABLE LABELS  R_MW5_SelfConceptClar_4 'COMPUTE R_MW5_SelfConceptClar_4=6 - '+
    'MW5_SelfConceptClar_4'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_5=6 - MW5_SelfConceptClar_5.
VARIABLE LABELS  R_MW5_SelfConceptClar_5 'COMPUTE R_MW5_SelfConceptClar_5=6 - '+
    'MW5_SelfConceptClar_5'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_6=6 - MW5_SelfConceptClar_6.
VARIABLE LABELS  R_MW5_SelfConceptClar_6 'COMPUTE R_MW5_SelfConceptClar_6=6 - '+
    'MW5_SelfConceptClar_6'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_7=6 - MW5_SelfConceptClar_7.
VARIABLE LABELS  R_MW5_SelfConceptClar_7 'COMPUTE R_MW5_SelfConceptClar_7=6 - '+
    'MW5_SelfConceptClar_7'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_8=6 - MW5_SelfConceptClar_8.
VARIABLE LABELS  R_MW5_SelfConceptClar_8 'COMPUTE R_MW5_SelfConceptClar_8=6 - '+
    'MW5_SelfConceptClar_8'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_9=6 - MW5_SelfConceptClar_9.
VARIABLE LABELS  R_MW5_SelfConceptClar_9 'COMPUTE R_MW5_SelfConceptClar_9=6 - '+
    'MW5_SelfConceptClar_9'.
EXECUTE.

COMPUTE R_MW5_SelfConceptClar_10=6 - MW5_SelfConceptClar_10.
VARIABLE LABELS  R_MW5_SelfConceptClar_10 'COMPUTE R_MW5_SelfConceptClar_10=6 - '+
    'MW5_SelfConceptClar_10'.
EXECUTE.

COMPUTE R_MW9_PsychSafety_1=6-MW9_PsychSafety_1.
VARIABLE LABELS  R_MW9_PsychSafety_1 'COMPUTE R_MW9_PsychSafety_1=6-MW9_PsychSafety_1'.
EXECUTE.

COMPUTE R_MW9_PsychSafety_3=6-MW9_PsychSafety_3.
VARIABLE LABELS  R_MW9_PsychSafety_3 'COMPUTE R_MW9_PsychSafety_3=6-MW9_PsychSafety_3'.
EXECUTE.

COMPUTE R_MW9_PsychSafety_5=6-MW9_PsychSafety_5.
VARIABLE LABELS  R_MW9_PsychSafety_5 'COMPUTE R_MW9_PsychSafety_5=6-MW9_PsychSafety_5'.
EXECUTE.



COMPUTE R_MW4_UBOS_1=8-MW4_UBOS_1.
VARIABLE LABELS  R_MW4_UBOS_1 'COMPUTE R_MW4_UBOS_1=8-MW4_UBOS_1'.
EXECUTE.

COMPUTE R_MW4_UBOS_2=8-MW4_UBOS_2.
VARIABLE LABELS  R_MW4_UBOS_2 'COMPUTE R_MW4_UBOS_2=8-MW4_UBOS_2'.
EXECUTE.

COMPUTE R_MW4_UBOS_3=8-MW4_UBOS_3.
VARIABLE LABELS  R_MW4_UBOS_3 'COMPUTE R_MW4_UBOS_3=8-MW4_UBOS_3'.
EXECUTE.

COMPUTE R_MW4_UBOS_4=8-MW4_UBOS_4.
VARIABLE LABELS  R_MW4_UBOS_4 'COMPUTE R_MW4_UBOS_4=8-MW4_UBOS_4'.
EXECUTE.

COMPUTE R_MW4_UBOS_5=8-MW4_UBOS_5.
VARIABLE LABELS  R_MW4_UBOS_5 'COMPUTE R_MW4_UBOS_5=8-MW4_UBOS_5'.
EXECUTE.

COMPUTE R_MW4_UBOS_6=8-MW4_UBOS_6.
VARIABLE LABELS  R_MW4_UBOS_6 'COMPUTE R_MW4_UBOS_6=8-MW4_UBOS_6'.
EXECUTE.

*reliability analysis other 3 variables* 

RELIABILITY
  /VARIABLES=R_MW5_SelfConceptClar_1 R_MW5_SelfConceptClar_2 R_MW5_SelfConceptClar_3 
    R_MW5_SelfConceptClar_4 R_MW5_SelfConceptClar_5 R_MW5_SelfConceptClar_6 R_MW5_SelfConceptClar_7 
    R_MW5_SelfConceptClar_8 R_MW5_SelfConceptClar_9 R_MW5_SelfConceptClar_10 MW5_SelfConceptClar_11 
    MW5_SelfConceptClar_12
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=R_MW9_PsychSafety_1 MW9_PsychSafety_2 R_MW9_PsychSafety_3 MW9_PsychSafety_4 
    R_MW9_PsychSafety_5 MW9_PsychSafety_6 MW9_PsychSafety_7
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE
  /SUMMARY=TOTAL.

RELIABILITY
  /VARIABLES=R_MW4_UBOS_1 R_MW4_UBOS_2 R_MW4_UBOS_3 R_MW4_UBOS_4 R_MW4_UBOS_5 R_MW4_UBOS_6 
    MW4_UBOS_7 MW4_UBOS_8 MW4_UBOS_9 MW4_UBOS_10 MW4_UBOS_11 MW4_UBOS_12 MW4_UBOS_13 MW4_UBOS_14 
    MW4_UBOS_15
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=DESCRIPTIVE
  /SUMMARY=TOTAL.

*Computing variables*

COMPUTE SCC=MEAN(R_MW5_SelfConceptClar_1 to R_MW5_SelfConceptClar_10, MW5_SelfConceptClar_11, 
    MW5_SelfConceptClar_12).
VARIABLE LABELS  SCC 'COMPUTE SCC=MEAN(R_MW5_SelfConceptClar_1 to R_MW5_SelfConceptClar_10, '+
    'MW5_SelfConceptClar_11, MW5_SelfConceptClar_12)'.
EXECUTE.

COMPUTE PsychSaf=MEAN(R_MW9_PsychSafety_1, MW9_PsychSafety_2, R_MW9_PsychSafety_3, 
    MW9_PsychSafety_4, R_MW9_PsychSafety_5, MW9_PsychSafety_6, MW9_PsychSafety_7).
VARIABLE LABELS  PsychSaf 'COMPUTE PsychSaf=MEAN(R_MW9_PsychSafety_1, MW9_PsychSafety_2, '+
    'R_MW9_PsychSafety_3, MW9_PsychSafety_4, R_MW9_PsychSafety_5, MW9_PsychSafety_6, '+
    'MW9_PsychSafety_7)'.
EXECUTE.

COMPUTE Burnout=MEAN(R_MW4_UBOS_1 to R_MW4_UBOS_6, MW4_UBOS_7 to MW4_UBOS_15).
VARIABLE LABELS  Burnout 'COMPUTE Burnout=MEAN(R_MW4_UBOS_1 to R_MW4_UBOS_6, MW4_UBOS_7 to '+
    'MW4_UBOS_15)'.
EXECUTE.

COMPUTE DespLeid=MEAN(LG15_DespotischLeider_1 to LG15_DespotischLeider_6).
VARIABLE LABELS  DespLeid 'COMPUTE DespLeid=MEAN(LG15_DespotischLeider_1 to '+
    'LG15_DespotischLeider_6)'.
EXECUTE.

*correlation table all variables*

CORRELATIONS
  /VARIABLES=DespLeid SCC PsychSaf Burnout
  /PRINT=TWOTAIL NOSIG LOWER
  /STATISTICS DESCRIPTIVES
  /MISSING=LISTWISE.

*checking linear regression assumptions* 

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS BCOV R ANOVA COLLIN TOL CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT Burnout
  /METHOD=ENTER DespLeid SCC PsychSaf
  /SCATTERPLOT=(*ZRESID ,*ZPRED)
  /RESIDUALS DURBIN
  /CASEWISE PLOT(ZRESID) OUTLIERS(3.3)
  /SAVE PRED ZPRED COOK RESID ZRESID.




