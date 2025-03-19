#include "cases.h"
#include "string.h"
#include <stdio.h>

#include <quark/services/database/sqlite_service.h>
#include "quark/core/types/string.h"


void cSelectLocations()
{
    const char* database_path = "polaris.sqlite";
    QKString* dbPath = QKStringCreate((char*)database_path);
    QKSqliteService* sqliteService = QKSqliteServiceCreate(dbPath, nullptr);
    QKString* sqlText = QKStringCreate("SELECT $str as strVal, $int as intVal;");
    QKSqliteCommand* sqlCmd = QKSqliteServiceCreateCommand(sqliteService, sqlText, nullptr);
    QKString* strName = QKStringCreate("$str");
    QKString* strVal = QKStringCreate("hello呀哈哈");
    int rc = QKSqliteCommandBindString(sqlCmd, strName, strVal, nullptr);
    if (rc != 0)
    {
        printf("cSqliteStatParams error: %d\n", rc);
        return;
    }

    QKString* intName = QKStringCreate("$int");
    int intVal = 128;
    QKSqliteCommandBindInt(sqlCmd, intName, intVal, nullptr);

    QKSqliteResult* sqlResult = QKSqliteCommandRun(sqlCmd, nullptr);
    QKSqliteRow* sqlRow = QKSqliteResultGetRow(sqlResult, 0, nullptr);

    QKString* strColName = QKStringCreate("strVal");
    QKSqliteColumn* strColByName = QKSqliteRowGetColumnByName(sqlRow, strColName, nullptr);
    QKString* strValByName = QKSQliteColumnGetStringValue(strColByName, nullptr);
    char* strValData = QKStringGetData(strValByName);
    QKSqliteColumn* intColByName = QKSqliteRowGetColumnByName(sqlRow, QKStringCreate("intVal"), nullptr);
    int intValByName = QKSQliteColumnGetIntValue(intColByName, nullptr);

    // QKSqliteCommandClose(sqlCmd);
    // QKSqliteServiceDelete(sqliteService);
    printf("cSqliteSelectNames: %s, %d\n", strValData, intValByName);
}
