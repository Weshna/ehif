/*
	File: fn_revived.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	THANK YOU JESUS I WAS SAVED!
*/
private["_medic","_dir"];
_medic = [_this,0,"Unknown Medic",[""]] call BIS_fnc_param;
_oldGear = [life_corpse] call life_fnc_fetchDeadGear;
[_oldGear] spawn life_fnc_loadDeadGear;
life_corpse setVariable["realname",nil,true]; //Should correct the double name sinking into the ground.
[[life_corpse],"life_fnc_corpse",nil,FALSE] spawn life_fnc_MP;
_dir = getDir life_corpse;
hint format[localize "STR_Medic_RevivePay",_medic,[(call life_revive_fee)] call life_fnc_numberText];

closeDialog 0;
life_deathCamera cameraEffect ["TERMINATE","BACK"];
camDestroy life_deathCamera;

//Take fee for services.
if(life_atmcash > (call life_revive_fee)) then {
	life_atmcash = life_atmcash - (call life_revive_fee);
} else {
	life_atmcash = 0;
};


//Bring me back to life.
player setDir _dir;
player setPosASL (visiblePositionASL life_corpse);
life_corpse setVariable["Revive",nil,TRUE];
life_corpse setVariable["name",nil,TRUE];
[[life_corpse],"life_fnc_corpse",true,false] spawn life_fnc_MP;
hideBody life_corpse;

player setVariable["Revive",nil,TRUE];
player setVariable["name",nil,TRUE];
player setVariable["Reviving",nil,TRUE];
[] call life_fnc_hudUpdate; //Request update of hud.

//I did not die, so give me my license back (implementation prevents gaining from dc'ing while dead) -GT-
if (life_removedReb) then {
	license_civ_rebel = true;
	life_removedReb = false;
};

// U f*** uniform will you finally paint yourself??
[] spawn
{
	sleep 3;
	if (uniform player in ["U_Rangemaster","U_B_CombatUniform_mcam","U_C_Poloshirt_redwhite","U_BG_Guerilla2_3"]) then{
		[] spawn life_fnc_uniSet;
	};
};
