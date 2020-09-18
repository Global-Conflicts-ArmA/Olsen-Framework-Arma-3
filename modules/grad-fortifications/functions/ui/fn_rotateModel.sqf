/*  Rotates 3D Model while dialog is open
*
*/

#include "script_component.hpp"
params ["_modelCtrl"];

_modelCtrl ctrlSetModelDirAndUp [[0,1,0.06],[0,0,1]];
_modelCtrl ctrlEnable false;

[{
    params ["_modelCtrl", "_handle"];
    if (isNull _modelCtrl) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    (ctrlModelDirAndUp _modelCtrl) params ["_currentDir"];
    _currentDir params ["_x", "_y","_z"];

    ([[_x,_y], 0.8] call BIS_fnc_rotateVector2D) params ["_newX","_newY"];

    _modelCtrl ctrlSetModelDirAndUp [[_newX,_newY,_z],[0,0,1]];
    _modelCtrl ctrlCommit 0;
} , 0.036, _modelCtrl] call CBA_fnc_addPerFrameHandler;
