#include "script_component.hpp"

#include "settings.sqf"

if (GVAR(SetupTimers) isEqualto []) exitWith {};
GVAR(SetupTimers) apply {
    [{(!isNull ace_player) && {!isNull findDisplay 46}}, {
        params [
            ["_area", "", [""]],
            ["_waitTime", 30, [30]],
            ["_sides", [], [[]]]
        ];
        if (CBA_missionTime > _waitTime) exitwith {};
        if (!((side player) in _sides) || !((vehicle player) inArea _area)) exitwith {};
        private _alreadyInATimer = GETMVAR(InSetupTimer,false);
        if (_alreadyInATimer) exitwith {};
        SETMVAR(InSetupTimer,true);
        SETMVAR(WaitTime,_waitTime);
        (QGVAR(Layer) call BIS_fnc_rscLayer) cutRsc [QGVAR(DisplayRsc), "PLAIN", 0.5, false];
        LOG("Starting Setup Timer");
        GVAR(PFHhandle_Main) = [{
            params ["_argNested", "_idPFH"];
            _argNested params ["_unit","_area","_endTime","_pos"];
            private _timeLeft = (_endTime - CBA_missionTime);
            if (_timeLeft <= 0) exitwith {
                LOG_1("%1 exited SetupTimer PFHandle Main",_unit);
                [_idPFH] call CBA_fnc_removePerFrameHandler;
            };
            if ((vehicle _unit) inArea _area) then {
                _pos = getPosATL (vehicle _unit);
                _argNested set [3,_pos];
            } else {
                (vehicle _unit) setVelocity [0,0,0];
                (vehicle _unit) setPosATL _pos;
            };
        }, 0, [player,_area,_waitTime]] call CBA_fnc_addPerFrameHandler;
    }, _x] call CBA_fnc_waitUntilAndExecute;
};
