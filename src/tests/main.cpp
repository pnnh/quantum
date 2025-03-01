#include <iostream>
#include "version.h"

#include "quark/services/database/SqliteService.h"

void cxxSqliteVersion() {
    auto database_path = "polaris.sqlite";
    auto sqliteService = quark::SqliteService(database_path);
    auto version = sqliteService.sqliteVersion();

    std::cout << "cxxSqliteVersion: " << version << std::endl;
}


int main() {
    cSqliteVersion();
    return 0;
}
