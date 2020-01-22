*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL.gms


*' @description Technology policy components that refer to the DIPOL scenario
*' framework. It only sets policies specifically for EUR.
*'
*' @limitations This realization is still work in progress


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/43_stakepol/DIPOL/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/43_stakepol/DIPOL/declarations.gms"
$Ifi "%phase%" == "datainput" $include "./modules/43_stakepol/DIPOL/datainput.gms"
$Ifi "%phase%" == "equations" $include "./modules/43_stakepol/DIPOL/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/43_stakepol/DIPOL/preloop.gms"
$Ifi "%phase%" == "bounds" $include "./modules/43_stakepol/DIPOL/bounds.gms"
$Ifi "%phase%" == "presolve" $include "./modules/43_stakepol/DIPOL/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/43_stakepol/DIPOL/solve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/43_stakepol/DIPOL/postsolve.gms"
$Ifi "%phase%" == "output" $include "./modules/43_stakepol/DIPOL/output.gms"
*######################## R SECTION END (PHASES) ###############################
*** EOF ./modules/43_stakepol/DIPOL.gms
