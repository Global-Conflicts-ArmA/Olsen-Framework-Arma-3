#include "script_component.hpp"

GVAR(Markers) = [];

#include "settings.sqf"

GVAR(Markers) apply {
  _x params[
    ["_side", blufor, [blufor]],
    ["_marker", "", [""]],
    ["_deleteAfterStart", false, [false]]
  ];

  private _playerSide = (side player);

  if (_side != _playerSide) then {
    _marker setMarkerAlphaLocal 0;
  };
};

[{CBA_missionTime > 0},
{
  _this apply {
    _x params[
      ["_side", blufor, [blufor]],
      ["_marker", "", [""]],
      ["_deleteAfterStart", false, [false]]
    ];

    if (_deleteAfterStart) then {
      _marker setMarkerAlphaLocal 0;
    };
  };
}, GVAR(Markers)] call CBA_fnc_waitUntilAndExecute;
