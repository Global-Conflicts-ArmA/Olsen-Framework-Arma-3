#include "defs.hpp"

_id = POFM_DIA_IDC_SHELLSELECT;
_numGuns = POFM_DIA_IDC_NUMGUNSELECT;
_gun = _this;

if (_gun >= 0) then {
	lbClear _id;
	lbClear _numGuns;

	{
		_x params ["_name","_ready","_ammo","_guns"];

		if (lbText [POFM_DIA_IDC_GUNSELECT,_this] == _name) then {
			if (_ready) then {
				{
					_x params ["_class","_qty"];

					_text = "";
					if (_qty > 0) then {
						_text = (str _qty) + " x " + getText (configfile / "CfgMagazines" / _class / "displayName");
					};

					lbAdd [_id, _text];
				} forEach _ammo;

				for "_i" from 1 to _guns do {
					lbAdd [_numGuns,str(_i)];
				};
				lbSort [POFM_DIA_IDC_NUMGUNSELECT, "DESC"];
			};
		};
	} forEach tin_var_artyBatteries;

	lbSetCurSel [_id,0];
	lbSetCurSel [_numGuns,0];
};