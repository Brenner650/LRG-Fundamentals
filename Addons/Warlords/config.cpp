#include "script_component.hpp"

class CfgPatches
{
	class LRG_Warlords
	{
		author = AUTHOR;
		name = NAME;
		url = URL;
		units[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"A3_UI_F","cba_main","cba_xeh"};
		version = VERSION;
		authors[] = {"MitchJC"};
		weapons[] = {};
	};
};

class CfgWLRequisitionPresets
{
	#include "RHS_Presets.hpp"
};