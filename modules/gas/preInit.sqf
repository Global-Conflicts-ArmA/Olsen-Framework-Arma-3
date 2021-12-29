//Gas script implementation by TinfoilHate
#include "script_component.hpp"

private _version = 0.1;

// Register this module
["Gas", "Simulates the effects of biological / chemical warfare.", "TinfoilHate &amp; StatusRed", _version] call EFUNC(FW,RegisterModule);

if (isNil QGVAR(ACTIVE)) then {GVAR(ACTIVE) = true};
if (isNil  QGVAR(AREALIST)) then {GVAR(AREALIST) = []};
if (isNil  QGVAR(INHOTAREA)) then {GVAR(INHOTAREA) = false};

if (isNil  QGVAR(INTENSITY)) then {GVAR(INTENSITY) = 0};
if (isNil  QGVAR(BLURSTEP)) then {GVAR(BLURSTEP) = 0};
if (isNil  QGVAR(COUGHING)) then {GVAR(COUGHING) = false};
if (isNil  QGVAR(ANIMEH)) then {GVAR(ANIMEH) = -1};
if (isNil  QGVAR(GEAREH)) then {GVAR(GEAREH) = -1};
if (isNil  QGVAR(DOWN)) then {GVAR(DOWN) = false};
if (isNil  QGVAR(HASMASK)) then {GVAR(HASMASK) = false};
if (isNil  QGVAR(GASLOGICS)) then {GVAR(GASLOGICS) = []};

GVAR(AIMASK) = "skn_m04_gas_mask_bare_dry";
GVAR(MASKLIST) = [
	"skn_m04_gas_mask_blu",
	"skn_m04_gas_mask_blk",
	"skn_m04_gas_mask_gre",
	"skn_m04_gas_mask_bare_dry",
	"skn_s10_balaclava_blue_dry",
	"skn_s10_balaclava_red_dry",
	"skn_s10_balaclava_yellow_dry",
	"skn_s10_balaclava_white_dry",
	"skn_m50_gas_mask_hood",
	"skn_m50_gas_mask",
	"skn_m50_gas_mask_hood_wd"
];

GVAR(GAS_BLUR) = ppEffectCreate ["dynamicBlur", -13501];

["GAS_FIREMISSION", FUNC(fireMission)] call CBA_fnc_addEventHandler;
["GAS_FAKEMISSION", FUNC(fakeMission)] call CBA_fnc_addEventHandler;
["GAS_CREATEHOTZONE", FUNC(createHotZone)] call CBA_fnc_addEventHandler;
["GAS_GASZONES", FUNC(gasZones)] call CBA_fnc_addEventHandler;
["GAS_JIPSEND", FUNC(jipSend)] call CBA_fnc_addEventHandler;
["GAS_GASPARTICLES", FUNC(gasParticles)] call CBA_fnc_addEventHandler;
