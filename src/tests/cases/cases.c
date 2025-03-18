#include "cases.h"
#include "string.h"
#include <stdio.h>

#include <quark/services/database/sqlite_service.h>
#include "quark/core/types/string.h"


void cSelectLocations() {
    const char *database_path = "polaris.sqlite";
    QKString *dbPath = QKStringCreate((char *) database_path);
    QKSqliteService *sqliteService = QKSqliteServiceCreate(dbPath);
    QKString *sqlText = QKStringCreate("SELECT $str as strVal, $int as intVal;");
    QKSqliteCommand *sqlCmd = QKSqliteServiceCreateCommand(sqliteService, sqlText);
    QKString *strName = QKStringCreate("$str");
    QKString *strVal = QKStringCreate("hello呀哈哈");
    int rc = QKSqliteCommandBindString(sqlCmd, strName, strVal);
    if (rc != 0) {
        printf("cSqliteStatParams error: %d\n", rc);
        return;
    }

    QKString *intName = QKStringCreate("$int");
    int intVal = 128;
    QKSqliteCommandBindInt(sqlCmd, intName, intVal);

    QKSqliteResult *sqlResult = QKSqliteCommandRun(sqlCmd);
    QKSqliteRow *sqlRow = QKSqliteResultGetRow(sqlResult, 0);

    QKString *strColName = QKStringCreate("strVal");
    QKSqliteColumn *strColByName = QKSqliteRowGetColumnByName(sqlRow, strColName);
    QKString *strValByName = QKSQliteColumnGetStringValue(strColByName);
    char *strValData = QKStringGetData(strValByName);
    QKSqliteColumn *intColByName = QKSqliteRowGetColumnByName(sqlRow, QKStringCreate("intVal"));
    int intValByName = QKSQliteColumnGetIntValue(intColByName);

    // QKSqliteCommandClose(sqlCmd);
    // QKSqliteServiceDelete(sqliteService);
    printf("cSqliteSelectNames: %s, %d\n", strValData, intValByName);
}
