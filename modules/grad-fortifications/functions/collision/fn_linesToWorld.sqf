#include "script_component.hpp"
params ["_lines", "_fort"];

private _linesCopy = +_lines;
private _linesWorld = _linesCopy apply {[_fort modelToWorld (_x select 0),_fort modelToWorld (_x select 1)]};

_linesWorld
