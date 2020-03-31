
if (isNil "LRG_Main_AISRevive") exitwith {};
if (not LRG_Main_AISRevive) exitWith{};

diag_log format ["############## %1 ############## - AIS init started", missionName];

if (isServer) then {
	ais_mobile_medic_stations  = [];
	publicVariable "ais_mobile_medic_stations";
};

if !(isClass (configFile >> "CfgPatches" >> "ace_main")) then {

    removeAllMissionEventHandlers "Draw3D";
    removeAllMissionEventHandlers "EachFrame";

    call AIS_Core_fnc_initEvents;
    AIS_Core_Interaction_Actions = [];

};
