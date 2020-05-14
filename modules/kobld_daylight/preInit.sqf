["Daylight", "Admin parameter for time-of-day: First light, Dawn, Dusk, Last Light, Night.", "TinfoilHate"] call FNC_RegisterModule;

if (isServer) then {
	private ["_param","_hour","_lite","_dark","_newHour","_newMin","_newDate"];

	_param = ["kobld_daylight", 0] call BIS_fnc_getParamValue;

	_date = date;
	_hour = _date # 3;	//[year,month,day,hour,minute]
	_lite = (_date call BIS_fnc_sunriseSunsetTime) # 0;
	_dark = (_date call BIS_fnc_sunriseSunsetTime) # 1;

	_newHour = -1;

	switch _param do {
		case 0: {	//FIRST LIGHT
			_newHour = _lite - 1.31666667;
		};
		case 1: {	//DAWN
			_newHour = _lite - 0.5;
		};
		case 2: {	//DUSK
			_newHour = _dark + 0.5;
		};
		case 3: {	//LAST LIGHT
			_newHour = _dark + 1.31666667;
		};
		case 4: {	//NIGHT
			_newHour = 0.5;
		};

		default { /* DO NOTHING */ };
	};

	if (_newHour != -1) then {
		_newMin = (_newHour mod 1) * 60;
		_newHour = floor _newHour;

		_newDate = [_date # 0,_date # 1,_date # 2,_newHour,_newMin];
		[_newDate] call BIS_fnc_setDate;
	};
};