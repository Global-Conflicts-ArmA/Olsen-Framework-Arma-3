#include "core\briefingCore.sqf" //DO NOT REMOVE

switch (side player) do { //Checks what team the player is on

	case west: { //If player is west he receives this briefing
	
		NEWTAB("I. Situation:")
		<font color='#BBBBBB' size='16' face='PuristaBold'>This is an example header:</font><br/>
		<br/>
		Example text.<br/>
		<br/>
		This is how you create a <marker name='markerName'>marker</marker>.
		ENDTAB;

		NEWTAB("A. Enemy Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("B. Friendly Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("II. Mission:")
		//Text goes here
		ENDTAB;

		NEWTAB("III. Execution:")
		//Text goes here
		ENDTAB;

		NEWTAB("IV. Service Support:")
		//Text goes here
		ENDTAB;

		NEWTAB("V. Command & Signal:")
		//Text goes here
		ENDTAB;
	
	};
	
	case east: { 
	
		NEWTAB("I. Situation:")
		<font color='#BBBBBB' size='16' face='PuristaBold'>This is an example header:</font><br/>
		<br/>
		Example text.<br/>
		<br/>
		This is how you create a <marker name='markerName'>marker</marker>.
		ENDTAB;

		NEWTAB("A. Enemy Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("B. Friendly Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("II. Mission:")
		//Text goes here
		ENDTAB;

		NEWTAB("III. Execution:")
		//Text goes here
		ENDTAB;

		NEWTAB("IV. Service Support:")
		//Text goes here
		ENDTAB;

		NEWTAB("V. Command & Signal:")
		//Text goes here
		ENDTAB;
	
	};
	
	case independent: {
	
		NEWTAB("I. Situation:")
		<font color='#BBBBBB' size='16' face='PuristaBold'>This is an example header:</font><br/>
		<br/>
		Example text.<br/>
		<br/>
		This is how you create a <marker name='markerName'>marker</marker>.
		ENDTAB;

		NEWTAB("A. Enemy Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("B. Friendly Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("II. Mission:")
		//Text goes here
		ENDTAB;

		NEWTAB("III. Execution:")
		//Text goes here
		ENDTAB;

		NEWTAB("IV. Service Support:")
		//Text goes here
		ENDTAB;

		NEWTAB("V. Command & Signal:")
		//Text goes here
		ENDTAB;
	
	};
	
	case civilian: {
	
		NEWTAB("I. Situation:")
		<font color='#BBBBBB' size='16' face='PuristaBold'>This is an example header:</font><br/>
		<br/>
		Example text.<br/>
		<br/>
		This is how you create a <marker name='markerName'>marker</marker>.
		ENDTAB;

		NEWTAB("A. Enemy Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("B. Friendly Forces:")
		//Text goes here
		ENDTAB;

		NEWTAB("II. Mission:")
		//Text goes here
		ENDTAB;

		NEWTAB("III. Execution:")
		//Text goes here
		ENDTAB;

		NEWTAB("IV. Service Support:")
		//Text goes here
		ENDTAB;

		NEWTAB("V. Command & Signal:")
		//Text goes here
		ENDTAB;
	
	};

}; //End of switch
//Everything below here is showen for all teams/sides
NEWTAB("") //Blank spacer to seperate mission brief from mission notes
//Text goes here
ENDTAB;
	
NEWTAB("Mission notes") //Add other stuff that is important but not related to the lore/brief
//Text goes here
ENDTAB;

NEWTAB("Changelog") //Add changes here each update
//Text goes here
ENDTAB;

if (!isNil "uo_fnc_hasGMAccess" && {call uo_fnc_hasGMAccess}) then {
	NEWTAB("ADMIN NOTES")
	<font size='10' face='RobotoCondensedBold'>
		<br/>THIS IS ONLY VISIBLE TO LOGGED-IN ADMINS AND GMS
	</font>
	ENDTAB;
};


DISPLAYBRIEFING();
