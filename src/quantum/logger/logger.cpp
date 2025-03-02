#include "quantum/quantum.h"

#include <iostream>
#include "quark/services/logger/logger.h"

void QMLogInfo(const char *message)
{
    std::cout << "[INFO] " << message << std::endl;
    std::string messageStr(message);
    quark::Logger::LogInfo(messageStr);
}