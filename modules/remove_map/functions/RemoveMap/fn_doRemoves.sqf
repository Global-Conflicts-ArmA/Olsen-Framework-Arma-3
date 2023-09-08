#include "script_component.hpp"

[{CBA_missionTime > 1}, {
    params ["_keepMapClasses", "_keepCompassClasses"];
	if (local player) then {
        private _gear = player getVariable [QEGVAR(FW,Loadout), "NO VALUE FOUND"];
        if (_gear in _keepMapClasses) exitWith {};
        player unlinkItem "ItemMap";
        if (_gear in _keepCompassClasses) exitWith {};
        player unlinkItem "ItemCompass";
	};
}, _this] call CBA_fnc_waitUntilAndExecute;
