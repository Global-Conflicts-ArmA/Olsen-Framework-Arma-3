#include "script_macros.hpp"

#define postInit
#define framework

enableSaving [false, false];

if (GETMVAR(testingDisableFriendlyAI,false)) then {
    if !(isMultiplayer) then {
    	switchableUnits select {!isPlayer _x && {side _x isEqualTo side player}} apply {
    		private _unit = _x;
    		_unit disableAI "ALL";
    		_unit forceSpeed 0;
    	};
    };
};

#include "..\customization\inits\PostInitGlobal.sqf" //DO NOT REMOVE
#include "..\modules\modules.sqf" //DO NOT REMOVE
