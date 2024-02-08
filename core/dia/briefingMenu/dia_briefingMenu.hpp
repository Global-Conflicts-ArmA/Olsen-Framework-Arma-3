#include "..\..\script_macros.hpp"

class GVAR(BriefingMenuCfg) {
	idd = 500;
    fadeout = 0;
	fadein = 0;
    duration = 10e10;
    movingEnable = 1;
    name = QGVAR(BriefingMenu);
    onLoad = QUOTE([ARR_2('open', _this select 0)] call FUNC(briefingMenu));
    objects[] = {};
    controls[] = {
        backgroundBox,
        selectionListCombo,
        buttonOK,
        buttonCancel,
        textBox
    };
    class backgroundBox: IGUIBack
    {
    	idc = 2200;
    	x = 11 * GUI_GRID_W + GUI_GRID_X;
    	y = 6.5 * GUI_GRID_H + GUI_GRID_Y;
    	w = 16.5 * GUI_GRID_W;
    	h = 7 * GUI_GRID_H;
    };
    class selectionListCombo: RscCombo
    {
    	idc = 2100;
    	x = 11.5 * GUI_GRID_W + GUI_GRID_X;
    	y = 12 * GUI_GRID_H + GUI_GRID_Y;
    	w = 8.5 * GUI_GRID_W;
    	h = 1 * GUI_GRID_H;
    };
    class buttonOK: RscButtonMenuOK
    {
        idc = 1300;
        onButtonClick = QUOTE(['apply'] call FUNC(briefingMenu));
    	x = 20.5 * GUI_GRID_W + GUI_GRID_X;
    	y = 12 * GUI_GRID_H + GUI_GRID_Y;
    	w = 2 * GUI_GRID_W;
    	h = 1 * GUI_GRID_H;
    };
    class buttonCancel: RscButtonMenuCancel
    {
        idc = 1200;
        onButtonClick = QUOTE(['close'] call FUNC(briefingMenu));
    	x = 23 * GUI_GRID_W + GUI_GRID_X;
    	y = 12 * GUI_GRID_H + GUI_GRID_Y;
    	w = 4 * GUI_GRID_W;
    	h = 1 * GUI_GRID_H;
    };
    class textBox: RscStructuredText
    {
    	idc = 1100;
    	text = """Use the combo box to select what side's briefing will be applied to your local player. All admin notes/mission notes will also be shown."""; //--- ToDo: Localize;
    	x = 12 * GUI_GRID_W + GUI_GRID_X;
    	y = 7 * GUI_GRID_H + GUI_GRID_Y;
    	w = 14.5 * GUI_GRID_W;
    	h = 4.5 * GUI_GRID_H;
    	sizeEx = 1 * GUI_GRID_H;
    };
};
