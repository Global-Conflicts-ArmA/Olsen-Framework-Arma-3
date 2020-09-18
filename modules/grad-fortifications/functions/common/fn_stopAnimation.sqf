/*  Credits to ACE-team - this is from the repair component, slightly modified
*
*/

#include "script_component.hpp"
params ["_caller"];

if (primaryWeapon _caller == "ACE_FakePrimaryWeapon") then {
    _caller removeWeapon "ACE_FakePrimaryWeapon";
};
if (vehicle _caller == _caller) then {
    [_caller, _caller getVariable ["uo_prevAnimCaller", ""], 2] call ace_common_fnc_doAnimation;
};
_caller setVariable ["uo_prevAnimCaller", nil];

private _weaponSelect = (_caller getVariable ["uo_selectedWeaponOnAnimation", ""]);
if (_weaponSelect != "") then {
    _caller selectWeapon _weaponSelect;
} else {
    [_caller] call ACE_weaponSelect_fnc_putWeaponAway;
};
