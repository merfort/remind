*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/datainput.gms

*** ---------------------------------------------------------------------------
*** Data for transport sector
*** ---------------------------------------------------------------------------

*LM* Fill parameter pm_subsidies_te to subsidize certain technologies for a given set of
*** period-region combinations. The period is defined by a start year and an end year
*** (ttot to ttot2, bounds included).
$ifThen.subsidies_te not "%cm_subsidies_te%" == "off"
loop((ttot,ttot2,regi, te)$p43_subsidies_te(ttot, ttot2, regi, te),
	loop(ttot3$((ttot3.val ge ttot.val) AND (ttot3.val le ttot2.val)),
        pm_subsidies_te(ttot3, regi, te) = p43_subsidies_te(ttot, ttot2, regi, te);
	);
);
display pm_subsidies_te;

*** Convert from $2015 to $2005 and from $/kW to T$/TW
pm_subsidies_te(ttot, regi, te) = sm_D2015_2_D2005 * pm_subsidies_te(ttot, regi, te);
pm_subsidies_te(ttot, regi, te) = sm_DpKW_2_TDpTW * pm_subsidies_te(ttot, regi, te);
display pm_subsidies_te;

$else.subsidies_te
*** Initialize to zero if switch is turned off
pm_subsidies_te(ttot, regi, te) = 0;
$endIf.subsidies_te

*LM* Initialize parameter that saves the capacity additions from the last iteration to zero
p43_deltacap0(ttot,regi,te,rlf) = 0;

*** EOF ./modules/43_stakepol/DIPOL/datainput.gms