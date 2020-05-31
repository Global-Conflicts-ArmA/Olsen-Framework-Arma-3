#include "script_component.hpp"
params ["_fort","_owner"];

if (!hasInterface) exitWith {};
if (isNull _fort) exitWith {};

private _type = typeOf _fort;
if ([_type] call FUNC(isVehicle)) exitWith {};

switch (GVAR(fortificationOwnerType)) do {
    case ("BUILDER"): {
        _fort setVariable [QGVAR(fortOwner),_owner,false];
    };
    case ("GROUP"): {
        _fort setVariable [QGVAR(fortOwner),group _owner,false];
    };
    case ("SIDE"): {
        _fort setVariable [QGVAR(fortOwner),side _owner,false];
    };
};

//demolition
private _canDemolish = [_type, "canDemolish"] call FUNC(getConfigValue);
if (_canDemolish) then {
    
    private _action = [QGVAR(demolishAction), "Demolish fortification", "", {[_this select 0, _this select 1] call FUNC(demolish)}, {(_this select 1) getVariable [QGVAR(canDemolish), GVAR(canDemolishDefault)]}] call ace_interact_menu_fnc_createAction;
    [_fort, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};

//pack up
private _canPackUp = [_type, "canPackUp"] call FUNC(getConfigValue);
if (_canPackup) then {
    
    private _condition = {
        (_this select 1) getVariable [QGVAR(canPackUp), GVAR(canPackUpDefault)] &&
        {[_this select 0, _this select 1] call FUNC(isOwner)}
    };
    private _action = [QGVAR(packUpAction), "Pack up fortification", "", {[GVAR(fnc_packUp),[_this select 0, _this select 1]] call CBA_fnc_execNextFrame}, _condition] call ace_interact_menu_fnc_createAction;
    [_fort, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
};
