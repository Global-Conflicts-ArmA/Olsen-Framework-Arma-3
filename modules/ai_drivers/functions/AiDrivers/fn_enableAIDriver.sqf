#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_target","_player"];

params ["_veh"];

if (isNil QGVAR(Vehicle)) then {
    GVAR(Vehicle) = objNull;
};

if (GETVAR(_veh,hasActions,false)) exitwith {};

//AI driver action
private _addAction = ["ai_driver","Add AI driver","",{
    [_target, _player] call FUNC(createDriver);
},{
    (vehicle _player isEqualTo _target) && {driver _target isEqualTo objNull} && {isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {GVAR(Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

private _removeAction = ["ai_driver","Remove AI driver","",{
    [_target] call FUNC(removeDriver);
},{
    (vehicle _player isEqualTo _target) && {driver _target isNotEqualTo objNull} && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {GVAR(Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

//unflip action
private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
    [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
    (getposATL _target) params ["_xPos","_yPos","_zPos"];
    _target setPosATL [_xPos, _yPos, _zPos + 2];
},{
    (vehicle _player isEqualTo _target) && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {(vectorUp _target) select 2 < 0}
}] call ace_interact_menu_fnc_createAction;

//engine off action
private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
    [_target, false] remoteExec ["engineOn", _target];
},{
    (vehicle _player isEqualTo _target) && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {isEngineOn _target}
}] call ace_interact_menu_fnc_createAction;

//PIP action
private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
    (isNil QGVAR(DriverCam) || {isNull GVAR(DriverCam)}) call FUNC(ToggleDriverCam);
},{
    (vehicle _player isEqualTo _target) && {effectiveCommander vehicle _player isEqualTo _player} && {!isNull (GETVAR(_target,driver,objnull))}
}] call ace_interact_menu_fnc_createAction;

//move PIP action
private _movePIPAction = ["ai_driver_pip","Switch driver view location","",{
    with uiNamespace do {
        GVAR(driverPipDisplay) ctrlSetPosition [0.1,0.1,0.75,0.5];
        GVAR(driverPipDisplay) ctrlCommit 0;
    };
},{
    (vehicle _player isEqualTo _target) &&
    {effectiveCommander vehicle _player isEqualTo _player} &&
    {!isNull (GETVAR(_target,driver,objnull))} //&&
    //{!isNil QGVAR(DriverCam) && {!isNull GVAR(DriverCam)}} &&
    //{uiNamespace getVariable [QGVAR(pipDisplay), displayNull] isNotEqualTo displayNull} &&
    //{uiNamespace getVariable [QGVAR(driverPipDisplay), controlNull] isNotEqualTo controlNull}
}] call ace_interact_menu_fnc_createAction;

//toggle NV for PIP
private _pipNvAction = ["ai_driver_pip_nv","Enable/Disable NV in driver's view","",{
    if (isNil QGVAR(pipNvEnabled)) then {
        GVAR(pipNvEnabled) = false;
    };
    QGVAR(RTT) setPiPEffect ([[1], [0]] select GVAR(pipNvEnabled));
    GVAR(pipNvEnabled) = !GVAR(pipNvEnabled);
},{
    (vehicle _player isEqualTo _target) &&
    {effectiveCommander vehicle _player isEqualTo _player} &&
    {!isNull (GETVAR(_target,driver,objnull))} &&
    {{_x in (items (GETVAR(_target,driver,objnull)) + assignedItems (GETVAR(_target,driver,objnull)))} count ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP"] > 0} &&
    {!isNil QGVAR(DriverCam) && {!isNull GVAR(DriverCam)}}
}] call ace_interact_menu_fnc_createAction;

[_veh, 1, ["ACE_SelfActions"], _addAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _removeAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;
[_veh, 1, ["ACE_SelfActions"], _movePIPAction] call ace_interact_menu_fnc_addActionToObject;

if (GVAR(FlipAction)) then {
    [_veh, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
};

if (GVAR(NVGAction)) then {
    [_veh, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
};

SETPVAR(_veh,hasActions,true);
