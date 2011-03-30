//------------------------------------------------------

/*
	Database Handler Script Imperium SA-MP
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
// Encargados del Script: Nevermore, Froda, Rodam, Razzo
//------------------------------------------------------

// Variables Globales/Defines
//------------------------------------------------------
new MYSQL_HOST[64];
new MYSQL_USER[64];
new MYSQL_PASS[64];
new MYSQL_DB[64];

// Prototipos de Funciones
//------------------------------------------------------
forward MySQLConnect(sqlhost[], sqluser[], sqlpass[], sqldb[]);
forward MySQLGetStr(sqlid, sqltable[], sqlvalname[], sqldest[]);
forward MySQLGetInt(sqlid, sqltable[], sqlvalname[]);
forward MySQLGetFlo(sqlid, sqltable[], sqlvalname[], &Float:sqldest);

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

public MySQLGetStr(sqlid, sqltable[], sqlvalname[], sqldest[])
{
	new query[256];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` WHERE `id` = %d", sqlvalname, sqltable, sqlid);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_field(sqlvalname, sqldest);
	}
	mysql_free_result();
	return 0;
}

public MySQLGetInt(sqlid, sqltable[], sqlvalname[])
{
	new query[256];
	new field[15];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` WHERE `id` = %d", sqlvalname, sqltable, sqlid);
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

public MySQLGetFlo(sqlid, sqltable[], sqlvalname[], &Float:sqldest)
{
	new query[256];
	new field[128];
	format(query, sizeof(query), "SELECT `%s` FROM `%s` WHERE `id` = %d", sqlvalname, sqltable, sqlid);
	mysql_query(query);
	mysql_store_result();
	if(mysql_num_rows())
	{
		mysql_fetch_field(sqlvalname, field); sqldest=floatstr(field);
	}
	mysql_free_result();
	return 0;
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
