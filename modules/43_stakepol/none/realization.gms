*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/none.gms


*' @description This realization turns off the module.


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "sets" $include "./modules/43_stakepol/none/sets.gms"
$Ifi "%phase%" == "declarations" $include "./modules/43_stakepol/none/declarations.gms"
$Ifi "%phase%" == "datainput" $include "./modules/43_stakepol/none/datainput.gms"
$Ifi "%phase%" == "equations" $include "./modules/43_stakepol/none/equations.gms"
$Ifi "%phase%" == "preloop" $include "./modules/43_stakepol/none/preloop.gms"
$Ifi "%phase%" == "bounds" $include "./modules/43_stakepol/none/bounds.gms"
$Ifi "%phase%" == "presolve" $include "./modules/43_stakepol/none/presolve.gms"
$Ifi "%phase%" == "solve" $include "./modules/43_stakepol/none/solve.gms"
$Ifi "%phase%" == "postsolve" $include "./modules/43_stakepol/none/postsolve.gms"
$Ifi "%phase%" == "output" $include "./modules/43_stakepol/none/output.gms"
*######################## R SECTION END (PHASES) ###############################
*** EOF ./modules/43_stakepol/none.gms
