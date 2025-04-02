{
   e3p1nuevo.pas
   
   Copyright 2025 Usuario <Usuario@DESKTOP-U6ORN85>
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.
   
   
}


program ej3p1nuevo;
type
	empleados= record
		nro: integer;
		apellido: string;
		nombre: string;
		edad: integer;
		dni: integer;
		end;
	archE = file of Empleados;
procedure leerE (var e: empleados);
begin
	with e do begin
		writeln('leer apellido del empleado');
		readln(apellido);
		if (apellido <> 'fin') then begin	
			writeln('leer nombre del empleado');
			readln(nombre);
			writeln('leer nro del empleado');
			readln(nro);
			writeln('leer edad del empleado');
			readln(edad);
			writeln('leer dni del empleado');
			readln(dni);
		end;
	end;
end;

procedure imprimirRegistro (e: empleados);
begin
	with e do begin
	writeln('Nombre: ',nombre);
	writeln('Apellido: ', apellido );
	writeln('Nro: ', nro);
	writeln('Edad: ',edad);
	writeln('Dni: ', dni);
end;
end;	
procedure incisoB(var a: archE);
var e: empleados;
x: string;
begin
	Writeln('leer nombre o apellido');
	readln(x);
	reset (a);
	while not eof(a) do begin
		read(a, e);
		if (e.apellido = x) or (e.nombre = x) then begin
			seek (a, filepos(a)-1);
			imprimirRegistro(e);
		end;
	end;
end;
	
procedure incisoB3(var a: archE);
var e: empleados;
begin
	reset (a);
	while not eof(a) do begin
		read(a, e);
		if (e.edad >70) then begin
			seek (a, filepos(a)-1);
			imprimirRegistro(e);
		end;
	end;
end;	
procedure incisoB2(var a: archE);
var e: empleados;
begin
	reset (a);
	while not eof(a) do begin
		read(a, e);
		seek (a, filepos(a)-1);
		imprimirRegistro(e);
		end;
	end;

procedure verInciso (var a: archE);
var 
	op: integer;
begin
	writeln('marque 1:listarDatosDeEmpleadoX, 2 listarTodos, 3: listar > 70 años');
	read(op);
	case op of 
		1: incisoB(a);
		2: incisoB2(a);
		3: incisoB3(a);
	end;
end;
VAR
	archLog: archE;
	archFis: String;
	e: empleados;
	op: integer;
	
BEGIN
	writeln('leer nombre arch');
	readln(archFis);
	assign(archLog, archFis);
	writeln('op1: crear: op2: abrir');
	read(op);
	case op of
	1 : begin
		rewrite (archLog);
		leerE(e);
		while (e.apellido <> 'fin') do begin
			Write (archLog, e);
			leerE(e);
	end;
	end;
	2: verInciso(archLog);
	end;
	close (archLog);
END.

