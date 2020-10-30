// AUTHORS: TinfoilHate and StatusRed
#include "script_component.hpp"

params ["_keepMapClasses", "_keepCompassClasses"];

[{CBA_missionTime > 1}, {
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
			private _inKeepCompass = _gear in _keepCompassClasses;

			if (_inKeepMap || _inKeepCompass) then {
				if (_inKeepCompass && (!_inKeepMap)) then {
					_unit unlinkItem "ItemMap";
				};
			} else {
				_unit unlinkItem "ItemMap";
				_unit unlinkItem "ItemCompass";
			};
		};
	} forEach allUnits;
}, [_keepMapClasses, _keepCompassClasses]] call CBA_fnc_waitUntilAndExecute;
