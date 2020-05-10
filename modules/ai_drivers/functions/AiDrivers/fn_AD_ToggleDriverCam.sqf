#include "script_component.hpp"

params [["_arg", false, [false]]];

if (_arg) then {
    GVAR(AD_DriverCam) = "camera" camCreate [0,0,0];
    GVAR(AD_DriverCam) cameraEffect ["INTERNAL", "BACK", QGVAR(AD_RTT)];
    GVAR(AD_DriverCam) camSetFov 0.9;
    GVAR(AD_DriverCam) camCommit 0;

    SETMVAR(AD_pipNvEnabled,true);

    private _veh = vehicle player;
    private _mempoint = getText ( configfile >> "CfgVehicles" >> (typeOf _veh) >> "memoryPointDriverOptics" );
    GVAR(AD_DriverCam) attachTo [_veh,[0,0,0], _mempoint];

    with uiNamespace do {
        QGVAR(AD_PiPDriverLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN"];
        GVAR(AD_pipDisplay) = uiNamespace getVariable "RscTitleDisplayEmpty";
        GVAR(AD_driverPipDisplay) = GVAR(AD_pipDisplay) ctrlCreate ["RscPicture", -1];
        GVAR(AD_driverPipDisplay) ctrlSetPosition [0.1,1,0.75,0.5];
        GVAR(AD_driverPipDisplay) ctrlCommit 0;
        GVAR(AD_driverPipDisplay) ctrlSetText ("#(argb,512,512,1)r2t(" + QGVAR(AD_RTT) + ",1.0)");
    };
} else {
    if (!(isNil QGVAR(AD_DriverCam)) && {!isNull GVAR(AD_DriverCam)}) then {
        with uiNamespace do {
            GVAR(AD_pipDisplay) closeDisplay 2;
        };
        detach GVAR(AD_DriverCam);
        GVAR(AD_DriverCam) cameraEffect ["terminate", "back", QGVAR(AD_RTT)];
        camDestroy GVAR(AD_DriverCam);
    };
};
