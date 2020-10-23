// AUTHORS: TinfoilHate and StatusRed
#include "script_component.hpp"

params ["_keepMapClasses", "_keepCompassClasses"];

_keepMapClasses append _keepCompassClasses;

[{time > 1}, {
	private _keepMapClasses = (_this select 0);
	private _keepCompassClasses = (_this select 1);

	{
		_unit = _x;
		_gear = (_unit getVariable [QGVAR(Loadout), ""]);
		if (isNil _gear) then {
			_gear = "NO VALUE FOUND";
		};

		if (local _unit) then {
			private _inKeepMap = _gear in _keepMapClasses;
			private _inKeepCompass = _gear in _keepMapClasses;

			if (_inKeepMap) then {
				if (_inKeepCompass) then {
					_unit unlinkItem "ItemMap";
				} else {
					//Hooray, you're important!
				};
			} else {
				_unit unlinkItem "ItemMap";
				_unit unlinkItem "ItemCompass";
			};
		};
	} forEach allUnits;
}, [_keepMapClasses, _keepCompassClasses]] call CBA_fnc_waitUntilAndExecute;
