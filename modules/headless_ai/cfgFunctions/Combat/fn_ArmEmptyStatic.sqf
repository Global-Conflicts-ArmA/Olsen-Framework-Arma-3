#include "..\..\script_macros.hpp"


params ["_unit"];

if !(GVAR(MountStatics)) exitWith {};
if (GVAR(MountStaticsDistance) > 100) then {
    GVAR(MountStaticsDistance) = 100;
};

private _pos = getPosATL _unit;
private _weapon = nearestObject [_pos,"StaticWeapon"];

if (isNull _weapon || {(_weapon distance _unit) > GVAR(MountStaticsDistance)}) exitWith {};

if (isNull (assignedGunner _weapon)) then {
    LOG_2("%1 attempting to mount empty static weapon: %2",_unit,_weapon);
    _unit doMove (getposATL _weapon);
    _unit assignAsGunner _weapon;
    [_unit] orderGetIn true;
    [{(((_this select 0) distance (_this select 1)) < 3) && {isNull (assignedGunner _weapon)}}, {
        params ["_unit","_weapon"];
        _unit moveInGunner _weapon;
        LOG_2("%1 mounting empty static weapon: %2",_unit,_weapon);
    }, [_unit,_weapon], 10, {
        params ["_unit","_weapon"];
        private _assignedGunner = assignedGunner _weapon;
        LOG_3("%1 failed to mount empty static weapon: %2 gunner of weapon: %3",_unit,_weapon,_assignedGunner);
    }] call CBA_fnc_waitUntilAndExecute;
};
