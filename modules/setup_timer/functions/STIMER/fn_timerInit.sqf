#include "script_component.hpp"

params ["_display"];
LOG("called Setup init");

[{!(displayNull isEqualto _this)}, {
    params ["_display"];
    LOG("Starting Setup waituntil");
    GVAR(PFHhandleDisplay)= [{
        params ["_argNested", "_idPFH"];
        _argNested params [
            "_endTime",
            "_nextBeep",
            "_colorSet",
            "_display"
        ];
        private _ctrlTime = _display displayCtrl 1003;
        private _timeLeft = (_endTime - CBA_missionTime);
        if (_timeLeft <= 0) exitWith {
            _ctrlTime ctrlSetText "00:00.000";
            [QGVAR(TimerEnded)] call BIS_fnc_showNotification;
            [_idPFH] call CBA_fnc_removePerFrameHandler;
            [{
                params ["_display"];
                _display closeDisplay 1;
            }, [_display], 3] call CBA_fnc_waitAndExecute;
        };
        if (CBA_missionTime >= _nextBeep) then {
            playSound "Beep_Target";
            _nextBeep = (_nextBeep + 1);
            _argNested set [1,_nextBeep];
        };
        if (_timeLeft <= 30) then {
            if (_timeLeft <= 10) then {
                _argNested set [2,["IGUI","ERROR_RGB"]];
            } else {
                _argNested set [2,["IGUI","WARNING_RGB"]];
            }
        };
        private _color = _colorSet call bis_fnc_displaycolorget;
        _ctrlTime ctrlSetTextColor _color;
        _ctrlTime ctrlSetText ([_timeLeft,"MM:SS.MS"] call bis_fnc_secondsToString);
    }, 0, [(GETMVAR(WaitTime,30)),((GETMVAR(WaitTime,30)) - 10),["IGUI","TEXT_RGB"],_display]] call CBA_fnc_addPerFrameHandler;
}, _display] call CBA_fnc_waitUntilAndExecute;
