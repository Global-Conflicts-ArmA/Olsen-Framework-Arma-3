//GVAR(START_TEXT_ARRAY_<TEAM>) Format:
//
//["LINE_TYPE", "LINE_TEXT"], <-- remember to put a comma unless this is the last line
//
//Line Types:
//
//TITLEQUOTE -> "MyTitle"
//TITLE -> MyTitle
//TEXT - > MyText
//TIME -> Displays time (no text required)
//DATE -> Displays date (no text required)
//DATETIME -> Displays date and time (no text required)
// To disable the start text for a specific team just comment out its declaration.

GVAR(START_TEXT_DELAY) = 10; // Delay (in seconds) after mission start to display the text

// If player is BLUFOR they receive this message
GVAR(START_TEXT_ARRAY_BLUFOR) = [
	["TITLEQUOTE", "BLUFOR Time"],
	["TEXT", "Somewhere in Kavala"],
	["DATETIME"]
];

// If player is OPFOR they receive this message
GVAR(START_TEXT_ARRAY_OPFOR) = [
	["TITLEQUOTE", "OPFOR Time"],
	["TEXT", "Somewhere in Kavala"],
	["DATETIME"]
];

// If player is INDEPENDENT they receive this message
GVAR(START_TEXT_ARRAY_INDFOR) = [
	["TITLEQUOTE", "INDFOR Time"],
	["TEXT", "Somewhere in Kavala"],
	["DATETIME"]
];

// If player is CIVILIAN they receive this message
GVAR(START_TEXT_ARRAY_CIVFOR) = [
	["TITLEQUOTE", "CIVFOR Time"],
	["TEXT", "Somewhere in Kavala"],
	["DATETIME"]
];
