#include "script_component.hpp"
params ["_crate","_type"];

if (isNil "_crate") exitWith {};
if (isNull _crate) exitWith {};

_crate setVariable [QGVAR(dropCrate_type), _type];

if (isClass (configfile >> "CfgPatches" >> "CUP_Core")) then {
    [_crate,true,[0,2,0]] call ace_dragging_fnc_setDraggable;
    [_crate,true,[0,1.5,0.8]] call ace_dragging_fnc_setCarryable;

    if (isServer) then {
        [cursorTarget, 1] call ace_cargo_fnc_setSize;
    };
};


private _displayName = [_type] call FUNC(getDisplayName);
private _pickUpName = format ["Pick up (%1)", _displayName];
private _buildName = format ["Build (%1)", _displayName];

private _action = [QGVAR(pickupAction), _pickUpName, "\A3\ui_f\data\igui\cfg\actions\take_ca.paa", {[_this select 0, _this select 1,"TAKE"] call FUNC(requestInteractionServer)}, {true}] call ace_interact_menu_fnc_createAction;
[_crate, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;

private _action = [QGVAR(buildAction), _buildName, "modules\grad-fortifications\data\sandbags.paa", {[_this select 0, _this select 1,"BUILD"] call FUNC(requestInteractionServer)}, {true}] call ace_interact_menu_fnc_createAction;
[_crate, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
