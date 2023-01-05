#include "script_component.hpp"

params [
    ["_unit", objNull, [objNull]],
    ["_markerName", "", [""]],
    ["_joinGroup", true, [true]],
    ["_careless", false, [false]],
    ["_sitDown", true, [true]]
];

if (_markerName isEqualTo "") exitwith {
    ERROR_1("Hostage Rescue Area not defined: %1!",_unit);
};
if (markerColor _markerName isEqualto "") exitWith {
    ERROR_2("Hostage Rescue marker for unit: %1 does not exist: %2!",_unit,_markerName);
};
LOG_2("%1 set to hostage with rescue area of %2", _unit, _markerName);

SETVAR(_unit,IsUntied,false);
SETVAR(_unit,IsRescued,false);
SETVAR(_unit,FreedJoinSquad,_joinGroup);
SETVAR(_unit,FreedBehaviorModifier,_careless);

[{(CBA_missionTime > 0)},{
    params [
        ["_unit", objNull, [objNull]],
        ["_markerName", "", [""]],
        ["_sitDown", true, [true]]
    ];

    [QGVAR(ACEActionsEvent), [_unit]] call CBA_fnc_globalEventJiP;
    _unit setBehaviour "CARELESS";
    _unit allowFleeing 0;
    _unit setCaptive true;
    [_unit, "Acts_AidlPsitMstpSsurWnonDnon04", 1] call ace_common_fnc_doAnimation;
    _unit disableAI "MOVE";

    //IGNORE_PRIVATE_WARNING ["_thisID","_thisType"];
    private _EhAnimDone = [_unit, "AnimDone", {
        params ["_unit", "_anim"];
        if ((!alive _unit) || (GETVAR(_unit,IsRescued,false)) || (GETVAR(_unit,IsUntied,false))) exitWith {
            _unit removeEventHandler [_thisType, _thisID];
        };
        [_unit, "Acts_AidlPsitMstpSsurWnonDnon04", 1] call ace_common_fnc_doAnimation;
    }, []] call CBA_fnc_addBISEventHandler;

    SETVAR(_unit,EhAnimDone,_EhAnimDone);

    [{
        params ["_argNested", "_idPFH"];
        _argNested params [
            ["_unit", objNull, [objNull]],
            ["_markerName", "", [""]],
            ["_sitDown", true, [true]]
        ];
        /* diag_log format ["Checking.. untied? %1 in area? %2", (GETVAR(_unit, IsUntied, false)), (_unit inArea _markerName)]; */
        if ((animationState _unit != "acts_aidlpsitmstpssurwnondnon04") && {(GETVAR(_unit,IsUntied,false))} && {(_unit inArea _markerName)}) exitwith {
          /* diag_log "Rescued exiting.."; */
            if ((vehicle _unit) isEqualto _unit) then {
                [_unit] joinSilent grpNull;
                _unit disableAI "MOVE";
                if (_sitDown) then {
                    [_unit, "AmovPsitMstpSnonWnonDnon_ground", 1] call ace_common_fnc_doAnimation;
                    _unit disableAI "ANIM";
                };
            };
            /* diag_log "Setting var!"; */
            SETPVAR(_unit,IsRescued, true);
            /* diag_log format ["Var set to: %1", GETVAR(_unit, IsRescued, false)]; */
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
        if (GETVAR(_unit,IsRescued, false)) exitWith {
            [_idPFH] call CBA_fnc_removePerFrameHandler;
        };
    }, 5, [_unit, _markerName, _sitDown]] call CBA_fnc_addPerFrameHandler;
}, [_unit, _markerName, _sitDown]] call CBA_fnc_WaitUntilAndExecute;
