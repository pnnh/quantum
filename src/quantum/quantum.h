#pragma once
#include <quark/build.h>

#ifdef __cplusplus
extern "C" {
#endif
CXAPI int add(int a, int b);

CXAPI void QMLogInfo(const char *message);
#ifdef __cplusplus
}
#endif
