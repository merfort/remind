*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/40_techpol/DIPOL/bounds.gms 

*LM* Include bounds.gms from the NDC2018 realization. All policies from DIPOL will therefore add to those
*** from NDC2018 afterwards
$include "./modules/40_techpol/NDC2018/bounds.gms"


display "test*LM*2020-01-07 DIPOL bounds";

*** vm_cap.lo(t,regi,"spv","1") = p40_TechBound(t,regi,"spv")*0.001; 

*** EOF ./modules/40_techpol/DIPOL/bounds.gms
