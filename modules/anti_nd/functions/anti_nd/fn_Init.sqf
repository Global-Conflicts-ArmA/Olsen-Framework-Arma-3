#include "script_component.hpp"
#include "..\..\settings.sqf"

[{(!isNull ace_player)}, {
    private _firedEH = [ACE_player, "DefaultAction", {true}, {
        private _canFire = (_this select 1) getVariable [QGVAR(Active), false];
        if (_canFire) exitWith {false};
        true
    }] call ace_common_fnc_addActionEventHandler;

    ace_player setVariable ["ace_common_effect_blockThrow", 1];
    SETPLVAR(EHid, _FiredEh);
    SETPLVAR(Active, true);

    [{
        ((GETMVAR(Time,30)) isEqualTo 0 || {CBA_missionTime >= GETMVAR(Time,30)})
        && {(GETMVAR(Distance,200)) isEqualTo 0 || {((EGETMVAR(FW,SpawnPos,getpos player)) distance player) >= GETMVAR(Distance,200)}}
    },{
        params ["_eh"];
        [ACE_player, "DefaultAction", _eh] call ace_common_fnc_removeActionEventHandler;
        ace_player setVariable ["ace_common_effect_blockThrow", 0];
        SETPLVAR(EHid, "DISABLED");
        SETPLVAR(Active, false);
    }, [_FiredEh]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
