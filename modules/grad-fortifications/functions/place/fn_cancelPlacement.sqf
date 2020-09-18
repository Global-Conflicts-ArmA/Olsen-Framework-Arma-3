#include "script_component.hpp"
private _builder = ACE_player;

[] call FUNC(removeAllEHs);
[false] call FUNC(openHint);
call ace_interaction_fnc_hideMouseHint;

_builder forceWalk false;

private _fort = _builder getVariable [QGVAR(currentFort), objNull];
private _fortPos = getPosASL _fort;
private _fortType = typeOf _fort;

private _onPlaceCancel = [_fortType, "onPlaceCancel"] call FUNC(getConfigValue);
[_builder,_fortType,_fort] call compile _onPlaceCancel;

deleteVehicle _fort;

_builder setVariable [QGVAR(isPlacing), false];

private _type = _builder getVariable [QGVAR(currentType), ""];
private _mode = _builder getVariable [QGVAR(currentMode), "NORMAL"];

if (_mode == "DROPPED") then {
    if (_builder getVariable [QGVAR(isColliding),true] || {!(_builder getVariable [QGVAR(isOnGround),true])}) then {
        [_builder,_type,_mode] call FUNC(dropFort);
    } else {
        [_builder,_type,_mode,_fortPos] call FUNC(dropFort);
    };
};
