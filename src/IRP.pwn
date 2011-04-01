//------------------------------------------------------

/*
	GameMode Oficial Imperium SA-MP
    Copyright (C) 2011  Imperium Games

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//------------------------------------------------------
// Encargados del Script: Nevermore, Froda, Rodam, Razzo?
//------------------------------------------------------

// Includes Generales
//------------------------------------------------------
#include <a_samp>
#include <mysql>
#include <streamer>
#include <core>
#include <float>

#include <isamp/database>
#include <isamp/functions>

#pragma tabsize 0

// Arrays
//------------------------------------------------------


// Variables Globales/Defines
//------------------------------------------------------
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1
#define COLOR_ASKQ 0xFF0000FF
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFFF
#define COLOR_GREEN 0x9EC73DFF
#define COLOR_RED 0xAA3333FF
#define COLOR_LIGHTRED 0xFF6347FF
#define COLOR_LIGHTBLUE 0x33CCFFFF
#define COLOR_LIGHTGREEN 0x9ACD32FF
#define COLOR_YELLOW 0xDABB3EFF
#define COLOR_YELLOW2 0xF5DEB3FF
#define COLOR_WHITE 0xFFFFFFFF
#define COLOR_FADE1 0xE6E6E6FF
#define COLOR_FADE2 0xC8C8C8FF
#define COLOR_FADE3 0xAAAAAAFF
#define COLOR_FADE4 0x8C8C8CFF
#define COLOR_FADE5 0x6E6E6EFF
#define COLOR_PURPLE 0xC2A2DAFF

// Prototipos de Funciones
//------------------------------------------------------


// Funciones
//------------------------------------------------------
main()
{
	print("---------------------------------------");
	print("Imperium SA-MP Roleplay");
	print("---------------------------------------");
}

// Callbacks
//------------------------------------------------------

	// OnGameModeInit
	//------------------------------------------------------
	public OnGameModeInit()
	{
		MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
		SetGameModeText("RolePlay Espanol");
		SendRconCommand("mapname Malos Aires");
		SendRconCommand("weburl www.imperiumgames.com.ar");
		ShowNameTags(0);
		ShowPlayerMarkers(0);
		EnableStuntBonusForAll(0);
		DisableInteriorEnterExits();
		return 1;
	}

	// OnPlayerConnect
	//------------------------------------------------------
	public OnPlayerConnect(playerid)
	{
		new string[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	    if(IsPlayerNPC(playerid)) return 1;
	    SetPlayerColor(playerid,COLOR_GRAD2);
		format(string, sizeof(string), "Servidor: {AFAFAF}%s [%d] ha entrado a Imperium SA-MP RolePlay.", PlayerName, playerid);
		SendClientMessageToAll(COLOR_WHITE, string);
		if(MySQLCheckPlayer(PlayerName))
		{
			format(string, sizeof(string), "Servidor: {AFAFAF}Usa \"/conectar [contraseña]\" para conectarte al servidor.", PlayerName, playerid);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		else
		{
			format(string, sizeof(string), "Servidor: {AFAFAF}Usa \"/registrar [contraseña]\" para registrarte en el servidor.", PlayerName, playerid);
			SendClientMessage(playerid, COLOR_WHITE, string);
		}
		return 1;
	}

	// OnPlayerSpawn
	//------------------------------------------------------
	public OnPlayerSpawn(playerid)
	{
		if(IsPlayerNPC(playerid)) return 1;

		// Spawn en la Casa de Gobierno
		SetPlayerColor(playerid, COLOR_WHITE);
		SetPlayerInterior(playerid, 0);
		SetPlayerVirtualWorld(playerid, 0);
		SetPlayerPos(playerid, 1486.4741, -1758.3142, 17.5313);
		return 1;
	}

	// OnPlayerRequestClass
	//------------------------------------------------------
	public OnPlayerRequestClass(playerid, classid)
	{
		if(IsPlayerNPC(playerid)) return 1;
		
		SpawnPlayer(playerid);

		return 0;
	}
	
	// OnPlayerText
	//------------------------------------------------------
	public OnPlayerText(playerid, text[])
	{
		new string[256];
		new PlayerName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
		format(string, sizeof(string), "%s dice: %s", PlayerName, text);
		ProxDetector(20.0, playerid, string, COLOR_FADE1, COLOR_FADE2, COLOR_FADE3, COLOR_FADE4, COLOR_FADE5);
		return 0;
	}
	
// DCMD
//------------------------------------------------------

// Registrarse
dcmd_registrar(playerid, params[])
{
	new idx;
	new string[256];
	new PlayerName[MAX_PLAYER_NAME];
	new Password[256];
	GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
	if(MySQLCheckPlayer(PlayerName))
	{
		format(string, sizeof(string), "Servidor: {AFAFAF}Este nombre ya está Registrado. Use /conectar para ingresar al servidor.", PlayerName, playerid);
		SendClientMessage(playerid, COLOR_WHITE, string);
		return 1;
	}
	Password = strtok(params, idx);
	MySQLRegisterPlayer(PlayerName, Password);
	format(string, sizeof(string), "Servidor: {AFAFAF}¡Gracias por registrarse en Imperium SA-MP Roleplay!", PlayerName, playerid);
	SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

// OnPlayerCommandText
//------------------------------------------------------
public OnPlayerCommandText(playerid, cmdtext[])
{
    dcmd(registrar, 9, cmdtext);
    return 0;
}

