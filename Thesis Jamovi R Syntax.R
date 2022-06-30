*model 1, main effects)*

gamlj::gamljMixed(
  formula = Burnout ~ 1 + DespLeid + SCC + PsychSaf+( 1 | LG ),
  data = data)

*model 2, interaction effects + simple slopes*

gamlj::gamljMixed(
  formula = Burnout ~ 1 + DespLeid + SCC + PsychSaf + DespLeid:SCC + SCC:PsychSaf + DespLeid:PsychSaf+( 1 | LG ),
  data = data,
  plotHAxis = PsychSaf,
  plotSepLines = SCC,
  simpleVariable = PsychSaf,
  simpleModerator = SCC)

*model 3 threeway interaction*
  
gamlj::gamljMixed(
  formula = Burnout ~ 1 + DespLeid + SCC + PsychSaf + DespLeid:SCC + SCC:PsychSaf + DespLeid:PsychSaf + DespLeid:SCC:PsychSaf+( 1 | LG ),
  data = data)