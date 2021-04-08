#include "script_component.hpp"

private ["_TimeLimitParam"];

_TimeLimitParam = "TimeLimit" call BIS_fnc_getParamValue;

if (_TimeLimitParam == -1) then {
	GVAR(TimeLimit) = 0;
} else {
	if ((GVAR(TimeLimit) + _TimeLimitParam) > 0) then {
		GVAR(TimeLimit) = GVAR(TimeLimit) + _TimeLimitParam;
	} else {
		"Time limit was negative and therefore not changed." call FNC_DebugMessage;
	}
};
