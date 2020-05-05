if (!isDedicated) then {
	
	private ["_modules", "_module"];

	_modules = "<font size='18'>Olsen Framework Modules</font><br/><br/>";

	for "_i" from 0 to (count GVAR(Modules) - 1) do {
	
		_module = GVAR(Modules) select _i;

		_modules = _modules + "<font size='16'>" + (_module select 0) + "</font><br/>Description: " + (_module select 1) + "<br/>by " + (_module select 2);

		if (_i < count GVAR(Modules)) then {
		
			_modules = _modules + "<br/><br/>";

		};
	};
	
	player createDiaryRecord [QGVAR(Menu), ["Modules", _modules]];
	
	private ["_respawnName", "_respawnPoint", "_temp", "_text"];
	
	if (GVAR(RespawnTickets) > 0) then {
		
		_respawnName = toLower(format ["fw_%1_respawn", side player]);
		_respawnPoint = missionNamespace getVariable [_respawnName, objNull];

		if (isNull(_respawnPoint)) then {
			
			_temp = format ["Ticketed respawn feature:<br></br>Warning game logic ""%1"" does not exist.", _respawnName];
			_temp call FUNC(DebugMessage);
			
		};
		
		[] spawn {
			sleep 5;
			
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
		};
	};
};