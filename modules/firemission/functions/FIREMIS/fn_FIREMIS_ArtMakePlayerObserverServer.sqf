#include "script_component.hpp"

params[
  ["_unit", objNull, [objNull]],
  ["_guns", [], [[]]]
];

if (isServer) then
{
  _unit setVariable [VAR_SART_OBSGUNS,_guns,true];
  ["Event_ReceiveFoGuns",_guns,_unit] call CBA_fnc_targetEvent;
};
