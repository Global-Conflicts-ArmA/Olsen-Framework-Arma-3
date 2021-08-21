////////////////////////////////////////////////////////
// GUI EDITOR OUTPUT START (by Sacher, v1.063, #Dyroxu)
////////////////////////////////////////////////////////

#include "defs.hpp"
class DIA_POLARFIREMISSION {
	idd = POFM_DIA_IDD_DISPLAY;
	movingEnable = false;
	enableSimulation = true;
	scriptName = "Dialog_PolarFiremission";
	controlsBackground[] = {};
	objects[] = {};
	controls[] = {
			POFM_BACKGROUND,
			POFM_DESCRIPTIONTEXT,
			POFM_SELECTEDGUNTEXT,
			POFM_SELECTEDSHELLTEXT,
			POFM_GRIDTEXT,
			POFM_MILSTEXT,
			POFM_DISTANCETEXT,
			POFM_BURSTROUNDSTEXT,
			POFM_SELECTEDGUNEDIT,
			POFM_SELECTEDSHELLEDIT,
			POFM_GRIDEDIT,
			POFM_MILSEDIT,
			POFM_DISTANCEEDIT,
			POFM_BURSTROUNDSEDIT,
			POFM_FIREBUTTON,
			POFM_CANCELBUTTON,
			POFM_NUMGUNSTEXT,
			POFM_NUMGUNEDIT
		};
		class POFM_BACKGROUND: RscText
		{
			idc = -1;
			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX - ARTIBORDERTHICKNESS;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY - ARTIBORDERTHICKNESS;
			w =  ( ARTILAYOUTWIDTH +  ARTILAYOUTWIDTHSPACE) *  safezoneW  + ARTIBORDERTHICKNESS * 2 ;
			h = ARTILAYOUTHEIGHTSPACE * 12 * safezoneH + ARTIBORDERTHICKNESS * 2 ;
				shadow = 0;
			colorBackground[] = {0.65,0.65,0.65,0.7};
		};
		class POFM_DESCRIPTIONTEXT: RscText
		{
			idc = -1;
			text = "POLAR MISSION"; //--- ToDo: Localize;

			x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
			y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 0) * safezoneH + safezoneY;
			w = ARTILAYOUTWIDTH * safezoneW;
			h = ARTILAYOUTHEIGHT * safezoneH;
			colorText[] = {0,0,0,1};

			shadow = 0;

		};
	class POFM_SELECTEDGUNTEXT: RscText
	{
		idc = -1;
		text = "BATTERY:"; //--- ToDo: Localize;

		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;

		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;

	};
	class POFM_SELECTEDSHELLTEXT: RscText
	{
		idc = -1;
		text = "AMMO TYPE:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};

	class POFM_NUMGUNSTEXT: RscText
	{
		idc = -1;
		text = "GUNS:"; //--- ToDo: Localize;

		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;

		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;

	};

	class POFM_GRIDTEXT: RscText
	{
		idc = -1;
		text = "GRID:"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_MILSTEXT: RscText
	{
		idc = -1;
		text = "DIRECTION (MILS):"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_DISTANCETEXT: RscText
	{
		idc = -1;
		text = "DISTANCE (M):"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_BURSTROUNDSTEXT: RscText
	{
		idc = -1;
		text = "ROUNDS (PER GUN):"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_FIREBUTTON: RscButton
	{
		idc = 1430;
		text = "SEND"; //--- ToDo: Localize;
		x = ARTIWIDTHMAINSPACE * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 11) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		shadow = 0;
		onMouseButtonDown = "[] call tin_fnc_dia_PolarFiremissionFire;";
	};
	class POFM_SELECTEDGUNEDIT: RscListbox
	{
		idc = POFM_DIA_IDC_GUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 1) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = (ARTILAYOUTHEIGHT * 2) * safezoneH;
		//colorText[] = {0,1,1,1};
		//
		shadow = 0;
		onLBSelChanged = "(_this select 1) call tin_fnc_dia_PolarFiremissionSetArtillery;";
	};
	class POFM_SELECTEDSHELLEDIT: RscListbox
	{
		idc = POFM_DIA_IDC_SHELLSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 3) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = (ARTILAYOUTHEIGHT * 2) * safezoneH;
		shadow = 0;
	};

	class POFM_NUMGUNEDIT: RscListbox
	{
		idc = POFM_DIA_IDC_NUMGUNSELECT;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 5) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = (ARTILAYOUTHEIGHT * 2) * safezoneH;
		//colorText[] = {0,1,1,1};
		//
		shadow = 0;
	};

	class POFM_GRIDEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_GRID;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 7) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_MILSEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_MILS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 8) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_DISTANCEEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_DISTANCE;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 9) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_BURSTROUNDSEDIT: RscEdit
	{
		idc = POFM_DIA_IDC_BURSTROUNDS;
		text = ""; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 10) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		colorText[] = {0,0,0,1};

		shadow = 0;
	};
	class POFM_CANCELBUTTON: RscButton
	{
		idc = 1600;
		text = "CANCEL"; //--- ToDo: Localize;
		x = (ARTIWIDTHMAINSPACE + ARTILAYOUTWIDTHSPACE) * safezoneW + safezoneX;
		y = (ARTIHEIGHTMAINSPACE + ARTILAYOUTHEIGHTSPACE * 11) * safezoneH + safezoneY;
		w = ARTILAYOUTWIDTH * safezoneW;
		h = ARTILAYOUTHEIGHT * safezoneH;
		shadow = 0;
		onMouseButtonDown = "[] call tin_fnc_dia_polarFiremissionCloseDialog;";
	};
};