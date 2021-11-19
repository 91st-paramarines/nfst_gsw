// Remove the on mouse move event handler
private _hud = uiNameSpace getVariable ["NFST_GSW_Display", []];
private _onMouseMove = uiNameSpace getVariable ["NFST_GSW_MouseEvent", []];
_hud displayRemoveEventHandler ["MouseMoving", _onMouseMove select 0];

// Get selected grenade, if any
private _selected = uiNameSpace getVariable ["NFST_GSW_Selection", []];
private _selectedGrenade = _selected select 0;
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
private _uniformGrenades  = uniformItems  player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};
private _vestGrenades     = vestItems     player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};
private _backpackGrenades = backpackItems player select {_x call BIS_fnc_isThrowable && _x != _selectedGrenade};

// Remove all grenades of type != className
{player removeItemFromUniform  _x; false} count _uniformGrenades;
{player removeItemFromVest     _x; false} count _vestGrenades;
{player removeItemFromBackpack _x; false} count _backpackGrenades;

// Replace all removed grenades
{player addItemToUniform  _x; false} count _uniformGrenades;
{player addItemToVest     _x; false} count _vestGrenades;
{player addItemToBackpack _x; false} count _backpackGrenades;
