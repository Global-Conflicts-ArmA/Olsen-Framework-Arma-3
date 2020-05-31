#include "script_component.hpp"

if (GETMVAR(StartOnSafe,true)) then {
	if !(currentWeapon player isEqualTo "") then {
        [player, currentWeapon player, currentMuzzle player] call ace_safemode_fnc_lockSafety;
        if (GETMVAR(StartOnSafe_Lowered,true)) then {
            player action ["WeaponOnBack", player];
        };
        if (GETMVAR(StartOnSafe_Unloaded,true)) then {
            private _magazineClass = currentMagazine player;
            [player, _magazineClass, -1, true] call CBA_fnc_addMagazine;
            player removePrimaryWeaponItem _magazineClass;
        } else {
			private _ammo = player ammo currentWeapon player;
			player setAmmo [currentWeapon player, 0];
			[{
				params ["_ammo"];
			    player setAmmo [currentWeapon player, _ammo];
			}, [_ammo], 0.1] call CBA_fnc_waitAndExecute;
		};
    };
};