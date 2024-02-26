#include "script_component.hpp"

params ["_unit"];

private _stance = GETVAR(_unit,stance,"");
private _stanceGroup = GETVAR(group _unit,stance,"");
// manual stance overrides this system
if (_stance isNotEqualTo "" || {_stanceGroup isNotEqualTo ""}) exitWith {};
private _originalStance = [stance _unit] call FUNC(getStance);

_unit addEventHandler ["Suppressed", {
	params ["_unit", "_distance", "_shooter", "_instigator", "_ammoObject", "_ammoClassName", "_ammoConfig"];
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
}];

//LOG_2("stanceMachine set: %1 with originalStance: %2",_unit,_originalStance);

SETVAR(_unit,originalStance,_originalStance);
SETVAR(_unit,US_SetStance,false);
