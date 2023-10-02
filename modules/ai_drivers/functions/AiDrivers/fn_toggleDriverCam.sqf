#include "script_component.hpp"

params [["_arg", false, [false]]];

if (_arg) then {
    GVAR(DriverCam) = "camera" camCreate [0,0,0];
    GVAR(DriverCam) cameraEffect ["INTERNAL", "BACK", QGVAR(RTT)];
    GVAR(DriverCam) camSetFov 0.9;
    GVAR(DriverCam) camCommit 0;

    SETMVAR(pipNvEnabled,true);

    private _veh = vehicle player;
    private _pos = [_veh] call FUNC(getDriverOpticsPos);
    TRACE_2("",_veh,_pos);
    if (_pos isEqualType "") then {
        GVAR(DriverCam) attachTo [_veh, [0,0,0], _pos];
    } else {
        _pos params ["_pos", "_targetPos"];
        //GVAR(DriverCam) attachTo [_veh, _pos];
        GVAR(DriverCam) setPosASL (_veh modelToWorldWorld _pos);
        //GVAR(DriverCamTarget) = "Sign_Sphere10cm_F" createVehicleLocal [0,0,0];
        //GVAR(DriverCamTarget) setobjecttexture [0,"#(rgb,8,8,3)color(1,0,0,1)"];
        //GVAR(DriverCamTarget) attachTo [_veh, _targetPos];
        GVAR(DriverCamTarget) setPosASL (_veh modelToWorldWorld _targetPos);
        GVAR(DriverCam) attachTo [_veh];
        GVAR(DriverCam) camSetTarget GVAR(DriverCamTarget);
        GVAR(DriverCam) camCommit 0;
        GVAR(DriverCamPFH) = [{
            params ["_args", "_pfhID"];
            _args params ["_veh", "_pos", "_targetPos"];
            if (isNull GVAR(DriverCamTarget)) exitWith {
                [_pfhID] call CBA_fnc_removePerFrameHandler;
            };
            //GVAR(DriverCam) setPosASL (_veh modelToWorldWorld _pos);
            GVAR(DriverCamTarget) setPosASL (_veh modelToWorldWorld _targetPos);
            //GVAR(DriverCam) camSetTarget GVAR(DriverCamTarget);
            //GVAR(DriverCam) camCommit 0;
        }, 0, [_veh, _pos, _targetPos]] call CBA_fnc_addPerFrameHandler;
    };

    with uiNamespace do {
        QGVAR(PiPDriverLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
        GVAR(pipDisplay) = uiNamespace getVariable "RscTitleDisplayEmpty";
        GVAR(driverPipDisplay) = GVAR(pipDisplay) ctrlCreate ["RscPicture", -1];
        GVAR(driverPipDisplay) ctrlSetPosition GVAR(bottomDisplay);
        GVAR(driverPipDisplay) ctrlCommit 0;
        GVAR(driverPipDisplay) ctrlSetText ("#(argb,512,512,1)r2t(" + QGVAR(RTT) + ",1.0)");
        GVAR(driverPipDisplayBottom) = true;
    };
} else {
    if (!(isNil QGVAR(DriverCam)) && {!isNull GVAR(DriverCam)}) then {
        with uiNamespace do {
            GVAR(pipDisplay) closeDisplay 2;
        };
        detach GVAR(DriverCam);
        GVAR(DriverCam) cameraEffect ["terminate", "back", QGVAR(RTT)];
        camDestroy GVAR(DriverCam);
        deleteVehicle GVAR(DriverCamTarget);
        [GVAR(DriverCamPFH)] call CBA_fnc_removePerFrameHandler;
    };
};
