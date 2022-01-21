#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class GVAR(DisplayRsc) {
    onLoad = QUOTE([_this] call FUNC(TimerInit););
    idd = -1;
    duration = 1200;
    movingEnable = 0;
    class Controls {
        class Background: RscText
        {
        	idc = 1001;
        	font = "PuristaMedium";

        	x = 14 * GUI_GRID_W + GUI_GRID_X;
        	y = 1 * GUI_GRID_H + GUI_GRID_Y;
        	w = 14 * GUI_GRID_W;
        	h = 2 * GUI_GRID_H;
        	colorBackground[] = {0,0,0,0.5};
        };
        class TitleBackground: RscText
        {
        	idc = 1002;
        	font = "PuristaMedium";

        	text = "Setup Time Left:"; //--- ToDo: Localize;
        	x = 16.4 * GUI_GRID_W + GUI_GRID_X;
        	y = 1.2 * GUI_GRID_H + GUI_GRID_Y;
        	w = 6.2 * GUI_GRID_W;
        	h = 1.6 * GUI_GRID_H;
        	sizeEx = 0.85 * GUI_GRID_H;
        };
        class SetupTimeLeft: RscText
        {
        	idc = 1003;
        	font = "PuristaMedium";

        	text = "  --:--.---"; //--- ToDo: Localize;
        	x = 23.2 * GUI_GRID_W + GUI_GRID_X;
        	y = 1.2 * GUI_GRID_H + GUI_GRID_Y;
        	w = 4.5 * GUI_GRID_W;
        	h = 1.6 * GUI_GRID_H;
        	sizeEx = 0.95 * GUI_GRID_H;
        };
        class RscPicture_1200: RscPicture
        {
        	idc = 1200;

        	text = "modules\setup_timer\resources\setuptimermodule_ca.paa";
        	x = 14.3 * GUI_GRID_W + GUI_GRID_X;
        	y = 1.2 * GUI_GRID_H + GUI_GRID_Y;
        	w = 1.8 * GUI_GRID_W;
        	h = 1.7 * GUI_GRID_H;
        	sizeEx = 1 * GUI_GRID_H;
        };
    };
};
