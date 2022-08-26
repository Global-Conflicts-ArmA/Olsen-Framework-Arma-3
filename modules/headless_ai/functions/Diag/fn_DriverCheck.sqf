#include "script_component.hpp"


//Created on 8/15/14
// Modified on : 8/29/14 - Fixed passenger getting a nill for _NotDriver
params ["_unit"];

private _NotDriver = false;
private _Vehicle = (vehicle _Unit);
private _ActualDriver = driver _Vehicle;

if (_Unit isEqualTo _ActualDriver) then {
  _NotDriver = true;
};

_NotDriver
