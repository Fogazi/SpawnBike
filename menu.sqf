_pathtoscripts = "scripts\spawnbike\"; //edit this to wherever you place the script
_EXECscript = '["%1","%2"] execVM "'+_pathtoscripts+'deploy.sqf"';
_EXECscript1 = '["%1","%2",%3] execVM "'+_pathtoscripts+'deploy.sqf"';
_v1 = "1";
_v2 = "1";
_v3 = "1";
_v4 = "1";
_parts1 = ["PartEngine","PartGeneric"];
_parts2 = ["PartEngine","PartGeneric","PartGeneric","PartVRotor"];
_deployables =["Old_bike_TK_CIV_EP1","TT650_Civ","CSJ_GyroC"];
_thing = typeof cursorTarget;
if !(_thing in _deployables) then {_v4 = "0"};
if !("ItemToolbox" in weapons player) then {_v1 = "0";};
{if!(_x in magazines player) then {	_v2 ="0";};} count (_parts1);
{if!(_x in magazines player) then {	_v3 ="0";};} count (_parts2);

Deploy_Menu = 
[
	["Deploy",false],
	["Deploy Bike", [0], "", -5, [["expression", format[_EXECscript,"Bike","Old_bike_TK_CIV_EP1"]]], _v1, "1"],
	["Deploy Motorcycle", [0], "", -5, [["expression", format[_EXECscript1,"Motorbike","TT650_Civ",_parts1]]],_v2, "1"],
	["Deploy Mozzie", [0], "", -5, [["expression", format[_EXECscript1,"Mozzie","CSJ_GyroC",_parts2]]],_v3, "1"],
	["(separator)",[3],"",-1, [["expression", ""]],"1","1"],
	["Pack vehicle", [0], "", -5, [["expression", format[_EXECscript,"Pack",_thing]]],_v4, "1"]
];
showCommandingMenu "#USER:Deploy_Menu";
