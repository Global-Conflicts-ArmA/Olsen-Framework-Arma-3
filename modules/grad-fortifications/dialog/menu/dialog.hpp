class GVAR(MainMenu) {
    idd = MENU_DIALOG;
    movingEnable = true;
    enableSimulation = true;

    class ControlsBackground {
        class MainBackground: GVAR(RscBackground) {
            x = MENU_BG_X;
            y = MENU_BG_Y;
            w = MENU_BG_W;
            h = MENU_BG_H;
        };

        class TopBar: GVAR(RscBackground) {
            x = MENU_BG_X;
            y = MENU_TOPBAR_Y;
            w = MENU_BG_W;
            h = MENU_ITEM_H;

            colorBackground[] = {
                "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_G',0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",
                1
            };
        };

        class DialogTitleText: GVAR(RscText) {
            idc = MENU_TITLE;
            text = "MY FORTIFICATIONS";
            sizeEx = 0.04 * TEXT_SCALE;

            x = MENU_BG_X;
            y = MENU_TOPBAR_Y;
            w = MENU_BG_W;
            h = MENU_ITEM_H;
        };

        class ItemListBG: GVAR(RscBackground) {
            idc = -1;
            colorBackground[] = {0,0,0,0.4};

            x = MENU_COLUMN1_X;
            y = MENU_BG_Y + MENU_PADDING_Y;
            w = MENU_COLUMN_W;
            h =MENU_COLUMN_H;
        };

        class PreviewPictureBG: GVAR(RscBackground) {
            idc = -1;
            colorBackground[] = {0,0,0,0.4};

            x = MENU_COLUMN2_X;
            y = MENU_BG_Y + MENU_PADDING_Y;
            w = 2*MENU_COLUMN_W;
            h =MENU_COLUMN_H;
        };
    };

    class Controls {
        class ItemList: GVAR(RscListNBox) {
            idc = MENU_ITEMLIST;

            x = MENU_COLUMN1_X;
            y = MENU_BG_Y + MENU_PADDING_Y + MENU_ITEMSPACE_Y;
            w = MENU_COLUMN_W;
            h =MENU_COLUMN_H - 2*MENU_ITEMSPACE_Y;

            onLBSelChanged = QUOTE(_this call FUNC(onSelChanged));
        };

        class BuildButton: GVAR(RscButton) {
            idc = MENU_BUILDBUTTON;
            text = "BUILD";
            action = QUOTE(['NORMAL'] call FUNC(doBuild); closeDialog 0);

            x = MENU_BG_X + MENU_BG_W - MENU_BUTTON_W;
            y = MENU_BG_Y + MENU_BG_H + MENU_ITEMSPACE_Y;
            w = MENU_BUTTON_W;
            h = MENU_ITEM_H;
        };

        class DropButton: GVAR(RscButton) {
            idc = MENU_DROPBUTTON;
            text = "DROP";
            action = QUOTE(_this call FUNC(doDrop));

            x = MENU_BG_X + MENU_BG_W - MENU_ITEMSPACE_X - 2*MENU_BUTTON_W;
            y = MENU_BG_Y + MENU_BG_H + MENU_ITEMSPACE_Y;
            w = MENU_BUTTON_W;
            h = MENU_ITEM_H;
        };

        class CloseButton: GVAR(RscCloseButton) {
          idc = -1;
          x = MENU_BG_X + MENU_BG_W - MENU_ITEMSPACE_X - MENU_CLOSEBUTTON_W;
          y = MENU_TOPBAR_Y + MENU_ITEMSPACE_Y;
          w = MENU_CLOSEBUTTON_W;
          h = MENU_CLOSEBUTTON_W;
        };
    };

    class Objects {
        class previewModel {
            idc = MENU_3DMODEL;
            type = 82;
            model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
            scale = 0.05;

            direction[] = {-0.40, 0.35, 0.65};
			up[] = {0, 0.65, -0.35};

            x = MENU_COLUMN2_X + MENU_COLUMN_W;
            y = MENU_BG_Y + MENU_PADDING_Y + 0.5*GVAR(Column_H);
            z = 0.2;

            xBack = MENU_COLUMN2_X + MENU_COLUMN_W;
            yBack = MENU_BG_Y + MENU_PADDING_Y + 0.5*GVAR(Column_H);
            zBack = 1.2;

            inBack = 1;
            enableZoom = 0;
            zoomDuration = 0.001;
            onLoad = QUOTE(_this call FUNC(rotateModel););
        };
    };
};
