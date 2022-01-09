// AUTHORS: TinfoilHate and StatusRed
#include "script_component.hpp"

params ["_keepMapClasses", "_keepCompassClasses"];

[{CBA_missionTime > 1}, {
	private _keepMapClasses = (_this select 0);
	private _keepCompassClasses = (_this select 1);

		_gear = (player getVariable [QGVAR(Loadout), ""]);
		if (isNil _gear) then {
			_gear = "NO VALUE FOUND";
		};

		if (local player) then {
			private _inKeepMap = _gear in _keepMapClasses;
			private _inKeepCompass = _gear in _keepCompassClasses;

			if (_inKeepMap || _inKeepCompass) then {
				if (_inKeepCompass && (!_inKeepMap)) then {
					player unlinkItem "ItemMap";
				};
			} else {
				player unlinkItem "ItemMap";
				player unlinkItem "ItemCompass";
			};
		};
}, [_keepMapClasses, _keepCompassClasses]] call CBA_fnc_waitUntilAndExecute;
