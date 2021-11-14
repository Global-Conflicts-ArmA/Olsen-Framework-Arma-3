#include "script_component.hpp"

private _version = 0.1;

["Snow", "Snow and breath effects for winter.", "TinfoilHate &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

#include "settings.sqf"

if (GVAR(postProcessing)) then {
	"colorCorrections" ppEffectAdjust [1, 1, 0, [0.01, 0.02, 0.04, 0.01], [0.87, 1.08, 1.196, 0.3], [0.399, 0.287, 0.014, 0.0]];
	"colorCorrections" ppEffectCommit 0;
	"colorCorrections" ppEffectEnable TRUE;
};

if (GVAR(fog)) then {
	if (0.05 * (GVAR(density) / 15) < 0.6) then {
		0 setFog [0.020 * (GVAR(density) / 5),0,0];
	} else {
		0 setFog [0.6,0,0];
	};
};

GVAR(snowTimer) = 0.001;
if !(GVAR(density) isEqualTo 100) then {
	GVAR(snowTimer) = parseNumber ((0.001 + 0.000070 * (100 - GVAR(density))) toFixed 6);
};

["CBA_loadingScreenDone", {
	kobld_snow_fxType = "";
	kobld_snow_posType = "";
	kobld_snow_machine = "Land_HelipadEmpty_F" createVehicleLocal [0,0,0];
	kobld_snow_particleSource = "#particlesource" createVehicleLocal getPosATL player;
	kobld_snow_particleSource attachTo [player,[0,5,0]];

	if (GVAR(shiver)) then {
		GVAR(shiverInterval) = 20 + (random 30);
		GVAR(shiverTimer) = 0;
		GVAR(shiverCheckTime) = CBA_missionTime;
	};

	kobld_snow_fxHandle = [{
		call FUNC(posCheck);

		if (GVAR(breath)) then {
			call FUNC(breathEffect);
		};

		if (GVAR(shiver)) then {
			call FUNC(shiver);
		};

		if (player getVariable ["FW_Dead",false]) then {
			[kobld_snow_fxHandle] call CBA_fnc_removePerFrameHandler;

			kobld_snow_particleSource setDropInterval -1;
		};
	},0.1] call cba_fnc_addPerFrameHandler;
}] call CBA_fnc_addEventHandler;
