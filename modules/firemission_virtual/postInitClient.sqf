#include "script_component.hpp"

["tin_evt_menu_addMission", FUNC(menu_addMission)] call CBA_fnc_addEventHandler;
["tin_evt_grid_addMarkers", FUNC(grid_addMarkers)] call CBA_fnc_addEventHandler;

[{!isNil "tin_var_fireMissions_west"}, {
	switch (side player) do {
		case west: {
			tin_var_fireMissions_west apply {
				["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
			};
		};
		case east: {
			tin_var_fireMissions_east apply {
				["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
			};
		};
		case independent: {
			tin_var_fireMissions_independent apply {
				["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
			};
		};
		case civilian: {
			tin_var_fireMissions_civilian apply {
				["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
			};
		};
		default {false};
	};
}] call CBA_fnc_waitUntilAndExecute;

[{!isNil "tin_var_artyObservers"}, {
	private _action = ["Artillery_Menu", "Firemission", "", {true}, {
		private _radioList = [] call acre_api_fnc_getCurrentRadioList;
		private _ret = false;
		_radioList apply {
			switch (side player) do {
				case west: {
					if ([_x] call acre_api_fnc_getRadioChannel == tin_var_artyFreq_west && !([_x, "ACRE_PRC343"] call acre_api_fnc_isKindOf)) then {
						_ret = true;
					};
				};
				case east: {
					if ([_x] call acre_api_fnc_getRadioChannel == tin_var_artyFreq_east && !([_x, "ACRE_PRC343"] call acre_api_fnc_isKindOf)) then {
						_ret = true;
					};
				};
				case independent: {
					if ([_x] call acre_api_fnc_getRadioChannel == tin_var_artyFreq_independent && !([_x, "ACRE_PRC343"] call acre_api_fnc_isKindOf)) then {
						_ret = true;
					};
				};
				case civilian: {
					if ([_x] call acre_api_fnc_getRadioChannel == tin_var_artyFreq_civilian && !([_x, "ACRE_PRC343"] call acre_api_fnc_isKindOf)) then {
						_ret = true;
					};
				};
			};
		};

		if (count tin_var_artyObservers > 0 && _ret) then {
			private _flag = false;
			tin_var_artyObservers apply {
				_x params ["_name"];

				switch (typeName _name) do {
					case "OBJECT": {
						if (player == _name) then {_flag = true};
					};
					case "GROUP": {
						if (player in (units _name)) then {_flag = true};
					};

					default {
						hintSilent format ["DEBUG: NAME %1 IS NOT AN OBJECT OR GROUP NAME, OR IS UNDEFINED", _name];
					};
				};
			};

			if (!_flag) then {_ret = false};
		};

		_ret
	}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["PolarFiremission", "New", "", {
		[] call FUNC(dia_PolarFiremissionOpenDialog);
	}, {true}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

	_action = ["CompletedFiremission", "Completed", "", {true}, {
		switch (side player) do {
			case west: {count tin_var_fireMissions_west > 0};
			case east: {count tin_var_fireMissions_east > 0};
			case independent: {count tin_var_fireMissions_independent > 0};
			case civilian: {count tin_var_fireMissions_civilian > 0};
			default {false};
		};
	}] call ace_interact_menu_fnc_createAction;
	[player, 1, ["ACE_SelfActions","Artillery_Menu"], _action] call ace_interact_menu_fnc_addActionToObject;

	//Generates the cancellation and repeat options for fired missions /////
	private _insertChildren = {
		params ["_target", "_player", "_params"];
		//hint format ["_insertChildren [%1]", _params];

		// Add children to this action
		private _actions = [];

		private _childStatement = {
			params ["_target", "_player", "_array"];

			_array params ["_id","_cancel","_subArray"];
			_subArray params ["_obs", "_name", "_selectedAmmo", "_selectedGrid", "_selectedMils", "_selectedDist", "_selectedRnds", "_selectedGuns"];

			_subArray set [0, _player];

			_array = [_id, _cancel, _subArray];

			["tin_evt_callPolarFiremissionRepeat", _array] call CBA_fnc_serverEvent;
		};
		private _action = ["RepeatMission", "Repeat Mission", "", _childStatement, {true}, {}, _this # 2] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _target]; // NEW ACTION, CHILDREN, TARGET

		private _childStatement = {
			params ["_target", "_player", "_array"];

			[_array # 0, true, side _player] call FUNC(array_setMissionCancel);
		};
		private _action = ["CancelMission", "Cancel Mission", "", _childStatement, {true}, {}, _this # 2] call ace_interact_menu_fnc_createAction;
		_actions pushBack [_action, [], _target]; // NEW ACTION, CHILDREN, TARGET

		_actions
	};

	private _addFnc = {
		private _modifierFunc = {
			params ["_target", "_player", "_params", "_actionData"];
			//hint format ["_modifierFunc [%1]", _params];

			_actionData set [1, format ["%1", (_params # 0)]];	//#1 Display Name #2 Icon
		};

		_action = [
			(_x # 0) + "_" + str(_x # 2 # 13),
			"?",
			"",
			{true},
			{true},
			_insertChildren,
			_x,
			"",
			4,
			[false, false, false, true, false],
			_modifierFunc
		] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions","Artillery_Menu","CompletedFiremission"], _action] call ace_interact_menu_fnc_addActionToObject;
	};

	switch (side player) do {
		case west: {tin_var_fireMissions_west apply {_x call _addFnc}};
		case east: {tin_var_fireMissions_east apply {_x call _addFnc}};
		case independent: {tin_var_fireMissions_independent apply {_x call _addFnc}};
		case civilian: {tin_var_fireMissions_civilian apply {_x call _addFnc}};
	};
	////////////////////////////////////////////////////////////////////////

}, [player]] call CBA_fnc_waitUntilAndExecute;
