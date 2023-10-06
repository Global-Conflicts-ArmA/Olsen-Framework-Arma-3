#include "script_component.hpp"


//unit 1, unit 2
params [
    ["_unit", objNull, [objNull]],
    ["_chosenMuzzle", [], [[]]]
];

if (INVEHICLE(_unit)) then {
    private _invisibleTarget = [_unit] call FUNC(targetHelper);
    private _vehWeapons = weapons (vehicle _unit);
    private _selectedWeapon = _vehWeapons select 0;
    private _ambientFireMuzzles = vehicle _unit getVariable [QGVAR(ambientFireMuzzles), []];
    if (_ambientFireMuzzles isNotEqualTo []) then {
        if (_ambientFireMuzzles isEqualType []) then {
            _selectedWeapon = _vehWeapons select (selectRandom _ambientFireMuzzles);
        } else {
            if (_ambientFireMuzzles isEqualType 0) then {
                _selectedWeapon = _vehWeapons select _ambientFireMuzzles;
            };
        };
    } else {
        _selectedWeapon = selectRandom _vehWeapons
    };
    //TRACE_3("vehicle weapon list",_unit,_vehWeapons,_selectedWeapon);
    (vehicle _unit) fireAtTarget [_invisibleTarget, _selectedWeapon];
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_1("vehicle %1 attempting to fire weapon",_unit);
    };
} else {
    //private _weaponType = ((currentWeapon _unit) call BIS_fnc_itemType) select 1;
    if (_chosenMuzzle isEqualTo []) then {
        private _fireMode = currentWeaponMode _unit;
        _unit forceWeaponFire [currentWeapon _unit, _fireMode];
        if (GETMVAR(VerboseDebug,false)) then {
            LOG_2("%1 attempting to fire weapon in mode %2",_unit,_fireMode);
        };
    } else {
        _unit forceWeaponFire _chosenMuzzle;
        if (GETMVAR(VerboseDebug,false)) then {
            LOG_2("%1 attempting to fire weapon %2",_unit,_chosenMuzzle);
        };
    };
    // TODO: cache weapon modes and choose better
    //if (_weaponType isEqualTo "MachineGun") then {
        //private _weaponModes = (getArray (configFile >> "CfgWeapons" >> (primaryWeapon _unit) >> "modes"));
        //_fireMode = switch (true) do {
        //    case ("FullAuto" in _weaponModes): {
        //        "FullAuto"
        //    };
        //    case ("close" in _weaponModes): {
        //        "close"
        //    };
        //    case ("medium" in _weaponModes): {
        //        "medium"
        //    };
        //    default {
        //        currentWeaponMode _unit
        //    };
        //};
    //};
};
