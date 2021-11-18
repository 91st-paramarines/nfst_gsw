// Remove the on mouse move event handler
// Get last cursor position
// Get selected grenade, if any

// Hide the cursor
private _cursor = uiNameSpace getVariable ["NFST_GSW_Cursor", []];
ctrlDelete _cursor;

// Hide the wheel
private _displayData = uiNameSpace getVariable ["NFST_GSW_Items", []];

{
  ctrlDelete (_x select 4);
} forEach _displayData;

// Set active grenade https://github.com/acemod/ACE3/blob/master/addons/weaponselect/functions/fnc_selectNextGrenade.sqf
