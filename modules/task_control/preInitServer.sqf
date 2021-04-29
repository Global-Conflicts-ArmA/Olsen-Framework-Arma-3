#include "..\..\core\script_macros.hpp"

serverTaskArray = [];

#define ADDTASK(TARGET, DESTINATION, TITLE, DESCRIPTION, WPTITLE) \
[TARGET, DESTINATION, TITLE, DESCRIPTION, WPTITLE] call FW_fnc_TASK_AddTask;

#define COMPLETETASK(TITLE) \
[TITLE, "Succeeded"] call FW_fnc_TASK_SetTaskState;

#define FAILTASK(TITLE) \
[TITLE, "Failed"] call FW_fnc_TASK_SetTaskState;

#define CANCELTASK(TITLE) \
[TITLE, "Canceled"] call FW_fnc_TASK_SetTaskState;

#define RESETTASK(TITLE) \
[TITLE, "Created"] call FW_fnc_TASK_SetTaskState;

#define ASSIGNTASK(TITLE) \
[TITLE, "Assigned"] call FW_fnc_TASK_SetTaskState;

#define REMOVETASK(TITLE) \
[TITLE] call FW_fnc_TASK_RemoveTask;

#include "settings.sqf"
