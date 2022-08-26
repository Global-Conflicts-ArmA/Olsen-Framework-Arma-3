#include "script_component.hpp"

params [
	["_marker", "marker_capture", [""]],
	["_sides", [blufor], [[]]],
	["_wins", [300], []]
];

private _markerCount = [_marker, []];
GVAR(CAPZONE_MARKERCOLLECTION) pushBack ["NONE", _marker, false];
private _countforwins = 0;
_sides apply {
	(_markerCount select 1) pushBack [_x, 0, _wins select _countforwins]; //side,count,win
	_countforwins = _countforwins + 1;
};
//special format [_marker,[[_side,count,win],[_side,count,win]]];
GVAR(TIMERS) pushBack [_marker, CBA_missionTime, 0];
GVAR(OLD_OWNERS_MAP) set [_marker, ["temp", 0, 9999]];
 //ident,count,win

	[{
		/* diag_log "INFO: Capture zone loop running"; */
		/* LOG_1("Timers = %1", GVAR(TIMERS)); */

		_this params ["_args", "_pfhID"];
		_args params ["_markerCount", "_messages", "_marker", "_colours", "_countforwins"];

		private _start = CBA_missionTime;
		private _delta = _start - (((GVAR(TIMERS) select {(_x select 0) == _marker}) select 0) select 1);
		private _contester = "NONE";
		//count all units in area n special format [_marker,[[_side,count,win],[_side,count,win]]];

		(_markerCount select 1) apply {
			_x set [1, 0];
		};

		allUnits apply {
			private _unit = _x;

			if ((_unit inArea (_markerCount select 0)) && {_unit call EFUNC(FW,isAlive)}) then {
				(_markercount select 1) apply {
					if (side _unit == _x select 0) then {
						_x set [1,(_x select 1) + 1];
					};
				};
			};
		};
		private _currentOwner = ["UNCONTESTED",0,9999];
		(_markerCount select 1) apply {
			if (_x select 1 > _currentOwner select 1) then {
				_currentOwner = [str (_x select 0), _x select 1, _x select 2];
			} else {
				if ((_x select 1) == (_currentOwner select 1) && (_x select 1) != 0) then {
					_currentOwner = ["CONTESTED", _x select 1,9999];
				};
			}
		};

		if(((_currentOwner select 0) != ((GVAR(OLD_OWNERS_MAP) get _marker) select 0)) || (_currentOwner select 0 == "CONTESTED")) then {
			switch(_currentOwner select 0) do {
				case "WEST": {
						private _mes = _messages select 0;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if (_contester != "WEST") then {
							{
								GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
							} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
							_contester = "WEST";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 0]] call CBA_fnc_globalExecute;

				};
				case "EAST": {
						private _mes = _messages select 1;
						if (_contester != "EAST") then {
							{
								GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
							} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
							_contester = "EAST";
						};
						[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 1]] call CBA_fnc_globalExecute;

				};
				case "GUER": {
						private _mes = _messages select 2;
						if (_contester != "GUER") then {
							{
								GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
							} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
							_contester = "GUER";
						};
						[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 2]] call CBA_fnc_globalExecute;

				};
				case "RESISTANCE": {
						private _mes = _messages select 2;
						if (_contester != "RESISTANCE") then {
							{
								GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
							} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
							_contester = "RESISTANCE";
						};
						[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 2]] call CBA_fnc_globalExecute;

				};
				case "CIVILIAN": {
						private _mes = _messages select 3;
						if (_contester != "CIVILIAN") then {
							{
								GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
							} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
							_contester = "CIVILIAN";
						};
						[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 3]] call CBA_fnc_globalExecute;

				};
				case "UNCONTESTED": {
						private _mes = _messages select 5;
						[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 5]] call CBA_fnc_globalExecute;

						{
							GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), CBA_missionTime]];
						} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
						_contester = "NONE";
				};
				case "CONTESTED": {
						if ((_currentOwner select 0) != ((GVAR(OLD_OWNERS_MAP) get _marker) select 0)) then {
							private _mes = _messages select 4;
							[-1, {hintSilent _this}, _mes] call CBA_fnc_globalExecute;
							[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker, _colours select 4]] call CBA_fnc_globalExecute;
						};

						{
							GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 1), (_x select 2) + _delta]];
						} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
				};
			};
		};

		_countforwins = 0;
		GVAR(CAPZONE_MARKERCOLLECTION) apply {
			if(_marker == _x select 1) then {
				private _timerTime = (((GVAR(TIMERS) select {(_x select 0) == _marker}) select 0) select 2);
				/* LOG_1("Timer time = %1", _timerTime); */
				private _timeCheck = CBA_missionTime - _timerTime;
				/* LOG_2("Checking %1 >= %2", _timeCheck, (_currentOwner select 2)); */
				if (_timeCheck >= _currentOwner select 2) then {
					private _temp = true;

					if (_temp) exitWith {
						GVAR(CAPZONE_MARKERCOLLECTION) set [_countforwins, [_currentOwner select 0, _marker, true]];
						[_pfhID] call CBA_fnc_removePerFrameHandler;
					};
				} else {
						GVAR(CAPZONE_MARKERCOLLECTION) set [_countforwins, [_currentowner select 0, _marker, false]];
				};
			};
			_countforwins = _countforwins + 1;
		};

		GVAR(OLD_OWNERS_MAP) set [_marker, _currentOwner];
		{
			GVAR(TIMERS) set [_forEachIndex, [(_x select 0), (_x select 2), (_x select 2)]];
		} forEach (GVAR(TIMERS) select {(_x select 0) == _marker});
}, GVAR(CAPZONE_INTERVAL), [_markerCount, GVAR(CAPZONE_MESSAGES), _marker, GVAR(CAPZONE_COLOURS), _countforwins]] call CBA_fnc_addPerFrameHandler;
