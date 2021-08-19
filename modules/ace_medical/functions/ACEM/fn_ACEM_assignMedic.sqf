//Make a unit a medic, also works for medical vehicles. Ex: [this,2] call FW_fnc_ACEM_assignMedic; makes a unit or medical vehicle a 'doctor' level.
params[
  ["_unit", objNull, [objNull]], //Unit to be a medic
  ["_type", 0, [0]] //2 Doctor, 1 Medic, 0 Normal
];

if (local _unit) then {
  _unit setVariable ["ace_medical_medicClass", _type, true];
};
