#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_target","_player"];

params ["_veh"];

if (isNil QGVAR(AD_Vehicle)) then {
    GVAR(AD_Vehicle) = objNull;
};

if (GETVAR(_veh,AD_hasActions,false)) exitwith {};

//AI driver action
private _addAction = ["ai_driver","Add AI driver","",{
    [_target, _player] call FUNC(AD_CreateUnit);
},{
    (vehicle _player == _target) && {isNull (GETVAR(_target,AD_driver,objnull))} && {((assignedVehicleRole _player) select 0) isEqualTo "turret"} && {GVAR(AD_Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

private _removeAction = ["ai_driver","Remove AI driver","",{
    [_target] call FUNC(AD_RemoveUnit);
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,AD_driver,objnull))} && {((assignedVehicleRole _player) select 0) isEqualTo "turret"} && {GVAR(AD_Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

//unflip action
private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
    [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
    (getposATL _target) params ["_xPos","_yPos","_zPos"];
    _target setPosATL [_xPos, _yPos, _zPos + 2];
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,AD_driver,objnull))} && {((assignedVehicleRole _player) select 0) isEqualTo "turret"} && {(vectorUp _target) select 2 < 0}
}] call ace_interact_menu_fnc_createAction;

//engine off action
private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
    [_target, false] remoteExec ["engineOn", _target];
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,AD_driver,objnull))} && {((assignedVehicleRole _player) select 0) isEqualTo "turret"} && {isEngineOn _target}
}] call ace_interact_menu_fnc_createAction;

//PIP action
private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
    (isNil QGVAR(AD_DriverCam) || {isNull GVAR(AD_DriverCam)}) call FUNC(AD_ToggleDriverCam);
},{
    (vehicle _player == _target) && {((assignedVehicleRole _player) select 0) isEqualTo "turret"} && {!isNull (GETVAR(_target,AD_driver,objnull))}
}] call ace_interact_menu_fnc_createAction;

//toggle NV for PIP
private _pipNvAction = ["ai_driver_pip_nv","Enable/Disable NV in driver's view","",{
    if (isNil QGVAR(AD_pipNvEnabled)) then {
        GVAR(AD_pipNvEnabled) = false;
    };
    QGVAR(AD_RTT) setPiPEffect ([[1], [0]] select GVAR(AD_pipNvEnabled));
    GVAR(AD_pipNvEnabled) = !GVAR(AD_pipNvEnabled);
},{
    (vehicle _player == _target) &&
    {((assignedVehicleRole _player) select 0) isEqualTo "turret"} &&
    {!isNull (GETVAR(_target,AD_driver,objnull))} &&
    {{_x in (items (GETVAR(_target,AD_driver,objnull)) + assignedItems (GETVAR(_target,AD_driver,objnull)))} count ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP"] > 0} &&
    {!isNil QGVAR(AD_DriverCam) && {!isNull GVAR(AD_DriverCam)}}
}] call ace_interact_menu_fnc_createAction;

[_veh, 1, ["ACE_SelfActions"], _addAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _removeAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;

if (GVAR(AiDriversFlipAction)) then {
    [_veh, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
};

if (GVAR(AiDriversNVGAction)) then {
    [_veh, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
};

SETPVAR(_veh,AD_hasActions,true);
