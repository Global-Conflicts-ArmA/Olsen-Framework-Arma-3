//GVAR(START_TEXT_ARRAY) Format:
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

switch (side player) do { //Checks what team the player is on

	case blufor: { //If player is blufor they receive this message

		GVAR(START_TEXT_ARRAY) = [
			["TITLEQUOTE", "BLUFOR Time"],
			["TEXT", "Somewhere in Kavala"],
			["DATETIME"]
		];

		GVAR(START_TEXT_DELAY) = 10; // Delay (in seconds) after mission start to display the text

	}; //End of blufor case

	case opfor: { //If player is opfor they receive this message

		GVAR(START_TEXT_ARRAY) = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

		GVAR(START_TEXT_DELAY) = 10; // Delay (in seconds) after mission start to display the text

	}; //End of opfor case

	case independent: {

		GVAR(START_TEXT_ARRAY) = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

		GVAR(START_TEXT_DELAY) = 10; // Delay (in seconds) after mission start to display the text

	};

	case civilian: {

		GVAR(START_TEXT_ARRAY) = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

		GVAR(START_TEXT_DELAY) = 10; // Delay (in seconds) after mission start to display the text

	};
}; //End of switch
