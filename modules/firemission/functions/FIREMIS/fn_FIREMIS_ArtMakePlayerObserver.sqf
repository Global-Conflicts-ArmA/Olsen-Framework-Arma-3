#include "script_component.hpp"

#include "..\..\Dia\defs.hpp"

_this spawn
{
  while{time <= 0} do
  {
    sleep(1);
  };
  if (local (_this select 0)) exitWith
  {
    ["Event_ArtPlayerJipped",_this] call CBA_fnc_serverEvent;
  };

};
