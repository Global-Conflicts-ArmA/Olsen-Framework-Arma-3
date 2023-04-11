#include "script_component.hpp"

params ["_stance"];

private _return = switch (toLower _stance) do {
	case "stand": {"UP";};
	case "crouch": {"MIDDLE";};
	case "prone": {"DOWN";};
	case "auto": {"Auto"};
	default {"Auto"};
};

_return
