#include "script_component.hpp"

createDialog "DIA_PolarFiremission";

private _id = POFM_DIA_IDC_GUNSELECT;

lbClear _id;

tin_var_artyBatteries apply {
	_x params ["_name", "_ready", "_ammo", "_guns", "_disp", "_reloadTime", "_calcTime", "_flightTime", "_delayTime", "_side"];

	if (_ready && side player == _side) then {
		lbAdd [_id, _name];
	};
};

lbSetCurSel [_id, 0];
