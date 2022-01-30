#include "script_component.hpp"


params ["_functions","_delay"];
[{
    {
        private _logic = _x;
        // Where is getSyncedModules declared?
        private _posModules = [_logic,[QGVAR(PositionModule)]] call FUNC(getSyncedModules);
        private _spos = [0,0,0];
        if ( count _posModules > 0) then {
            private _pos = getPosATL (_posModules select 0);
            if (((_posModules select 0) getVariable [QGVAR(PositionRadius),0]) > 0) then {
                _spos = [_pos,0,(GETVAR((_posModules select 0),PositionRadius,0)),1] call FUNC(getRandomPositionCircle);
            } else {
                _spos = _pos;
            };
        };
        switch (typeof _logic) do {
            //Function Types - spawns at synced position module if found, if not found spawns at function module pos
            default {};
        };
    } forEach _functions;
}, [], _delay] call CBA_fnc_waitAndExecute;
