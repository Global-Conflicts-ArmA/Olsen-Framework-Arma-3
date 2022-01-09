#include "script_component.hpp"

#include "settings.sqf"

#define PLAYERCLIENT (!isDedicated && hasInterface)

if PLAYERCLIENT then {
	switch (side player) do {
		case west: {[player, WESTCVC] call kobld_cvc_check_fnc_cvcCheck};
		case east: {[player, EASTCVC] call kobld_cvc_check_fnc_cvcCheck};
		case resistance: {[player, GUERCVC] call kobld_cvc_check_fnc_cvcCheck};
		default {[player, CIVCVC] call kobld_cvc_check_fnc_cvcCheck};
	};
} else {
	{
		switch (side _x) do {
			case west: {[_x, WESTCVC] call kobld_cvc_check_fnc_cvcCheck};
			case east: {[_x, EASTCVC] call kobld_cvc_check_fnc_cvcCheck};
			case resistance: {[_x, GUERCVC] call kobld_cvc_check_fnc_cvcCheck};
			default {[_x, CIVCVC] call kobld_cvc_check_fnc_cvcCheck};
		};
	} forEach AIUNITLIST;
};
