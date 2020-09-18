#include "script_component.hpp"
params ["_fort","_unit"];

if (isNull _fort) exitWith {};

private _type = typeOf _fort;
private _size = [_type] call FUNC(getObjectSize);

private _objPackUpTimeAuto = 15*(_size);
private _objPackUpTime = [_type, "packUpTime"] call FUNC(getConfigValue);
private _packUpTime = _objPackUpTime * (_unit getVariable [QGVAR(packUpTimeFactor),GVAR(packUpTimeFactor)]);


[_unit,(configFile >> "ACE_Repair" >> "Actions" >> "FullRepair")] call FUNC(doAnimation);
private _onComplete = {
    private _args = _this select 0;
    _args params ["_fort","_unit","_type"];
    [_unit] call FUNC(stopAnimation);

    private _pos = getPos _fort;
    deleteVehicle _fort;
    [_unit,_type] call FUNC(addFort);
};
private _onCancel = {
    private _args = _this select 0;
    _args params ["_fort","_unit"];
    [_unit] call FUNC(stopAnimation);
};
[_packUpTime, [_fort,_unit,_type], _onComplete, _onCancel, "Packing up..."] call ace_common_fnc_progressBar;
