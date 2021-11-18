#include "script_component.hpp"

class CfgPatches
{
  class ADDON
  {
    // Meta information for editor
    name   = COMPONENT_NAME;
    author = "Kerpollo";
    //url    = ECSTRING(main, URL);

    // Requirements data
    requiredVersion  = 1.98;
    requiredAddons[] = { "CBA_main" };

    // List of added objects and weapons
    units[]   = {};
    weapons[] = {};
  };
};

#include "CfgEventhandlers.hpp"

class RscTitles
{
	class NFST
	{
		idd = -1;
		duration = 99999;
		onLoad = "uiNamespace setVariable ['NFST_GSW', _this select 0]";
		class controls
		{
			class mouseCursor
			{
				idc = 9275;
				x = "( safeZoneX + ( safeZoneWAbs / 2 )) - ( 0.15 / 2 )";
				y = "( safeZoneY + (safeZoneH / 2)) - (0.15 / 2)";
				w = 0.15;
				h = 0.15;
				colorBackground[] = {0,0,0,1};
				font = "EtelkaNarrowMediumPro";
				colorText[] = {1,1,1,1};
				sizeEx = "safezoneW / 40";
				type = 0;
				style = "2048 + 48";
				text = "\x\nfst_gsw\addons\main\data\optionWheelCursor.paa";
			};
		};
	};
};

/*
class CfgFunctions
{
	class NFST
	{
		class All
		{
			file = "main\functions";
      class postInit
      {
        postInit = 1;
      };

			class setWheel{};
			class setWheelCursor{};
			class setWheelKey{};
			class removeWheel{};

		};
	};
};
*/
