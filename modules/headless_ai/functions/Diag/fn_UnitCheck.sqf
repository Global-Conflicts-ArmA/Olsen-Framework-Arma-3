#include "script_component.hpp"

params ["_unit"];

//Determine if this AI should even execute new code
private _UseAI = GETVAR(_Unit,NoAI,false);
private _BunkerAI = GETVAR(_Unit,Bunker,false);
private _Passarray = [_UseAI,(isPlayer _Unit),_BunkerAI];
LOG_2("%1 unitcheck array: %2",_unit,_Passarray);
_Passarray
