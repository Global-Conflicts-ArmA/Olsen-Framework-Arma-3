// Function by TinfoilHate
// Handles the actual 'FIRE' button press on the dialog
// Based off work by Sacher for the firemission module

#include "script_component.hpp"

tin_var_artyBatteries apply {
	_x params ["_name", "_ready", "_ammo"];

	if (_name == lbText [POFM_DIA_IDC_GUNSELECT, lbCurSel POFM_DIA_IDC_GUNSELECT]) then {
		if (_ready) then {
			private _selectedAmmo = lbCurSel POFM_DIA_IDC_SHELLSELECT;
			private _selectedGrid = ctrlText POFM_DIA_IDC_GRID;
			private _selectedMils = (ctrlText POFM_DIA_IDC_MILS) call BIS_fnc_parseNumber;
			private _selectedDist = (ctrlText POFM_DIA_IDC_DISTANCE) call BIS_fnc_parseNumber;
			private _selectedRnds = (ctrlText POFM_DIA_IDC_BURSTROUNDS) call BIS_fnc_parseNumber;
			private _selectedGuns = (lbText [POFM_DIA_IDC_NUMGUNSELECT, lbCurSel POFM_DIA_IDC_NUMGUNSELECT]) call BIS_fnc_parseNumber;

			//Input validation, thanks Sacher!
			private _inputIsCorrect = true;
			_inputIsCorrect = _inputIsCorrect && [_selectedMils, "Mils is not a number!"] call FUNC(check_isNumber);
			_inputIsCorrect = _inputIsCorrect && [_selectedDist, "Distance is not a number!"] call FUNC(check_isNumber);
			_inputIsCorrect = _inputIsCorrect && [_selectedRnds, "Rounds is not a number!"] call FUNC(check_isNumber);
			_inputIsCorrect = _inputIsCorrect && [_selectedGuns, "Select a number of guns!"] call FUNC(check_isNumber);

			if(_inputIsCorrect) then {
				private _newAmmoClass = "";
				{
					_x params ["_class"];

					if (_forEachIndex == _selectedAmmo) then {
						_newAmmoClass = _class;
					};
				} forEach _ammo;

				["tin_evt_callPolarFiremission", [player, _name, _newAmmoClass, _selectedGrid, _selectedMils, _selectedDist, _selectedRnds, _selectedGuns]] call CBA_fnc_serverEvent;

				[] call FUNC(dia_polarFiremissionCloseDialog);
			};
		};
	};
};
