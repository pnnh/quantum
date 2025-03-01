#include "version.h"
#include "string.h"
#include <stdio.h>

#include <quark/services/database/SqliteService.h>
#include "quark/types/string.h"

void cSqliteVersion() {
    const char *database_path = "polaris.sqlite";
    QKString* dbPath = QKStringCreate((char*)database_path, strlen(database_path));
    QKSqliteService* sqliteService = QKSqliteServiceCreate(dbPath);
    QKString* version = QKSqliteVersion(sqliteService);

    printf("cSqliteVersion: %s", version->data);
}
