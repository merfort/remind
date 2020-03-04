*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/sets.gms

*LM* Define region sets according to switches
Sets
$ifThen.regiNoBioImport not "%cm_regiNoBioImport%" == "none"
    regiNoBioImport_43(all_regi)     "Set of regions that do not import biomass" / %cm_regiNoBioImport% /
$endIf.regiNoBioImport
$ifThen.regiPhaseOutFosBuil not "%cm_regiPhaseOutFosBuil%" == "none"
    regiPhaseOutFosBuil_43(all_regi) "Set of regions that phase out fossils in buildings" / %cm_regiPhaseOutFosBuil% /
$endIf.regiPhaseOutFosBuil
;

*** EOF ./modules/43_stakepol/DIPOL/sets.gms