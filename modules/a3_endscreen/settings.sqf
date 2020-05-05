// Module by Starfox64 (STEAM_0:1:37636871) //

//If you wish to use this EndScreen please use the following syntax to update endConditions.sqf

// FW_fnc_EndMission Syntax:
// COOP
// [string EndType (endTypes.hpp), bool isVictory] call FW_fnc_EndMission;
//
// TVT
// [[side/array/unit Target, string EndType, bool isVictory], [side/array/unit Target, string EndType, bool isVictory]] call FW_fnc_EndMission;
//
// TVT Example:
// OPFOR Victory
// [[west, "BLUFOREliminated", false], [east, "BLUFOREliminated", false]] call FW_fnc_EndMission;
//
// BLUFOR Victory
// [[west, "OPFOREliminated", true], [east, "OPFOREliminated", false]] call FW_fnc_EndMission;
//
// COOP Examples:
// ["BLUFOREliminated", false] call FW_fnc_EndMission;
// ["OPFOREliminated", true] call FW_fnc_EndMission;
// ["TimeLimit", false] call FW_fnc_EndMission;

//ENABLE_A3_ENDSCREEN
//Whether or not to use the ArmA 3 gorgeous EndScreen.
#define ENABLE_A3_ENDSCREEN false