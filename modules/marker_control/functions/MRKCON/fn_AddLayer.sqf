#include "script_component.hpp"

params [
  ["_side", blufor, [blufor, []]],
  ["_layerName", "", [""]],
  ["_deleteAfterStart", false, [false]]
];

if !(_layerName in getMissionLayers) exitWith {
    private _temp = format ["%1 not found in mission layer names!", _layerName];
    ERROR(_temp);
};
private _layerEntities = getMissionLayerEntities _layerName;
private _layerMarkers = _layerEntities select 1;
if (_layerMarkers isNotEqualto []) then {
    _layerMarkers apply {
        GVAR(Markers) pushBackUnique [_side, _x, _deleteAfterStart];
    };
};
