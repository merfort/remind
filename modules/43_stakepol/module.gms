*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/43_stakepol.gms

*' @title stakepol
*'
*' @description  The 43_stakepol module formulates additional technological
*' policies formulated in a stakeholder-interaction process.
*'
*' @authors Leon Merfort

*###################### R SECTION START (MODULETYPES) ##########################
$Ifi "%stakepol%" == "DIPOL" $include "./modules/43_stakepol/DIPOL/realization.gms"
$Ifi "%stakepol%" == "none" $include "./modules/43_stakepol/none/realization.gms"
*###################### R SECTION END (MODULETYPES) ############################
*** EOF ./modules/43_stakepol/43_stakepol.gms
