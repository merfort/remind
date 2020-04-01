# |  (C) 2006-2019 Potsdam Institute for Climate Impact Research (PIK)
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
    # list(period = "long",  set = "C_PkBudg1300",  dirs = c("C_SSP2-PkBudg1300_S1-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S2-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S3-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S4-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S5-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S6-rem-5",
    #                                                        "C_SSP2-PkBudg1300_S7-rem-5")),
    # list(period = "long",  set = "C_PkBudg900",  dirs = c("C_SSP2-PkBudg900_S1-rem-5",
    #                                                       "C_SSP2-PkBudg900_S2-rem-5",
    #                                                       "C_SSP2-PkBudg900_S3-rem-5",
    #                                                       "C_SSP2-PkBudg900_S4-rem-5",
    #                                                       "C_SSP2-PkBudg900_S5-rem-5",
    #                                                       "C_SSP2-PkBudg900_S6-rem-5",
    #                                                       "C_SSP2-PkBudg900_S7-rem-5")),
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

start_comp <- function(outputdirs,shortTerm,outfilename) {
  jobname <- paste0("compScen",ifelse(outfilename=="","","-"),outfilename,ifelse(shortTerm, "-shortTerm", ""))
  cat("Starting ",jobname,"\n")
  on_cluster <- file.exists("/p/projects/")
  if (on_cluster) {
    clcom <- paste0("sbatch --qos=standby --job-name=",jobname," --output=",jobname,".out --error=",jobname,".err --mail-type=END --time=200 --mem-per-cpu=8000 --wrap=\"Rscript scripts/utils/run_compareScenarios.R outputdirs=",paste(outputdirs,collapse=",")," shortTerm=",shortTerm," outfilename=",jobname,"\"")
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

for (r in listofruns) {
  if (r$period == "short" | r$period == "both") start_comp(outputdirs = r$dirs, shortTerm = TRUE,  outfilename = r$set)
  if (r$period == "long"  | r$period == "both") start_comp(outputdirs = r$dirs, shortTerm = FALSE, outfilename = r$set)
}
