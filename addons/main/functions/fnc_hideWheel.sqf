// Remove the on mouse move event handler
private _hud = uiNameSpace getVariable ["NFST_GSW_Display", []];
private _onMouseMove = uiNameSpace getVariable ["NFST_GSW_MouseEvent", []];
_hud displayRemoveEventHandler ["MouseMoving", _onMouseMove];


// Get last cursor position


// Get selected grenade, if any
private _selected = uiNameSpace getVariable ["NFST_GSW_Selection", []];
systemChat str _selected select 0;

// Hide the cursor
private _cursor = uiNameSpace getVariable ["NFST_GSW_Cursor", []];
ctrlDelete _cursor;

// Hide the wheel
private _displayData = uiNameSpace getVariable ["NFST_GSW_Items", []];

{
  ctrlDelete (_x select 4);
} forEach _displayData;

// Set active grenade https://github.com/acemod/ACE3/blob/master/addons/weaponselect/functions/fnc_selectNextGrenade.sqf
