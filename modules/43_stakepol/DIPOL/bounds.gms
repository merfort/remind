*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/bounds.gms

*** ---------------------------------------------------------------------------
*** Set bounds for transport sector
*** ---------------------------------------------------------------------------

*LM* Regulatory law setting an upper bound to ICE for given region(s) and start year(s)
*** according to switch.
$ifThen.upboundICE not "%cm_upboundICE%" == "off"
loop((ttot, all_regi)$t_regi_upboundICE_43(ttot, all_regi),
	loop(t$(t.val ge ttot.val),
		vm_shUePeT.up(t,all_regi,"apCarPeT") = p43_upboundICE(ttot,all_regi);
	);
);
$endIf.upboundICE

*LM* Set lower bounds for tdh2t in EUR between 2020 and 2050 if switch is activated.
*** Values are taken from a Budg600 run
if (cm_bounds_tdh2t_EUR eq 1,
	vm_cap.lo("2020","EUR","tdh2t","1") = 0.00011;
	vm_cap.lo("2025","EUR","tdh2t","1") = 0.00169;
	vm_cap.lo("2030","EUR","tdh2t","1") = 0.00690;
	vm_cap.lo("2035","EUR","tdh2t","1") = 0.01612;
	vm_cap.lo("2040","EUR","tdh2t","1") = 0.02642;
	vm_cap.lo("2045","EUR","tdh2t","1") = 0.03504;
	vm_cap.lo("2050","EUR","tdh2t","1") = 0.03937;
);

*LM* Set lower bounds for tdelt in EUR between 2020 and 2050 if switch is activated.
*** Values are taken from a Budg600 run
if (cm_bounds_tdelt_EUR eq 1,
	vm_cap.lo("2020","EUR","tdelt","1") = 0.01561892;
	vm_cap.lo("2025","EUR","tdelt","1") = 0.02904888;
	vm_cap.lo("2030","EUR","tdelt","1") = 0.05347430;
	vm_cap.lo("2035","EUR","tdelt","1") = 0.08916937;
	vm_cap.lo("2040","EUR","tdelt","1") = 0.13165252;
	vm_cap.lo("2045","EUR","tdelt","1") = 0.16665672;
	vm_cap.lo("2050","EUR","tdelt","1") = 0.18292249;
);

*LM* Switch off biomass import for a given region(s)
$ifThen.regiNoBioImport not "%cm_regiNoBioImport%" == "none"
vm_Mport.fx(t,regiNoBioImport_43,"pebiolc") = 0;
$endIf.regiNoBioImport



*** ---------------------------------------------------------------------------
*** Set bounds for buildings sector
*** ---------------------------------------------------------------------------
*LM* Exogenously fade out fossils in buildings
$ifThen.regiPhaseOutFosBuil not "%cm_regiPhaseOutFosBuil%" == "none"
vm_cesIO.up("2040", regiPhaseOutFosBuil_43, "fegab")                    = 0.10;
vm_cesIO.up("2045", regiPhaseOutFosBuil_43, "fegab")                    = 0.05;
vm_cesIO.up(ttot,   regiPhaseOutFosBuil_43, "fegab")$(ttot.val ge 2050) = 1e-6;

vm_cesIO.up("2040", regiPhaseOutFosBuil_43, "fehob")                    = 0.04;
vm_cesIO.up("2045", regiPhaseOutFosBuil_43, "fehob")                    = 0.02;
vm_cesIO.up(ttot,   regiPhaseOutFosBuil_43, "fehob")$(ttot.val ge 2050) = 1e-6;

* vm_cesIO.up(ttot,   regiPhaseOutFosBuil_43, "fesob")$(ttot.val ge 2040) = 1e-6;
$endIf.regiPhaseOutFosBuil



*** ---------------------------------------------------------------------------
*** Set other bounds
*** ---------------------------------------------------------------------------
*FIXME: EUR is hardcoded
*FIXME: sm_ccsinjecrate needs to be regional, otherwise v21_taxrevCCS will be wrong
*FIMME: potentially c_ccsinjecratescen -> cm_ccsinjecratescen
*LM* set low CCS injection rate for EUR
if(c_ccsinjecratescen eq 6,
	vm_co2CCS.up(t,regi, "cco2","ico2","ccsinje","1") = pm_dataccs(regi, "quan","1") * sm_ccsinjecrate;
	vm_co2CCS.up(t,"EUR","cco2","ico2","ccsinje","1") = pm_dataccs("EUR","quan","1") * sm_ccsinjecrate*0.2; 
);

*FIXME: EUR is hardcoded
*LM* Set bounds on bioenergy production in EUR; overwrites values from 30_biomass/magpie_40 realization (cf. there for further information)
if(cm_bioenergymaxscen eq 5,
	vm_fuExtr.up(t,regi, "pebiolc","1") = 3.2 + pm_pedem_res(t,regi, "biotr"); !! 3.2 TWa; just a very high number that is not crossed, equal to 100EJ (for each region)
	vm_fuExtr.up(t,"EUR","pebiolc","1") = 0.2 + pm_pedem_res(t,"EUR","biotr"); !! 0.2 TWa; equal to ~6.3 EJ (value estimated from a run with cm_bioenergymaxscen = 1)
);
if(cm_bioenergymaxscen eq 6,
	vm_fuExtr.up(t,regi, "pebiolc","1") = 3.2 + pm_pedem_res(t,regi, "biotr"); !! 3.2 TWa; just a very high number that is not crossed, equal to 100EJ (for each region)
	vm_fuExtr.up(t,"EUR","pebiolc","1") = 0 + pm_pedem_res(t,"EUR","biotr");   !! no purpose grown biomass in EUR
);


*** EOF ./modules/43_stakepol/DIPOL/bounds.gms
