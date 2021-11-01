#include "script_component.hpp"

params ["_group"];

private _flare = "F_20mm_Red" createVehicle ((leader _group) ModelToWorld [0,0,300]);

_flare setVelocity [0,0,-10];

private _magColor = [0.5,0.25,0.25];

private _flareLight = "#lightpoint" createVehicle position _flare;
_flareLight lightAttachObject [_flare, [0,0,0]];

[_flareLight,15] remoteExec ["setLightBrightness",0];
[_flareLight,false] remoteExec ["setLightUseFlare",0];
[_flareLight,_magColor] remoteExec ["setLightColor",0];

[{(getPosATL (_this select 0) select 2) < 1}, {
	if (alive (_this select 0)) then {deleteVehicle (_this select 0)};
	if (alive (_this select 1)) then {deleteVehicle (_this select 1)};
}, [_flare,_flareLight], 40, {
	if (alive (_this select 0)) then {deleteVehicle (_this select 0)};
	if (alive (_this select 1)) then {deleteVehicle (_this select 1)};
}] call CBA_fnc_waitUntilAndExecute;
