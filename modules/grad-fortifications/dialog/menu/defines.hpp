//CONTROLS =====================================================================
#define MENU_DIALOG          42000
#define MENU_TITLE           42001
#define MENU_ITEMLIST        42002
#define MENU_BUILDBUTTON     42003
#define MENU_DROPBUTTON      42004
#define MENU_3DMODEL         42005


//DIMENSIONS AND POSITIONS =====================================================
#define MENU_TEXTSIZE       (0.04 * TEXT_SCALE)

#define MENU_ITEM_H         (0.025 * Y_SCALE)
#define MENU_ITEM_W         (0.025 * X_SCALE)
#define MENU_ITEMSPACE_Y    (0.0025 * Y_SCALE)
#define MENU_ITEMSPACE_X    (0.0025 * X_SCALE)

#define MENU_PADDING_Y      (0.5 * MENU_ITEM_H)
#define MENU_PADDING_X      (0.5 * MENU_ITEM_W)

#define MENU_COLUMN_W       (0.35 * X_SCALE)
#define MENU_COLUMN_H       (0.4 * Y_SCALE)

#define MENU_COLUMN1_X      (MENU_BG_X + MENU_PADDING_X)
#define MENU_COLUMN2_X      (MENU_COLUMN1_X + MENU_COLUMN_W + MENU_PADDING_X)

#define MENU_ITEMLIST_H     (MENU_COLUMN_H - MENU_ITEM_H - MENU_ITEMSPACE_Y)
#define MENU_PICTURE_H      (0.4* (MENU_COLUMN_H - MENU_ITEMSPACE_Y))
#define MENU_DESCRIPTION_H  (0.6* (MENU_COLUMN_H - MENU_ITEMSPACE_Y))

#define MENU_BG_W           (3*MENU_PADDING_X + 3*MENU_COLUMN_W)
#define MENU_BG_H           (2*MENU_PADDING_Y + MENU_COLUMN_H)
#define MENU_BG_X           CENTER(1, MENU_BG_W)
#define MENU_BG_Y           CENTER(1, MENU_BG_H)

#define MENU_BUTTON_W       (0.2 * X_SCALE)

#define MENU_CLOSEBUTTON_W  (MENU_ITEM_H - (2 * MENU_ITEMSPACE_Y))
#define MENU_TOPBAR_Y       (MENU_BG_Y - MENU_ITEM_H * 1.1)
