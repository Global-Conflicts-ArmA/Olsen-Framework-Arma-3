#include "script_component.hpp"

//IGNORE_PRIVATE_WARNING ["_target","_player"];

if (isNil QGVAR(Vehicle)) then {
    GVAR(Vehicle) = objNull;
};

//AI driver action

if (GETMVAR(TestMode,false)) then {
    private _debugAddAction = ["ai_driver","test mode edit","",{
        GVAR(Vehicle) = _target;
        private _veh = GVAR(Vehicle);
        if ((GETMVAR(viewHelper,objNull)) isEqualTo objNull) then {
            private _viewHelper = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
            SETMVAR(viewHelper,_viewHelper);
        };
        if ((GETMVAR(targetHelper,objNull)) isEqualTo objNull) then {
            private _targetHelper = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
            _targetHelper setobjecttexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
            SETMVAR(targetHelper,_targetHelper);
        };
        if (isNil QGVAR(OpticsNamespace)) then {
            GVAR(OpticsNamespace) = createHashMap;
        };

        private _type = typeOf _veh;
        private _typesArray = [(configFile >> "CfgVehicles" >> _type), true] call BIS_fnc_returnParents;
        TRACE_2("",_type,_typesArray);

        private _index = _typesArray findIf {
            private _inHash = _x in GVAR(OpticsNamespace);
            TRACE_2("",_veh,_inHash);
            _inHash
        };

        if (_index isNotEqualTo -1) then {
            private _selectedType = _typesArray select _index;
            private _viewValues = GVAR(OpticsNamespace) getOrDefault [_selectedType, [[0,0,0], [0,0,0]]];
            TRACE_2("",_veh,_viewValues);
            GVAR(viewHelperPos) = _viewValues select 0;
            GVAR(targetHelperPos) = _viewValues select 1;
        } else {
            GVAR(targetHelperPos) = [0,0,0];
            GVAR(viewHelperPos) = [0,0,0];
        };
        GVAR(viewHelper) attachTo [GVAR(Vehicle), GVAR(viewHelperPos)];
        GVAR(targetHelper) attachTo [GVAR(Vehicle), GVAR(targetHelperPos)];

        GVAR(DriverCam) = "camera" camCreate [0,0,0];
        GVAR(DriverCam) cameraEffect ["INTERNAL", "BACK", QGVAR(RTT)];
        GVAR(DriverCam) camSetFov 1;
        GVAR(DriverCam) camSetTarget GVAR(targetHelper);
        GVAR(DriverCam) camCommit 0;

        SETMVAR(pipNvEnabled,true);

        GVAR(DriverCam) attachTo [_veh, GVAR(viewHelperPos)];

        with uiNamespace do {
            QGVAR(PiPDriverLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
            GVAR(pipDisplay) = uiNamespace getVariable "RscTitleDisplayEmpty";
            GVAR(driverPipDisplay) = GVAR(pipDisplay) ctrlCreate ["RscPicture", -1];
            GVAR(driverPipDisplay) ctrlSetPosition GVAR(bottomDisplay);
            GVAR(driverPipDisplay) ctrlCommit 0;
            GVAR(driverPipDisplay) ctrlSetText ("#(argb,512,512,1)r2t(" + QGVAR(RTT) + ",1.0)");
        };

        GVAR(cameraTarget) = false;

        private _class = switch (side ace_player) do {
            case BLUFOR: {"B_Soldier_F"};
            case EAST: {"O_Soldier_F"};
            case INDEPENDENT: {"I_Soldier_F"};
            case CIVILIAN: {"C_Marshal_F"};
            default {"B_Soldier_F"};
        };

        private _unit = createAgent [_class, getPos ace_player, [], 0, "CAN_COLLIDE"];

        removeAllWeapons _unit;
        removeUniform _unit;
        removeVest _unit;
        removeHeadgear _unit;
        removeGoggles _unit;

        _unit forceAddUniform uniform ace_player;
        _unit addVest vest ace_player;
        _unit addHeadGear headGear ace_player;

        _unit moveInDriver _target;
        _unit setBehaviour "COMBAT";

        GVAR(TestDriver) = _unit;

        GVAR(TestKeyHandler) = (findDisplay 46) displayAddEventHandler ["keyDown", {
            params ["", "_key", "_shift"];
            if (_shift) exitWith {false};

            if (GVAR(cameraTarget)) then {
                GVAR(targetHelperPos) params [
                    "_xPos",
                    "_yPos",
                    "_zPos"
                ];
                private _edited = true;
                switch true do {
                    case (_key in actionKeys "MoveForward"): {
                        GVAR(targetHelperPos) = [_xPos + 0.01, _yPos, _zPos];
                    };
                    case (_key in actionKeys "MoveBack"): {
                        GVAR(targetHelperPos) = [_xPos - 0.01, _yPos, _zPos];
                    };
                    case (_key in actionKeys "TurnLeft"): {
                        GVAR(targetHelperPos) = [_xPos, _yPos - 0.01, _zPos];
                    };
                    case (_key in actionKeys "TurnRight"): {
                        GVAR(targetHelperPos) = [_xPos, _yPos + 0.01, _zPos];
                    };
                    case (_key in actionKeys "MoveUp"): {
                        GVAR(targetHelperPos) = [_xPos, _yPos, _zPos + 0.01];
                    };
                    case (_key in actionKeys "MoveDown"): {
                        GVAR(targetHelperPos) = [_xPos, _yPos, _zPos - 0.01];
                    };
                    case (_key in [57]): {
                        GVAR(cameraTarget) = false;
                    };
                    case (_key in [1]): {
                        deleteVehicle GVAR(viewHelper);
                        deleteVehicle GVAR(targetHelper);
                        deleteVehicle GVAR(TestDriver);
                        with uiNamespace do {
                            GVAR(pipDisplay) closeDisplay 2;
                        };
                        detach GVAR(DriverCam);
                        GVAR(DriverCam) cameraEffect ["terminate", "back", QGVAR(RTT)];
                        camDestroy GVAR(DriverCam);
                        hintSilent "copied view position and vehicle class to clipboard";
                        (findDisplay 46) displayRemoveEventHandler ["keyDown",GVAR(TestKeyHandler)];
                        copyToClipboard format ["Class: %1 Pos: %2 TargetPos: %3", typeOf GVAR(Vehicle), GVAR(viewHelperPos), GVAR(targetHelperPos)];
                    };
                    default {
                        _edited = false;
                    };
                };
                if (_edited) then {
                    GVAR(targetHelper) attachTo [GVAR(Vehicle), GVAR(targetHelperPos)];
                    GVAR(DriverCam) attachTo [GVAR(Vehicle), GVAR(viewHelperPos)];
                    GVAR(DriverCam) camSetTarget GVAR(targetHelper);
                    GVAR(DriverCam) camCommit 0;
                };
                _edited
            } else {
                GVAR(viewHelperPos) params [
                    "_xPos",
                    "_yPos",
                    "_zPos"
                ];
                private _edited = true;
                switch true do {
                    case (_key in actionKeys "MoveForward"): {
                        GVAR(viewHelperPos) = [_xPos + 0.01, _yPos, _zPos];
                    };
                    case (_key in actionKeys "MoveBack"): {
                        GVAR(viewHelperPos) = [_xPos - 0.01, _yPos, _zPos];
                    };
                    case (_key in actionKeys "TurnLeft"): {
                        GVAR(viewHelperPos) = [_xPos, _yPos - 0.01, _zPos];
                    };
                    case (_key in actionKeys "TurnRight"): {
                        GVAR(viewHelperPos) = [_xPos, _yPos + 0.01, _zPos];
                    };
                    case (_key in actionKeys "MoveUp"): {
                        GVAR(viewHelperPos) = [_xPos, _yPos, _zPos + 0.01];
                    };
                    case (_key in actionKeys "MoveDown"): {
                        GVAR(viewHelperPos) = [_xPos, _yPos, _zPos - 0.01];
                    };
                    case (_key in [57]): {
                        GVAR(cameraTarget) = true;
                    };
                    case (_key in [1]): {
                        deleteVehicle GVAR(viewHelper);
                        deleteVehicle GVAR(targetHelper);
                        deleteVehicle GVAR(TestDriver);
                        with uiNamespace do {
                            GVAR(pipDisplay) closeDisplay 2;
                        };
                        detach GVAR(DriverCam);
                        GVAR(DriverCam) cameraEffect ["terminate", "back", QGVAR(RTT)];
                        camDestroy GVAR(DriverCam);
                        hintSilent "copied view position and vehicle class to clipboard";
                        (findDisplay 46) displayRemoveEventHandler ["keyDown",GVAR(TestKeyHandler)];
                        copyToClipboard format ["Class: %1 Pos: %2 TargetPos: %3", typeOf GVAR(Vehicle), GVAR(viewHelperPos), GVAR(targetHelperPos)];
                    };
                    default {
                        _edited = false;
                    };
                };
                if (_edited) then {
                    GVAR(viewHelper) attachTo [GVAR(Vehicle), GVAR(viewHelperPos)];
                    GVAR(DriverCam) attachTo [GVAR(Vehicle), GVAR(viewHelperPos)];
                    GVAR(DriverCam) camSetTarget GVAR(targetHelper);
                    GVAR(DriverCam) camCommit 0;
                };
                _edited
            };
        }];

    },{true}] call ace_interact_menu_fnc_createAction;
    ["LandVehicle", 0, ["ACE_MainActions"], _debugAddAction, true] call ace_interact_menu_fnc_addActionToClass;
} else {
    private _addAction = ["ai_driver","Add AI driver","",{
        [_target, _player] call FUNC(createDriver);
    },{
        (vehicle _player == _target) &&
        {isNull (GETVAR(_target,driver,objnull))} &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {GVAR(Vehicle) in [objNull, vehicle _player]}
    }] call ace_interact_menu_fnc_createAction;

    private _removeAction = ["ai_driver","Remove AI driver","",{
        [_target] call FUNC(removeDriver);
    },{
        (vehicle _player == _target) &&
        {!isNull (GETVAR(_target,driver,objnull))} &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {GVAR(Vehicle) in [objNull, vehicle _player]}
    }] call ace_interact_menu_fnc_createAction;

    //unflip action
    private _unflipAction = ["ai_driver_unflip","Unflip vehicle","",{
        [_target, surfaceNormal position _target] remoteExec ["setVectorUp", _target, false];
        (getposATL _target) params ["_xPos","_yPos","_zPos"];
        _target setPosATL [_xPos, _yPos, _zPos + 2];
    },{
        (vehicle _player == _target) &&
        {!isNull (GETVAR(_target,driver,objnull))} &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {(vectorUp _target) select 2 < 0}
    }] call ace_interact_menu_fnc_createAction;

    //engine off action
    private _engineOffAction = ["ai_driver_engineoff","Turn off engine","",{
        [_target, false] remoteExec ["engineOn", _target];
    },{
        (vehicle _player == _target) &&
        {!isNull (GETVAR(_target,driver,objnull))} &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {isEngineOn _target}
    }] call ace_interact_menu_fnc_createAction;

    //PIP action
    private _pipAction = ["ai_driver_pip","Enable/Disable driver's view","",{
        (isNil QGVAR(DriverCam) || {isNull GVAR(DriverCam)}) call FUNC(ToggleDriverCam);
    },{
        (vehicle _player == _target) &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {!isNull (GETVAR(_target,driver,objnull))}
    }] call ace_interact_menu_fnc_createAction;

    //move PIP action
    private _movePIPAction = ["ai_driver_pip","Switch driver view location","",{
        with uiNamespace do {
            if (GVAR(driverPipDisplayBottom)) then {
                GVAR(driverPipDisplayBottom) = false;
                GVAR(driverPipDisplay) ctrlSetPosition GVAR(topDisplay);
                GVAR(driverPipDisplay) ctrlCommit 0;
            } else {
                GVAR(driverPipDisplayBottom) = true;
                GVAR(driverPipDisplay) ctrlSetPosition GVAR(bottomDisplay);
                GVAR(driverPipDisplay) ctrlCommit 0;
            };
        };
    },{
        (vehicle _player isEqualTo _target) &&
        {effectiveCommander vehicle _player isEqualTo _player} &&
        {!isNull (GETVAR(_target,driver,objnull))} &&
        {!isNil QGVAR(DriverCam) && {!isNull GVAR(DriverCam)}} &&
        {uiNamespace getVariable [QGVAR(pipDisplay), displayNull] isNotEqualTo displayNull} &&
        {uiNamespace getVariable [QGVAR(driverPipDisplay), controlNull] isNotEqualTo controlNull}
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
    private _selectVehicles = GETMVAR(selectVehicles, []);

    if (GETMVAR(AllCars, false)) then {
        GVAR(VehicleClasses) pushBackUnique "Car";
        _vehClasses = _vehClasses select {!(_x isKindOf "Car")};
        _vehClasses pushBackUnique "Car";
        _selectVehicles = _selectVehicles select {!(_x isKindOf "Car")};
    };

    if (GETMVAR(AllTanks, false)) then {
        GVAR(VehicleClasses) pushBackUnique "Tank";
        _vehClasses = _vehClasses select {!(_x isKindOf "Tank")};
        _vehClasses pushBackUnique "Tank";
        _selectVehicles = _selectVehicles select {!(_x isKindOf "Tank")};
    };

    if (GETMVAR(AllShips, false)) then {
        GVAR(VehicleClasses) pushBackUnique "Ship";
        _vehClasses = _vehClasses select {!(_x isKindOf "Ship")};
        _vehClasses pushBackUnique "Ship";
        _selectVehicles = _selectVehicles select {!(_x isKindOf "Ship")};
    };

    if (_selectVehicles isNotEqualTo []) then {
        _selectVehicles select {
            private _veh = _x;
            (_vehClasses findIf {_veh isKindOf _x}) isEqualTo -1
        } apply {
            [{missionNamespace getvariable [(_this select 0), objNull] isNotEqualTo objNull}, {
                params ["_veh", "_addAction", "_removeAction", "_engineOffAction", "_pipAction", "_unflipAction", "_pipNvAction"];
                _veh = missionNamespace getvariable [_veh, objNull];

                [_veh, 1, ["ACE_SelfActions"], _addAction] call ace_interact_menu_fnc_addActionToObject;
                [_veh, 1, ["ACE_SelfActions"], _removeAction] call ace_interact_menu_fnc_addActionToObject;
                [_veh, 1, ["ACE_SelfActions"], _engineOffAction] call ace_interact_menu_fnc_addActionToObject;
                [_veh, 1, ["ACE_SelfActions"], _pipAction] call ace_interact_menu_fnc_addActionToObject;
                [_veh, 1, ["ACE_SelfActions"], _movePIPAction] call ace_interact_menu_fnc_addActionToObject;
                if (GETMVAR(FlipAction, false)) then {
                    [_veh, 1, ["ACE_SelfActions"], _unflipAction] call ace_interact_menu_fnc_addActionToObject;
                };
                if (GETMVAR(NVGAction, false)) then {
                    [_veh, 1, ["ACE_SelfActions"], _pipNvAction] call ace_interact_menu_fnc_addActionToObject;
                };
            }, [_x, _addAction, _removeAction, _engineOffAction, _pipAction, _unflipAction, _pipNvAction]] call CBA_fnc_waitUntilAndExecute;
        };
    };

    if (_vehClasses isNotEqualTo []) then {
        _vehClasses apply {
            private _class = _x;
            [_class, 1, ["ACE_SelfActions"], _addAction, true] call ace_interact_menu_fnc_addActionToClass;
            [_class, 1, ["ACE_SelfActions"], _removeAction, true] call ace_interact_menu_fnc_addActionToClass;
            [_class, 1, ["ACE_SelfActions"], _engineOffAction, true] call ace_interact_menu_fnc_addActionToClass;
            [_class, 1, ["ACE_SelfActions"], _pipAction, true] call ace_interact_menu_fnc_addActionToClass;
            [_class, 1, ["ACE_SelfActions"], _movePIPAction, true] call ace_interact_menu_fnc_addActionToClass;
            if (GETMVAR(FlipAction, false)) then {
                [_class, 1, ["ACE_SelfActions"], _unflipAction, true] call ace_interact_menu_fnc_addActionToClass;
            };
            if (GETMVAR(NVGAction, false)) then {
                [_class, 1, ["ACE_SelfActions"], _pipNvAction, true] call ace_interact_menu_fnc_addActionToClass;
            };
        };
    };
};
