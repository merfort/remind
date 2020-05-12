*** |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  REMIND License Exception, version 1.0 (see LICENSE file).
*** |  Contact: remind@pik-potsdam.de
*** SOF ./modules/30_biomass/magpie_4/sets.gms

sets
all_charScen                 "coefficients of the emulator formulas"   
/ a,b,c /

peren2rlf30(all_enty,rlf)    "map biomass energy to grades"
/
        pebios.(5)            
        pebioil.(5)
        pebiolc.2            "residues from agriculture and forestry"
/

peren2cont30(all_enty,rlf)   "map biomass energy to grades with continous supplycurve"
/
        pebiolc.1         "purpose grown"
/

*** Define sets that are used to define a scenario for bioenergy co-emission factors
sspMagScen30                 "SSP scenarios from MAgPIE that where used to derive co-emission factors"
/
        ssp1
        ssp2
        ssp5
/

fsMagScen30                  "bioenergy feedstock type scenarios from MAgPIE that where used to derive co-emission factors"
/
        TypeALL              "all possible types of feedstock are allowed for bioenergy production from lignocellulosic biomass"
        TypeBEGR             "only grassy biomass allowed as lignocellulosic feedstock for bioenergy production"
        TypeBETR             "only woody biomass allowed as lignocellulosic feedstock for bioenergy production"
/

irMagScen30                  "bioenergy irrigation type scenarios from MAgPIE that where use to derive co-emission factors"
/
        WaterALL             "growth of biomass for bioenergy with additional irrigation"
        WaterRAINFED         "growth of biomass for bioenergy only rainfed"
/

emiBioMag30(all_enty)        "emission types related to bioenergy production in MAgPIE"
/
        co2luc               "bioenergy related CO2 emissions"
        n2obio               "bioenergy related N2O emissions"
/


;

*** EOF ./modules/30_biomass/magpie_4/sets.gms
