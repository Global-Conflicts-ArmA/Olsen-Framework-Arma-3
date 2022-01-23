#include "script_component.hpp"

params ["_note"];
if (!hasInterface) exitWith {};
if (isNil "_note") exitWith {};
if (isNull _note) exitWith {};

//add ACE-actions
private _action = [QGVAR(mainActionGround), "Interactions", "", {}, {true}, {}, [], GVAR(actOffset), GVAR(actDist)] call ace_interact_menu_fnc_createAction;
[_note, 0, [], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [QGVAR(readNoteGround), "Read Note", getMissionPath "modules\notes\data\read.paa", {[[(_this select 0) getVariable ["message", ""], _this select 0, (_this select 0) getVariable ["handwriting", ["",""]]],GVAR(fnc_readNote)] call FUNC(delayedCall)}, {true}] call ace_interact_menu_fnc_createAction;
[_note, 0, [QGVAR(mainActionGround)], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [QGVAR(takeNoteGround), "Take Note", "\A3\ui_f\data\igui\cfg\actions\take_ca.paa", {[_this select 0] call FUNC(takeNote)}, {true}] call ace_interact_menu_fnc_createAction;
[_note, 0, [QGVAR(mainActionGround)], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [QGVAR(destroyNoteGround), "Destroy Note", getMissionPath "modules\notes\data\destroy.paa", {[_this select 0] call FUNC(destroyNote)}, {true}] call ace_interact_menu_fnc_createAction;
[_note, 0, [QGVAR(mainActionGround)], _action] call ace_interact_menu_fnc_addActionToObject;
