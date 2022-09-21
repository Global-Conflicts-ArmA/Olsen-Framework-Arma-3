#include "script_component.hpp"

private _adminParam = [QGVAR(ScenarioSelection), 0] call BIS_fnc_getParamValue;

private _sel = switch (_adminParam) do {
	case 1: {"r1"};
	case 2: {"r2"};
	case 3: {"r3"};
	case 4: {"r4"};
	case 5: {"r5"};
    //Random Parameter
	default {
        selectRandom ["r1","r2","r3","r4","r5"]
	};
};

// Set selected variable to true and propagate
LOG_1("Scenario %1 selected", _sel);
missionNamespace setVariable [_sel, true, true];

// Set other variables to false and propagate
private _paramArray = ["r1","r2","r3","r4","r5"] - _sel;
_paramArray apply {
    missionNamespace setVariable [_x, false, true];
};
