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

    GVAR(Time) = switch (side ace_player) do {
        case blufor: {GVAR(BLUFOR_Time)};
        case opfor: {GVAR(OPFOR_Time)};
        case independent: {GVAR(INDFOR_Time)};
        case civilian: {GVAR(CIVFOR_Time)};
        default {GVAR(BLUFOR_Time)};
    };

    GVAR(Distance) = switch (side ace_player) do {
        case blufor: {GVAR(BLUFOR_Distance)};
        case opfor: {GVAR(OPFOR_Distance)};
        case independent: {GVAR(INDFOR_Distance)};
        case civilian: {GVAR(CIVFOR_Distance)};
        default {GVAR(BLUFOR_Distance)};
    };

    [{
        ((GETMVAR(Time,30)) <= 0 || {CBA_missionTime >= GETMVAR(Time,30)})
        && {(GETMVAR(Distance,200)) <= 0 || {((EGETMVAR(FW,SpawnPos,getpos player)) distance player) >= GETMVAR(Distance,200)}}
    },{
        params ["_eh"];
        [ACE_player, "DefaultAction", _eh] call ace_common_fnc_removeActionEventHandler;
        ace_player setVariable ["ace_common_effect_blockThrow", 0];
        SETPLVAR(EHid, "DISABLED");
        SETPLVAR(Active, false);
    }, [_FiredEh]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_waitUntilAndExecute;
