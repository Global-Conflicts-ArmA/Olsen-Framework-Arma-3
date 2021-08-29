#include "script_component.hpp"
#include "defs.hpp"

private _unit = _this;
private _rounds = _unit call FUNC(FIREMIS_Dia_GetArtyFiremissionRoundsRequired);
private _callerName = _unit call FUNC(FIREMIS_Dia_GetArtyCaller)Text;
private _fireMissionText =_unit getVariable [VAR_SART_ARTFMTEXT,"Error"];
private _ret = _fireMissionText +"Rounds fired: " + (str (_rounds select 0)) + "/" + (str (_rounds select 1)) + "\nRequested by: " + (_unit call FUNC(FIREMIS_Dia_GetArtyCaller)Text);
_ret;
