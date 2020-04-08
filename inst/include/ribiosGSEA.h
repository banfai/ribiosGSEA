/* Common definitions of ribiosGSEA */
#ifndef RIBIOS_GSEA_H
#define RIBIOS_GSEA_H

#ifdef __cplusplus
extern "C" {
#endif

#include <R.h>
#include <Rinternals.h>

#define CALLMETHOD_DEF(fun, numArgs) {#fun, (DL_FUNC) &fun, numArgs}

#ifdef __cplusplus
}
#endif

#endif
