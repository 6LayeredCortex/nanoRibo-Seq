#Script to read in options from command line, set up R environment and pass onto .rmd

args <- commandArgs(trailingOnly = T)

rlibPath=args[1]
experimentTypeFile=args[2]
CDS=args[3]
five_utr=args[4]
three_utr=args[5]
bamFiles=args[6]
gtf=args[7]
lengthCountsFile=args[8]
RiboCodeFile=args[9]
outFile=args[10]
outDir=args[11]
Rmd=args[12]
workDir=args[13]


if (length(args) != 13) {
  stop("number of command line input arguments is incorrect")
}

bamFiles
gtf
lengthCountsFile
experimentTypeFile
outFile

.libPaths(c(rlibPath, "/n/sw/helmod/apps/centos7/Core/R_packages/3.5.1-fasrc01"))
.libPaths()

library('devtools')
library('tidyverse')
library('riboWaltz')
library("rmarkdown")
library("patchwork")
library("pheatmap")
library("RColorBrewer")
library("ggplotify")
library("topGO")
library("ggstance")

rmarkdown::render(Rmd, output_file = outFile, knit_root_dir = workDir, output_dir = workDir )




