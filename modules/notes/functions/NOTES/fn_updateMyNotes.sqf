#include "script_component.hpp"

if (!hasInterface) exitWith {};
params ["_noteID", "_mode", ["_message", ""], ["_handwriting", ["",["",""]]]];

//remove note
if (_mode == "remove") then {
    player setVariable [QGVAR(notesInInventory), (player getVariable [QGVAR(notesInInventory), 1]) - 1];

    private _nodeName = format ["GVAR(myNotes_)%1", _noteID];
    private _readactionName = _nodeName + "_read";
    private _dropactionName = _nodeName + "_drop";
    private _destroyactionName = _nodeName + "_destroy";
    private _giveactionName = _nodeName + "_give";

    //self interactions
    [player,1,["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName, _readactionName]] call ace_interact_menu_fnc_removeActionFromObject;
    [player,1,["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName, _dropactionName]] call ace_interact_menu_fnc_removeActionFromObject;
    [player,1,["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName, _destroyactionName]] call ace_interact_menu_fnc_removeActionFromObject;
    [player,1,["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName]] call ace_interact_menu_fnc_removeActionFromObject;

    //give interaction
    ["CAManBase",0,["ACE_MainActions", "GRAD_leaveNotes_mainGiveAction", _giveactionName]] call ace_interact_menu_fnc_removeActionFromClass;
};

//add note
if (_mode == "add") then {
    player setVariable [QGVAR(notesHandled), (player getVariable [QGVAR(notesHandled), 0]) + 1];
    player setVariable [QGVAR(notesInInventory), (player getVariable [QGVAR(notesInInventory), 0]) + 1];
    private _nodeName = format ["GVAR(myNotes_)%1", _noteID];
    player setVariable [_nodeName + "_message", _message];
    player setVariable [_nodeName + "_handwriting", _handwriting];

    //node
    private _actionDisplayText = [_message] call FUNC(generateName);
    private _action = [_nodeName, _actionDisplayText, getMissionPath "modules\notes\data\note.paa", {true}, {true}] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction)], _action] call ace_interact_menu_fnc_addActionToObject;

    //read
    private _readactionName = _nodeName + "_read";
    private _readAction = {(_this select 2) call FUNC(delayedCall)};
    _action = [_readactionName, "Read Note", getMissionPath "modules\notes\data\read.paa", _readAction, {true}, {}, [[_message, _noteID, _handwriting],FUNC(readNote)]] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName], _action] call ace_interact_menu_fnc_addActionToObject;

    //drop
    private _dropactionName = _nodeName + "_drop";
    private _dropAction = {(_this select 2) params ["_noteID", "_message", "_handwriting"]; [_message, _handwriting] call FUNC(dropNote); [_noteID, "remove"] call FUNC(updateMyNotes)};
    _action = [_dropactionName, "Drop Note", getMissionPath "modules\notes\data\drop.paa", _dropAction, {true}, {}, [_noteID, _message, _handwriting]] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName], _action] call ace_interact_menu_fnc_addActionToObject;

    //destroy
    private _destroyactionName = _nodeName + "_destroy";
    _action = [_destroyactionName, "Destroy Note", getMissionPath "modules\notes\data\destroy.paa", {(_this select 2) call FUNC(destroyNote)}, {true}, {}, [_noteID]] call ace_interact_menu_fnc_createAction;
    [player, 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(mainAction), _nodeName], _action] call ace_interact_menu_fnc_addActionToObject;

    //give
    private _giveactionName = _nodeName + "_give";
    _action = [_giveactionName, _actionDisplayText, getMissionPath "modules\notes\data\note.paa", {_this call FUNC(giveNote)}, {true}, {}, [_noteID, _message, _handwriting]] call ace_interact_menu_fnc_createAction;
    ["CAManBase",0,["ACE_MainActions",QGVAR(mainGiveAction)],_action,true] call ace_interact_menu_fnc_addActionToClass;
};
