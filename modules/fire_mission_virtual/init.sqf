["Virtual Firemission", "Based upon Firemission by Sacher", "TinfoilHate"] call FNC_RegisterModule;

["tin_evt_fireMessage", tin_fnc_radio_fireMessage] call CBA_fnc_addEventHandler;

if (isServer) then {
	#include "settings.sqf"

	["tin_evt_callPolarFiremission", tin_fnc_dia_server_polarFiremissionFire] call CBA_fnc_addEventHandler;
	["tin_evt_callPolarFiremissionRepeat", tin_fnc_dia_server_polarFiremissionRepeat] call CBA_fnc_addEventHandler;
};

if (!isDedicated && hasInterface) then {
	["tin_evt_menu_addMission", tin_fnc_menu_addMission] call CBA_fnc_addEventHandler;
	["tin_evt_grid_addMarkers", tin_fnc_grid_addMarkers] call CBA_fnc_addEventHandler;

	[{!isNil "tin_var_fireMissions_west"}, {
		switch (side player) do {
			case west: {
				{
					["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
				} forEach tin_var_fireMissions_west;
			};
			case east: {
				{
					["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
				} forEach tin_var_fireMissions_east;
			};
			case independent: {
				{
					["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
				} forEach tin_var_fireMissions_independent;
			};
			case civilian: {
				{
					["tin_evt_grid_addMarkers", _x] call CBA_fnc_globalEvent;
				} forEach tin_var_fireMissions_civilian;
			};
			default {false};
		};
	}] call CBA_fnc_waitUntilAndExecute;

	[{!isNil "tin_var_artyObservers"}, {
		_action = ["Artillery_Menu", "Firemission", "", {true}, {
			_radioList = [] call acre_api_fnc_getCurrentRadioList;
			_ret = false;
			{
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
			} forEach _radioList;

			if (count tin_var_artyObservers > 0 && _ret) then {
				_flag = false;
				{
					_x params ["_name"];
					
					switch (typeName _name) do {
						case "OBJECT": {
							if (player == _name) then {_flag = true};
						};
						case "GROUP": {
							if (player in (units _name)) then {_flag = true};
						};

						default {
							hintSilent format ["DEBUG: NAME %1 IS NOT AN OBJECT OR GROUP NAME, OR IS UNDEFINED",_name];
						};
					};					
				} forEach tin_var_artyObservers;

				if (!_flag) then {_ret = false};
			};

			_ret
		}] call ace_interact_menu_fnc_createAction;
		[player, 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToObject;

		_action = ["PolarFiremission", "New", "", {
			[] call tin_fnc_dia_PolarFiremissionOpenDialog;
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
		_insertChildren = {
			params ["_target", "_player", "_params"];
			//hint format ["_insertChildren [%1]", _params];

			// Add children to this action
			private _actions = [];

			private _childStatement = {
				params ["_target", "_player", "_array"];

				_array params ["_id","_cancel","_subArray"];
				_subArray params ["_obs","_name","_selectedAmmo","_selectedGrid","_selectedMils","_selectedDist","_selectedRnds","_selectedGuns"];

				_subArray set [0,_player];

				_array = [_id,_cancel,_subArray];

				["tin_evt_callPolarFiremissionRepeat", _array] call CBA_fnc_serverEvent;
			};
			private _action = ["RepeatMission", "Repeat Mission", "", _childStatement, {true}, {}, _this # 2] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _target]; // NEW ACTION, CHILDREN, TARGET

			private _childStatement = {
				params ["_target", "_player", "_array"];

				[_array # 0,true,side _player] call tin_fnc_array_setMissionCancel;
			};
			private _action = ["CancelMission", "Cancel Mission", "", _childStatement, {true}, {}, _this # 2] call ace_interact_menu_fnc_createAction;
			_actions pushBack [_action, [], _target]; // NEW ACTION, CHILDREN, TARGET

			_actions
		};

		_addFnc = {
			_modifierFunc = {
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
			case west: {{_x call _addFnc} forEach tin_var_fireMissions_west};
			case east: {{_x call _addFnc} forEach tin_var_fireMissions_east};
			case independent: {{_x call _addFnc} forEach tin_var_fireMissions_independent};
			case civilian: {{_x call _addFnc} forEach tin_var_fireMissions_civilian};
		};
		////////////////////////////////////////////////////////////////////////

	}, [player]] call CBA_fnc_waitUntilAndExecute;
};