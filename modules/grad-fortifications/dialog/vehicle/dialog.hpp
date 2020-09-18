class GVAR(vehicle): GVAR(MainMenu) {
    class ControlsBackground: ControlsBackground {
        class MainBackground: MainBackground {
            x = VEHICLE_BG_X;
            w = VEHICLE_BG_W;
        };
        class TopBar: TopBar {
            x = VEHICLE_BG_X;
            w = VEHICLE_BG_W;
        };
        class DialogTitleText: DialogTitleText {
            x = VEHICLE_BG_X;
            text = "FORTIFICATIONS";
        };

        class ItemListBG1: ItemListBG {
            x = VEHICLE_COLUMN1_X;
        };
        class ItemListBG2: ItemListBG {
            x = VEHICLE_COLUMN2_X;
        };

        class PreviewPictureBG: PreviewPictureBG {
            x = VEHICLE_COLUMN3_X;
        };
    };

    class Controls: Controls {
        class ItemListVehicleTitle: GVAR(RscText) {
            idc = VEHICLE_ITEMLISTTITLEVEHICLE;
            x = VEHICLE_COLUMN1_X;
            y = MENU_BG_Y + MENU_PADDING_Y;
            w = MENU_COLUMN_W;
            h = MENU_ITEM_H;

            sizeEx = 0.035 * TEXT_SCALE;
            colorBackground[] = {
                "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_G',0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",
                0.7
            };
        };

        class ItemListVehicle: ItemList {
            idc = VEHICLE_ITEMLIST;
            x = VEHICLE_COLUMN1_X;
            y = MENU_BG_Y + MENU_PADDING_Y + MENU_ITEMSPACE_Y + MENU_ITEM_H;
            h = MENU_COLUMN_H - 2 * MENU_ITEMSPACE_Y - MENU_ITEM_H;
            onLBSelChanged = QUOTE(_this call FUNC(onSelChanged));
        };

        class ItemListTitle: GVAR(RscText) {
            idc = VEHICLE_ITEMLISTTITLE;
            x = VEHICLE_COLUMN2_X;
            y = MENU_BG_Y + MENU_PADDING_Y;
            w = MENU_COLUMN_W;
            h = MENU_ITEM_H;

            sizeEx = 0.035 * TEXT_SCALE;
            colorBackground[] = {
                "(profilenamespace getvariable ['GUI_BCG_RGB_R', 0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_G',0])",
                "(profilenamespace getvariable ['GUI_BCG_RGB_B',0])",
                0.7
            };
        };

        class ItemList: ItemList {
            idc = MENU_ITEMLIST;
            x = VEHICLE_COLUMN2_X;
            y = MENU_BG_Y + MENU_PADDING_Y + MENU_ITEMSPACE_Y + MENU_ITEM_H;
            h = MENU_COLUMN_H - 2 * MENU_ITEMSPACE_Y - MENU_ITEM_H;
            onLBSelChanged = QUOTE(_this call FUNC(onSelChanged));
        };

        class StoreButton: GVAR(RscButton) {
            idc = VEHICLE_STOREBUTTON;
            style = ST_CENTER;

            x = VEHICLE_BUTTON_X;
            y = VEHICLE_BUTTON_Y;
            w = MENU_ITEM_W;
            h = MENU_ITEM_H;

            colorBackground[] = {0,0.8,0,0.8};
            text = "<";
            action = QUOTE(['STORE'] call FUNC(onSelChanged));
        };

        class TakeButton: GVAR(RscButton) {
            idc = VEHICLE_TAKEBUTTON;
            style = ST_CENTER;

            x = VEHICLE_BUTTON_X;
            y = VEHICLE_BUTTON_Y + MENU_ITEM_H + MENU_ITEMSPACE_Y;
            w = MENU_ITEM_W;
            h = MENU_ITEM_H;

            colorBackground[] = {0,0.8,0,0.8};
            text = ">";
            action = QUOTE(['TAKE'] call FUNC(onSelChanged));
        };

        class BuildButton: BuildButton {
            idc = MENU_BUILDBUTTON;
            text = "BUILD";
            action = QUOTE([] call FUNC(doBuild); closeDialog 0);

            x = VEHICLE_BG_X + VEHICLE_BG_W - MENU_BUTTON_W;
            y = MENU_BG_Y + MENU_BG_H + MENU_ITEMSPACE_Y;
            w = MENU_BUTTON_W;
            h = MENU_ITEM_H;
        };

        class CloseButton: CloseButton {
            x = VEHICLE_BG_X + VEHICLE_BG_W - MENU_ITEMSPACE_X - MENU_CLOSEBUTTON_W;
        };
    };

    class Objects: Objects {
        class previewModel: previewModel {
            x = VEHICLE_COLUMN3_X + MENU_COLUMN_W;
            y = MENU_BG_Y + MENU_PADDING_Y + 0.5 * MENU_COLUMN_H;
            z = 0.2;

            xBack = VEHICLE_COLUMN3_X + MENU_COLUMN_W;
            yBack = MENU_BG_Y + MENU_PADDING_Y + 0.5 * MENU_COLUMN_H;
            zBack = 1.2;
        };
    };
};
