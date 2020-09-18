#include "script_component.hpp"
params ["_type","_dir","_vectorUp","_posASL",["_owner",objNull]];

private _fort = createVehicle [_type, [0,0,0], [], 0, "NONE"];
_fort setDir _dir;
_fort setVectorUp _vectorUp;
_fort setPosASL _posASL;

[_fort,_owner] remoteExecCall [QFUNC(initFort),0,true];

private _onBuildComplete = [_type, "onBuildComplete"] call FUNC(getConfigValue);
[_owner,_fort] call compile _onBuildComplete;

_fort
