// Module by Starfox64 (STEAM_0:1:37636871) //

//If you wish to use this EndScreen please use the following syntax to update endConditions.sqf

// FW_fnc_EndMission Syntax:
// COOP
// [string EndType (endTypes.hpp), bool isVictory] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
//
// TVT
// [[side/array/unit Target, string EndType, bool isVictory], [side/array/unit Target, string EndType, bool isVictory]] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
//
// TVT Example:
// OPFOR Victory
// [[west, "BLUFOREliminated", false], [east, "BLUFOREliminated", false]] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
//
// BLUFOR Victory
// [[west, "OPFOREliminated", true], [east, "OPFOREliminated", false]] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
//
// COOP Examples:
// ["BLUFOREliminated", false] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
// ["OPFOREliminated", true] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code
// ["TimeLimit", false] call A3END_fnc_EndMission; OR call EFUNC(A3END,EndMission) from within code

//ENABLE_A3_ENDSCREEN
//Whether or not to use the ArmA 3 gorgeous EndScreen.
#define ENABLE_A3_ENDSCREEN true
