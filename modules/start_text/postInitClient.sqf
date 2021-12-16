#include "..\..\core\script_macros.hpp"

params ["_unit"];
/* diag_log format ["INFO: _unit = %1, player = %2", _unit, player]; */
if (!(local _unit) || (player != _unit)) exitWith {};

[] call FUNC(START_init);
