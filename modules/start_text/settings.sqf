//_startTextArray Format:
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

	case west: { //If player is west he receives this message

		_startTextArray = [
			["TITLEQUOTE", "BLUFOR Time"],
			["TEXT", "Somewhere in Kavala"],
			["DATETIME"]
		];

	}; //End of west case

	case east: { //If player is east he receives this message

		_startTextArray = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

	}; //End of east case

	case independent: {

		_startTextArray = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

	};

	case civilian: {

		_startTextArray = [
			["TITLEQUOTE", "Malden"],
			["TEXT", "Near Saint Maire"],
			["DATETIME"]
		];

	};
}; //End of switch

