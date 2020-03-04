*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/43_stakepol/DIPOL/declarations.gms

equations
    q43_costSubsidizePolicy(ttot,all_regi)              "Subsidy for technologies explicitely introduced by a policy - total"
;

parameters
    p43_deltacap0(ttot,all_regi,all_te,rlf)             "deltacap from last iteration"
;

*LM* Define parameter to read subsidies directly from the config file. The first entry defines
*** the starting year and the second the last year in which the given technology is subsidized
*** in the given region.
$ifThen.subsidies_te not "%cm_subsidies_te%" == "off"
Parameter
    p43_subsidies_te(ttot, tall, all_regi, all_te) "auxiliary parameter to read in subsidies for a given technology. [$(2015)/kW]" / %cm_subsidies_te% /
;
$endIf.subsidies_te

*LM* Define parameter and set to set an upper bound to ICE vehicles
$ifThen.upboundICE not "%cm_upboundICE%" == "off"
Parameter
	p43_upboundICE(ttot, all_regi)                      "upper bound for ICE share [%]" / %cm_upboundICE% /
;



*LM* Definine a set that contains all combinations of regions and time steps on which an upper bound on ICE
*** share should be applied. This set has to be defined dynamically since it is dependent on the read-in
*** parameter p43_upboundICE. It is needed to allow for having the value "0" in p43_upboundICE. Without this
*** "trick" a "0" in p43_upboundICE would disable the bound instead setting it to the number "0".
*** In order to have exactly the value "0", use a number smaller than 0.00011 for cm_upboundICE in the config.
set t_regi_upboundICE_43(ttot, all_regi) "time-region combinations that get an upper bound to ICE share";

*LM* Fill the set according to read-in parameter p43_upboundICE
loop(t,
    loop(regi,
        t_regi_upboundICE_43(t, regi)$p43_upboundICE(t, regi) = YES;
	);
);

*LM* Set all values that are close to zero directly to zero.
p43_upboundICE(t_regi_upboundICE_43)$(p43_upboundICE(t_regi_upboundICE_43) < 0.0011) = 0;
$endIf.upboundICE

*** EOF ./modules/43_stakepol/DIPOL/declarations.gms