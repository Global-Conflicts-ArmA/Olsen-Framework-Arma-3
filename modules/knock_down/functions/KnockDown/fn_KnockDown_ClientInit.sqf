// AUTHOR: StatusRed
#include "script_component.hpp"

if (!hasInterface) exitWith {}; // As this module is client-side only, only continue if this is a client

#include "..\..\settings.sqf"

private _key = "knock_down";
private _title = "Knock Down";

private _condition = {
	((side player) in GVAR(KNOCKDOWN_TEAMS))
};

private _statement = {
    [GVAR(KNOCKDOWN_WEAPONS), GVAR(KNOCKDOWN_REVIVE_ACTION)] call FUNC(KnockDown_Action);
};

private _action = [_key, _title, "", _statement, _condition] call ace_interact_menu_fnc_createAction;
[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

private _keybindCode = {
	if ((side player) in GVAR(KNOCKDOWN_TEAMS)) then {
		[GVAR(KNOCKDOWN_WEAPONS), GVAR(KNOCKDOWN_REVIVE_ACTION)] call FUNC(KnockDown_Action);
	};
};

["Framework", _key, _title, _keybindCode, "",
[GVAR(KNOCKDOWN_KEY), [GVAR(KNOCKDOWN_KEY_SHIFT), GVAR(KNOCKDOWN_KEY_CONTROL), GVAR(KNOCKDOWN_KEY_ALT)]]] call CBA_fnc_addKeybind;
