// Currency settings
// Author: StatusRed
// This module brings support for currency / money to the framework, it's up to you, as the mission maker how you use this.
//
// Functions at your disposal:
// [<unit:Object>, <amount:Number>] call EFUNC(CURRENCY,setCurrency); // Set a unit's current currency
// [<unit:Object>, <amount:Number>] call EFUNC(CURRENCY,addCurrency); // Add to a unit's current currency
// [<unit:Object>, <amount:Number>] call EFUNC(CURRENCY,deductCurrency); // Deduct from a unit's current currency
// [<unit:Object>] call EFUNC(CURRENCY,getCurrency); // Get a unit's current currency
// [<unit:Object>, <showSymbol:Boolean>, <showShortName:Boolean>, <showFullname:Boolean>] call EFUNC(CURRENCY,getCurrencyText); // Get a unit's current currency (formatted text with symbol etc..)
//
// -----------------------------
// Settings explained:
// Name - Full name for the currency
// Short_Name - Short name for the currency, GBP, USD, CAD, AUD etc..
// Symbol - Symbol used, £, $ etc..
// -----------------------------

GVAR(Name) = "Great British Pounds";
GVAR(Short_Name) = "GBP";
GVAR(Symbol) = "£";
