//IDCs =========================================================================
#define LN_DIALOG           6000
#define LN_TITLE            6010
#define LN_NOTEPAD          6020
#define LN_CLOSEBUTTON      6030
#define LN_BUTTON1          6100
#define LN_BUTTON2          6200
#define LN_BUTTON3          6300
#define LN_EDITBOX          6400
#define LN_TEXTBOX          6500

//COORDS AND DIMENSIONS ========================================================
#define lnButton_textSize   (0.04 * TEXT_SCALE)
#define lnTotal_W           (0.4 * X_SCALE)
#define lnTotal_H           (0.65 * Y_SCALE)
#define lnTotal_X           CENTER(1, lnTotal_W)
#define lnTotal_Y           CENTER(1, lnTotal_H)

#define lnButton_W          (0.100 * X_SCALE)
#define lnButton_H          (0.025 * Y_SCALE)

#define lnSpacing_X         (0.0025 * X_SCALE)
#define lnSpacing_Y         (0.0025 * Y_SCALE)

#define lnCloseButton_W     ((0.025 * X_SCALE) - (2 * lnSpacing_Y))
#define lnCloseButton_H     (lnButton_H - (2 * lnSpacing_X))

#define lnPadding_X         (1 * (0.025 * Y_SCALE))
#define lnPadding_Y         (1 * lnButton_H)

#define lnBG_X              (lnTotal_X)
#define lnBG_Y              (lnTotal_Y + lnButton_H + lnSpacing_Y)
#define lnBG_H              (lnTotal_H - lnButton_H - lnSpacing_Y)
#define lnTopbar_Y          (lnBG_Y + lnSpacing_Y + lnButton_H)
