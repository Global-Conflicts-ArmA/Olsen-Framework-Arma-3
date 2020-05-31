#include "..\ui_toolkit.hpp"
#include "defines.hpp"

class GVAR(empty) {
    idd = -1;
    fadein = 0;
    fadeout = 0;
    duration = 0;
};

class GVAR(hint) {
    idd = HINT_TITLE;
    duration = 99999;

    enableSimulation = 1;
    enableDisplay = 1;

    onLoad = QUOTE(uiNamespace setVariable [GVAR(hint), _this select 0];);
    onUnload = QUOTE(uiNamespace setVariable [GVAR(hint), displayNull];);

    class ControlsBackground {
        class BG1: GVAR(RscText) {
            idc = HINT_BG_LINE1;

            w = HINT_W;
            h = HINT_H;
            x = HINT_X;
            y = HINT_Y + 0*(SPACING_Y + HINT_H);

            colorBackground[] = {0,0,0,0.65};
        };
        class Text1: GVAR(RscText) {
            idc = HINT_TXT_LINE1;

			sizeEx = HINT_TEXTSCALE;

            w = HINT_TEXT_W;
            h = HINT_H;
            x = HINT_TEXT_X;
            y = HINT_Y + 0*(SPACING_Y + HINT_H);
        };
        class Pic1: GVAR(RscPicture) {
            idc = HINT_PIC_LINE1;

            w = HINT_PICTURE_W;
            h = HINT_H;
            x = HINT_X + SPACING_X;
            y = HINT_Y + 0*(SPACING_Y + HINT_H);
        };

        class BG2: GVAR(RscText) {
            idc = HINT_BG_LINE2;

            w = HINT_W;
            h = HINT_H;
            x = HINT_X;
            y = HINT_Y + 1*(SPACING_Y + HINT_H);

            colorBackground[] = {0,0,0,0.65};
        };
        class Text2: GVAR(RscText) {
            idc = HINT_TXT_LINE2;

			sizeEx = HINT_TEXTSCALE;

            w = HINT_TEXT_W;
            h = HINT_H;
            x = HINT_TEXT_X;
            y = HINT_Y + 1*(SPACING_Y + HINT_H);
        };
        class Pic2: GVAR(RscPicture) {
            idc = HINT_PIC_LINE2;

            w = HINT_PICTURE_W;
            h = HINT_H;
            x = HINT_X + SPACING_X;
            y = HINT_Y + 1*(SPACING_Y + HINT_H);
        };

        class BG3: GVAR(RscText) {
            idc = HINT_BG_LINE3;

            w = HINT_W;
            h = HINT_H;
            x = HINT_X;
            y = HINT_Y + 2*(SPACING_Y + HINT_H);

            colorBackground[] = {0,0,0,0.65};
        };
        class Text3: GVAR(RscText) {
            idc = HINT_TXT_LINE3;

			sizeEx = HINT_TEXTSCALE;

            w = HINT_TEXT_W;
            h = HINT_H;
            x = HINT_TEXT_X;
            y = HINT_Y + 2*(SPACING_Y + HINT_H);
        };
        class Pic3: GVAR(RscPicture) {
            idc = HINT_PIC_LINE3;

            w = HINT_PICTURE_W;
            h = HINT_H;
            x = HINT_X + SPACING_X;
            y = HINT_Y + 2*(SPACING_Y + HINT_H);
        };

        class BG4: GVAR(RscText) {
            idc = HINT_BG_LINE4;

            w = HINT_W;
            h = HINT_H;
            x = HINT_X;
            y = HINT_Y + 3*(SPACING_Y + HINT_H);

            colorBackground[] = {0,0,0,0.65};
        };
        class Text4: GVAR(RscText) {
            idc = HINT_TXT_LINE4;

			sizeEx = HINT_TEXTSCALE;

            w = HINT_TEXT_W;
            h = HINT_H;
            x = HINT_TEXT_X;
            y = HINT_Y + 3*(SPACING_Y + HINT_H);
        };
        class Pic4: GVAR(RscPicture) {
            idc = HINT_PIC_LINE4;

            w = HINT_PICTURE_W;
            h = HINT_H;
            x = HINT_X + SPACING_X;
            y = HINT_Y + 3*(SPACING_Y + HINT_H);
        };

        class BG5: GVAR(RscText) {
            idc = HINT_BG_LINE5;

            w = HINT_W;
            h = HINT_H;
            x = HINT_X;
            y = HINT_Y + 4*(SPACING_Y + HINT_H);

            colorBackground[] = {0,0,0,0.65};
        };
        class Text5: GVAR(RscText) {
            idc = HINT_TXT_LINE5;

			sizeEx = HINT_TEXTSCALE;

            w = HINT_TEXT_W;
            h = HINT_H;
            x = HINT_TEXT_X;
            y = HINT_Y + 4*(SPACING_Y + HINT_H);
        };
        class Pic5: GVAR(RscPicture) {
            idc = HINT_PIC_LINE5;

            w = HINT_PICTURE_W;
            h = HINT_H;
            x = HINT_X + SPACING_X;
            y = HINT_Y + 4*(SPACING_Y + HINT_H);
        };
    };
};
