#include "..\..\core\script_macros.hpp"

zade_boc_onChest = ["zade_boc_onChest", "Backpack to Chest", "modules\backpack_on_chest\data\actions\onchest_ca.paa", {[_player] call FUNC(BPKCHST_UTIL_actionOnChest)}, {!(missionNamespace getVariable ['zade_boc_disabled',false]) && !(backpack _player isEqualTo '') && ([_player] call FUNC(BPKCHST_Chestpack) isEqualTo '')}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], zade_boc_onChest] call ace_interact_menu_fnc_addActionToClass;

zade_boc_onBack = ["zade_boc_onBack", "Backpack to Back", "modules\backpack_on_chest\data\actions\onback_ca.paa", {[_player] call FUNC(BPKCHST_UTIL_actionOnBack)}, {!(missionNamespace getVariable ['zade_boc_disabled',false]) && (backpack _player isEqualTo '') && !([_player] call FUNC(BPKCHST_Chestpack) isEqualTo '')}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], zade_boc_onBack] call ace_interact_menu_fnc_addActionToClass;

zade_boc_swap = ["zade_boc_swap", "Swap Backpack", "modules\backpack_on_chest\data\actions\swap_ca.paa", {[_player] call FUNC(BPKCHST_UTIL_actionSwap)}, {!(missionNamespace getVariable ['zade_boc_disabled',false]) && !(backpack _player isEqualTo '') && !([_player] call FUNC(BPKCHST_Chestpack) isEqualTo '')}] call ace_interact_menu_fnc_createAction;
[typeOf player, 1, ["ACE_SelfActions", "ACE_Equipment"], zade_boc_swap] call ace_interact_menu_fnc_addActionToClass;

_sounds = [] spawn {
	while {true} do {
		if (typeOf vehicle player == "Steerable_Parachute_F") then {
			_para = vehicle player;

			[[player,"paraOpen"],"say3D"] call BIS_fnc_MP;
			//_para say3D "paraOpen";

			0 = ["DynamicBlur", 400, [4]] spawn {
				params ["_name", "_priority", "_effect", "_handle"];
				while {
					_handle = ppEffectCreate [_name, _priority];
					_handle < 0
				} do {
					_priority = _priority + 1;
				};

				_handle ppEffectEnable true;
				_handle ppEffectAdjust _effect;
				_handle ppEffectCommit 0.1;
				waitUntil {ppEffectCommitted _handle};
				uiSleep 0.2;
				_handle ppEffectAdjust [0];
				_handle ppEffectCommit 0.1;
				waitUntil {ppEffectCommitted _handle};
				_handle ppEffectEnable false;
				ppEffectDestroy _handle;
			};

			_sound = [_para] spawn {
				_unit = _this select 0;

				while {player in (crew _unit) && alive player} do {
					_unit say3D "paraGlide";

					_rustle = [_unit] spawn {
						_unit = _this select 0;
						_sound = ["paraRus1","paraRus2","paraRus3","paraRus4","paraRus5","paraRus6"] call BIS_fnc_selectRandom;
						_chance = random(100);

						if (_chance > 50) then {_unit say3D _sound};
					};

					sleep 9;
				};
			};

			_zipF = [_para] spawn {
				_unit = _this select 0;

				while {player in (crew _unit) && alive player} do {
					_sound = ["paraTurn1","paraTurn2","paraTurn3","paraTurn4","paraTurn5","paraTurn6"] call BIS_fnc_selectRandom;

					waitUntil {inputAction "CarForward" > 0};

					_unit say3D _sound;

					waitUntil {inputAction "CarForward" == 0};

					sleep 1;
				};
			};
			_zipB = [_para] spawn {
				_unit = _this select 0;

				while {player in (crew _unit) && alive player} do {
					_sound = ["paraTurn1","paraTurn2","paraTurn3","paraTurn4","paraTurn5","paraTurn6"] call BIS_fnc_selectRandom;

					waitUntil {inputAction "CarBack" > 0};

					_unit say3D _sound;

					waitUntil {inputAction "CarBack" == 0};

					sleep 1;
				};
			};
			_zipL = [_para] spawn {
				_unit = _this select 0;

				while {player in (crew _unit) && alive player} do {
					_sound = ["paraTurn1","paraTurn2","paraTurn3","paraTurn4","paraTurn5","paraTurn6"] call BIS_fnc_selectRandom;

					waitUntil {inputAction "CarLeft" > 0};

					_unit say3D _sound;

					waitUntil {inputAction "CarLeft" == 0};

					sleep 1;
				};
			};
			_zipR = [_para] spawn {
				_unit = _this select 0;

				while {player in (crew _unit) && alive player} do {
					_sound = ["paraTurn1","paraTurn2","paraTurn3","paraTurn4","paraTurn5","paraTurn6"] call BIS_fnc_selectRandom;

					waitUntil {inputAction "CarRight" > 0};

					_unit say3D _sound;

					waitUntil {inputAction "CarRight" == 0};

					sleep 1;
				};
			};

			waitUntil {typeOf vehicle player != "Steerable_Parachute_F"};
			[[player,"paraLand"],"say3D"] call BIS_fnc_MP;
			//player say3D "paraLand";
		};

		if (position player select 2 < 5) exitWith {false};
	};
};
