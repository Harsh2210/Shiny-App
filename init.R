my_packages = c("RCurl", "data.table","shinythemes","neuralnet","psych","caret")

install_if_missing = function(p) {
  if (p %in% rownames(installed.packages()) == FALSE) {
    install.packages(p)
  }
}

invisible(sapply(my_packages, install_if_missing))