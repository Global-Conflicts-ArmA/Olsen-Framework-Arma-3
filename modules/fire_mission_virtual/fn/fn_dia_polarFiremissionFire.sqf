// Function by TinfoilHate
// Handles the actual 'FIRE' button press on the dialog
// Based off work by Sacher for the firemission module

#include "defs.hpp"

{
	_x params ["_name","_ready","_ammo"];

	if (_name == lbText [POFM_DIA_IDC_GUNSELECT, lbCurSel POFM_DIA_IDC_GUNSELECT]) then {
		if (_ready) then {
			_selectedAmmo = lbCurSel POFM_DIA_IDC_SHELLSELECT;
			_selectedGrid = ctrlText POFM_DIA_IDC_GRID;
			_selectedMils = (ctrlText POFM_DIA_IDC_MILS) call BIS_fnc_parseNumber;
			_selectedDist = (ctrlText POFM_DIA_IDC_DISTANCE) call BIS_fnc_parseNumber;
			_selectedRnds = (ctrlText POFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
			_selectedGuns = (lbText [POFM_DIA_IDC_NUMGUNSELECT, lbCurSel POFM_DIA_IDC_NUMGUNSELECT]) call BIS_fnc_parseNumber;

			//Input validation, thanks Sacher!
			_inputIsCorrect = true;
			_inputIsCorrect = _inputIsCorrect && [_selectedMils,"Mils is not a number!"] call tin_fnc_check_isNumber;
			_inputIsCorrect = _inputIsCorrect && [_selectedDist,"Distance is not a number!"] call tin_fnc_check_isNumber;
			_inputIsCorrect = _inputIsCorrect && [_selectedRnds,"Rounds is not a number!"] call tin_fnc_check_isNumber;
			_inputIsCorrect = _inputIsCorrect && [_selectedGuns,"Select a number of guns!"] call tin_fnc_check_isNumber;

			if(_inputIsCorrect) then {
				_newAmmoClass = "";
				{
					_x params ["_class"];

					if (_forEachIndex == _selectedAmmo) then {
						_newAmmoClass = _class;
					};
				} forEach _ammo;

				["tin_evt_callPolarFiremission", [player,_name,_newAmmoClass,_selectedGrid,_selectedMils,_selectedDist,_selectedRnds,_selectedGuns]] call CBA_fnc_serverEvent;

				[] call tin_fnc_dia_polarFiremissionCloseDialog;
			};
		};
	};
} forEach tin_var_artyBatteries;