//Gas script implementation by TinfoilHate
//["GAS_FIREMISSION", [position player, 50, 3, 1, 5, 300]] call CBA_fnc_serverEvent;
#include "script_component.hpp"

player setVariable ["GAS_NEEDSMASK", false];

if (!isDedicated && hasInterface) then {
	[{!isNull ACE_player}, {
		GVAR(DOWN) = false;

		//Monitor gas mask usage for stamina purposes
		GVAR(maskOn) = false;
		[{
			[{
				if (goggles player in GVAR(MASKLIST) && !GVAR(maskOn)) then {
					GVAR(maskOn) = true;

					ace_advanced_fatigue_loadFactor				= 0.9;
					ace_advanced_fatigue_recoveryFactor			= 0.6;
					ace_advanced_fatigue_performanceFactor		= 0.6;
					ace_advanced_fatigue_terrainGradientFactor	= 0.8;
				};

				if (!(goggles player in GVAR(MASKLIST)) && GVAR(maskOn)) then {
					GVAR(maskOn) = false;

					ace_advanced_fatigue_loadFactor				= 1.0;
					ace_advanced_fatigue_recoveryFactor			= 1.0;
					ace_advanced_fatigue_performanceFactor		= 1.0;
					ace_advanced_fatigue_terrainGradientFactor	= 1.0;
				};
			}, 1, []] call CBA_fnc_addPerFrameHandler;
		}, [], 1] call CBA_fnc_waitAndExecute;

		//Vehicle alarm action
		vehicles apply {
			_x setVariable ["GAS_VEHALARM_ON", false, true];
		};

		private _vehAlarm_toggle_off = ["vehAlarm_off_class", "Turn CBRN Alarm Off", "", {
			_target setVariable ["GAS_VEHALARM_ON", false, true];
		}, {
			([_player, _target, []] call ace_common_fnc_canInteractWith) && (commander _target == _player || gunner _target == _player || driver _target == _player) && (_target getVariable "GAS_VEHALARM_ON")
		}] call ace_interact_menu_fnc_createAction;
		["LandVehicle", 1, ["ACE_SelfActions"], _vehAlarm_toggle_off, true] call ace_interact_menu_fnc_addActionToClass;

		private _vehAlarm_toggle_on = ["vehAlarm_on_class", "Turn CBRN Alarm On", "", {
			/* _target setVariable ["GAS_VEHALARM_ON", true, true]; */
			_target call FUNC(vehicleSiren);
		}, {
			([_player, _target, []] call ace_common_fnc_canInteractWith) && (commander _target == _player || gunner _target == _player || driver _target == _player) && !(_target getVariable "GAS_VEHALARM_ON")
		}] call ace_interact_menu_fnc_createAction;
		["LandVehicle", 1, ["ACE_SelfActions"], _vehAlarm_toggle_on, true] call ace_interact_menu_fnc_addActionToClass;

		//Various user actions for mask usage
		private _maskUpSelf = ["maskUpSelf_class", "Put Gasmask On Self", "", {
			GVAR(MASKLIST) apply {	//Check player inventory for mask
				if (_x in items player && !(goggles player in GVAR(MASKLIST))) then {
					player addGoggles _x;
					player removeItem _x;
				};
			};
		}, {
			{_x in items player} count GVAR(MASKLIST) > 0 && !(goggles player in GVAR(MASKLIST)) && !GVAR(DOWN)
		}] call ace_interact_menu_fnc_createAction;
		[typeOf player, 1, ["ACE_SelfActions"], _maskUpSelf] call ace_interact_menu_fnc_addActionToClass;

		private _maskUpFriend = ["maskUp_class", "Put Gasmask On", "", {
			params ["_target", "_player"];

			GVAR(MASKLIST) apply {	//Check target inventory first
				if (_x in items _target && !(goggles _target in GVAR(MASKLIST))) then {
					[_target,_x] remoteExec ["addGoggles", _target];
					_target removeItem _x;
				};
			};

			GVAR(MASKLIST) apply {	//Check player inventory next
				if (_x in items _player && !(goggles _target in GVAR(MASKLIST))) then {
					[_target,_x] remoteExec ["addGoggles", _target];
					_player removeItem _x;
				};
			};
		}, {
			([_player, _target, []] call ace_common_fnc_canInteractWith) && ({_x in items _target} count GVAR(MASKLIST) > 0 || {_x in items _player} count GVAR(MASKLIST) > 0) && !(goggles _target in GVAR(MASKLIST)) && _target getVariable ["GAS_NEEDSMASK",false]
		}] call ace_interact_menu_fnc_createAction;
		["MAN", 0, ["ACE_MainActions"], _maskUpFriend, true] call ace_interact_menu_fnc_addActionToClass;

		//JIP Data Sending
		if (didJIP) then {
			["GAS_JIPSEND"] spawn CBA_fnc_serverEvent;
		};
	}, []] call CBA_fnc_waitUntilAndExecute;

	[{
		params ["_args", "_idPFH"];

		if ((player getVariable ["FW_Dead", false])) exitWith {
			GVAR(INTENSITY) = 0;
			GVAR(BLUR) ppEffectEnable false;

			LOG("Removing GAS frame handler..");
			[_idPFH] call CBA_fnc_removePerFrameHandler;
		};

		if (goggles player in GVAR(MASKLIST)) then {
			GVAR(HASMASK) = true;

			ace_advanced_fatigue_loadFactor				= 1.0;
			ace_advanced_fatigue_recoveryFactor			= 0.6;
			ace_advanced_fatigue_performanceFactor		= 0.6;
			ace_advanced_fatigue_terrainGradientFactor	= 0.8;
		} else {
			GVAR(HASMASK) = false;

			if (GVAR(INTENSITY) <= 10) then {
				ace_advanced_fatigue_loadFactor				= 1.0;
				ace_advanced_fatigue_recoveryFactor			= 1.0;
				ace_advanced_fatigue_performanceFactor		= 1.0;
				ace_advanced_fatigue_terrainGradientFactor	= 1.0;
			};
		};

		/* LOG_1("AREALIST = %1", GVAR(AREALIST)); */
		/* LOG_1("INTENSITY = %1", GVAR(INTENSITY)); */

		if (count GVAR(AREALIST) > 0) then {GVAR(INHOTAREA) = true} else {GVAR(INHOTAREA) = false};

		if (GVAR(ACTIVE)) then {
			if (GVAR(INTENSITY) >= 2 && GVAR(INHOTAREA) && !GVAR(HASMASK)) then {
				if !(player getVariable "GAS_NEEDSMASK") then {player setVariable ["GAS_NEEDSMASK", true, true]};

				if (!GVAR(COUGHING)) then {
					GVAR(COUGHING) = true;

					enableCamShake true;
					addCamShake [5, 3, 15];

					GVAR(BLUR) ppEffectAdjust [GVAR(BLURSTEP) - 8];
					GVAR(BLUR) ppEffectCommit 0.8;
					GVAR(BLUR) ppEffectAdjust [GVAR(BLURSTEP) + 10];
					GVAR(BLUR) ppEffectCommit 2.0;
					GVAR(BLUR) ppEffectAdjust [GVAR(BLURSTEP)];
					GVAR(BLUR) ppEffectCommit 3.0;

					private _sound = "";
					if (GVAR(INTENSITY) <= 40) then {	//This should be like 20 or 25, but the damn H1/H2 sounds get cut off weirdly?
						_sound = [
							"ACE_Cough_1",
							"ACE_Cough_2",
							"ACE_Cough_3",
							"ACE_Cough_4",
							"ACE_Cough_5"
						] call BIS_fnc_selectRandom;
					} else {
						_sound = [
							"ACE_Cough_H1",
							"ACE_Cough_H2"
						] call BIS_fnc_selectRandom;
					};
					[player, [_sound, 50]] remoteExec ["say3D"];

					[{
						GVAR(COUGHING) = false;
					}, [], (8 + random 4)] call CBA_fnc_waitAndExecute;
				};
			};

			if (GVAR(INTENSITY) >= 15 && !GVAR(DOWN)) then {
				GVAR(DOWN) = true;

				if (vehicle player == player) then {[player,"ainjppnemstpsnonwrfldnon"] remoteExec ['playMove']};

				GVAR(ANIMEH) = player addEventHandler ["AnimChanged",{
					if (vehicle player == player) then {[(_this select 0),"ainjppnemstpsnonwrfldnon"] remoteExec ['playMove']};
				}];

				GVAR(GEAREH) = player addEventHandler ["InventoryOpened",{
					true
				}];
			};

			if (GVAR(INTENSITY) >= 25) then {
				GVAR(BLUR) ppEffectAdjust [20];
				GVAR(BLUR) ppEffectCommit 8;

				addCamShake [2, 15, 15];
			};

			if (GVAR(INTENSITY) >= 35) then {
				player setDamage 1;
				GVAR(INTENSITY) = 0;

				GVAR(BLUR) ppEffectEnable false;
			};

			//Add or remove effects depending on if you're in a hot area.
			if ((GVAR(INHOTAREA) && !GVAR(HASMASK)) || GVAR(INTENSITY) > 25) then {
				GVAR(INTENSITY) = GVAR(INTENSITY) + 0.5;

				if (GVAR(BLURSTEP) < 10) then {
					GVAR(BLURSTEP) = GVAR(BLURSTEP) + 0.5;
				};

				GVAR(BLUR) ppEffectEnable true;
				GVAR(BLUR) ppEffectAdjust [GVAR(BLURSTEP)];
				GVAR(BLUR) ppEffectCommit 0.5;
			} else {
				if (GVAR(INTENSITY) > 0) then {GVAR(INTENSITY) = GVAR(INTENSITY) - 0.15};

				if (GVAR(BLURSTEP) > 0) then {
					GVAR(BLURSTEP) = GVAR(BLURSTEP) - 0.1;

					GVAR(BLUR) ppEffectAdjust [GVAR(BLURSTEP)];
					GVAR(BLUR) ppEffectCommit 0.5;
				};

				if (GVAR(INTENSITY) <= 15 && GVAR(DOWN)) then {
					GVAR(DOWN) = false;

					if (vehicle player == player) then {[player, "amovpknlmstpsraswrfldnon_amovppnemstpsraswrfldnon"] remoteExec ['playMove']};

					player removeEventHandler ["AnimChanged", GVAR(ANIMEH)];
					player removeEventHandler ["InventoryOpened", GVAR(GEAREH)];

					player setVariable ["GAS_NEEDSMASK", false, true];
				};
			};
		};
	}, 0.5 + (random 1), []] call CBA_fnc_addPerFrameHandler;
};
