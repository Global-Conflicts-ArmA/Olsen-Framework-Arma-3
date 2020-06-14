#include "script_component.hpp"
params ["_fort","_unit"];

if (isNull _fort) exitWith {};

private _type = typeOf _fort;
private _size = [_type] call FUNC(getObjectSize);

private _objDemolitionTimeAuto = 10*(_size);
private _objDemolitionTime = [_type, "demolitionTime"] call FUNC(getConfigValue);
private _ownerFactor = if ([_fort,_unit] call FUNC(isOwner)) then {0.5} else {1};
private _demolitionTime = _ownerFactor * _objDemolitionTime * (_unit getVariable [QGVAR(demolishTimeFactor),GVAR(demolishTimeFactor)]);

[_unit,(configFile >> "ACE_Repair" >> "Actions" >> "FullRepair")] call FUNC(doAnimation);
private _onComplete = {
    private _args = _this select 0;
    _args params ["_fort","_unit"];
    [_unit] call FUNC(stopAnimation);
    deleteVehicle _fort;
};
private _onCancel = {
    private _args = _this select 0;
    _args params ["_fort","_unit"];
    [_unit] call FUNC(stopAnimation);
};
[_demolitionTime, [_fort,_unit], _onComplete, _onCancel, "Demolishing..."] call ace_common_fnc_progressBar;
