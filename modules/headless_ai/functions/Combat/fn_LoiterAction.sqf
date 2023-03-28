#include "script_component.hpp"

params [
    ["_group", grpNull, [grpNull]]
];

_group setBehaviour "SAFE";
_group setSpeedMode "LIMITED";
private _leaderPos = getPosATL leader _group;

[{
    params ["_argNested", "_idPFH"];
    _argNested params ["_group", "_leaderPos"];
    private _leader = leader _group;
    // exit loiter upon enemy contact
    if (
        behaviour _leader in ["COMBAT","STEALTH"] &&
        {_leader findNearestEnemy _leader isNotEqualTo objNull}
    ) exitWith {
        units _group apply {
            [_x, "", 1] call ace_common_fnc_doAnimation;
            _x doFollow _leader;
        };
        [_group, _leader findNearestEnemy _leader] call FUNC(CombatResponse);
        [_idPFH] call CBA_fnc_removePerFrameHandler;
    };
    // choose random actions for units to do
    units _group apply {
        private _unit = _x;
        private _selectedAction = if (GETVAR(_unit,Sitting,false)) then {
            if (RNG(0.9)) then {
                "Sitting"
            } else {
                [_unit, "", 1] call ace_common_fnc_doAnimation;
                SETVAR(_unit,Sitting,false);
                selectRandom ["Wander", "Building"]
            };
        } else {
            selectRandom [
                //"Wander",
                "SitDown"//,
                //"Building"
            ]
        };
        private _sitting = GETVAR(_unit,Sitting,false);
        TRACE_3("",_unit,_selectedAction,_sitting);
        switch _selectedAction do {
            case "Sitting": {
                // continue sitting
                if (animationState _unit != "AidlPsitMstpSnonWnonDnon_ground00") then {
                    private _sitType = selectRandom ["AidlPsitMstpSnonWnonDnon_ground00"];
                    [_unit, _sitType, 1] call ace_common_fnc_doAnimation;
                    [_unit, "AnimDone", {
                        _this params ["_unit", "_anim"];
                        if (_anim == "AidlPsitMstpSnonWnonDnon_ground00") then {
                            doStop _unit;
                            SETVAR(_unit,Sitting,false);
                            _unit removeEventHandler [_thisType, _thisID];
                        };
                    }, []] call CBA_fnc_addBISEventHandler;
                };
            };
            case "SitDown": {
                [_unit, "", 1] call ace_common_fnc_doAnimation;
                _unit setUnitPos "AUTO";
                private _pos = [_leaderPos, 5 + random 10] call FUNC(randPos);
                _unit doMove _pos;
                [{
                    params ["_unit", "_pos"];
                    _unit distance _pos <= 2
                }, {
                    params ["_unit", "_pos"];
                    //doStop _unit;
                    private _sitType = selectRandom ["AidlPsitMstpSnonWnonDnon_ground00"];
                    [_unit, _sitType, 1] call ace_common_fnc_doAnimation;
                    [_unit, "AnimDone", {
                        _this params ["_unit", "_anim"];
                        if (_anim == "AidlPsitMstpSnonWnonDnon_ground00") then {
                            doStop _unit;
                            SETVAR(_unit,Sitting,false);
                            _unit removeEventHandler [_thisType, _thisID];
                        };
                    }, []] call CBA_fnc_addBISEventHandler;
                    SETVAR(_unit,Sitting,true);
                }, [_unit, _pos], 5, {
                    params ["_unit", "_pos"];
                    [_unit, "AnimDone", {
                        _this params ["_unit", "_anim"];
                        if (_anim == "AidlPsitMstpSnonWnonDnon_ground00") then {
                            doStop _unit;
                            SETVAR(_unit,Sitting,false);
                            _unit removeEventHandler [_thisType, _thisID];
                        };
                    }, []] call CBA_fnc_addBISEventHandler;
                }] call CBA_fnc_waitUntilAndExecute;
            };
            // default wander
            default {
                //[_unit, ""] call ace_common_fnc_doAnimation;
                //_unit setUnitPos "AUTO";
                //doStop _unit;
                //private _pos = [_leaderPos, 5 + random 10, "NO", "NO"] call FUNC(randPos);
                //_unit doMove _pos;
                //[{
                //    params ["_unit", "_pos"];
                //    _unit distance _pos <= 2
                //}, {
                //    params ["_unit", "_pos"];
                //    private _randomAnim = selectRandom ["Acts_CivilTalking_1","Acts_CivilTalking_2", "Acts_CivilIdle_1", "Acts_CivilIdle_2", "Acts_ShieldFromSun_loop"];
                //    [_unit, _randomAnim, 1] call ace_common_fnc_doAnimation;
                //}, [_unit, _pos], 8, {}] call CBA_fnc_waitUntilAndExecute;
            };
        };
    };
}, 10, [_group, _leaderPos]] call CBA_fnc_addPerFrameHandler;
