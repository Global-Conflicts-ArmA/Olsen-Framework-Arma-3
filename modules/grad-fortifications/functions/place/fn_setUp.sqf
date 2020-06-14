#include "script_component.hpp"
params ["_unit", "_fort", "_surfaceNormal"];

switch (true) do {
    case (!_surfaceNormal): {
        _fort setVectorUp [0,0,1];
    };
    case (_unit getVariable [QGVAR(surfaceNormal),true]): {
        _fort setVectorUp surfaceNormal (getPos _fort);
    };
    case (!(_unit getVariable [QGVAR(surfaceNormal),true])): {
        _fort setVectorUp [0,0,1];
    };
};
