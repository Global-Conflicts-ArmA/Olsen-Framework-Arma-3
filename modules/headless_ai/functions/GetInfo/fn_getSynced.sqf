#include "script_component.hpp"

params [
    ["_logic", objnull, [objnull]]
];

private _synced = synchronizedObjects _logic;

_synced = _synced arrayIntersect _synced;
//LOG_1("return _synced %1",_synced);
_synced
