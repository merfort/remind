*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/30_biomass/exogenous/declarations.gms

parameter

p30_fix_costfu_bio(tall,all_regi)            "exogenous data for _costFuBio"
p30_fix_fuelex(tall,all_regi,all_enty,rlf)   "exogenous data for _fuExtr"

;

*** Define parameter to read in regionally specific bounds on lignocellulosic bioenergy
$ifThen.regiBioenergymax (("%cm_bioenergymaxscen%" == "5") and (not "%cm_regiBioenergymax%" == "off"))
parameter
    p30_regiBioenergymax(all_regi) "auxiliary parameter to read in regionally specific bounds on lignocellulosic bioenergy. [EJ/yr]" / %cm_regiBioenergymax% /
;
$endIf.regiBioenergymax

*** EOF ./modules/30_biomass/exogenous/declarations.gms
