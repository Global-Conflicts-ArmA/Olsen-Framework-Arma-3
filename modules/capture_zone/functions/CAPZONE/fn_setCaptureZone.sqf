#include "script_component.hpp"

diag_log format ["INFO: In capture zone, params: %1", _this];

params [
	["_opts", ["marker_capture",[blufor],[300]], [[]]],
	["_colours", ["ColorBlue","ColorRed","ColorGreen","ColorYellow","ColorWhite","ColorKhaki"], [[]]],
	["_interval", 15, [15]],
	["_messages", ["Blufor is capturing the zone","Opfor is capturing the zone","Resistance is capturing the zone","Civilian is capturing the zone","The zone is contested","The zone is uncontested"], [[]]]
];

private _marker = _opts select 0;
private _wins = [300,300,300,300];
private _sides = [west,east,resistance,civilian];
if((count _opts) > 1) then
{
	_sides = _opts select 1;
};
if((count _opts) > 2) then
{
	_wins = _opts select 2;
};
private _markerCount = [_marker,[]];
GVAR(CAPZONE_MARKERCOLLECTION) pushBack ["NONE",_marker,false];
private _countforwins = 0;
_sides apply {
	(_markerCount select 1) pushBack [_x ,0,_wins select _countforwins]; //side,count,win
	_countforwins = _countforwins + 1;
};
//special format [_marker,[[_side,count,win],[_side,count,win]]];
private _end = CBA_missionTime;
private _timer = 0;
 //ident,count,win
private _oldOwner = ["temp",0,9999];

	[{
		diag_log "INFO: Capture zone loop running";

		_this params ["_args", "_pfhID"];
		_args params ["_end", "_markerCount", "_oldOwner", "_messages", "_marker", "_colours", "_timer", "_countforwins"];

		private _start = CBA_missionTime;
		private _delta = _start - _end;
		private _contester = "NONE";
		//count all units in area n special format [_marker,[[_side,count,win],[_side,count,win]]];

		(_markerCount select 1) apply {
			_x set [1,0];
		};

		allUnits apply {
			private _unit = _x;

			if ((_unit inArea (_markerCount select 0)) && {_unit call EFUNC(FW,isAlive)}) then
			{
				(_markercount select 1) apply {

					if(side _unit == _x select 0) then
					{
						_x set [1,(_x select 1) + 1] ;
					}
				};
			};
		};
		private _currentOwner = ["UNCONTESTED",0,9999];
		(_markerCount select 1) apply {

			if(_x select 1 > _currentOwner select 1) then
			{
				_currentOwner = [str (_x select 0),_x select 1,_x select 2];

			}
			else
			{
				if((_x select 1) == (_currentOwner select 1) && (_x select 1) != 0) then
				{
					_currentOwner = ["CONTESTED",_x select 1,9999];
				};
			}
		};

		if(((_currentOwner select 0) != (_oldOwner select 0)) || (_currentOwner select 0 == "CONTESTED")) then
		{
			switch(_currentOwner select 0) do
			{
				case "WEST":
				{

						private _mes = _messages select 0;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if(_contester != "WEST") then
						{
							_timer = CBA_missionTime;
							_contester = "WEST";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 0]] call CBA_fnc_globalExecute;

				};
				case "EAST":
				{
						private _mes = _messages select 1;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if(_contester != "EAST") then
						{
							_timer = CBA_missionTime;
							_contester = "EAST";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 1]] call CBA_fnc_globalExecute;

				};
				case "GUER":
				{
						private _mes = _messages select 2;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if(_contester != "GUER") then
						{
							_timer = CBA_missionTime;
							_contester = "GUER";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 2]] call CBA_fnc_globalExecute;


				};
				case "RESISTANCE":
				{
						private _mes = _messages select 2;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if(_contester != "RESISTANCE") then
						{
							_timer = CBA_missionTime;
							_contester = "RESISTANCE";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 2]] call CBA_fnc_globalExecute;

				};
				case "CIVILIAN":
				{
						private _mes = _messages select 3;
						//this is for ContestedZone so the timer doesn't reset
						//can probaply be done better
						if(_contester != "CIVILIAN") then
						{
							_timer = CBA_missionTime;
							_contester = "CIVILIAN";
						};
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 3]] call CBA_fnc_globalExecute;

				};
				case "UNCONTESTED":
				{
						private _mes = _messages select 5;
						[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
						[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 5]] call CBA_fnc_globalExecute;
						_timer = CBA_missionTime;
						_contester = "NONE";
				};
				case "CONTESTED":
				{
						if((_currentOwner select 0) != (_oldOwner select 0)) then
						{
							private _mes = _messages select 4;
							[-1, {hintSilent _this},_mes] call CBA_fnc_globalExecute;
							[-1, {(_this select 0) setMarkerColor (_this select 1)}, [_marker,_colours select 4]] call CBA_fnc_globalExecute;

						};
						_timer = _timer + _delta;
				};
			};
		};
		_countforwins = 0;
		GVAR(CAPZONE_MARKERCOLLECTION) apply {
			if(_marker  == _x select 1) then
			{
				if((CBA_missionTime - _timer) >= _currentOwner select 2) then
				{
					private _temp = true;

					if(_temp) exitWith
					{
						GVAR(CAPZONE_MARKERCOLLECTION) set [_countforwins,[_currentOwner select 0,_marker,true]];
						[_pfhID] call CBA_fnc_removePerFrameHandler;
					};
				}
				else
				{
						GVAR(CAPZONE_MARKERCOLLECTION) set [_countforwins,[_currentowner select 0,_marker,false]];
				};
			};
			_countforwins = _countforwins + 1;
		};
		_oldOwner = _currentOwner;
		_end = _start;
}, _interval, [_end, _markerCount, _oldOwner, _messages, _marker, _colours, _timer, _countforwins]] call CBA_fnc_addPerFrameHandler;;
