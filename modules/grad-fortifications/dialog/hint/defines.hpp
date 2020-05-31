//CONTROLS =====================================================================
#define HINT_TITLE     57000
#define HINT_BG_LINE1  57010
#define HINT_TXT_LINE1 57011
#define HINT_PIC_LINE1 57012
#define HINT_BG_LINE2  57020
#define HINT_TXT_LINE2 57021
#define HINT_PIC_LINE2 57022
#define HINT_BG_LINE3  57030
#define HINT_TXT_LINE3 57031
#define HINT_PIC_LINE3 57032
#define HINT_BG_LINE4  57040
#define HINT_TXT_LINE4 57041
#define HINT_PIC_LINE4 57042
#define HINT_BG_LINE5  57050
#define HINT_TXT_LINE5 57051
#define HINT_PIC_LINE5 57052


//DIMENSIONS AND POSITIONS =====================================================
#define SPACING_Y       (0.0025 * Y_SCALE)
#define SPACING_X       (0.0025 * X_SCALE)

#define HINT_W          (0.3 * X_SCALE)
#define HINT_H          (0.0275 * Y_SCALE)

#define HINT_PICTURE_W  (0.0275 * X_SCALE)

#define HINT_X          (1.3 * X_SCALE)
#define HINT_Y          (0.3 * Y_SCALE)

#define HINT_TEXTSCALE  (0.03 * TEXT_SCALE)

#define HINT_TEXT_X     (HINT_X + HINT_PICTURE_W + SPACING_X)
#define HINT_TEXT_W     (HINT_W - HINT_PICTURE_W - SPACING_X)
