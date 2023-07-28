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
    # list(period = "long",  set = "cpl-DIPOL-socket400-2021_07_30-rem-8",
    #      dirs = c(
    #        "C_TraInd-Base-DIPOL-rem-5",
    #        "C_TraInd-NDC-DIPOL-rem-5",
    #        "C_TraInd-Npi-DIPOL-rem-5",
    #        "C_TraInd-ROWcp150-socket400-S1-rem-8",
    #        "C_TraInd-ROWcp150-socket400-S2-rem-8",
    #        "C_TraInd-ROWcp150-socket400-S3-rem-8",
    #        "C_TraInd-ROWcp150-socket400-S4-rem-8",
    #        "C_TraInd-ROWcp150-socket400-S5-rem-8",
    #        "C_TraInd-ROWcp150-socket400-S6-rem-8"
    #      )
    # ),
    # list(period = "long",  set = "cpl-DIPOL-socket300-2021_07_30-rem-8",
    #      dirs = c(
    #        "C_TraInd-Base-DIPOL-rem-5",
    #        "C_TraInd-NDC-DIPOL-rem-5",
    #        "C_TraInd-Npi-DIPOL-rem-5",
    #        "C_TraInd-ROWcp150-socket300-S1-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S2-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S3-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S4-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S5-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S6-rem-8"
    #      )
    # ),
    # list(period = "both",  set = "cpl-DIPOL-socket200-2021_11_14-rem-8-woBase",
    #      dirs = c(
    #        # "C_TraInd-Base-DIPOL-rem-5",
    #        # "C_TraInd-NDC-DIPOL-rem-5",
    #        # "C_TraInd-Npi-DIPOL-rem-5",
    #        "C_TraInd-ROWcp150-socket200-S1-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S2-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S3-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S4-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S6-rem-8"
    #      )
    # ),
    list(period = "both",  set = "cpl-DIPOL-GHGneutral-2021_11_20-rem-8-woBase",
         dirs = c(
           "C_TraInd-ROWcp150-socket200-S1-rem-8",
           "C_TraInd-ROWcp150-socket200-S2-rem-8",
           "C_TraInd-ROWcp150-socket200-S3-rem-8",
           "C_TraInd-ROWcp150-socket200-S4-rem-8",
           "C_TraInd-ROWcp150-socket200-S5-rem-8",
           "C_TraInd-ROWcp150-socket200-S6-rem-8"
         )
    ),
    list(period = "both",  set = "cpl-DIPOL-GHGneutral-2021_11_20-rem-8-woBase-S1-S4",
         dirs = c(
           "C_TraInd-ROWcp150-socket200-S1-rem-8",
           "C_TraInd-ROWcp150-socket200-S2-rem-8",
           "C_TraInd-ROWcp150-socket200-S3-rem-8",
           "C_TraInd-ROWcp150-socket200-S4-rem-8"
         )
    ),
    list(period = "both",  set = "cpl-DIPOL-GHGneutral-2021_11_20-rem-8-woBase-S2-S4",
         dirs = c(
           "C_TraInd-ROWcp150-socket200-S2-rem-8",
           "C_TraInd-ROWcp150-socket200-S3-rem-8",
           "C_TraInd-ROWcp150-socket200-S4-rem-8"
         )
    ),
    # list(period = "long",  set = "cpl-DIPOL-socket200-S5_convergence",      
    #      dirs = c(
    #        # "C_TraInd-ROWcp150-socket200-S5-rem-1",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-2",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-3",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-4",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-5",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-6",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-7",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-8"
    #      )
    # ),
    # list(period = "long",  set = "cpl-DIPOL-S5-socket400_300_200",      
    #      dirs = c(
    #        "C_TraInd-ROWcp150-socket400-S5-rem-8",
    #        "C_TraInd-ROWcp150-socket300-S5-rem-8",
    #        "C_TraInd-ROWcp150-socket200-S5-rem-8"
    #      )
    # ),
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
