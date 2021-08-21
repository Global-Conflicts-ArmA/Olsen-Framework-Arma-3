/*
 * Author: DerZade
 * Triggerd by AnimDone-Eventhandler
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: animtaion <STRING>
 *
 * Return Value:
 * Nothing
 *
 * Example:
 * _this call zade_boc_fnc_EHAnimDone;
 *
 * Public: No
 */
params ["_unit","_anim"];

if (isNil "_unit") exitWith {["No proper argument(s) given."] call BIS_fnc_error};

_chestpack = [_unit] call zade_boc_fnc_chestpackContainer;

//freefall
if ((animationState _unit) find "halofreefall_" isEqualTo 0) then {
     _chestpack attachTo [_unit,[0,-0.4,0.05],"pelvis"];
     _chestpack setVectorDirandUp [[0,0,1],[0,1,0]];
};
