private _loadout = getUnitLoadout player;
private _allItems = [];

for "_i" from 3 to 5 do
{
  _slotLoadout = _loadout select _i;
  if ( count _slotLoadout > 1  ) then
  {
    _allItems append (_slotLoadout select 1);
  }
};

private _allThrowables = [];

{
  _itemClassName = _x select 0;
  if ( _itemClassName call BIS_fnc_isThrowable) then
  {
    _picture = (getText (configFile >> 'CfgMagazines' >> _itemClassName >> 'picture'));
    _allThrowables append [[_itemClassName, _picture]];
  };
} forEach _allItems;


// Show wheel
_angularSeparation = 360 / count _allThrowables;
_currentAngle = 0;
_objectSize = 0.3;
_size = 0.3;
_animListCenterX = ( safeZoneX + ( safeZoneWAbs * 0.5)) - ( _objectSize * 0.5) ;
_animListyCenterY =  ( safeZoneY + (safeZoneH * 0.5)) - (_objectSize * 0.5);
_maxSize = _size / 4;
_displayData = [];
//_hud = uiNamespace getVariable "NFST_GSW";
_hud = findDisplay 46;
{
  // compute display shit
  _className = _x select 0;
	_imagePath = _x select 1;

	_posX = ((cos _currentAngle)*_size) + _animListCenterX;
	_posY = ((sin _currentAngle)*_size) + _animListyCenterY;

	_pos = [_posX,_posY];


	_control1PosX = _posX + ( _objectSize * 0.5);
	_control1PosY = _posY + ( _objectSize * 0.5);


	_centerPos = [_control1PosX,_control1PosY];

	_currentAngle = _currentAngle + _angularSeparation;

  _displayData append [[_className, _imagePath, _pos, _objectSize]]; //objectSize is constant
} forEach _allThrowables;


// display shit
{
  _imagePath = _x select 1;
  _pos = _x select 2;
  _objectSize = _x select 3;

  _type = "RscPictureKeepAspect";

  _ctrl = _hud ctrlCreate [_type, -1];
  _ctrl ctrlSetPosition [_pos select 0,_pos select 1,_objectSize,_objectSize];
  _ctrl ctrlSetTextColor [1, 1, 1, 0.6];
  _ctrl ctrlSetText _imagePath;
  _ctrl ctrlCommit 0;

  _x set [4, _ctrl];
} forEach _displayData;

uiNameSpace setVariable ["NFST_GSW_Items", _displayData];

// Display the cursor at center position
_width = 0.1;
_height = 0.1;
_centerX = ((safeZoneW - _width) / 2 + SafeZoneX);
_centerY = ((safeZoneH - _height) / 2 + SafeZoneY);
_imagePath = "\x\nfst_gsw\addons\main\data\optionWheelCursor.paa";

_ctrl = _hud ctrlCreate ["RscPictureKeepAspect", -1];
_ctrl ctrlSetPosition [_centerX,_centerY,_width,_height];
_ctrl ctrlSetTextColor [1, 1, 1, 0.6];
_ctrl ctrlSetText _imagePath;
_ctrl ctrlCommit 0;

uiNameSpace setVariable ["NFST_GSW_Cursor", _ctrl];

// Add on mouse moved event handler to update the cursor position
