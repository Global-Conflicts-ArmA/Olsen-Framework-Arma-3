#include "script_component.hpp"

[{CBA_missionTime >= 0},
{
  if (local (_this select 0)) exitWith
  {
    ["Event_ArtPlayerJipped", _this] call CBA_fnc_serverEvent;
  };
},
_this, 1] call CBA_fnc_waitUntilAndExecute;
