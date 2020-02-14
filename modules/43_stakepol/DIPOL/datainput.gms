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

*LM* Fill parameter pm_subsidies_teLearn to subsidize certain learning technologies
*** for a given set of period-region combinations. The period is defined by a start 
*** year and an end year (ttot to ttot2, bounds included).
$ifThen.subsidies_teLearn not "%cm_subsidies_teLearn%" == "off"
loop((ttot,ttot2,regi, teLearn)$p43_subsidies_teLearn(ttot, ttot2, regi, teLearn),
	loop(ttot3$((ttot3.val ge ttot.val) AND (ttot3.val le ttot2.val)),
        pm_subsidies_teLearn(ttot3, regi, teLearn) = p43_subsidies_teLearn(ttot, ttot2, regi, teLearn);
	);
);
display pm_subsidies_teLearn;

* Convert from $2015 to $2005 and from $/kW to T$/TW
pm_subsidies_teLearn(ttot, regi, te) = sm_D2015_2_D2005 * pm_subsidies_teLearn(ttot, regi, te);
pm_subsidies_teLearn(ttot, regi, te) = sm_DpKW_2_TDpTW * pm_subsidies_teLearn(ttot, regi, te);
display pm_subsidies_teLearn;

$else.subsidies_teLearn
* Initialize to zero if switch is turned off
pm_subsidies_teLearn(ttot, regi, te) = 0;
$endIf.subsidies_teLearn

*** EOF ./modules/43_stakepol/DIPOL/datainput.gms