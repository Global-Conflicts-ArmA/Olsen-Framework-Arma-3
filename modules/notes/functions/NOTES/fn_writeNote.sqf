#include "script_component.hpp"

if ((player getVariable [QGVAR(amount), 0 ]) <= 0) exitWith {hint "I'm out of paper."};
["WRITE"] call FUNC(loadUI);
