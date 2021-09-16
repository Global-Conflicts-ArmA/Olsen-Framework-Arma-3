#include "script_component.hpp"

GVAR(Markers) = [];

#include "settings.sqf"

GVAR(Markers) apply {
  diag_log format ["INFO: Markers processing: %1", GVAR(Markers)];

  private _side = (_x select 0);
  private _marker = (_x select 1);
  private _playerSide = (side player);

  if (_side != _playerSide) then {
    _marker setMarkerAlphaLocal 0;
  };
};

[{CBA_missionTime > 0},
{
  _this apply {
    private _marker = (_x select 1);
    private _deleteAfterStart = (_x select 2);

    if (_deleteAfterStart) then {
      _marker setMarkerAlphaLocal 0;
    };
  };
}, GVAR(Markers)] call CBA_fnc_waitUntilAndExecute;
