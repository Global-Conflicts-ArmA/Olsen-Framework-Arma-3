#include "script_component.hpp"
#include "..\..\settings.sqf"

if !(isMultiplayer) exitWith {};

private _WeatherParam = ["Weather", -1] call BIS_fnc_getParamValue;

if (-1 != _WeatherParam) then {

	private _overcast = _WeatherParam;
	if (-10 == _overcast) then {
		_overcast = random 10;
	};
	_overcast = (_overcast / 10);

	diag_log format ["INFO: Setting overcast to: %1", _overcast];

	0 setOvercast _overcast;
	if (_overcast > 0.5) then {
		0 setRain _overcast;
	};
	forceWeatherChange;

};

private _wind = ["Wind", -1] call BIS_fnc_getParamValue;
private _windDir = ["WindDir", 90] call BIS_fnc_getParamValue;

if (-1 != _wind) then {
    // Calculate X and Y component of wind direction vector
    // Convert to CCW from X-axis, inverted (so the wind blows *from* that dir)
    _windDir = 90 + (180 - _windDir);
    _dirX = cos _windDir;
    _dirY = sin _windDir;

    0 setWindStr 1;
    setWind [_dirX * _wind, _dirY * _wind, true];
};

private _FogParam = ["Fog", -1] call BIS_fnc_getParamValue;

if (-1 != _FogParam) then {

	if (-10 == _FogParam) then {
		_FogParam = (floor random [0, 10, 30]) / 10;
	};

	if (defaultFogType) then {
		private _fog = _FogParam;
		0 setFog (_fog / 3.2);
	} else {
		_fog = (fogArrays select _FogParam);
		if (0 == (count _fog)) then {
			_fog = [0, 0, 0];
		};
		0 setFog _fog;
	};

};
