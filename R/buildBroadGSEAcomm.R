## complication: any parameter cannot contain minus
## gseaLnks: makes links when necessary
gseaLns <- function(filename, pattern="file", fileext=".rnk") {
  if(grepl("-", filename)) {
    temp <- tempfile(tmpdir="/tmp", pattern=pattern, fileext=fileext)
    makeLn <- paste("ln -s", filename, temp)
    rmLn <- paste("unlink", temp)
  } else {
    temp <- filename
    makeLn <- ""
    rmLn <- ""
  }
  return(c(file=temp, makeLn=makeLn, rmLn=rmLn))
}

#' Build the command-line command to run BROAD GSEA
#'
#' @param gseaJar Character string, full file name of BROAD GSEA (gene
#' permutation) jar file
#' @param javaBin Character string, java binary file
#' @param rnkFiles Character string, rank files
#' @param gmtFile A \code{GMT} file encoding GMT files to be used
#' @param chipFile A \code{CHIP} file encoding feature annotation
#' @param nperm Integer, number of permutations
#' @param collapse Logical, whether to collapse duplicated features
#' @param plotTopX Integer, top gene-sets to be visualized
#' @param outdir Character string, the path of output
#' @param addShebang Logical, whether to add Shebang to the script
#' 
#' The command builds command-line command to run gene-permutation GSEA
#' over many rank files.
#'
#' @export
buildBroadGSEAcomm <- function(gseaJar,
			       javaBin, 
			       rnkFiles,
			       gmtFile,
                               chipFile,
                               nperm=1000L,
                               collapse=FALSE,
                               plotTopX=25,
                               outdir="./",
                               addShebang=TRUE) {
  stopifnot(all(file.exists(rnkFiles)))
  rnkFiles <- normalizePath(rnkFiles)
  if(!file.exists(outdir))
    dir.create(outdir)
  outdir <- normalizePath(outdir)
  mkOutDir <- paste("mkdir -p", outdir,"\n", sep=" ")

  stopifnot(missing(gmtFile) || file.exists(gmtFile))
  if(!missing(chipFile)) {
    if(!file.exists(chipFile))
      stop("Specified chip not found. Please call 'gseaChiptypes()' to find out supported chiptypes\n")
    chip <- paste("-chip", chipFile)
  } else {
    chip <- ""
  }
  
  gsea.command.template <- paste(c(ifelse(addShebang, "#!/bin/bash\n", ""),
                                   mkOutDir,
                                   "%s\n%s\n",
                                   "(time ", javaBin, "-Xmx2500m",
                                   "-classpath ", gseaJar, " xtools.gsea.GseaPreranked",
                                   "-gmx %s",
                                   chip,
                                   "-rnk %s -rpt_label %s -nperm %d -collapse %s",
                                   "-mode Max_probe -norm meandiv -include_only_symbols true",
                                   "-scoring_scheme weighted -make_sets true -plot_top_x %d",
                                   "-rnd_seed timestamp -set_min 5 -set_max 500", 
                                   "-zip_report false -gui false -out %s > %s) >& %s\n",
                                   "%s\n%s\n"),
                                 collapse=" ")
  gsea.commands <- vector("character", length(rnkFiles))
  for(i in seq(along=rnkFiles)) {
    outfile <- file.path(outdir, paste(basename(rnkFiles[i]), ".out", sep=""))
    errfile <- file.path(outdir, paste(basename(rnkFiles[i]), ".err",sep=""))
    rf <- rnkFiles[i]
    label.base <- paste("runGSEA",
                     gsub("(.*)\\..*", "\\1", basename(rf)), sep="_")
    label <- gsub("-", ".", label.base)

    rfLns <- gseaLns(rf, pattern="file", fileext=".rnk")
    rfTemp <- rfLns[1]; linkRf <- rfLns[2]; delRf <- rfLns[3]
    ofLns <- gseaLns(outdir, pattern="dir", fileext="")
    ofTemp <- ofLns[1]; linkOf <- ofLns[2]; delOf <- ofLns[3]
    
    gsea.commands[i] <- sprintf(gsea.command.template,
                                linkRf, linkOf,
                                gmtFile,
                                rfTemp,
                                label,
                                as.integer(nperm),
                                ifelse(collapse, "true", "false"),
                                as.integer(plotTopX),
                                ofTemp,
                                outfile,
                                errfile,
                                delRf, delOf)
  }
  return(gsea.commands)
}

