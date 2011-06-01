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

// Includes Generales
//------------------------------------------------------
#include <a_samp>
#include <core>

#include <isamp/defines>

// Variables Globales/Defines
//------------------------------------------------------
new MYSQL_HOST[64];
new MYSQL_USER[64];
new MYSQL_PASS[64];
new MYSQL_DB[64];

// Prototipos de Funciones
//------------------------------------------------------
forward MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[]);
forward MySQLGetStr(sqltable[], sqlvalname[], sqldest[], condicion[]);
forward MySQLGetInt(sqltable[], sqlvalname[], condicion[]);
forward MySQLGetFlo(sqltable[], sqlvalname[], &Float:sqldest, condicion[]);
forward MySQLUpdateInt(sqltable[], sqlvalname[], sqlupdateint, condicion[]);
forward MySQLUpdateFlo(sqltable[], sqlvalname[], Float:sqlupdateflo, condicion[]);
forward MySQLUpdateStr(sqltable[], sqlvalname[], sqlupdatestr[], condicion[]);
forward MySQLInsertInt(sqltable[], sqlfield[], sqlvalue);
forward MySQLCountRows(table[], condicion[]);
forward MySQLCheckPlayer(playername[]);
forward MySQLRegisterPlayer(playername[], password[]);
forward MySQLGetPlayerID(playername[]);

// Funciones
//------------------------------------------------------
public MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[])
{
	print("MYSQL: Cargando Configuracion de la DB!");
	new arrCords[4][64];
	new strFromFile[256];
	new File: file = fopen("mysql.ini", io_read);
	if (file)
	{
		fread(file, strFromFile);
		splita(strFromFile, arrCords, ',');
		MYSQL_HOST=arrCords[0];
		MYSQL_USER=arrCords[1];
		MYSQL_PASS=arrCords[2];
		MYSQL_DB=arrCords[3];
		fclose(file);
	}
	else
	{
		print("MYSQL: Error cargando la configuracion.");
		return 0;
	}
	print("MYSQL: Conectando al servidor MySQL!");
	mysql_init(LOG_ONLY_ERRORS);
	mysql_connect(sqlhost, sqluser, sqlpass, sqldb);
	return 1;
}

public MySQLGetStr(sqltable[], sqlvalname[], sqldest[], condicion[])
{
	new query[256];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` %s", sqlvalname, sqltable, condicion);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_field(sqlvalname, sqldest);
	}
	mysql_free_result();
	return 0;
}

public MySQLGetInt(sqltable[], sqlvalname[], condicion[])
{
	new query[256];
	new field[15];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` %s", sqlvalname, sqltable, condicion);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_field(sqlvalname, field);
		mysql_free_result();
		return strval(field);
	}
	return 0;
}

public MySQLGetFlo(sqltable[], sqlvalname[], &Float:sqldest, condicion[])
{
	new query[256];
	new field[128];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` %s", sqlvalname, sqltable, condicion);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_field(sqlvalname, field); sqldest=floatstr(field);
	}
	mysql_free_result();
	return 0;
}

public MySQLUpdateInt(sqltable[], sqlvalname[], sqlupdateint, condicion[])
{
	new updval[256];
	format(updval, sizeof(updval), "UPDATE `%s` SET `%s`=%d %s", sqltable, sqlvalname, sqlupdateint, condicion);
	mysql_query(updval);
	return 1;
}

public MySQLUpdateFlo(sqltable[], sqlvalname[], Float:sqlupdateflo, condicion[])
{
	new updval[256];
	format(updval, sizeof(updval), "UPDATE `%s` SET `%s`=%f %s", sqltable, sqlvalname, sqlupdateflo, condicion);
	mysql_query(updval);
	return 1;
}

public MySQLUpdateStr(sqltable[], sqlvalname[], sqlupdatestr[], condicion[])
{
	new updval[256];
	format(updval, sizeof(updval), "UPDATE `%s` SET `%s`='%s' %s", sqltable, sqlvalname, sqlupdatestr, condicion);
	mysql_query(updval);
	return 1;
}

public MySQLInsertInt(sqltable[], sqlfield[], sqlvalue)
{
	new query[256];
	format(query, sizeof(query), "INSERT INTO `%s` (`%s`) VALUES (%d)", sqltable, sqlfield, sqlvalue);
	mysql_query(query);
	return 1;
}

public MySQLCheckPlayer(playername[])
{
	new query[256];
    format(query, sizeof(query), "SELECT `IDChar` FROM `%s` WHERE `Name` = '%s'", CHARINFOTABLE, playername);
    mysql_query(query);
    mysql_store_result();
    if(mysql_num_rows())
    {
        mysql_free_result();
		return 1;
	}
	mysql_free_result();
	return 0;
}

public MySQLCountRows(table[], condicion[])
{
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `%s` %s", table, condicion);
	mysql_query(query);
	mysql_store_result();
	return mysql_num_rows();
}

public MySQLRegisterPlayer(playername[], password[])
{
	new query[256];
	new IDChar = MySQLCountRows(CHARINFOTABLE, "") + 1;
	
	// Inicializamos los campos para el usuario IDChar
	MySQLInsertInt(CHARINFOTABLE, "IDChar", IDChar);
	MySQLInsertInt(CHARDATATABLE, "IDChar", IDChar);
	
	// Updateamos los Campos
	format(Condicion, sizeof(Condicion), "WHERE `IDChar`=%d",IDChar); 
	MySQLUpdateStr(CHARINFOTABLE, "Name", playername, Condicion);
	MySQLUpdateInt(CHARDATATABLE, "Skin", 26, Condicion);
	format(query, sizeof(query), "UPDATE `%s` SET `Key`=MD5('%s') %s", CHARINFOTABLE, password, Condicion);
	mysql_query(query);
	return 1;
}

public MySQLGetPlayerID(playername[])
{
	new condicion[128];
	format(condicion, sizeof(condicion), "WHERE `Name`='%s'", playername);
	return MySQLGetInt(CHARINFOTABLE, "IDChar", condicion);
}

stock splita(const strsrc[], strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i] == delimiter || i == strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return 1;
}

