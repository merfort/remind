*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/equations.gms

*LM* Calculate costs for subsidies for given technologies
q43_costSubsidizePolicy(ttot,regi)$(ttot.val ge max(2010,cm_startyear))..
    vm_costSubsidizePolicy(ttot,regi)
    =e=
    sum(teLearn,
	   pm_subsidies_teLearn(ttot,regi,teLearn) * sum(te2rlf(teLearn,rlf), vm_deltaCap(ttot,regi,teLearn,rlf))
    )
; 

*** EOF ./modules/43_stakepol/DIPOL/equations.gms
