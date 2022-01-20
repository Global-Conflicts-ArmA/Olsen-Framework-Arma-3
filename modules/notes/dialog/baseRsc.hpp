class GRAD_leaveNotes_RscUIBack {
    idc = -1;
    type = CT_STATIC;
    style = ST_HUD_BACKGROUND;
    text = "";
    colorText[] = {1, 1, 1, 1};
    font = "PuristaMedium";
    sizeEx = 0;
    shadow = 0;
    x = 0.1;
    y = 0.1;
    w = 0.1;
    h = 0.1;
    colorbackground[] =
    {
    	"(profilenamespace getvariable ['IGUI_BCG_RGB_R',0])",
    	"(profilenamespace getvariable ['IGUI_BCG_RGB_G',1])",
    	"(profilenamespace getvariable ['IGUI_BCG_RGB_B',1])",
    	"(profilenamespace getvariable ['IGUI_BCG_RGB_A',0.8])"
    };
};

class GRAD_leaveNotes_RscText {
    idc = -1;
    access = 0;
    type = CT_STATIC;

    style = ST_MULTI;
    lineSpacing = 1;
    w = 0.1;
    h = 0.05;
    font = "TahomaB";
    sizeEx = TEXT_SCALE_UI * 0.0465;
    colorBackground[] = {0,0,0,0};
    colorText[] = {0,0,0,1};
    text = "";
    fixedWidth = 0;
    shadow = 0;
};

class GRAD_leavNotes_RscEditBox: GRAD_leaveNotes_RscText {
    type = CT_EDIT;
    colorDisabled[] = {0,0,0,0};
    colorSelection[] = {0,0,0,0.25};
    autocomplete = "";
    htmlControl = 1;
    size = 0.2;
};

class GRAD_leaveNotes_RscCloseButton {
    access = 0;
    idc = -1;
    type = CT_BUTTON;
    action = "closeDialog 0";
    text = "X";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.25};
    colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",1};
    colorFocused[] = {1,1,1,0.5};
    colorBackgroundActive[] = {1,1,1,0.8}; // hover
    colorBackgroundDisabled[] = {0.3,0.3,0.3,1};
    colorBackgroundFocused[] = {1,1,1,0};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
    animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
    animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
    animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "PuristaMedium";
    sizeEx = 0.04;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class GRAD_leaveNotes_RscButton {
    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,1};
    colorDisabled[] = {1,1,1,0.1};
    colorBackground[] = {0,0,0,0.5};
    colorFocused[] = {1,1,1,0.5};
    colorBackgroundActive[] = {1,1,1,0.8}; // hover
    colorBackgroundDisabled[] = {0.3,0.3,0.3,1};
    colorBackgroundFocused[] = {0,0,0,0.5};
    colorShadow[] = {0,0,0,0};
    colorBorder[] = {0,0,0,1};
    soundEnter[] = {"\A3\ui_f\data\sound\RscButton\soundEnter", 0.09, 1};
    soundPush[] = {"\A3\ui_f\data\sound\RscButton\soundPush", 0.09, 1};
    soundClick[] = {"\A3\ui_f\data\sound\RscButton\soundClick", 0.09, 1};
    soundEscape[] = {"\A3\ui_f\data\sound\RscButton\soundEscape", 0.09, 1};
    animTextureDefault = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureNormal = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureDisabled = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\normal_ca.paa";
    animTextureOver = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\over_ca.paa";
    animTextureFocused = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\focus_ca.paa";
    animTexturePressed = "\A3\ui_f\data\GUI\RscCommon\RscShortcutButton\down_ca.paa";
    style = ST_RIGHT;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "PuristaMedium";
    sizeEx = 0.04;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};
