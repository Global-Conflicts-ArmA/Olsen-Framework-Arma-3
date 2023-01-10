#include "script_component.hpp"

params [
    ["_veh", objNull, [objNull]]
];

private _type = typeOf _veh;

if (isNil QGVAR(OpticsNamespace)) then {
    GVAR(OpticsNamespace) = createHashMap;
};

private _typesArray = [(configFile >> "CfgVehicles" >> _type), true] call BIS_fnc_returnParents;
TRACE_2("",_type,_typesArray);

private _index = _typesArray findIf {
    private _inHash = _x in GVAR(OpticsNamespace);
    TRACE_3("",_veh,_x,_inHash);
    _inHash
};

private _return = if (_index isEqualTo -1) then {
    private _mempoint = [configfile >> "CfgVehicles" >> _type, "memoryPointDriverOptics", ""] call BIS_fnc_returnConfigEntry;
    if (_mempoint isEqualType []) then {
        _mempoint = _mempoint select 0;
    };
    if (
        _mempoint isEqualTo "" ||
        {(_veh selectionPosition [_mempoint, "memory"]) isEqualTo [0,0,0]}
    ) then {
        ERROR_1("Driver mempoint not found, make a custom value in settings.hpp",_type);
        [0,0,0]
    } else {
        GVAR(OpticsNamespace) set [_type, _mempoint];
        TRACE_2("storing mempoint in namespace",_veh,_mempoint);
        _mempoint
    };
} else {
    private _selectedType = _typesArray select _index;
    GVAR(OpticsNamespace) getOrDefault [_selectedType, [[0,0,0], [0,0,0]]];
};

_return

//private _return = GVAR(OpticsNamespace) getOrDefault [_type, [0,0,0]];
//
//if (_return isEqualTo -1) then {
//    private _ammo = getText (configfile >> "CfgMagazines" >> _mag >> "Ammo");
//    private _sim = getText (configfile >> "CfgAmmo" >> _ammo >> "simulation");
//    GVAR(OpticsNamespace) set [_type, _return];
//};
//
//_return
