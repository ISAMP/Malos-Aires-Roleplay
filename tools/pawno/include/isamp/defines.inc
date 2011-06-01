//------------------------------------------------------

/*
	Este archivo es parte del Proyecto Malos Aires 2.0
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
// Encargados del Script: Nevermore, Froda, Rodam, Razzo
//------------------------------------------------------

// Variables
//------------------------------------------------------
// TextDraws
new Text:gBanner;

// Defines
//------------------------------------------------------

// DCMD
#define dcmd(%1,%2,%3) if ((strcmp((%3)[1], #%1, true, (%2)) == 0) && ((((%3)[(%2) + 1] == 0) && (dcmd_%1(playerid, "")))||(((%3)[(%2) + 1] == 32) && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1

// Colores
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

// Tablas
#define CHARINFOTABLE "rp_charinfo"
#define CHARDATATABLE "rp_chardata"

// Diálogos
#define DIALOG_LOGIN 1
#define DIALOG_REGISTER 2
#define DIALOG_MAIL 3

// Variables Globales
new Condicion[128];
