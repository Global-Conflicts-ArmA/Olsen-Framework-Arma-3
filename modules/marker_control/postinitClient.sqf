#include "script_component.hpp"

GVAR(Markers) = [];

#include "settings.sqf"

{
  private _side = (_x select 0);
  private _marker = (_x select 1);
  private _playerSide = (side player);

  if (_side != _playerSide) then {
    _marker setMarkerAlphaLocal 0;
  };
} forEach GVAR(Markers);

[{CBA_MissionTime > 0},
{
  {
    private _marker = (_x select 1);
    private _deleteAfterStart = (_x select 2);

    if (_deleteAfterStart) then {
      _marker setMarkerAlphaLocal 0;
    };
  } forEach _this;
}, GVAR(Markers)] call CBA_fnc_WaitUntilAndExecute;
