#include "script_component.hpp"

private _param = ["kobld_daylight", 0] call BIS_fnc_getParamValue;

private _date = date;
/* private _hour = _date select 3;	//[year,month,day,hour,minute] */
private _lite = (_date call BIS_fnc_sunriseSunsetTime) select 0;
private _dark = (_date call BIS_fnc_sunriseSunsetTime) select 1;

private _newHour = -1;

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
	private _newMin = (_newHour mod 1) * 60;
	_newHour = floor _newHour;

	private _newDate = [_date select 0,_date select 1,_date select 2,_newHour,_newMin];
	[_newDate] call BIS_fnc_setDate;
};
