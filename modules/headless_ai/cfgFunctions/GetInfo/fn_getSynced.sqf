#include "..\..\script_macros.hpp"


params ["_logic"];
private _synced = synchronizedObjects _logic;
//LOG_1("command _synced %1",_synced);
{
    private _obj = _x;
    if (_obj isKindOf "StaticWeapon"
        || _obj isKindOf "Static"
        || _obj isKindOf "Air"
        || _obj isKindOf "Ship"
        || _obj isKindOf "LandVehicle"
    ) then {
        _synced = _synced + (units _obj);
        _synced = _synced + (assignedCargo _obj);
    };
} foreach _synced;
_synced = _synced arrayIntersect _synced;
//LOG_1("return _synced %1",_synced);
_synced