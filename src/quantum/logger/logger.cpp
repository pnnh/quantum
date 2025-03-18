#include "quantum/quantum.h"

#include <iostream>
#include "quark/services/logger/logger.h"

void QMLogInfo(const char* message)
{
    quark::MTLogInfo(message);
}
