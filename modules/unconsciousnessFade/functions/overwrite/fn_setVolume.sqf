#include "\z\ace\addons\common\script_component.hpp"

#define MUTED_LEVEL  0.2
#define NORMAL_LEVEL 1
#define NO_SOUND     0

params [
    ["_restore", false, [false]],
    ["_unit", player, [objNull]],
    ["_fadeSpeed", 2, [2]],
    ["_volume", -1, [-1]]
];

if (_volume isEqualTo -1) then {
    _volume = [MUTED_LEVEL, NORMAL_LEVEL] select _restore;
};

_fadeSpeed fadeSound _volume;
_unit setVariable ["tf_globalVolume", _volume];
if (!isNil "acre_api_fnc_setGlobalVolume") then { [_volume] call acre_api_fnc_setGlobalVolume; };
