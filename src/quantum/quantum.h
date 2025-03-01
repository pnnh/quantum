#pragma once

#ifdef _MSC_VER
#define QMAPI __declspec (dllexport)
#endif


#ifdef __cplusplus
extern "C" {
#endif
    QMAPI int  add(int a, int b);
    QMAPI void QMLogInfo(const char *message);
#ifdef __cplusplus
}
#endif