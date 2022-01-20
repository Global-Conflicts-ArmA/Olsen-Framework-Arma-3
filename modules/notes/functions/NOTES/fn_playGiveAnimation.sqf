#include "script_component.hpp"

if (vehicle player != player) exitWith {};
private _animation = switch (currentWeapon player) do {
    case (""): {
        switch (stance player) do {
            case ("STAND"): {"AmovPercMstpSnonWnonDnon_AinvPercMstpSnonWnonDnon_Putdown"};
            case ("CROUCH"): {"AmovPknlMstpSnonWnonDnon_AinvPknlMstpSnonWnonDnon_Putdown"};
            case ("PRONE"): {"AmovPpneMstpSnonWnonDnon_AinvPpneMstpSnonWnonDnon_Putdown"};
            default {""};
        };
    };

    case (primaryWeapon player): {
        switch (stance player) do {
            case ("STAND"): {"AmovPercMstpSrasWrflDnon_AinvPercMstpSrasWrflDnon_Putdown"};
            case ("CROUCH"): {"AmovPknlMstpSrasWrflDnon_AinvPknlMstpSrasWrflDnon_Putdown"};
            case ("PRONE"): {"AmovPpneMstpSrasWrflDnon_AinvPpneMstpSrasWrflDnon_Putdown"};
            default {""};
        };
    };

    case (handgunWeapon player): {
        switch (stance player) do {
            case ("STAND"): {"AmovPercMstpSrasWpstDnon_AinvPercMstpSrasWpstDnon_Putdown"};
            case ("CROUCH"): {"AmovPknlMstpSrasWpstDnon_AinvPknlMstpSrasWpstDnon_Putdown"};
            case ("PRONE"): {"AmovPpneMstpSrasWpstDnon_AinvPpneMstpSrasWpstDnon_Putdown"};
            default {""};
        };
    };

    case (secondaryWeapon player): {
        switch (stance player) do {
            case ("STAND"): {"AmovPercMstpSrasWlnrDnon_AinvPercMstpSrasWlnrDnon_Putdown"};
            case ("CROUCH"): {"AmovPknlMstpSrasWlnrDnon_AinvPknlMstpSrasWlnrDnon_Putdown"};
            case ("PRONE"): {""};
            default {""};
        };
    };

    case (binocular player): {
        switch (stance player) do {
            case ("STAND"): {"AmovPercMstpSoptWbinDnon_AinvPercMstpSoptWbinDnon_Putdown"};
            case ("CROUCH"): {""};
            case ("PRONE"): {""};
            default {""};
        };
    };

    default {""};
};

player playMove _animation;
