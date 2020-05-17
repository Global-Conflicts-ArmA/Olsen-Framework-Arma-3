// AUTHOR: StatusRed (EM-Creations.co.uk)

// Register this module
["Knock Down", "Allows melee knocking out of units.", "StatusRed, Krause"] call FUNC(RegisterModule);

if (hasInterface) then { // As this module is client-side only, only continue if this is a client
	#include "settings.sqf"

	private _key = "knock_down";
	private _title = "Knock Down";

	private _condition = {
		((side player) in FRAMEWORK_KNOCKDOWN_TEAMS)
	};

	private _statement = {
	    [FRAMEWORK_KNOCKDOWN_WEAPONS, FRAMEWORK_KNOCKDOWN_REVIVE_ACTION] call KnockDown_fnc_KnockDownAction;
	};

	private _action = [_key, _title, "", _statement, _condition] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	private _keybindCode = {
		if ((side player) in FRAMEWORK_KNOCKDOWN_TEAMS) then {
			[FRAMEWORK_KNOCKDOWN_WEAPONS, FRAMEWORK_KNOCKDOWN_REVIVE_ACTION] call KnockDown_fnc_KnockDownAction;
		};
	};

	["Framework", _key, _title, _keybindCode, "",
	[FRAMEWORK_KNOCKDOWN_KEY, [FRAMEWORK_KNOCKDOWN_KEY_SHIFT, FRAMEWORK_KNOCKDOWN_KEY_CONTROL, FRAMEWORK_KNOCKDOWN_KEY_ALT]]] call CBA_fnc_addKeybind;
};
