#include "script_component.hpp"

private _textBLUFOR = "BLUFOR Munitions Expended:<br/>";
private _textOPFOR = "OPFOR Munitions Expended:<br/>";
private _textINDFOR = "INDFOR Munitions Expended:<br/>";
private _textCIVILIAN = "CIVILIAN Munitions Expended:<br/>";

private _textArray = [];

if (west in GVAR(TeamSides)) then {
    _textArray pushBack [_textBLUFOR, GVAR(SC_west_ExpendedAmmo)];
};
if (east in GVAR(TeamSides)) then {
    _textArray pushBack [_textOPFOR, GVAR(SC_east_ExpendedAmmo)];
};
if (independent in GVAR(TeamSides)) then {
    _textArray pushBack [_textINDFOR, GVAR(SC_ind_ExpendedAmmo)];
};
if (civilian in GVAR(TeamSides)) then {
    _textArray pushBack [_textCIVILIAN, GVAR(SC_civ_ExpendedAmmo)];
};

LOG_1("shotDisplay _textArray: %1",_textArray);

private _return = _textArray apply {
    _x params [["_text", "", [""]], ["_array", [], [[]]]];
    LOG_2("shotDisplay _text: %1 _array: %2", _text, _array);
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