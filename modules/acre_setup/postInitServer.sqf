#include "script_component.hpp"
#include "settings.sqf"

GVAR(ACRE_Presets) = ["default2", "default3", "default4", "default"];

if (GETMVAR(ACRE_Enable_AddRacks,false) && {GVAR(ACRE_ORRList) isNotEqualTo []}) then {
	[{(call acre_api_fnc_isInitialized && time > 0)}, {
		scopeName "mainLoop";
		GVAR(ACRE_ORRList) apply {
			_x params ["_objString","_rackType","_mountRadio","_radioRemovable","_rackNames","_whitelistedPositions","_blacklistedPositions","_faction"];
			private ["_mountedRadio"];
			private _object = missionNamespace getVariable [_objString, objNull];
			if((missionNamespace getVariable _objString) isEqualTo objNull) then {
				(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
				(format ["(ACRE_SETUP_MODULE) [ERR]: OBJECT VARIABLE NAME DOES NOT EXIST OR IS INCORRECT"]) call FNC_DebugMessage;
				(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR VARIABLE STRING: %1", _objString]) call FNC_DebugMessage;
				breakTo "mainLoop";
			} else {
				if((GVAR(ACRE_Enable_Scramble) || GVAR(ACRE_Enable_Babel)) && {isNil "_faction"}) then {
					(format ["(ACRE_SETUP_MODULE) [WRN]: RADIO SCRAMBLING OR BABEL ARE ENABLED BUT %1 HAS NO ASSIGNED FACTION", _object]) call FNC_DebugMessage;
				};
				if(isNil "_rackType") then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: RACK CLASSNAME: %1 DOES NOT EXIST OR A TYPO EXISTS VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
					breakTo "mainLoop";
				};
				if(_mountRadio) then {
					switch (_rackType) do {
						case "ACRE_SEM90": {_mountedRadio = "ACRE_SEM70";};
						case "ACRE_VRC103": {_mountedRadio = "ACRE_PRC117F";};
						case "ACRE_VRC110": {_mountedRadio = "ACRE_PRC152";};
						case "ACRE_VRC111": {_mountedRadio = "ACRE_PRC148";};
						case "ACRE_VRC64": {_mountedRadio = "ACRE_PRC77";};
						default {
							(format ["(ACRE_SETUP_MODULE) [ERR]: NFB ERROR ENCOUNTERED"]) call FNC_DebugMessage;
							(format ["(ACRE_SETUP_MODULE) [ERR]: VERIFY YOUR RACK CLASSNAME: %1", _rackType]) call FNC_DebugMessage;
							breakTo "mainLoop";
						};
					};
				} else {_mountedRadio = "";};
				_rackNames params ["_longRack","_shortRack"];
				if(isNil "_longRack" || isNil "_shortRack") then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: A RACKNAME IS NIL, LONG: %1 SHORT: %2", _longRack, _shortRack]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING TO LONGNAME: ""DEFAULT RACK NAME: FIX ME"" AND SHORTNAME: ""FIX"" "]) call FNC_DebugMessage;
					_longRack = "DEFAULT RACK NAME: FIX ME";
					_shortRack = "FIX";
				};
				if(_whitelistedPositions isEqualTo []) then {
					(format ["(ACRE_SETUP_MODULE) [ERR]: NO POSITIONS HAVE BEEN WHITELISTED OR BLACKLISTED"]) call FNC_DebugMessage;
					(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING TO 'inside' and 'all'"]) call FNC_DebugMessage;
					_whitelistedPositions = ["inside", "all"];
				} else {
					if(_whitelistedPositions isEqualTo _blacklistedPositions) then {
						(format ["(ACRE_SETUP_MODULE) [ERR]: ALL POSITIONS ARE WHITELISTED AND BLACKLISTED"]) call FNC_DebugMessage;
						(format ["(ACRE_SETUP_MODULE) [ERR]: DEFAULTING WHITELISTED POSITIONS TO: 'inside'"]) call FNC_DebugMessage;
						_whitelistedPositions = ["inside"];
						_blacklistedPositions = [];
					};
				};
				if(!(isNil "_faction") && {GVAR(ACRE_Enable_Scramble)}) then {
					private _faction_i = 3;
					switch (_faction) do {
						case west: {_faction_i = 0};
						case east: {_faction_i = 1};
						case independent: {_faction_i = 2};
						case civilian: {_faction_i = 3};
						default {_faction_i = 3;};
					};
					private _preset = GVAR(ACRE_Presets) select _faction_i;
					[_object, _preset] call acre_api_fnc_setVehicleRacksPreset;
				};

				[_object, {}] call acre_api_fnc_initVehicleRacks;
				[_object, [_rackType, _longRack, _shortRack, _radioRemovable, _whitelistedPositions, _blacklistedPositions, _mountedRadio, [], []], false, {}] call acre_api_fnc_addRackToVehicle;
				if(GVAR(ACRE_Enable_AddRackDebug)) then {(format ["ACRE_SETUP: RACK ADDED: %1 %2", _x, _longRack]) call FNC_DebugMessage;};
			};
		};

	},[],30,{ERROR_MSG_1("ACRE_SETUP: UNABLE TO ADD RACKS")}] call CBA_fnc_waitUntilAndExecute;
};

if (GVAR(ACRE_Enable_Channel_Names)) then {
	{
		private _index = _forEachIndex;
		_x apply {
			_x params ["_channel", "_label", "_name"];
			["ACRE_PRC117F", "ACRE_PRC148", "ACRE_PRC152"] apply {
				_label = [_x, _label] call acre_api_fnc_mapChannelFieldName;
				[_x, GVAR(ACRE_Presets) select _index, _channel, _label, _name] remoteExecCall ["acre_api_fnc_setPresetChannelField", 0, true];
			};
		};
	} foreach GVAR(ACRE_ChannelNames);
};
