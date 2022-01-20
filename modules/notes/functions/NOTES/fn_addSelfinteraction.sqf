#include "script_component.hpp"

//add main selfinteraction node
private _mainCondition = {(player getVariable [QGVAR(notesInInventory), 0]) > 0 || {player getVariable [QGVAR(canWriteNotes), GVAR(canWriteDefault)]}};
private _action = [QGVAR(mainAction), "Notes", getMissionPath "modules\notes\data\note.paa", {}, _mainCondition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions","ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToObject;

//add write action
private _writeCondition = {player getVariable [QGVAR(canWriteNotes), GVAR(canWriteDefault)]};
private _action = [QGVAR(writeNote), "Write Note", getMissionPath "modules\notes\data\write.paa", {[[],GVAR(fnc_writeNote)] call FUNC(delayedCall)}, _writeCondition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction)], _action] call ace_interact_menu_fnc_addActionToObject;
