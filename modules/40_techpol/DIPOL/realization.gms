*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de


*' @description Technology policy components that refer to the DIPOL scenario framework. 
*' It only sets policies specifically for EUR. In module.gms it is defined that this realization
*' also loads 
*' 
*' @limitations This realization is still work in progress


*####################### R SECTION START (PHASES) ##############################
$Ifi "%phase%" == "declarations" $include "./modules/40_techpol/DIPOL/declarations.gms"
$Ifi "%phase%" == "datainput" $include "./modules/40_techpol/DIPOL/datainput.gms"
$Ifi "%phase%" == "equations" $include "./modules/40_techpol/DIPOL/equations.gms"
$Ifi "%phase%" == "bounds" $include "./modules/40_techpol/DIPOL/bounds.gms"
*######################## R SECTION END (PHASES) ###############################
