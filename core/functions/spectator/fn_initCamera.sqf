#include "script_component.hpp"
//disableserialization;

params ["_display"];

[_display] spawn {
    params ["_display"];
    uiSleep 0.1;
    _display displayRemoveAllEventHandlers "KeyDown";
    private _id = _display displayaddeventhandler ["KeyDown", {
        _this call FUNC(cameraHandleKeyDown);
    }];
    private _sliderControls = (allControls _display) select {
        (ctrlIDC _x in [31434, 31436, 31438]) ||
        {ctrlIDC _x in [31435, 31437, 31439]} ||
        {ctrlText _x in ["Daytime","Overcast","Acctime"]}
    };
    _sliderControls apply {
        _x ctrlEnable false;
        _x ctrlShow false;
    };
};