#include "..\..\script_macros.hpp"

class DIA_ENDSCREEN {
	idd = 300;
	fadeout = 0;
	fadein = 0;
	duration = 30;
	onLoad = QUOTE(uiNamespace setVariable [ARR_2(QQGVAR(EndScreen), _this select 0)];);
	controlsBackground[] = {GVAR(DOUBLES(DIA,Background))};
	objects[] = {};
	controls[] = {
		GVAR(DOUBLES(DIA,bottomRight4)),
		GVAR(DOUBLES(DIA,bottomMiddleRight4)),
		GVAR(DOUBLES(DIA,bottomMiddleLeft4)),
		GVAR(DOUBLES(DIA,bottomLeft4)),
		GVAR(DOUBLES(DIA,bottomRight3)),
		GVAR(DOUBLES(DIA,bottomMiddle3)),
		GVAR(DOUBLES(DIA,bottomLeft3)),
		GVAR(DOUBLES(DIA,bottomLeft2)),
		GVAR(DOUBLES(DIA,bottomRight2)),
		GVAR(DOUBLES(DIA,Right4)),
		GVAR(DOUBLES(DIA,MiddleRight4)),
		GVAR(DOUBLES(DIA,MiddleLeft4)),
		GVAR(DOUBLES(DIA,Left4)),
		GVAR(DOUBLES(DIA,Right3)),
		GVAR(DOUBLES(DIA,Middle3)),
		GVAR(DOUBLES(DIA,Left3)),
		GVAR(DOUBLES(DIA,Left2)),
		GVAR(DOUBLES(DIA,Right2)),
		GVAR(DOUBLES(DIA,Title))
	};

	class GVAR(DOUBLES(DIA,Background)): RscBackground {
		idc = 1099;
		x = 0 * safezoneW + safezoneX;
		y = 0 * safezoneH + safezoneY;
		w = 1 * safezoneW;
		h = 1 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Text)): RscStructuredText {
		x = 0.631249 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
		colorText[] = {-1,-1,-1,-1};
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class GVAR(DOUBLES(DIA,TextSmall)): GVAR(DOUBLES(DIA,Text)) {
		x = 0.631249 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
		size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.75)";
	};
	class GVAR(DOUBLES(DIA,bottomRight4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1114;
		x = 0.631249 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomMiddleRight4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1111;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomMiddleLeft4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1112;
		x = 0.36875 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomLeft4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1113;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomRight3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1110;
		x = 0.585312 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.177187 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomMiddle3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1109;
		x = 0.408125 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.177187 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomLeft3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1108;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.170625 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomRight2)): GVAR(DOUBLES(DIA,Text)) {
		idc = 1104;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,bottomLeft2)): GVAR(DOUBLES(DIA,Text)) {
		idc = 1103;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.5 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.350035 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,right4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1116;
		x = 0.631249 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,middleRight4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1115;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,middleLeft4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1117;
		x = 0.36875 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Left4)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1118;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.13125 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Right3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1107;
		x = 0.585312 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.177187 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Middle3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1106;
		x = 0.408125 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.177187 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Left3)): GVAR(DOUBLES(DIA,TextSmall)) {
		idc = 1105;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.170625 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Right2)): GVAR(DOUBLES(DIA,Text)) {
		idc = 1102;
		x = 0.5 * safezoneW + safezoneX;
		y = 0.289979 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Left2)): GVAR(DOUBLES(DIA,Text)) {
		idc = 1101;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.289953 * safezoneH + safezoneY;
		w = 0.2625 * safezoneW;
		h = 0.210021 * safezoneH;
	};
	class GVAR(DOUBLES(DIA,Title)): GVAR(DOUBLES(DIA,Text)) {
		idc = 1100;
		x = 0.2375 * safezoneW + safezoneX;
		y = 0.149922 * safezoneH + safezoneY;
		w = 0.525 * safezoneW;
		h = 0.140031 * safezoneH;
	};
};