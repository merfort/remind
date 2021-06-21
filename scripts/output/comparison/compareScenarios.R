# |  (C) 2006-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of REMIND and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  REMIND License Exception, version 1.0 (see LICENSE file).
# |  Contact: remind@pik-potsdam.de
# ---- Define set of runs that will be compared ----

if (exists("outputdirs")) {
  # This is the case if this script was called via Rscript output.R
  listofruns <- list(
  list(period = "both",  set = format(Sys.time(), "%Y-%m-%d_%H.%M.%S"),  dirs = outputdirs),  
  NULL)

} else {
  # This is the case if this script was called directly via Rscript
  listofruns <- list( 
      # list(period = "both",  set = "cpl-Base",       dirs = c("C_SDP-Base-rem-5",       "C_SSP1-Base-rem-5",       "C_SSP2-Base-rem-5",       "C_SSP5-Base-rem-5")),
      # list(period = "both",  set = "cpl-PkBudg900",  dirs = c("C_SDP-PkBudg900-rem-5",  "C_SSP1-PkBudg900-rem-5",  "C_SSP2-PkBudg900-rem-5",  "C_SSP5-PkBudg900-rem-5")),
      # list(period = "both",  set = "cpl-PkBudg1100", dirs = c("C_SDP-PkBudg1100-rem-5", "C_SSP1-PkBudg1100-rem-5", "C_SSP2-PkBudg1100-rem-5", "C_SSP5-PkBudg1100-rem-5")),
      # list(period = "both",  set = "cpl-PkBudg1300", dirs = c("C_SDP-PkBudg1300-rem-5", "C_SSP1-PkBudg1300-rem-5", "C_SSP2-PkBudg1300-rem-5", "C_SSP5-PkBudg1300-rem-5")),
      # list(period = "both",  set = "cpl-NPi",        dirs = c("C_SDP-NPi-rem-5",        "C_SSP1-NPi-rem-5",        "C_SSP2-NPi-rem-5",        "C_SSP5-NPi-rem-5")),
      # 
      # list(period = "both",  set = "cpl-SDP",  dirs = c("C_SDP-Base-rem-5",  "C_SDP-NPi-rem-5",  "C_SDP-PkBudg1300-rem-5",  "C_SDP-PkBudg1100-rem-5",  "C_SDP-PkBudg1000-rem-5")),
      # list(period = "both",  set = "cpl-SSP1", dirs = c("C_SSP1-Base-rem-5", "C_SSP1-NPi-rem-5", "C_SSP1-PkBudg1300-rem-5", "C_SSP1-PkBudg1100-rem-5", "C_SSP1-PkBudg900-rem-5")),
      # list(period = "both",  set = "cpl-SSP2", dirs = c("C_SSP2-Base-rem-5", "C_SSP2-NPi-rem-5", "C_SSP2-PkBudg1300-rem-5", "C_SSP2-PkBudg1100-rem-5", "C_SSP2-PkBudg900-rem-5", "C_SSP2-NDC-rem-5")), #
      # list(period = "both",  set = "cpl-SSP5", dirs = c("C_SSP5-Base-rem-5", "C_SSP5-NPi-rem-5", "C_SSP5-PkBudg1300-rem-5", "C_SSP5-PkBudg1100-rem-5", "C_SSP5-PkBudg900-rem-5")),
    
    # list(period = "both",  set = "cpl-PkBudg900-plant-vgl",  dirs = c("C_SDP-PkBudg900-plant-rem-5", "C_SDP-PkBudg900-rem-5", "C_SSP2-PkBudg900-plant-rem-5", "C_SSP2-PkBudg900-rem-5")),
    # list(period = "both",  set = "cpl-PkBudg900-plant",      dirs = c("C_SDP-PkBudg900-plant-rem-5",  "C_SSP1-PkBudg900-plant-rem-5",  "C_SSP2-PkBudg900-plant-rem-5",  "C_SSP5-PkBudg900-plant-rem-5")),
    
    # list(period = "long",  set = "Base-NDC_branch100-develop",  dirs = c("./output/SSP2-Base_coemi100_2020-04-08_14.18.44",
    #                                                                      "../remind_develop/output/SSP2-Base_2020-04-08_12.29.26",
    #                                                                      "./output/SSP2-NDC_coemi100_2020-04-08_14.54.56",
    #                                                                      "../remind_develop/output/SSP2-NDC_2020-04-08_13.08.54")),
    
    # list(period = "long",  set = "Base-coemi-CO2_21p4_N2O-7p5", dirs = c(
    #   "C_SSP2-Base-rem-5",
    #   "C_SSP2-Base_coemi-NPI-Budg1300-rem-5"
    # )),
    # list(period = "long",  set = "NDC-coemi-CO2_21p4_N2O-7p5", dirs = c(
    #   "C_SSP2-NDC-rem-5",
    #   "C_SSP2-NDC_coemi-NPI-Budg1300-rem-5",
    #   "C_SSP2-NDC_Mag-noTaxCO2N2O_tau1p5-rem-5",
    #   "C_SSP2-NDC_Mag-noTaxCO2N2O_tau0-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-coemi-CO2_21p4_N2O-7p5", dirs = c(
    #   "C_SSP2-PkBudg1300-rem-5",
    #   "C_SSP2-PkBudg1300_coemi-NPI-Budg1300-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_tau1p5-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_tau0-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-efCO2range-incl-all", dirs = c(
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-00-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-05-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-10-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-20-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-30-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-40-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-50-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-60-rem-5",
    #   "C_SSP2-PkBudg1300-rem-5",
    #   "C_SSP2-Base-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-effect-of-tau-runs", dirs = c(
    #   "C_SSP2-Base-rem-5",
    #   "C_SSP2-Base_tau0-rem-5",
    #   "C_SSP2-NDC-rem-5",
    #   "C_SSP2-NDC_tau0-rem-5",
    #   "C_SSP2-PkBudg1300-rem-5",
    #   "C_SSP2-PkBudg1300_tau0-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-effect-of-tau-runs-plus-coemi", dirs = c(
    #   "C_SSP2-Base-rem-5",
    #   "C_SSP2-Base_tau0-rem-5",
    #   "C_SSP2-NDC-rem-5",
    #   "C_SSP2-NDC_tau0-rem-5",
    #   "C_SSP2-PkBudg1300-rem-5",
    #   "C_SSP2-PkBudg1300_tau0-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-00-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_efCO2-60-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-allTaxOff-vs-noTaxCO2andN2O-tau0", dirs = c(
    #   "C_SSP2-Base_Mag-allTaxOff_tau0-rem-5",
    #   "C_SSP2-Base_Mag-noTaxCO2N2O_tau0-rem-5",
    #   "C_SSP2-NDC_Mag-allTaxOff_tau0-rem-5",
    #   "C_SSP2-NDC_Mag-noTaxCO2N2O_tau0-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-allTaxOff_tau0-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_tau0-rem-5",
    #   "C_SSP2-Base-rem-5",
    #   "C_SSP2-PkBudg1300-rem-5"
    # )),
    # list(period = "long",  set = "PkBudg1300-allTaxOff-vs-noTaxCO2andN2O-tau1p5", dirs = c(
    #   "C_SSP2-Base_Mag-allTaxOff_tau1p5-rem-5",
    #   "C_SSP2-Base_Mag-noTaxCO2N2O_tau1p5-rem-5",
    #   "C_SSP2-NDC_Mag-allTaxOff_tau1p5-rem-5",
    #   "C_SSP2-NDC_Mag-noTaxCO2N2O_tau1p5-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-allTaxOff_tau1p5-rem-5",
    #   "C_SSP2-PkBudg1300_Mag-noTaxCO2N2O_tau1p5-rem-5",
    #   "C_SSP2-Base-rem-5",
    #   "C_SSP2-PkBudg1300-rem-5"
    # )),
    list(period = "long",  set = "PkBudg900-1100-1300", dirs = c(
      "C_SSP2-PkBudg900-rem-5",
      "C_SSP2-PkBudg900_tau0-rem-5",
      "C_SSP2-PkBudg1100-rem-5",
      "C_SSP2-PkBudg1100_tau0-rem-5",
      "C_SSP2-PkBudg1300-rem-5",
      "C_SSP2-PkBudg1300_tau0-rem-5"
    )),
    NULL)
}

# remove the NULL element
listofruns <- listofruns[!sapply(listofruns, is.null)]

# if no path in "dirs" starts with "output/" insert it at the beginning
# this is the case if listofruns was created in the lower case above !exists("outputdirs"), i.e. if this script was not called via Rscript output.R
for (i in 1:length(listofruns)) {
  if(!any(grepl("output/",listofruns[[i]]$dirs))) {
    listofruns[[i]]$dirs <- paste0("output/",listofruns[[i]]$dirs)
  }
}

# ---- Start compareScenarios either on the cluster or locally ----

start_comp <- function(outputdirs,shortTerm,outfilename,regionList,mainReg) {
  jobname <- paste0("compScen",ifelse(outfilename=="","","-"),outfilename,ifelse(shortTerm, "-shortTerm", ""))
  cat("Starting ",jobname,"\n")
  on_cluster <- file.exists("/p/projects/")
  cat(paste0("sbatch --qos=standby --job-name=",jobname," --output=",jobname,".out --error=",jobname,".err --mail-type=END --time=200 --mem-per-cpu=8000 --wrap=\"Rscript scripts/utils/run_compareScenarios.R outputdirs=",paste(outputdirs,collapse=",")," shortTerm=",shortTerm," outfilename=",jobname," regionList=",paste(regionList,collapse=",")," mainRegName=",mainReg,"\""))
  if (on_cluster) {
    clcom <- paste0("sbatch --qos=standby --job-name=",jobname," --output=",jobname,".out --error=",jobname,".err --mail-type=END --time=200 --mem-per-cpu=8000 --wrap=\"Rscript scripts/utils/run_compareScenarios.R outputdirs=",paste(outputdirs,collapse=",")," shortTerm=",shortTerm," outfilename=",jobname," regionList=",paste(regionList,collapse=",")," mainRegName=",mainReg,"\"")
    system(clcom)
  } else {
    outfilename    <- jobname
    tmp.env <- new.env()
    script <- "scripts/utils/run_compareScenarios.R"
    tmp.error <- try(sys.source(script,envir=tmp.env))
    if(!is.null(tmp.error)) warning("Script ",script," was stopped by an error and not executed properly!")
    rm(tmp.env)
  }
}

# ---- For each list entry call start script that starts compareScenarios ----
regionSubsetList <- remind2::toolRegionSubsets(lucode2::path(listofruns[[1]]$dirs,"fulldata.gdx"))
for (r in listofruns) {
  # Create multiple pdf files for H12 and subregions of H12
  for (reg in c("H12",names(regionSubsetList))){
    fileName <- paste0(r$set, "-" , reg)
	if (reg=="H12")
	  regionList <- c("GLO","LAM","OAS","SSA","EUR","NEU","MEA","REF","CAZ","CHA","IND","JPN","USA")
	else
	  regionList <- c(reg,regionSubsetList[[reg]])
	if (reg=="H12")
	  mainRegName <- c("GLO")
	else
	  mainRegName <- c(reg)
	if (r$period == "short" | r$period == "both") start_comp(outputdirs = r$dirs, shortTerm = TRUE,  outfilename = fileName, regionList=regionList, mainReg=mainRegName)
	if (r$period == "long"  | r$period == "both") start_comp(outputdirs = r$dirs, shortTerm = FALSE, outfilename = fileName, regionList=regionList, mainReg=mainRegName)
  }
}
