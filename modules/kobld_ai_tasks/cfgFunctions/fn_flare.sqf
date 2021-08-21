#include "..\script_component.hpp"

params ["_group"];

private _flare = "F_20mm_Red" createVehicle ((leader _group) ModelToWorld [0,0,300]);

_flare setVelocity [0,0,-10];

_magColor = [0.5,0.25,0.25];

_flareLight = "#lightpoint" createVehicle position _flare;
_flareLight lightAttachObject [_flare, [0,0,0]];

[_flareLight,15] remoteExec ["setLightBrightness",0];
[_flareLight,false] remoteExec ["setLightUseFlare",0];
[_flareLight,_magColor] remoteExec ["setLightColor",0];

[{(getPosATL (_this # 0) # 2) < 1}, {
	if (alive (_this # 0)) then {deleteVehicle (_this # 0)};
	if (alive (_this # 1)) then {deleteVehicle (_this # 1)};
}, [_flare,_flareLight], 40, {
	if (alive (_this # 0)) then {deleteVehicle (_this # 0)};
	if (alive (_this # 1)) then {deleteVehicle (_this # 1)};
}] call CBA_fnc_waitUntilAndExecute;