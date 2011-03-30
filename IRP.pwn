//------------------------------------------------------

/*
	GameMode Oficial Imperium SA-MP
    Copyright (C) 2011  Rodrigo Troncoso

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
#include <database>

#pragma tabsize 0

// Arrays
//------------------------------------------------------


// Variables Globales/Defines
//------------------------------------------------------


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
public OnGameModeInit()
{
	MySQLConnect(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_DB);
	return 0;
}
