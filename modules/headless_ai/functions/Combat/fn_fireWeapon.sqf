#include "script_component.hpp"


//unit 1, unit 2
params [["_unit", objnull, [objnull]]];

private _isVehicle = (vehicle _unit != _unit);

if (_isVehicle) then {
    (vehicle _unit) fireAtTarget [objnull];
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_1("vehicle %1 attempting to fire weapon",_unit);
    };
} else {
    //private _weaponType = ((currentWeapon _unit) call BIS_fnc_itemType) select 1;
    private _fireMode = currentWeaponMode _unit;
    //if (_weaponType isEqualTo "MachineGun") then {
        private _weaponModes = (getArray (configFile >> "CfgWeapons" >> (currentWeapon _unit) >> "modes"));
        _fireMode = switch (true) do {
            case ("FullAuto" in _weaponModes): {
                "FullAuto"
            };
            case ("close" in _weaponModes): {
                "close"
            };
            case ("medium" in _weaponModes): {
                "medium"
            };
            default {
                currentWeaponMode _unit
            };
        };
    //};
    _unit forceWeaponFire [currentWeapon (vehicle _unit), _fireMode];
    if (GETMVAR(VerboseDebug,false)) then {
        LOG_2("%1 attempting to fire weapon in mode %2",_unit,_fireMode);
    };
};
