#include "script_component.hpp"

#include "..\..\settings.sqf"

[{!(isNull ACE_player)}, {
  private _colour = GETVAR(player, teamColour, "NONE");

  if (_colour != "NONE") then {
  	["CBA_teamColorChanged", [player, _colour]] call CBA_fnc_globalEvent;
    SETVAR(player, teamColour, nil);

  };
}, []] call CBA_fnc_waitUntilAndExecute;
