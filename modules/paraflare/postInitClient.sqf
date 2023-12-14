#include "script_component.hpp"
//[ACE_player] call CBA_fnc_canUseWeapon
// launch flares

private _paraflare_baseMenu = ["paraflare_baseClass", "Paraflares", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions"], _paraflare_baseMenu, true] call ace_interact_menu_fnc_addActionToClass;

// ace throwable flares

private _paraflare_fireWhite_ace = ["paraflare_fireWhite", "Launch White", "\A3\Weapons_f\Data\UI\gear_flare_white_ca.paa", {
	["ACE_HandFlare_White"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "ACE_HandFlare_White" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireWhite_ace, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireGreen_ace = ["paraflare_fireGreen", "Launch Green", "\A3\Weapons_f\Data\UI\gear_flare_green_ca.paa", {
	["ACE_HandFlare_Green"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "ACE_HandFlare_Green" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireGreen_ace, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireYellow_ace = ["paraflare_fireYellow", "Launch Yellow", "\A3\Weapons_f\Data\UI\gear_flare_yellow_ca.paa", {
	["ACE_HandFlare_Yellow"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "ACE_HandFlare_Yellow" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireYellow_ace, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireRed_ace = ["paraflare_fireRed", "Launch Red", "\A3\Weapons_f\Data\UI\gear_flare_red_ca.paa", {
	["ACE_HandFlare_Red"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "ACE_HandFlare_Red" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireRed_ace, true] call ace_interact_menu_fnc_addActionToClass;

// karts flaregun ammo

private _paraflare_fireWhite_karts = ["paraflare_fireWhite", "Launch White", "\A3\Weapons_f\Data\UI\gear_flare_white_ca.paa", {
	["FlareWhite_F"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "FlareWhite_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireWhite_karts, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireGreen_karts = ["paraflare_fireGreen", "Launch Green", "\A3\Weapons_f\Data\UI\gear_flare_green_ca.paa", {
	["FlareGreen_F"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "FlareGreen_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireGreen_karts, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireYellow_karts = ["paraflare_fireYellow", "Launch Yellow", "\A3\Weapons_f\Data\UI\gear_flare_yellow_ca.paa", {
	["FlareYellow_F"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "FlareYellow_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireYellow_karts, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireRed_karts = ["paraflare_fireRed", "Launch Red", "\A3\Weapons_f\Data\UI\gear_flare_red_ca.paa", {
	["FlareRed_F"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "FlareRed_F" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireRed_karts, true] call ace_interact_menu_fnc_addActionToClass;

// SOG dispoable Flarelauncher Ammo

private _paraflare_fireWhite_sog = ["paraflare_fireWhite", "Launch White", "\A3\Weapons_f\Data\UI\gear_flare_white_ca.paa", {
	["vn_m127_mag"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "vn_m127_mag" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireWhite_sog, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireGreen_sog = ["paraflare_fireGreen", "Launch Green", "\A3\Weapons_f\Data\UI\gear_flare_green_ca.paa", {
	["vn_m128_mag"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "vn_m128_mag" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions","paraflare_baseClass"], _paraflare_fireGreen_sog, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_fireRed_sog = ["paraflare_fireRed", "Launch Red", "\A3\Weapons_f\Data\UI\gear_flare_red_ca.paa", {
	["vn_m129_mag"] call FUNC(flareFire);
}, {
	[ACE_player] call CBA_fnc_canUseWeapon && "vn_m129_mag" in (magazines player)
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_fireRed_sog, true] call ace_interact_menu_fnc_addActionToClass;

// set Angles 

private _paraflare_angleMenu = ["paraflare_angleClass", "Launch Angle", "", {}, {true}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass"], _paraflare_angleMenu, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleVertical = ["paraflare_angleVertical", "Vertical", "", {GVAR(flareAngle) = 90}, {
	[ACE_player] call CBA_fnc_canUseWeapon && {"ACE_HandFlare_White" in (magazines player) || "ACE_HandFlare_Green" in (magazines player) || "ACE_HandFlare_Yellow" in (magazines player) || "ACE_HandFlare_Red" in (magazines player) || "FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player) || "vn_m127_mag" in (magazines player) || "vn_m128_mag" in (magazines player) || "vn_m129_mag" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleVertical, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleSteep = ["paraflare_angleSteep", "Steep", "", {GVAR(flareAngle) = 50}, {
	[ACE_player] call CBA_fnc_canUseWeapon && {"ACE_HandFlare_White" in (magazines player) || "ACE_HandFlare_Green" in (magazines player) || "ACE_HandFlare_Yellow" in (magazines player) || "ACE_HandFlare_Red" in (magazines player) || "FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player) || "vn_m127_mag" in (magazines player) || "vn_m128_mag" in (magazines player) || "vn_m129_mag" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleSteep, true] call ace_interact_menu_fnc_addActionToClass;

private _paraflare_angleShallow = ["paraflare_angleShallow", "Shallow", "", {GVAR(flareAngle) = 15}, {
	[ACE_player] call CBA_fnc_canUseWeapon && {"ACE_HandFlare_White" in (magazines player) || "ACE_HandFlare_Green" in (magazines player) || "ACE_HandFlare_Yellow" in (magazines player) || "ACE_HandFlare_Red" in (magazines player) || "FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player) || "vn_m127_mag" in (magazines player) || "vn_m128_mag" in (magazines player) || "vn_m129_mag" in (magazines player)}
}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "paraflare_baseClass", "paraflare_angleClass"], _paraflare_angleShallow, true] call ace_interact_menu_fnc_addActionToClass;
