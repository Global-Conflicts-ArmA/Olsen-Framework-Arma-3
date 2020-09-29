#include "..\..\script_macros.hpp"

params [
    ["_logic", objnull, [objnull]]
];

private _synced = synchronizedObjects _logic;
LOG_1("command _synced %1",_synced);

_synced apply {
    private _obj = _x;
    if (
        _obj isKindOf "Air" || 
        _obj isKindOf "Ship" || 
        _obj isKindOf "LandVehicle" || 
        _obj isKindOf "StaticWeapon" || 
        _obj isKindOf "Static"
    ) then {
        _synced append (units _obj);
        _synced append (assignedCargo _obj);
    };
};

_synced = _synced arrayIntersect _synced;
LOG_1("return _synced %1",_synced);
_synced