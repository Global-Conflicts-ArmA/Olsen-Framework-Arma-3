#include "script_component.hpp"

params ["_unit", ["_target", objNull, [objNull]]];

if (_target isEqualTo objNull) exitwith {false}; 
 
private _relDir = _unit getRelDir _target; 
 
(_relDir > 270 || _relDir < 90)
