#include "script_component.hpp"
GVAR(keydownEH) = (findDisplay 46) displayAddEventHandler ["KeyDown", {
    params ["_control","_DIK"];

    private _builder = ACE_player;

    switch (true) do {
        case (_DIK in [42,54]): {
            _builder setVariable [QGVAR(shiftDown),true];
        };
        case (_DIK in [29,157]): {
            _builder setVariable [QGVAR(ctrlDown),true];
        };
        case (_DIK in [56,184]): {
            _builder setVariable [QGVAR(altDown),true];
        };
    };

    private _return = if (_DIK in [42,54,29,157,56,184,15]) then {
        true
    } else {
        false
    };

    _return
}];

GVAR(keyupEH) = (findDisplay 46) displayAddEventHandler ["KeyUp", {
    params ["_control","_DIK"];

    private _builder = ACE_player;

    switch (true) do {
        case (_DIK in [42,54]): {
            _builder setVariable [QGVAR(shiftDown),false];
        };
        case (_DIK in [29,157]): {
            _builder setVariable [QGVAR(ctrlDown),false];
        };
        case (_DIK in [56,184]): {
            _builder setVariable [QGVAR(altDown),false];
        };
        case (_DIK == 15): {
            if !(_builder getVariable [QGVAR(surfaceNormalForced),false]) then {
                _builder setVariable [QGVAR(surfaceNormal),!(_builder getVariable [QGVAR(surfaceNormal),true])];
            };
        };
    };

    private _return = if (_DIK in [42,54,29,157,56,184,15]) then {
        true
    } else {
        false
    };

    _return
}];
