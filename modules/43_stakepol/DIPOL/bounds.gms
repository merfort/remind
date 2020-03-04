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

*LM* exogenously set upper bound for CES function for transport (switch behavioral change in transport).
*** Values are taken from an Budg600 run.
if((cm_boundsCEStrans eq 1) OR (cm_boundsCEStrans eq 2),
*** transport fuel use (subgroup of entrp)
	vm_cesIO.up("2020","EUR","fetf") = 1.298023906;
	vm_cesIO.up("2025","EUR","fetf") = 1.449570415;
	vm_cesIO.up("2030","EUR","fetf") = 1.525844015;
	vm_cesIO.up("2035","EUR","fetf") = 1.413794361;
	vm_cesIO.up("2040","EUR","fetf") = 1.504648332;
	vm_cesIO.up("2045","EUR","fetf") = 1.500495635;
	vm_cesIO.up("2050","EUR","fetf") = 1.457268734;
	vm_cesIO.up("2055","EUR","fetf") = 1.358097601;
	vm_cesIO.up("2060","EUR","fetf") = 1.302812664;
	vm_cesIO.up("2070","EUR","fetf") = 1.368901607;
	vm_cesIO.up("2080","EUR","fetf") = 1.185378076;
	vm_cesIO.up("2090","EUR","fetf") = 1.21928914;
	vm_cesIO.up("2100","EUR","fetf") = 1.118681628;

*** transport heavy duty vehicels (subgroup of fetf)
	vm_cesIO.up("2020","EUR","ueHDVt") = 0.194881074;
	vm_cesIO.up("2025","EUR","ueHDVt") = 0.197059844;
	vm_cesIO.up("2030","EUR","ueHDVt") = 0.198488316;
	vm_cesIO.up("2035","EUR","ueHDVt") = 0.198316701;
	vm_cesIO.up("2040","EUR","ueHDVt") = 0.201517993;
	vm_cesIO.up("2045","EUR","ueHDVt") = 0.204449702;
	vm_cesIO.up("2050","EUR","ueHDVt") = 0.211714648;
	vm_cesIO.up("2055","EUR","ueHDVt") = 0.224490971;
	vm_cesIO.up("2060","EUR","ueHDVt") = 0.234867716;
	vm_cesIO.up("2070","EUR","ueHDVt") = 0.24750735;
	vm_cesIO.up("2080","EUR","ueHDVt") = 0.244107004;
	vm_cesIO.up("2090","EUR","ueHDVt") = 0.262465909;
	vm_cesIO.up("2100","EUR","ueHDVt") = 0.268800434;

*** transport light duty vehicels (subgroup of fetf)
	vm_cesIO.up("2020","EUR","ueLDVt") = 0.32774657;
	vm_cesIO.up("2025","EUR","ueLDVt") = 0.328240348;
	vm_cesIO.up("2030","EUR","ueLDVt") = 0.334670597;
	vm_cesIO.up("2035","EUR","ueLDVt") = 0.340207281;
	vm_cesIO.up("2040","EUR","ueLDVt") = 0.342017892;
	vm_cesIO.up("2045","EUR","ueLDVt") = 0.361151884;
	vm_cesIO.up("2050","EUR","ueLDVt") = 0.379883162;
	vm_cesIO.up("2055","EUR","ueLDVt") = 0.377838917;
	vm_cesIO.up("2060","EUR","ueLDVt") = 0.370941238;
	vm_cesIO.up("2070","EUR","ueLDVt") = 0.355476704;
	vm_cesIO.up("2080","EUR","ueLDVt") = 0.381187995;
	vm_cesIO.up("2090","EUR","ueLDVt") = 0.343283603;
	vm_cesIO.up("2100","EUR","ueLDVt") = 0.356838413;

*** transport electric trains (subgroup of entrp)
	vm_cesIO.up("2020","EUR","ueelTt") = 0.008428868;
	vm_cesIO.up("2025","EUR","ueelTt") = 0.011329031;
	vm_cesIO.up("2030","EUR","ueelTt") = 0.014101972;
	vm_cesIO.up("2035","EUR","ueelTt") = 0.015769;
	vm_cesIO.up("2040","EUR","ueelTt") = 0.016730254;
	vm_cesIO.up("2045","EUR","ueelTt") = 0.017137472;
	vm_cesIO.up("2050","EUR","ueelTt") = 0.017597443;
	vm_cesIO.up("2055","EUR","ueelTt") = 0.018699165;
	vm_cesIO.up("2060","EUR","ueelTt") = 0.019388202;
	vm_cesIO.up("2070","EUR","ueelTt") = 0.019734166;
	vm_cesIO.up("2080","EUR","ueelTt") = 0.019560973;
	vm_cesIO.up("2090","EUR","ueelTt") = 0.022404498;
	vm_cesIO.up("2100","EUR","ueelTt") = 0.026208872;
);

*** scenario with even lower upper ces for transport
if(cm_boundsCEStrans eq 2,
	vm_cesIO.up(t,"EUR","fetf") = 0.9 * vm_cesIO.up(t,"EUR","fetf");
);



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


*** EOF ./modules/43_stakepol/DIPOL/bounds.gms
