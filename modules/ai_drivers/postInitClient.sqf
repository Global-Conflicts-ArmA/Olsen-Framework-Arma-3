#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_target","_player"];

if (isNil QGVAR(Vehicle)) then {
    GVAR(Vehicle) = objNull;
};

//AI driver action
private _addAction = ["ai_driver","Add AI driver","",{
    [_target, _player] call FUNC(createDriver);
},{
    (vehicle _player == _target) && {isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {GVAR(Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

private _removeAction = ["ai_driver","Remove AI driver","",{
    [_target] call FUNC(removeDriver);
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {GVAR(Vehicle) in [objNull, vehicle _player]}
}] call ace_interact_menu_fnc_createAction;

//unflip action
private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
    [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
    (getposATL _target) params ["_xPos","_yPos","_zPos"];
    _target setPosATL [_xPos, _yPos, _zPos + 2];
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {(vectorUp _target) select 2 < 0}
}] call ace_interact_menu_fnc_createAction;

//engine off action
private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
    [_target, false] remoteExec ["engineOn", _target];
},{
    (vehicle _player == _target) && {!isNull (GETVAR(_target,driver,objnull))} && {effectiveCommander vehicle _player isEqualTo _player} && {isEngineOn _target}
}] call ace_interact_menu_fnc_createAction;

//PIP action
private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
    (isNil QGVAR(DriverCam) || {isNull GVAR(DriverCam)}) call FUNC(ToggleDriverCam);
},{
    (vehicle _player == _target) && {effectiveCommander vehicle _player isEqualTo _player} && {!isNull (GETVAR(_target,driver,objnull))}
}] call ace_interact_menu_fnc_createAction;

//toggle NV for PIP
private _pipNvAction = ["ai_driver_pip_nv","Enable/Disable NV in driver's view","",{
    if (isNil QGVAR(pipNvEnabled)) then {
        GVAR(pipNvEnabled) = false;
    };
    QGVAR(RTT) setPiPEffect ([[1], [0]] select GVAR(pipNvEnabled));
    GVAR(pipNvEnabled) = !GVAR(pipNvEnabled);
},{
    (vehicle _player == _target) &&
    {effectiveCommander vehicle _player isEqualTo _player} &&
    {!isNull (GETVAR(_target,driver,objnull))} &&
    {{_x in (items (GETVAR(_target,driver,objnull)) + assignedItems (GETVAR(_target,driver,objnull)))} count ["NVGoggles", "NVGoggles_OPFOR", "NVGoggles_INDEP"] > 0} &&
    {!isNil QGVAR(DriverCam) && {!isNull GVAR(DriverCam)}}
}] call ace_interact_menu_fnc_createAction;

private _vehClasses = GETMVAR(VehicleClasses, []);
private _selectVehicles = GETMVAR(SelectVehicles, []);

if (GETMVAR(AllCars, false)) then {
    GVAR(VehicleClasses) pushBackUnique "Car";
    _vehClasses = _vehClasses select {!(_x isKindOf "Car")};
    _selectVehicles = _selectVehicles select {!(_x isKindOf "Car")};
};

if (GETMVAR(AllTanks, false)) then {
    GVAR(VehicleClasses) pushBackUnique "Tank";
    _vehClasses = _vehClasses select {!(_x isKindOf "Tank")};
    _selectVehicles = _selectVehicles select {!(_x isKindOf "Tank")};
};

if (GETMVAR(AllShips, false)) then {
    GVAR(VehicleClasses) pushBackUnique "Ship";
    _vehClasses = _vehClasses select {!(_x isKindOf "Ship")};
    _selectVehicles = _selectVehicles select {!(_x isKindOf "Ship")};
};

if (_selectVehicles isNotEqualTo []) then {
    _selectVehicles select {
        private _veh = _x;
        (_vehClasses findIf {_veh isKindOf _x}) isEqualTo -1
    } apply {
        [{!isNull _x},{
            private _veh = _x;
            params ["_addAction", "_removeAction", "_engineOffAction", "_pipAction", "_unflipAction", "_pipNvAction"];
            [_veh, 1, ["ACE_SelfActions"], _addAction] call ace_interact_menu_fnc_addActionToObject;
            [_veh, 1, ["ACE_SelfActions"], _removeAction] call ace_interact_menu_fnc_addActionToObject;
            [_veh, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
            [_veh, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;
            if (GETMVAR(FlipAction, false)) then {
                [_veh, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
            };
            if (GETMVAR(NVGAction, false)) then {
                [_veh, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
            };
        }, [_addAction, _removeAction, _engineOffAction, _pipAction, _unflipAction, _pipNvAction]] call CBA_fnc_waitUntilAndExecute;
    };
};

if (_vehClasses isNotEqualTo []) then {
    _vehClasses apply {
        private _class = _x;
        [_class, 1, ["ACE_SelfActions"], _addAction, true] call ace_interact_menu_fnc_addActionToClass;
        [_class, 1, ["ACE_SelfActions"], _removeAction, true] call ace_interact_menu_fnc_addActionToClass;
        [_class, 1, ["ACE_SelfActions"], _engineOffAction, true] call ace_interact_menu_fnc_addActionToClass;
        [_class, 1, ["ACE_SelfActions"], _pipAction, true] call ace_interact_menu_fnc_addActionToClass;
        if (GETMVAR(FlipAction, false)) then {
            [_class, 1, ["ACE_SelfActions"], _unflipAction, true] call ace_interact_menu_fnc_addActionToClass;
        };
        if (GETMVAR(NVGAction, false)) then {
            [_class, 1, ["ACE_SelfActions"], _pipNvAction, true] call ace_interact_menu_fnc_addActionToClass;
        };
    };
};
