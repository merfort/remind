*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/40_techpol/DIPOL/declarations.gms


*** ---------------------------------------------------------------------------
*** *LM* Include declarations.gms from the NDC2018 realization. All policies
*** from DIPOL will therefore add to those from NDC2018 afterwards.
*** For Baseline scenarios a switch can be activated to exclude the NDC2018
*** content
*** ---------------------------------------------------------------------------
$if %cm_DIPOL_only% == "off" $include "./modules/40_techpol/NDC2018/declarations.gms"

*** EOF ./modules/40_techpol/DIPOL/declarations.gms


