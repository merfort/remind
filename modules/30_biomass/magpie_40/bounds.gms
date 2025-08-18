*** |  (C) 2006-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/30_biomass/magpie_40/bounds.gms

*' @code{extrapage: "00_model_assumptions"}
*** -------------------------------------------------------------
*'  #### Bounds on 1st generation biomass annual production
*** -------------------------------------------------------------
*' Prescribe upper and lower limit for first generation biomass from 2030 on,
*' so REMIND has some freedom before. After 2030 the production of 1st
*' generation biofuels should be fixed (within a 90-100% range to avoid
*' infeasibilities), since production values are exogenously harmonized with
*' MAgPIE.
*' Note: these bounds need to be updated since they are, in some regions, too
*' strict to be compatible with historically installed capacities, such that
*' the bounds in its current form can only be satisfied in combination with
*' early retirement.
vm_fuExtr.up(t,regi,"pebios","5")$(t.val ge 2030)  = p30_datapebio(regi,"pebios","5","maxprod",t);
vm_fuExtr.up(t,regi,"pebioil","5")$(t.val ge 2030) = p30_datapebio(regi,"pebioil","5","maxprod",t);

if(cm_1stgen_phaseout=0,
    vm_fuExtr.lo(t,regi,"pebios","5")$(t.val ge 2030)  = 0.9 * p30_datapebio(regi,"pebios","5","maxprod",t);
    vm_fuExtr.lo(t,regi,"pebioil","5")$(t.val ge 2030) = 0.9 * p30_datapebio(regi,"pebioil","5","maxprod",t);
else                                                     
    vm_fuExtr.lo(t,regi,"pebios","5")$(t.val eq 2030)  = 0.9 * p30_datapebio(regi,"pebios","5","maxprod",t);
    vm_fuExtr.lo(t,regi,"pebioil","5")$(t.val eq 2030) = 0.9 * p30_datapebio(regi,"pebioil","5","maxprod",t);
);


*** -------------------------------------------------------------
*' #### Bounds on 2nd generation biomass annual production
*** -------------------------------------------------------------

*** In REMIND there are two grades for fuel extraxtion from pebiolc. The first
*** grade is purpose grown bioenergy, the second grade are residues. The
*** residue grade of pebiolc (pebiolc.2) in REMIND is roughly MAgPIE's residue
*** potential (plus some extra demand for traditional biomass, see below).

***-------------------------------------------------------------
*' 1. Bound on residues
*** Already in the initial years there are technologies in REMIND that demand
*** biomass. pm_pedem_res contains the biomass demand as it would evolve if all
*** these biomass technologies that are present in 2005 would phase out (phase-
*** out-trajectory). When calculating the maximal residue potential
*** p30_maxprod_residue we make sure (by applying the max operator) that the
*** resulting residue potential is big enough to feed these technologies so
*** they do not need to demand purpose-grown biomass. This is necessary,
*** because in the early years MAgPIE's residue potential is smaller than the
*** initial demand from REMIND's technologies. Except for "biotr" all
*** technologies present in 2005 are allowed to expand, but the resulting
*** additional demand for biomass (exceeding the phase-out-trajectory) can then
*** be supplied  from purpose-grown biomass.
p30_maxprod_residue(ttot,regi)     = max(p30_datapebio(regi,"pebiolc","2","maxprod",ttot), sum(teBioPebiolc, pm_pedem_res(ttot,regi,teBioPebiolc)));
vm_fuExtr.up(t,regi,"pebiolc","2") = p30_maxprod_residue(t,regi)*1.0001;
*'

***-------------------------------------------------------------
*' 2. Bound on purpose grown biomass
*** The bound on purpose grown biomass is disabled by default, it is only
*** applied according to a switch.
$ifthen.bioenergymaxscen not %cm_maxProdBiolc% == "off"
*** Set bound on global annual pebiolc production and convert from EJ to TWa
p30_max_pebiolc_path_glob(t) = %cm_maxProdBiolc% * sm_EJ_2_TWa;

*** Reduce the global upper bound on purpose grown bio-energy by residues,
*** since the total bound as defined in cm_maxProdBiolc applies to the sum of
*** residues and purpose grown.
p30_max_pebiolc_path_glob(t) = p30_max_pebiolc_path_glob(t) - sum(regi, p30_maxprod_residue(t,regi));
display p30_max_pebiolc_path_glob;

*' Calclate regional bounds with equal marginal costs from global bound
*** (inverting the supply curve)
loop(ttot$(ttot.val ge cm_startyear),
*** initialization
     p30_max_pebiolc_dummy = 0;
     p30_pebiolc_price_dummy = 0.01;
     while(p30_max_pebiolc_dummy < p30_max_pebiolc_path_glob(ttot),
*** Exclude JPN to avoid UNDF in p30_max_pebiolc_dummy
           loop(regi$(NOT sameas(regi,'JPN')),
*** Avoid execution errors for x**y with x<0 by applying the if-clause
                if( p30_pebiolc_price_dummy > (i30_bioen_price_a(ttot,regi)) * 1.01,
                      p30_fuelex_dummy(regi) = (p30_pebiolc_price_dummy - i30_bioen_price_a(ttot,regi)) / i30_bioen_price_b(ttot,regi);
                 else
                      p30_fuelex_dummy(regi) = 0;
                );
           ); 
           p30_max_pebiolc_dummy = sum(regi, p30_fuelex_dummy(regi));
           p30_pebiolc_price_dummy = p30_pebiolc_price_dummy + 0.001;
     );
     p30_max_pebiolc_path(regi,ttot) = p30_fuelex_dummy(regi);
);
display p30_max_pebiolc_path;

*' According to EMF guidelines, the upper bound on total (residues+purpose)
*' global biomass production does not include traditional biomass use. Since
*' the demand for traditional biomass is already supplied by the residue grade
*' we expand the purpose-grown grade by the demand for traditional biomass.
vm_fuExtr.up(t,regi,"pebiolc","1") = p30_max_pebiolc_path(regi,t) + pm_pedem_res(t,regi,"biotr");
$endif.bioenergymaxscen


*** -------------------------------------------------------------
*' #### Phase out capacities of bioenergy technologies that use
*' #### pebiolc as feedstock, if defined in config
*** -------------------------------------------------------------
if (cm_phaseoutBiolc eq 1,
    loop(t$(t.val ge max(2025, cm_startyear)),
        loop(regi,
            loop(te(teBioPebiolc),
                loop(rlf,
                    if(vm_deltaCap.up(t,regi,te,rlf) eq INF,
                       vm_deltaCap.up(t,regi,te,rlf) = 1e-6;
                    );
                );
            );
        );
    );
);

*' @stop

*** FS: limit biomass domestic production from 2035 onwards to regional upper value defined by cm_bioprod_regi_lim
$IFTHEN.bioprod_regi_lim not "%cm_bioprod_regi_lim%" == "off"
loop( ext_regi$(p30_bioprod_regi_lim(ext_regi)),
  loop(regi$regi_groupExt(ext_regi,regi),
    v30_BioPEProdTotal.up(t,regi)$(t.val ge 2035)= p30_bioprod_regi_lim(ext_regi)*sm_EJ_2_TWa
*** distribute across regions in a region group by share in 2005 biomass production as the model is initialized in 2005 with fixed historic production
                                                    * v30_BioPEProdTotal.l("2005",regi) 
                                                    / sum(regi2$regi_groupExt(ext_regi,regi2), 
                                                        v30_BioPEProdTotal.l("2005",regi2));
  );
);
$ENDIF.bioprod_regi_lim

$ifthen.cm_MAgPIE_coupling %cm_MAgPIE_coupling% == "on"
*** Potentially limit jumps betweeen iterations in bioenergy production in the
*** coupling to avoid infeasibilities in MAgPIE by only allowing production
*** that is not too far away from the last iteration. Also make sure that there
*** is always some (region-specific) minimum production allowed.
if(NOT (cm_lim_bio_increase_cpl eq -1),
  !! Upper bounds
  vm_fuExtr.up(t,"CAZ","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"CHA","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"EUR","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"IND","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"JPN","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"LAM","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"MEA","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"NEU","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"OAS","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"REF","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"SSA","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"USA","pebiolc","1")$(t.val le 2030) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 0.1 * sm_EJ_2_TWa);
  
  vm_fuExtr.up(t,"CAZ","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"CHA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"EUR","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"IND","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"JPN","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"LAM","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"MEA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"NEU","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"OAS","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"REF","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"SSA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 0.5 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"USA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 0.5 * sm_EJ_2_TWa);
  
  vm_fuExtr.up(t,"CAZ","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 1.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"CHA","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 5.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"EUR","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 2.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"IND","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 2.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"JPN","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"LAM","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 5.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"MEA","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 1.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"NEU","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 1.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"OAS","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 5.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"REF","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 1.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"SSA","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 3.0 * sm_EJ_2_TWa);
  vm_fuExtr.up(t,"USA","pebiolc","1")$(t.val gt 2050) = max((1 + cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 3.0 * sm_EJ_2_TWa);

  !! Lower bounds
  vm_fuExtr.lo(t,"CAZ","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"CHA","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"EUR","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"IND","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"JPN","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"LAM","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"MEA","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"NEU","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"OAS","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"REF","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"SSA","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"USA","pebiolc","1")$(t.val le 2030) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 0.1 * sm_EJ_2_TWa);

  vm_fuExtr.lo(t,"CAZ","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"CHA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"EUR","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"IND","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"JPN","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"LAM","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"MEA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"NEU","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"OAS","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"REF","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"SSA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"USA","pebiolc","1")$(t.val gt 2030 AND t.val le 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 0.1 * sm_EJ_2_TWa);

  vm_fuExtr.lo(t,"CAZ","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CAZ"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"CHA","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"CHA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"EUR","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"EUR"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"IND","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"IND"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"JPN","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"JPN"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"LAM","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"LAM"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"MEA","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"MEA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"NEU","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"NEU"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"OAS","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"OAS"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"REF","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"REF"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"SSA","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"SSA"), 0.1 * sm_EJ_2_TWa);
  vm_fuExtr.lo(t,"USA","pebiolc","1")$(t.val gt 2050) = max((1 - cm_lim_bio_increase_cpl) * pm_pebiolc_demandmag(t,"USA"), 0.1 * sm_EJ_2_TWa);
);
$endif.cm_MAgPIE_coupling

*** EOF ./modules/30_biomass/magpie_40/bounds.gms
