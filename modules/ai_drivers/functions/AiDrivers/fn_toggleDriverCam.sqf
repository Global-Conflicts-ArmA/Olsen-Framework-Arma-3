#include "script_component.hpp"

params [["_arg", false, [false]]];

if (_arg) then {
    GVAR(DriverCam) = "camera" camCreate [0,0,0];
    GVAR(DriverCam) cameraEffect ["INTERNAL", "BACK", QGVAR(RTT)];
    GVAR(DriverCam) camSetFov 0.9;
    GVAR(DriverCam) camCommit 0;

    SETMVAR(pipNvEnabled,true);

    private _veh = vehicle player;
    private _mempoint = getText ( configfile >> "CfgVehicles" >> (typeOf _veh) >> "memoryPointDriverOptics" );
    GVAR(DriverCam) attachTo [_veh,[0,0,0], _mempoint];

    with uiNamespace do {
        QGVAR(PiPDriverLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
        GVAR(pipDisplay) = uiNamespace getVariable "RscTitleDisplayEmpty";
        GVAR(driverPipDisplay) = GVAR(pipDisplay) ctrlCreate ["RscPicture", -1];
        GVAR(driverPipDisplay) ctrlSetPosition [0.1,1,0.75,0.5];
        GVAR(driverPipDisplay) ctrlCommit 0;
        GVAR(driverPipDisplay) ctrlSetText ("#(argb,512,512,1)r2t(" + QGVAR(RTT) + ",1.0)");
    };
} else {
    if (!(isNil QGVAR(DriverCam)) && {!isNull GVAR(DriverCam)}) then {
        with uiNamespace do {
            GVAR(pipDisplay) closeDisplay 2;
        };
        detach GVAR(DriverCam);
        GVAR(DriverCam) cameraEffect ["terminate", "back", QGVAR(RTT)];
        camDestroy GVAR(DriverCam);
    };
};
