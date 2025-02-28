#pragma once
#ifdef __cplusplus
#include <string>

void SLogInfo(const std::string &message);

extern "C" {
#endif
    void CLogInfo(const char *message);
#ifdef __cplusplus
}
#endif