*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/40_techpol/DIPOL/datainput.gms 


*** ---------------------------------------------------------------------------
*** *LM* Include content from another realization. All policies from DIPOL will
*** therefore add to those from the other realization. The default setting adds
*** the NDC2018 realization. For baseline scenarios, the switch can be
*** deactivated
*** ---------------------------------------------------------------------------
$if %cm_DIPOL_addRealization% == "NDC2018" $include "./modules/40_techpol/NDC2018/datainput.gms"
$if %cm_DIPOL_addRealization% == "NPi2018" $include "./modules/40_techpol/NPi2018/datainput.gms"

*** EOF ./modules/40_techpol/DIPOL/datainput.gms


