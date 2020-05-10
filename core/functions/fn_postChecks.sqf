#include "..\script_macros.hpp"

[{!(GVAR(Modules) isEqualTo [])},{
	player createDiarySubject [QGVAR(Menu), "Olsen Framework"];

	private _modules = "<font size='18'>Olsen Framework Modules</font><br/><br/>";

	for "_i" from 0 to (count GVAR(Modules) - 1) step 1 do {
		private _module = GVAR(Modules) select _i;
        _module params ["_name", "_description", "_author", ["_version", 0, [0]]];
        _version = if (_version isEqualTo 0) then {
            "Legacy"
        } else {
            str _version
        };
		_modules = _modules + "<font size='16'>" + _name + "</font><br/>Version: " + _version + "</font><br/>Description: " + _description + "<br/>by " + _author;
		if (_i < count GVAR(Modules)) then {
			_modules = _modules + "<br/><br/>";
		};
	};

	player createDiaryRecord [QGVAR(Menu), ["Modules", _modules]];

	private _info = "
	<font size='18'>Welcome to the Olsen Framework!</font><br/>
	The Olsen Framework is a simple framework designed for ArmA 3. It supports modules and is easy to configure.<br/>
	<br/>
	Find out more about the framework on GitHub.<br/>
	github.com/Bear-Cave-ArmA/Olsen-Framework-Arma-3<br/>
	<br/>
	Current Version: " + VERSIONSTR;

	player createDiaryRecord [QGVAR(Menu), ["Framework Info", _info]];
}, []] call CBA_fnc_waitUntilAndExecute;
	
if (GVAR(RespawnTickets) > 0) then {
	
	private _respawnName = toLower (format ["fw_%1_respawn", side player]);
	private _respawnPoint = missionNamespace getVariable [_respawnName, objNull];

	if (_respawnPoint isEqualTo objnull) then {
		private _temp = format ["Ticketed respawn feature:<br></br>Warning game logic ""%1"" does not exist.", _respawnName];
		_temp call FUNC(DebugMessage);
	};
	
	[{
		private _p = "";
		if (GVAR(RespawnTickets) != 1) then {
			_p = "s";
		};
		private _message2 = format ["you can respawn %1 time%2", GVAR(RespawnTickets), _p];

		private _sideTickets = 0;
		switch (side player) do {
			case west: {
				_sideTickets = GVAR(RespawnTicketsWest);
			};
			case east: {
				_sideTickets = GVAR(RespawnTicketsEast);
			};
			case independent: {
				_sideTickets = GVAR(RespawnTicketsInd);
			};
			case civilian: {
				_sideTickets = GVAR(RespawnTicketsCiv);
			};
		};
		private _p2 = "";
		if (_sideTickets != 1) then {
			_p2 = "s";
		};
		cutText [format ['Your side has %1 ticket%2 left, %3', _sideTickets, _p2, _message2], 'PLAIN DOWN'];
	}, [], 5] call CBA_fnc_waitAndExecute;
};