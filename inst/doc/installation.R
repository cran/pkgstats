## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set (
    collapse = TRUE,
    warning = TRUE,
    message = TRUE,
    width = 120,
    comment = "#>",
    fig.retina = 2,
    fig.path = "README-"
)
options (repos = c (
    ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
    CRAN = "https://cloud.r-project.org"
))

## ----install, eval = FALSE----------------------------------------------------
#  install.packages ("pkgstats")

## ----options, eval = FALSE----------------------------------------------------
#  options (repos = c (
#      ropenscireviewtools = "https://ropensci-review-tools.r-universe.dev",
#      CRAN = "https://cloud.r-project.org"
#  ))

## ----remotes, eval = FALSE----------------------------------------------------
#  remotes::install_github ("ropensci-review-tools/pkgstats")
#  pak::pkg_install ("ropensci-review-tools/pkgstats")

## ----library, eval = TRUE-----------------------------------------------------
library (pkgstats)

## ----ctags-check, eval = FALSE------------------------------------------------
#  ctags_test ()
#  #> [1] TRUE

## ----unsetenv, eval = FALSE---------------------------------------------------
#  Sys.unsetenv (c ("GTAGSCONF", "GTAGSLABEL"))

