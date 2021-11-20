// Get player's items
private _loadout  = getUnitLoadout player;
private _allItems = [];
for "_i" from 3 to 5 do
{
  _slotLoadout = _loadout select _i;
  if ( count _slotLoadout > 1  ) then
  {
    _allItems append (_slotLoadout select 1);
  }
};


// Get player's throwables
private _allThrowables = [];
{
  _itemClassName = _x select 0;
  if ( _itemClassName call BIS_fnc_isThrowable) then
  {
    _picture = (getText (configFile >> 'CfgMagazines' >> _itemClassName >> 'picture'));
    _allThrowables append [[_itemClassName, _picture]];
  };
} forEach _allItems;
_allThrowables sort true;


// Compute wheel display data
_deltaAngle   = 360 / count _allThrowables;
_currentAngle = 0;
_imageSize    = 0.2;
_size         = 0.6;
_aspectRatio  = 0.75;
_displayData  = [];
{
  _className = _x select 0;
	_imagePath = _x select 1;

	_posX = 0.5 - 0.5 * _imageSize + ((cos _currentAngle)*_size) * _aspectRatio;
	_posY = 0.5 - 0.5 * _imageSize + ((sin _currentAngle)*_size);

  _displayData append [[_className, _imagePath, [_posX, _posY]]];

  _currentAngle = _currentAngle + _deltaAngle;
} forEach _allThrowables;


// Display the wheel items
_display = findDisplay 46;
{
  _imagePath = _x select 1;
  _imagePos  = _x select 2;

  _image = _display ctrlCreate ["RscPictureKeepAspect", -1];
  _image ctrlSetPosition [_imagePos select 0, _imagePos select 1, _imageSize, _imageSize];
  _image ctrlSetTextColor [1, 1, 1, 0.5];
  _image ctrlSetBackgroundColor [0, 1, 0, 1];
  _image ctrlSetText _imagePath;
  _image ctrlCommit 0;

  _x set [3, _image];
} forEach _displayData;


// Display the cursor at center position
_cursorRadius = 0.1;
_cursorCenter = 0.5 - _cursorRadius * 0.5;
_imagePath = "\x\nfst_gsw\addons\main\data\selector.paa";

_cursor = _display ctrlCreate ["RscPictureKeepAspect", -1];
_cursor ctrlSetPosition [_cursorCenter, _cursorCenter, _cursorRadius, _cursorRadius];
_cursor ctrlSetTextColor [1, 1, 1, 0.6];
_cursor ctrlSetText _imagePath;
_cursor ctrlCommit 0;


// Share required data
uiNameSpace setVariable ["NFST_GSW_Display"   , _display];
uiNameSpace setVariable ["NFST_GSW_Items"     , _displayData];
uiNameSpace setVariable ["NFST_GSW_Cursor"    , [_cursor, _cursorCenter, _cursorRadius]];


// Add on mouse moved event handler to update the cursor position
_onMouseMove = _display displayAddEventHandler
[
  "MouseMoving",
  {
    params ["_control", "_xPos", "_yPos"];
    _pos = [_xPos, _yPos];

    _itemsData  = uiNameSpace getVariable ["NFST_GSW_Items" , []];
    _cursorData = uiNameSpace getVariable ["NFST_GSW_Cursor", []];
    _cursorCtrl   = _cursorData select 0;
    _cursorZeroed = _cursorData select 1;
    _cursorRadius = _cursorData select 2;

    // Get old cursor position
    _oldPos = ctrlPosition _cursorCtrl;
    _oldX = (_oldPos select 0) - _cursorRadius * 0.5;
    _oldY = (_oldPos select 1) - _cursorRadius * 0.5;


    // Update cursor position
    _sensitivity = 5;
    _cursorCtrl ctrlSetPositionX (_xPos * _sensitivity + _cursorZeroed);
    _cursorCtrl ctrlSetPositionY (_yPos * _sensitivity + _cursorZeroed);
    _cursorCtrl ctrlCommit 2;

    // See if cursor is near an image, and select if close enough
    _selectedControl   = controlNull;
    _selectionDistance = 0.2;
    {
      _className = _x select 0;
      _imagePath = _x select 1;
      _imagePos  = _x select 2;
      _imageCtrl = _x select 3;

      _imageCtrl ctrlSetTextColor [1, 1, 1, 0.5];

      _dx = _oldX - (_imagePos select 0);
      _dy = _oldY - (_imagePos select 1);

      _distance = sqrt (_dx * _dx + _dy * _dy);

      if (_distance < _selectionDistance) then
      {
        _selectionDistance = _distance ;
        _selectedControl   = _imageCtrl;
        uiNameSpace setVariable ["NFST_GSW_Selection", [_className, _imagePath]];
      };
    } forEach _itemsData;

    _selectedControl ctrlSetTextColor [1, 1, 1, 1];
  }
];

uiNameSpace setVariable ["NFST_GSW_MouseEvent", [_onMouseMove]];
