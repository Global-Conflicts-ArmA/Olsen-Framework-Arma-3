#include "defs.hpp"

_ok = createDialog "DIA_PolarFiremission";

private _id = POFM_DIA_IDC_GUNSELECT;

lbClear _id;

{
	_x params ["_name","_ready","_ammo","_guns","_disp","_reloadTime","_calcTime","_flightTime","_delayTime","_side"];

	if (_ready && side player == _side) then {
		lbAdd [_id,_name];
	};
} forEach tin_var_artyBatteries;

lbSetCurSel [_id,0];