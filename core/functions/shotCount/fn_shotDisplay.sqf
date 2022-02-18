#include "script_component.hpp"

private _textBLUFOR = "BLUFOR Munitions Expended:<br/>";
private _textOPFOR = "OPFOR Munitions Expended:<br/>";
private _textINDFOR = "INDFOR Munitions Expended:<br/>";
private _textCIVILIAN = "CIVILIAN Munitions Expended:<br/>";

private _textArray = [];

if (west in GVAR(TeamSides) && {GETMVAR(EndScreenDisplay_West,true)}) then {
    _textArray pushBack [_textBLUFOR, GVAR(west_ExpendedAmmo)];
};
if (east in GVAR(TeamSides) && {GETMVAR(EndScreenDisplay_East,true)}) then {
    _textArray pushBack [_textOPFOR, GVAR(east_ExpendedAmmo)];
};
if (independent in GVAR(TeamSides) && {GETMVAR(EndScreenDisplay_Ind,true)}) then {
    _textArray pushBack [_textINDFOR, GVAR(ind_ExpendedAmmo)];
};
if (civilian in GVAR(TeamSides) && {GETMVAR(EndScreenDisplay_Civ,true)}) then {
    _textArray pushBack [_textCIVILIAN, GVAR(civ_ExpendedAmmo)];
};

TRACE_1("shotDisplay",_textArray);

private _return = _textArray apply {
    _x params [["_text", "", [""]], ["_array", [], [[]]]];
    TRACE_2("shotDisplay", _text, _array);
    if (_array isEqualTo []) then {
        _text = _text + "None";
    } else {
        for "_i" from 0 to (count _array - 1) step 2 do {
            private _label = _array select (_i);
            private _count = _array select (_i + 1);
            _text = _text + _label + ": " + str(_count) + " Rounds" + "<br/>";
        };
    };
    _text
};

LOG_1("shotDisplay return: %1",_return);

_return
