#include "script_component.hpp"

private _version = 0.2;

["Snow", "Snow and breath effects for winter.", "TinfoilHate, StatusRed, &amp; PiZZADOX", _version] call EFUNC(FW,RegisterModule);

GVAR(snowfall) = ([missionConfigFile >> QGVAR(settings) >> "snowfall", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(snowFog) = ([missionConfigFile >> QGVAR(settings) >> "snowFog", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(breath) = ([missionConfigFile >> QGVAR(settings) >> "breath", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(shiver) = ([missionConfigFile >> QGVAR(settings) >> "shiver", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(shiverFrequency) = [missionConfigFile >> QGVAR(settings) >> "shiverFrequency", "number", 20] call CBA_fnc_getConfigEntry;
GVAR(postProcessing) = ([missionConfigFile >> QGVAR(settings) >> "postProcessing", "number", 0] call CBA_fnc_getConfigEntry) == 1;
GVAR(fog) = ([missionConfigFile >> QGVAR(settings) >> "fog", "number", 1] call CBA_fnc_getConfigEntry) == 1;
GVAR(density) = [missionConfigFile >> QGVAR(settings) >> "density", "number", 0.6] call CBA_fnc_getConfigEntry;
GVAR(decay) = [missionConfigFile >> QGVAR(settings) >> "decay", "number", 0] call CBA_fnc_getConfigEntry;
GVAR(baseHeight) = [missionConfigFile >> QGVAR(settings) >> "baseHeight", "number", 0] call CBA_fnc_getConfigEntry;


if (GVAR(postProcessing)) then {
	"colorCorrections" ppEffectAdjust [1, 1, 0, [0.01, 0.02, 0.04, 0.01], [0.87, 1.08, 1.196, 0.3], [0.399, 0.287, 0.014, 0.0]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectEnable true;
};

if (GVAR(fog)) then {
	0 setFog [GVAR(density), GVAR(decay), GVAR(baseHeight)];
};

GVAR(snowTimer) = 0.001;
if !(GVAR(density) isEqualTo 100) then {
	GVAR(snowTimer) = parseNumber ((0.001 + 0.000070 * (100 - GVAR(density))) toFixed 6);
};

GVAR(OffOn) = GETMVAR(snowfall,true);

["CBA_loadingScreenDone", {
	GVAR(fxType) = "";
	GVAR(posType) = "";
	GVAR(machine) = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
	GVAR(particleSource) = "#particlesource" createVehicleLocal getPosATL player;
	GVAR(particleSource) attachTo [player,[0,5,0]];
	if (GVAR(shiver)) then {
		GVAR(shiverInterval) = 20 + (random 30);
		GVAR(shiverTimer) = 0;
		GVAR(shiverCheckTime) = CBA_missionTime;
	};
	GVAR(fxHandle) = [{
		if (GVAR(snowfall) || GVAR(snowFog)) then {
			call FUNC(posCheck);
		};
		if (GVAR(breath)) then {
			call FUNC(breathEffect);
		};
		if (GVAR(shiver)) then {
			call FUNC(shiver);
		};
		if (player getVariable [QEGVAR(FW,Dead), false]) then {
			[GVAR(fxHandle)] call CBA_fnc_removePerFrameHandler;
			GVAR(particleSource) setDropInterval -1;
		};
	}, 0.1] call cba_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
