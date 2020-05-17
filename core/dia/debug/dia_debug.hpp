//Do not edit unless you know what you are doing
//because you are on the highway to the danger zone!

#include "..\..\script_macros.hpp"

class DIA_DEBUG {
	idd = 400;
	fadeout = 0;
	fadein = 0;
	duration = 180;
	onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(Debug), _this select 0)];);
	objects[] = {};
	controls[] = {
		GVAR(DOUBLES(DIA,DebugText))
	};

	class GVAR(DOUBLES(DIA,DebugText)): RscStructuredText {
		idc = 4001;
		x = 0 * safezoneW + safezoneX;
		y = 0 * safezoneH + safezoneY;
		w = 0.5 * safezoneW;
		h = 1 * safezoneH;
	};
};
