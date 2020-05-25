#include "..\..\script_macros.hpp"

params ["_unit", ["_target", objnull, [objnull]]];

if (_target isEqualTo objnull) exitwith {false}; 
 
private _relDir = _unit getRelDir _target; 
 
(_relDir > 270 || _relDir < 90)
