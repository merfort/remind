*** |  (C) 2006-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/36_buildings/simple/equations.gms

***---------------------------------------------------------------------------
*'  Buildings Final Energy Balance
***---------------------------------------------------------------------------
q36_demFeBuild(ttot,regi,entyFe,emiMkt)$((ttot.val ge cm_startyear) AND (entyFe2Sector(entyFe,"build"))) .. 
  sum((entySe,te)$se2fe(entySe,entyFe,te), vm_demFeSector(ttot,regi,entySe,entyFe,"build",emiMkt)) 
  =e=
  ( sum(in$(fe2ppfEn(entyFe,in) AND ppfen_buildings_dyn36(in)),
    vm_cesIO(ttot,regi,in)
    + pm_cesdata(ttot,regi,in,"offset_quantity") 
   )
  )$(sameas(emiMkt,"ES"))
;

***---------------------------------------------------------------------------
*'  Additional hydrogen cost at low penetration level and heat pumps markup
***---------------------------------------------------------------------------
q36_costAddTeInv(t,regi,te)..
  vm_costAddTeInv(t,regi,te,"build")
  =e=
  (
    ( 1 /(
      1 + (3**v36_costExponent(t,regi))
      )
    ) * (
      s36_costAddH2Inv * 8.76
      * (vm_demFeSector(t,regi,"seh2","feh2s","build","ES"))
    )
    + (v36_expSlack(t,regi)*1e-8)
  )$(sameas(te,"tdh2s"))
  +
  ( 
    p36_heatPumpMkup(t,regi)*(vm_cesIO(t,regi,"feelhpb") + pm_cesdata(t,regi,"feelhpb","offset_quantity")) 
  )$(sameas(te,"tdels"))
  +
  ( 
    p36_districtHeatingMkup(t,regi)*(vm_cesIO(t,regi,"feheb") + pm_cesdata(t,regi,"feheb","offset_quantity")) 
  )$(sameas(te,"tdhes"))
;

*' Logistic function exponent for additional hydrogen low penetration cost equation
q36_auxCostAddTeInv(t,regi)..
  v36_costExponent(t,regi)
  =e=
  ( (10/(s36_costDecayEnd-s36_costDecayStart)) * ( (v36_H2share(t,regi)+1e-7) -  ((s36_costDecayEnd+s36_costDecayStart)/2) ) ) - v36_expSlack(t,regi)
;


*' Hydrogen fe share in buildings gases use (natural gas + hydrogen)
q36_H2Share(t,regi)..
  v36_H2share(t,regi) 
  * sum(se2fe(entySe,entyFe,te)$(SAMEAS(entyFe,"feh2s") OR SAMEAS(entyFe,"fegas")),   
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
  =e=
  sum(se2fe(entySe,entyFe,te)$SAMEAS(entyFe,"feh2s"),
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
;

*** calculate district heat share in FE buildings
q36_HeatShare(t,regi)..
  v36_Heatshare(t,regi) 
  * sum(se2fe(entySe,entyFe,te)$( entyFe36(entyFe)),   
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
  =e=
  sum(se2fe(entySe,entyFe,te)$(SAMEAS(entyFe,"fehes")),
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
;

*** calculate electricity share in FE buildings
q36_ElShare(t,regi)..
  v36_Elshare(t,regi) 
  * sum(se2fe(entySe,entyFe,te)$( entyFe36(entyFe)),   
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
  =e=
  sum(se2fe(entySe,entyFe,te)$(SAMEAS(entyFe,"feels")),
      vm_demFeSector(t,regi,entySe,entyFe,"build","ES"))
;

$ifThen.regiPhaseOutFosBuil not "%cm_regiPhaseOutFosBuilSimple%" == "none"
***---------------------------------------------------------------------------
*'  Additional bound on coal in buildings
***---------------------------------------------------------------------------
*** Ensure that the whole demand for solids in buildings can be fulfilled with
*** biomass. This is equivalent to a phase out of coal in buildings, since 
*** secondary energy solids can either come from biomass or coal. This will,
*** however, have the "feedback" effect, that the industry sector uses much 
*** more coal.
q36_coalBoundBuildings (t,regi)$(t.val ge 2050 AND regiPhaseOutFosBuil_36(regi)) ..
    vm_cesIO(t,regi,"fesob")
    =l=  
    vm_prodFE(t,regi,"sesobio","fesos","tdfossos")
;
$endIf.regiPhaseOutFosBuil


*** EOF ./modules/36_buildings/simple/equations.gms
