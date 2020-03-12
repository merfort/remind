*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/45_carbonprice/exogenous/datainput.gms
***----------------------------
*** CO2 Tax level
***----------------------------

*** Include exogenous tax level
if((cm_emiscen eq 9),

$ifthen "%cm_DIPOL_exoCO2tax%" == "off"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S1"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S1_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S2"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S2_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S3"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S3_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S4"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S4_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S5"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S5_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S6"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S6_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "1300S7"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S7_PkBudg1300.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S1"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S1_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S2"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S2_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S3"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S3_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S4"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S4_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S5"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S5_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S6"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S6_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "900S7"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S7_PkBudg900.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS1"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S1_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS2"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S2_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS3"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S3_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS4"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S4_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS5"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S5_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS6"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S6_NDC.inc"
$elseif "%cm_DIPOL_exoCO2tax%" == "NDCS7"
$include "./modules/45_carbonprice/exogenous/input/p45_tau_co2_tax_S7_NDC.inc"
$endif

pm_taxCO2eq(ttot,regi)$(ttot.val ge 2005) = p45_tau_co2_tax(ttot,regi);

else
pm_taxCO2eq(ttot,regi)$(ttot.val ge 2005) = 0;
abort "Error: Please set cm_emiscen to 9";
);


*** EOF ./modules/45_carbonprice/exogenous/datainput.gms
