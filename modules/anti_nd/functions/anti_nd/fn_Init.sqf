#include "script_component.hpp"
#include "..\..\settings.sqf"

[{(!isNull ace_player)}, {
    private _FiredEh = player addEventHandler ["FiredMan", {
        params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_vehicle"];
        deleteVehicle _projectile;
        if (_magazine call BIS_fnc_isThrowable) then {
            player addMagazine _magazine;
        } else {
            private _curWeapon = currentWeapon player;
            player setAmmo [_curWeapon, (player ammo _curWeapon) + 1];
        };
        private _timeRemaining = round (GVAR(Time) - CBA_missionTime);
        private _distance = (EGETMVAR(FW,SpawnPos,getpos player)) distance player;
        if (_distance >= GVAR(Distance)) then {
            [["Anti-ND protection active!<br/>Time Remaining: %1 seconds.", _timeRemaining]] call EFUNC(FW,parsedTextDisplay);
        } else {
            [["Anti-ND protection active!<br/>Distance from Base: %1 out of %2 meters.<br/>Time Remaining: %3 seconds.", _distance, round GVAR(Distance), _timeRemaining]] call EFUNC(FW,parsedTextDisplay);
        };
    }];
    SETPLVAR(EHid,_FiredEh);
    SETPLVAR(Active,true);

    [{
        ((GETMVAR(Time,30)) isEqualTo 0 || {CBA_missionTime >= GETMVAR(Time,30)})
        && {(GETMVAR(Distance,200) isEqualTo 0) || {((EGETMVAR(FW,SpawnPos,getpos player)) distance player) >= GETMVAR(Distance,200)}}
    },{
        private _eh = (_this select 0);
        player removeEventHandler ["FiredMan", _eh];
        SETPLVAR(EHid,"DISABLED");
        SETPLVAR(Active,false);
    }, [_FiredEh]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
