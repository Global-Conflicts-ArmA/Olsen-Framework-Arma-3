#include "script_component.hpp"

params[
  ["_logic", objNull, [objNull]],
  ["_radius", 180, [180]],
  ["_side", blufor, [blufor]]
];

/* diag_log format ["INFO: In setup.. _logic = %1, _radius = %2, _side = %3", _logic, _radius, _side]; */

private _pos = getPos _logic;
private _dir = getDir _logic;
private _startedVarName = "sandi_setup_done_" + (str _side);

if (isServer) then { // server
  [{GVAR(missionStarter)}, {
    _this params ["_startedVarName"];

    GVAR(_startedVarName) = true;
    }, [_startedVarName]] call CBA_fnc_waitUntilAndExecute;
};

if (hasInterface) then { // player
  /* diag_log format ["INFO: Player setting up..."]; */
  [{!isNull player}, {
    _this params ["_startedVarName", "_side", "_pos", "_radius", "_dir"];

    /* diag_log format ["INFO: side player = %1, _side = %2", (side player), _side]; */
    if (side player == _side) then {
      /* diag_log format ["INFO: Side setting up..."]; */
      if (isNil QGVAR(_startedVarName)) then { // setup
        private _name = "setup_" + str _side;
        createMarkerLocal [_name, _pos];
        //_name setMarkerDir _dir;
        _name setMarkerDirLocal _dir;
        _name setMarkerShapeLocal "RECTANGLE";
        _name setMarkerSizeLocal [_radius, _radius];
        _name setMarkerBrushLocal "Border";
        if (_side == west) then {
          _name setMarkerColorLocal "ColorBlue";
        };
        if (_side == east) then {
          _name setMarkerColorLocal "ColorRed";
        };

        // make barrier
        private _barrierHandle = [_pos, _radius, _radius, _dir, "rectangle", "The setup area ends here"] call FUNC(register);

        [{!isNil QGVAR(_startedVarName)},
        {
          _this params ["_barrierHandle", "_markerName"];

          GVAR(sandi_barrier_barriers) set [_barrierHandle, 0]; // Set barrier state to false
          deleteMarkerLocal _markerName;
        }, [_barrierHandle, _name]] call CBA_fnc_waitUntilAndExecute;
      };
    };
  }, [_startedVarName, _side, _pos, _radius, _dir]] call CBA_fnc_waitUntilAndExecute;
};
