#include "logger/logger.h"

#include <iostream>


void SLogInfo(std::string &message)
{
    std::cout << "[INFO] " << message << std::endl;
}

void CLogInfo(const char *message)
{
    std::string messageStr(message);
    SLogInfo(messageStr);
}