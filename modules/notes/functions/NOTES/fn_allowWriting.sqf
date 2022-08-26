#include "script_component.hpp"

params ["_unit","_allow"];
if (!isServer && {!local _unit}) exitWith {};

_unit setVariable [QGVAR(canWriteNotes), _allow, true];
