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
* loop((ttot, all_regi)$(p43_upboundICE(ttot, all_regi) gt 0),
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

*** EOF ./modules/43_stakepol/DIPOL/bounds.gms
