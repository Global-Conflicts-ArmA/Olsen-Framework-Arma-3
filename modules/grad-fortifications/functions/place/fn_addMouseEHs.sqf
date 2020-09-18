#include "script_component.hpp"
GVAR(mousewheelEH) = (findDisplay 46) displayAddEventHandler ["MouseZChanged", {
    params ["_control","_wheelChange"];

    private _builder = ACE_player;
    private _accelFactor = if (_builder getVariable [QGVAR(altDown),false]) then {3} else {1};

    switch (true) do {
        case (_builder getVariable [QGVAR(shiftDown),false]): {
            private _currentDir = _builder getVariable [QGVAR(currentDirection),0];
            private _newDirection = _currentDir + _wheelChange*_accelFactor;
            _builder setVariable [QGVAR(currentDirection), _newDirection];
        };

        case (_builder getVariable [QGVAR(ctrlDown),false]): {
            private _currentHeight = _builder getVariable [QGVAR(currentHeight),0];
            private _minHeight = _builder getVariable [QGVAR(minHeight),-0.8];
            private _maxHeight = _builder getVariable [QGVAR(maxHeight),3];
            private _newHeight = ((_currentHeight + (_wheelChange/45)*_accelFactor) max _minHeight) min _maxHeight;
            _builder setVariable [QGVAR(currentHeight),_newHeight];
        };

        default {
            private _currentDistance = _builder getVariable [QGVAR(currentDistance),4];
            private _size = _builder getVariable [QGVAR(currentSize),1];
            private _newDistance = ((_currentDistance + (_wheelChange/20)*_accelFactor) max (((_size*2)^(1/2)) max 2)) min ((_size*6)^(1/2));
            _builder setVariable [QGVAR(currentDistance),_newDistance];
        };
    };

    false
}];

GVAR(mousebuttonEH) = (findDisplay 46) displayAddEventHandler ["MouseButtonUp", {
    params ["_control","_button"];

    if !(_button in [0,1]) exitWith {};

    if (_button == 0) then {
        [ACE_player] call FUNC(placeFortification);
    };

    if (_button == 1) then {
        [] call FUNC(cancelPlacement);
    };

    false
}];

GVAR(fireOverride) = ACE_player addAction ["", {true}, "", 0, false, true, "DefaultAction", "true"];
