#include "script_component.hpp"

params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];

if !(local _unit) exitwith {};

_suppressionImmunity = GETVAR(_unit,suppressionImmunity,false);
if (!(_suppressionImmunity) && _distance < 10) then {
	_increase = 10 - _distance;
	_suppressionFactor = GETVAR(_unit,suppressionFactor,0);
	SETVAR(_unit,suppressionFactor,_suppressionFactor + _increase);
	[{
		params ["_unit", "_increase"];
		_suppressionFactor = GETVAR(_unit,suppressionFactor,0);
		if (_suppressionFactor > 0) then {
			SETVAR(_unit,suppressionFactor,_suppressionFactor - _increase);
		};
	}, [_unit, _increase], 5] call CBA_fnc_waitAndExecute;
};
