
	kobld_paraflare_baseMenu = ["kobld_paraflare_baseClass", "Paraflares", "", {}, {true}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions"], kobld_paraflare_baseMenu, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_fireWhite = ["kobld_paraflare_fireWhite", "Launch White", "", {
		["FlareWhite_F"] spawn kobld_paraflare_fnc_flareFire;
	}, {
		vehicle player == player && "FlareWhite_F" in (magazines player)
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass"], kobld_paraflare_fireWhite, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_fireGreen = ["kobld_paraflare_fireGreen", "Launch Green", "", {
		["FlareGreen_F"] spawn kobld_paraflare_fnc_flareFire;
	}, {
		vehicle player == player && "FlareGreen_F" in (magazines player)
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass"], kobld_paraflare_fireGreen, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_fireYellow = ["kobld_paraflare_fireYellow", "Launch Yellow", "", {
		["FlareYellow_F"] spawn kobld_paraflare_fnc_flareFire;
	}, {
		vehicle player == player && "FlareYellow_F" in (magazines player)
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass"], kobld_paraflare_fireYellow, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_fireRed = ["kobld_paraflare_fireRed", "Launch Red", "", {
		["FlareRed_F"] spawn kobld_paraflare_fnc_flareFire;
	}, {
		vehicle player == player && "FlareRed_F" in (magazines player)
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass"], kobld_paraflare_fireRed, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_angleMenu = ["kobld_paraflare_angleClass", "Launch Angle", "", {}, {true}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass"], kobld_paraflare_angleMenu, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_angleVertical = ["kobld_paraflare_angleVertical", "Vertical", "", {kobld_paraflare_flareAngle = 10}, {
		vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass","kobld_paraflare_angleClass"], kobld_paraflare_angleVertical, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_angleSteep = ["kobld_paraflare_angleSteep", "Steep", "", {kobld_paraflare_flareAngle = 45}, {
		vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass","kobld_paraflare_angleClass"], kobld_paraflare_angleSteep, true] call ace_interact_menu_fnc_addActionToClass;

	kobld_paraflare_angleShallow = ["kobld_paraflare_angleShallow", "Shallow", "", {kobld_paraflare_flareAngle = 90}, {
		vehicle player == player && {"FlareWhite_F" in (magazines player) || "FlareGreen_F" in (magazines player) || "FlareYellow_F" in (magazines player) || "FlareRed_F" in (magazines player)}
	}] call ace_interact_menu_fnc_createAction;
	[typeOf player, 1, ["ACE_SelfActions","kobld_paraflare_baseClass","kobld_paraflare_angleClass"], kobld_paraflare_angleShallow, true] call ace_interact_menu_fnc_addActionToClass;