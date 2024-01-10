/*
GVAR(ARRAY_<TEAM>) Format:

[
    "LINE_TYPE", <STRING, MANDATORY>
    "TEXT TO DISPLAY", <STRING, MANDATORY FOR TEXT DISPLAYS>
    LINE_SIZE <NUMBER, OPTIONAL, DEFAULT: 1.2>,
    "LINE_FONT" <STRING, OPTIONAL, DEFAULT: "PuristaBold">
], <-- remember to put a comma between lines unless this is the last line

Line Types:

TEXT - > MyText
TEXTQUOTE - > 'MyText'
TIME -> Displays time (no text required)
DATE -> Displays date (no text required)
DATETIME -> Displays date and time (no text required)

To disable the start text for a specific team just comment out its declaration.

*/

GVAR(delay) = 5; // Delay (in seconds) after mission start to display the text

// If player is BLUFOR they receive this message
GVAR(ARRAY_BLUFOR) = [
	[
        "TEXTQUOTE",
        "BLUFOR Time",
        1.6,
        "rhs_digital_font"
    ],
	[
        "TEXT",
        "Somewhere in Kavala"
    ],
	["DATETIME"]
];

// If player is OPFOR they receive this message
GVAR(ARRAY_OPFOR) = [
    [
        "TEXTQUOTE",
        "OPFOR Time",
        1.6,
        "rhs_digital_font"
    ],
    [
        "TEXT",
        "Somewhere in Kavala"
    ],
    ["DATETIME"]
];

// If player is INDEPENDENT they receive this message
GVAR(ARRAY_INDFOR) = [
    [
        "TEXTQUOTE",
        "INDFOR Time",
        1.6,
        "rhs_digital_font"
    ],
    [
        "TEXT",
        "Somewhere in Kavala"
    ],
    ["DATETIME"]
];

// If player is CIVILIAN they receive this message
GVAR(ARRAY_CIVFOR) = [
    [
        "TEXTQUOTE",
        "CIVFOR Time",
        1.6,
        "rhs_digital_font"
    ],
    [
        "TEXT",
        "Somewhere in Kavala"
    ],
    ["DATETIME"]
];
