#include "..\..\script_macros.hpp"

params ["_group"];

LOG_1("freeing %1",_group);

(units _group) apply {
    _x forcespeed -1;
    _x enableAI "Path";
};
