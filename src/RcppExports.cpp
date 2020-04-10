// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include "../inst/include/ribiosGSEA.h"
#include <Rcpp.h>

using namespace Rcpp;

// cpp_geneSetPerm
RcppExport SEXP cpp_geneSetPerm(SEXP stats, SEXP rinds, SEXP Nsim);
RcppExport SEXP _ribiosGSEA_cpp_geneSetPerm(SEXP statsSEXP, SEXP rindsSEXP, SEXP NsimSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type stats(statsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type rinds(rindsSEXP);
    Rcpp::traits::input_parameter< SEXP >::type Nsim(NsimSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_geneSetPerm(stats, rinds, Nsim));
    return rcpp_result_gen;
END_RCPP
}
// cpp_list2mat
RcppExport SEXP cpp_list2mat(SEXP data);
RcppExport SEXP _ribiosGSEA_cpp_list2mat(SEXP dataSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< SEXP >::type data(dataSEXP);
    rcpp_result_gen = Rcpp::wrap(cpp_list2mat(data));
    return rcpp_result_gen;
END_RCPP
}

RcppExport SEXP cpp_geneSetPerm(SEXP, SEXP, SEXP);
RcppExport SEXP cpp_list2mat(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_ribiosGSEA_cpp_geneSetPerm", (DL_FUNC) &_ribiosGSEA_cpp_geneSetPerm, 3},
    {"_ribiosGSEA_cpp_list2mat", (DL_FUNC) &_ribiosGSEA_cpp_list2mat, 1},
    {"cpp_geneSetPerm", (DL_FUNC) &cpp_geneSetPerm, 3},
    {"cpp_list2mat",    (DL_FUNC) &cpp_list2mat,    1},
    {NULL, NULL, 0}
};

RcppExport void R_init_ribiosGSEA(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
