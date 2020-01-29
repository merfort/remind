*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/sets.gms

*LM* Define set of regions that do not import biomass according to switch
$ifThen.regiNoBioImport not "%cm_regiNoBioImport%" == "none"
Set regiNoBioImport_43(all_regi) "Set of regions that do not import biomass" / %cm_regiNoBioImport% /;
$endIf.regiNoBioImport

*** EOF ./modules/43_stakepol/DIPOL/sets.gms