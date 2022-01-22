
#include "script_component.hpp"

if !(hasInterface) exitWith {};

GVAR(playerDistance) = [missionConfigFile >> QGVAR(settings) >> "playerDistance", "number", 1] call CBA_fnc_getConfigEntry;
GVAR(actOffset) = [missionConfigFile >> QGVAR(settings) >> "actOffset", "array", [0,0,0.1]] call CBA_fnc_getConfigEntry;
GVAR(actDist) = [missionConfigFile >> QGVAR(settings) >> "actDist", "number", 2] call CBA_fnc_getConfigEntry;
GVAR(noteObject) = [missionConfigFile >> QGVAR(settings) >> "noteObject", "text", "Land_Notepad_F"] call CBA_fnc_getConfigEntry;
GVAR(startAmount) = [missionConfigFile >> QGVAR(settings) >> "startAmount", "number", 10] call CBA_fnc_getConfigEntry;
GVAR(visibleHandwriting) = ([missionConfigFile >> QGVAR(settings) >> "visibleHandwriting", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canWriteDefault) = ([missionConfigFile >> QGVAR(settings) >> "canWriteDefault", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(canInspectDefault) = ([missionConfigFile >> QGVAR(settings) >> "canInspectDefault", "number", 1] call CBA_fnc_getConfigEntry) == 1;

GVAR(interactionSleepTime) = 0.1;

//add interaction nodes
[{!isNull player}, {
    //set start amount
    private _startAmount = player getVariable [QGVAR(amount), -1];
    if (_startAmount isEqualTo -1) then {
        player setVariable [QGVAR(amount), GVAR(startAmount)]
    };

    //set handwriting
    [player] call FUNC(setHandwriting);
    [] call FUNC(addSelfinteraction);
    private _action = [QGVAR(mainGiveAction), "Give note", getMissionPath "modules\notes\data\give.paa", {}, {(player getVariable [QGVAR(notesInInventory), 0]) > 0}] call ace_interact_menu_fnc_createAction;
    ["CAManBase",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
}, []] call CBA_fnc_waitUntilAndExecute;
