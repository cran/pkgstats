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

## ----main-pkgstats-call, eval = FALSE-----------------------------------------
#  s <- pkgstats () # run in root directory of `pkgstats` source

## ----pkgstats-fakey, echo = FALSE---------------------------------------------
# These data all have to be faked because they can't be generated on CRAN
# windows machines.
loc <- tibble::tibble (
    language = c ("C++", "R", "R", "Rmd"),
    dir = c ("src", "R", "tests", "vignettes"),
    nfiles = c (3L, 24L, 7L, 2L),
    nlines = c (364L, 4727L, 300L, 347L),
    ncode = c (276L, 345L, 234L, 278L),
    nempty = c (67L, 682L, 61L, 61L),
    nspaces = c (932L, 333L, 511L, 1483L),
    nchars = c (6983L, 114334L, 5543L, 11290L),
    nexpr = c (1L, 1L, 1L, 1L),
    ntabs = c (0L, 0L, 0L, 0L),
    indentation = c (4L, 4L, 4L, 4L)
)
vignettes <- c (vignettes = 2L, demos = 0L)
data_stats <- c (n = 0L, total_size = 0L, median_size = 0L)
desc <- data.frame (
    package = "pkgstats",
    verion = "0.1.1",
    date = date (),
    license = "GPL-3",
    urls = paste0 (c (
        "https://docs.ropensci.org/pkgstats/",
        "nhttps://github.com/ropensci-review-tools/pkgstats"
    ), collapse = ",\n"),
    bugs = "https://github.com/ropensci-review-tools/pkgstats/issues",
    aut = 1L,
    ctb = 0L,
    fnd = 0L,
    rev = 0L,
    ths = 0L,
    trl = 0L,
    depends = NA,
    imports = paste0 (c (
        "brio",
        "checkmate",
        "dplyr",
        "fs",
        "igraph",
        "methods",
        "readr",
        "sys",
        "withr"
    ), collapse = ", "),
    suggests = paste0 (c (
        "curl",
        "hms",
        "jsonlite",
        "knitr",
        "parallel",
        "pkgbuild",
        "Rcpp",
        "rmarkdown",
        "roxygen2",
        "testthat",
        "visNetwork"
    ), collapse = ", "),
    enchances = NA_character_,
    linking_to = "cpp11"
)
translations <- NA_character_

s <- list (
    loc = loc,
    vignettes = vignettes,
    data_stats = data_stats,
    desc = desc,
    translations = translations
)

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

## ----objects-fakey, echo = FALSE----------------------------------------------
s$objects <- data.frame (
    file_name = c (
        rep ("R/archive-trawl.R", 4L),
        "R/cpp11.R",
        "R/ctags-install.R"
    ),
    fn_name = c (
        "pkgstats_from_archive",
        "list_archive_files",
        "rm_prev_files",
        "pkgstats_fns_from_archive",
        "cpp_loc",
        "clone_ctag"
    ),
    kind = rep ("function", 6L),
    language = rep ("R", 6L),
    loc = c (89, 17, 24, 82, 3, 17),
    npars = c (9, 2, 2, 7, 4, 1),
    has_dots = rep (FALSE, 6L),
    exported = rep (c (TRUE, FALSE, FALSE), 2L),
    param_nchards_md = c (
        133,
        rep (NA_integer_, 2L),
        163,
        rep (NA_integer_, 2L)
    ),
    param_nchards_mn = c (
        159.7778,
        rep (NA_integer_, 2L),
        174.5714,
        rep (NA_integer_, 2L)
    ),
    num_doclines = c (
        77,
        rep (NA_integer_, 2L),
        50,
        rep (NA_integer_, 2L)
    )
)

## ----objects------------------------------------------------------------------
head (s$objects)

## ----network-fakey, echo = FALSE----------------------------------------------
network <- data.frame (
    file = c (
        rep ("R/external_calls.R", 4L),
        rep ("R/pkgstats-summary.R", 2L)
    ),
    line1 = c (11L, 26L, 38L, 326L, 39L, 50L),
    from = c (
        rep ("external_call_network", 3L),
        "add_other_pkgs_to_calls",
        rep ("pkgstats_summary", 2L)
    ),
    to = c (
        "extract_call_content",
        "add_base_recommended_pkgs",
        "add_other_pkgs_to_calls",
        "control_parse",
        "null_stats",
        "loc_summary"
    ),
    language = rep ("R", 6L),
    cluster_dir = rep (1L, 6L),
    centrality_dir = c (9L, 9L, 9L, 1L, 11L, 11L),
    cluster_undir = rep (1L, 6L),
    centrality_undir = c (rep (230.8333, 3L), 6, rep (874, 2L))
)

nrows <- 142 # full number in result
# expand to nrows:
n <- ceiling (nrows / nrow (network))
network <- with (network, data.frame (
    file = rep (file, n),
    line1 = rep (line1, n),
    from = rep (from, n),
    to = rep (to, n),
    language = rep (language, n),
    cluster_dir = rep (cluster_dir, n),
    centrality_dir = rep (centrality_dir, n),
    cluster_undir = rep (cluster_undir, n),
    centrality_undir = rep (centrality_undir, n)
))
s$network <- network [seq (nrows), ]

## -----------------------------------------------------------------------------
head (s$network)
nrow (s$network)

## ----external_calls-fakey, echo = FALSE---------------------------------------
s$external_calls <- data.frame (
    tags_line = 1:6,
    call = c (
        "c",
        rep ("character", 2L),
        "logical",
        "integer",
        "left_join"
    ),
    tag = c (
        "GTAGSLABEL",
        "file_name",
        "fn_name",
        "has_dots",
        "loc",
        "name"
    ),
    file = c (
        "R/ctags-test.R",
        rep ("R/pkgstats.R", 4L),
        "R/plot.R"
    ),
    kind = rep ("nameattr", 6L),
    start = c (109L, 185L, 186L, 189L, 187L, 89L),
    end = c (109L, 185L, 186L, 189L, 187L, 89L),
    package = c (rep ("base", 5L), "dplyr")
)

## ----ext-call-head------------------------------------------------------------
head (s$external_calls)

## ----ext-call-summary, eval = FALSE-------------------------------------------
#  s_summ <- pkgstats_summary (s)
#  print (s_summ$external_calls)

## ----ext-call-sumamry-fakey, echo = FALSE-------------------------------------
s_summ <- list (external_calls = paste0 (c (
    "base:581:84",
    "brio:11:2",
    "curl:4:3",
    "dplyr:7:4",
    "fs:4:2",
    "graphics:10:2",
    "hms:2:1",
    "igraph:3:3",
    "parallel:2:1",
    "pkgstats:126:73",
    "readr:8:5",
    "stats:19:3",
    "sys:14:1",
    "tools:3:2",
    "utils:22:7",
    "visNetwork:3:2",
    "withr:6:2"
), collapse = ","))

## ----ext-call-details, eval = TRUE--------------------------------------------
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

