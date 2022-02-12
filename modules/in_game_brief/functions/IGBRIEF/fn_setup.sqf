#include "script_component.hpp"

params[
  ["_marker", "", [""]],
  ["_side", blufor, [blufor]]
];

/* diag_log format ["INFO: In setup.. _logic = %1, _radius = %2, _side = %3", _logic, _radius, _side]; */

private _pos = getMarkerPos _marker;
private _dir = markerDir _marker;
private _size = getMarkerSize _marker;
private _startedVarName = "sandi_setup_done_" + (str _side);
SETMVAR(_startedVarName, false);

if (isServer) then { // server
  [{GETMVAR(missionStarter, false)}, {
    _this params ["_startedVarName"];

    SETMVAR(_startedVarName, true);
    }, [_startedVarName]] call CBA_fnc_waitUntilAndExecute;
};

if (hasInterface) then { // player
  /* diag_log format ["INFO: Player setting up..."]; */
  [{!isNull player}, {
    _this params ["_startedVarName", "_side", "_pos", "_size", "_dir", "_marker"];

    /* diag_log format ["INFO: side player = %1, _side = %2", (side player), _side]; */
    if (side player == _side) then {
      /* LOG("Side setting up..."); */
      if !(GETMVAR(_startedVarName, false)) then { // setup
        // make barrier
        private _barrierHandle = [_pos, (_size select 0), (_size select 1), _dir, "rectangle", "The setup area ends here"] call FUNC(register);

        [{GETMVAR(_startedVarName, false)},
        {
          _this params ["_barrierHandle", "_marker"];
          GVAR(sandi_barrier_barriers) set [_barrierHandle, 0]; // Set barrier state to false
          deleteMarkerLocal _marker;
        }, [_barrierHandle, _marker]] call CBA_fnc_waitUntilAndExecute;
      };
    };
  }, [_startedVarName, _side, _pos, _size, _dir, _marker]] call CBA_fnc_waitUntilAndExecute;
};
