#include "script_component.hpp"

private _paraflare_baseMenu = ["paraflare_baseClass", "Paraflares", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions"], _paraflare_baseMenu, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireWhite = ["paraflare_fireWhite", "Launch White", "", {
	["FlareWhite_F"] call FUNC(flareFire);
}, {
	vehicle player == player && "FlareWhite_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireWhite, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireGreen = ["paraflare_fireGreen", "Launch Green", "", {
	["FlareGreen_F"] call FUNC(flareFire);
}, {
	vehicle player == player && "FlareGreen_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireGreen, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireYellow = ["paraflare_fireYellow", "Launch Yellow", "", {
	["FlareYellow_F"] call FUNC(flareFire);
}, {
	vehicle player == player && "FlareYellow_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireYellow, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireRed = ["paraflare_fireRed", "Launch Red", "", {
	["FlareRed_F"] call FUNC(flareFire);
}, {
	vehicle player == player && "FlareRed_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireRed, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleMenu = ["paraflare_angleClass", "Launch Angle", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_angleMenu, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleVertical = ["paraflare_angleVertical", "Vertical", "", {GVAR(flareAngle) = 10}, {
	vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleVertical, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleSteep = ["paraflare_angleSteep", "Steep", "", {GVAR(flareAngle) = 45}, {
	vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleSteep, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleShallow = ["paraflare_angleShallow", "Shallow", "", {GVAR(flareAngle) = 90}, {
	vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleShallow, true] call ace_interact_menu_fnc_addActionToClass;
