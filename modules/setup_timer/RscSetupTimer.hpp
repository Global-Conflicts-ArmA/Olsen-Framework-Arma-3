class GVAR(DisplayRsc) {
    onLoad = "_this call STIMER_fnc_TimerInit";
    idd = -1;
    duration = 1200;
    movingEnable = 0;
    class Controls {
        ////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by PiZZADOX, v1.063, #Tejytu)
////////////////////////////////////////////////////////

class TitleBackground: RscText
{
	idc = 1002;
	style = 0;
	type = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

	text = "Setup Timer"; //--- ToDo: Localize;
	x = 6 * GUI_GRID_W + GUI_GRID_X;
	y = 2 * GUI_GRID_H + GUI_GRID_Y;
	w = 29 * GUI_GRID_W;
	h = 3.5 * GUI_GRID_H;
	colorText[] = {1,1,1,1};
	colorBackground[] = {"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])","(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])","(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"};
	sizeEx = 20 * GUI_GRID_H;
};
class Title: RscText
{
	idc = 1001;
	style = 0;
	type = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

	text = "Setup Timer"; //--- ToDo: Localize;
	x = 10.5 * GUI_GRID_W + GUI_GRID_X;
	y = 2.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 13 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0.5};
	sizeEx = 20 * GUI_GRID_H;
};
class SetupTimeLeft: RscText
{
	idc = 1003;
	style = 0;
	type = 0;
	shadow = 1;
	colorShadow[] = {0,0,0,0.5};
	font = "PuristaMedium";
	linespacing = 1;
	tooltipColorText[] = {1,1,1,1};
	tooltipColorBox[] = {1,1,1,1};
	tooltipColorShade[] = {0,0,0,0.65};

	text = "  --:--.---"; //--- ToDo: Localize;
	x = 24 * GUI_GRID_W + GUI_GRID_X;
	y = 3.5 * GUI_GRID_H + GUI_GRID_Y;
	w = 13 * GUI_GRID_W;
	h = 1.5 * GUI_GRID_H;
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	sizeEx = 28 * GUI_GRID_H;
};
////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT END
////////////////////////////////////////////////////////

    };
};
