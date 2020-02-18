*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/presolve.gms

*LM* update values for next iteration. For non-optimal regions, keep last iterations value (same structure as in 22_subsidizeLearning)
p43_deltacap0(ttot,regi,te,rlf)$( (ttot.val ge 2005) and (pm_SolNonInfes(regi) eq 1)) = vm_deltaCap.l(ttot,regi,te,rlf);

*** EOF ./modules/43_stakepol/DIPOL/presolve.gms

