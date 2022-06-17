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
library (pkgstats)

## ----main-pkgstats-call-------------------------------------------------------
s <- pkgstats () # run in root directory of `pkgstats` source

## -----------------------------------------------------------------------------
s [!names (s) %in% c ("objects", "network", "external_calls")]

## ----loc----------------------------------------------------------------------
s$loc

## ----nested1, eval = FALSE----------------------------------------------------
#  x <- myfn ()

## ----nested4, eval = FALSE----------------------------------------------------
#  x <- function () { return (myfn ()) }

## ----rel-space----------------------------------------------------------------
index <- which (s$loc$dir %in% c ("R", "src")) # consider source code only
sum (s$loc$nspaces [index]) / sum (s$loc$nchars [index])

## ----desc---------------------------------------------------------------------
s$desc

## ----objects------------------------------------------------------------------
head (s$objects)

## -----------------------------------------------------------------------------
head (s$network)
nrow (s$network)

## ----ext-call-head------------------------------------------------------------
head (s$external_calls)

## ----ext-call-summary---------------------------------------------------------
s_summ <- pkgstats_summary (s)
print (s_summ$external_calls)
x <- strsplit (s_summ$external_calls, ",") [[1]]
x <- do.call (rbind, strsplit (x, ":"))
x <- data.frame (
    pkg = x [, 1],
    n_total = as.integer (x [, 2]),
    n_unique = as.integer (x [, 3])
)
x$n_total_rel <- round (x$n_total / sum (x$n_total), 3)
x$n_unique_rel <- round (x$n_unique / sum (x$n_unique), 3)
print (x)

