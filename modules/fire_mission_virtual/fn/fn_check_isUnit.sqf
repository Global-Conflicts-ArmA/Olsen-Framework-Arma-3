
params ["_value","_errorText"];

private _ret = true;

if(_value isEqualTo objNull) then {
	hint _errorText;

	_ret = false;
};

_ret