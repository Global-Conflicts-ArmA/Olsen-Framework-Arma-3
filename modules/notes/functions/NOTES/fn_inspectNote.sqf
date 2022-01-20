#include "script_component.hpp"

private ["_handwriting"];
params ["_handwriting"];

if (isNil "_handwriting") then {
    private _note = player getVariable [QGVAR(activeNote), objNull];
    switch (typeName _note) do {
        case ("OBJECT"): {
            _handwriting = _note getVariable ["handwriting", ["",["",""]]];
        };

        case ("SCALAR"): {
            private _nodeName = format ["GVAR(myNotes_)%1", _note];
            _handwriting = player getVariable [_nodeName + "_handwriting", ["",["",""]]];
        };

        default {
            _handwriting = ["",""];
        };
    };
};

_handwriting params ["_modifier", "_type"];
_type params ["_descriptor", "_font"];

private _texts = [
    "The handwriting on this note is %1 %2.",
    "The author of this note has %1 %2 handwriting.",
    "The letters on this note are %1 %2."
];


_myHandwriting = player getVariable [QGVAR(handwriting),["",["",""]]];
_myHandwriting params ["_myModifier", "_myType"];
_myType params ["_myDescriptor", "_myFont"];

if (_myModifier == _modifier && _myDescriptor == _descriptor) then {
    hint "This looks like my handwriting.";
} else {
    hint format [selectRandom _texts, _handwriting select 0, (_handwriting select 1) select 0];
};
