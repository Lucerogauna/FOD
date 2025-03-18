{ 5. Realizar un programa para una tienda de celulares, que presente un menú con
 opciones para:
 a. Crear un archivo de registros no ordenados de celulares y cargarlo con datos
 ingresados desde un archivo de texto denominado “celulares.txt”. Los registros
 correspondientes a los celulares deben contener: código de celular, nombre,
 descripción, marca, precio, stock mínimo y stock disponible.
 b. Listar en pantalla los datos de aquellos celulares que tengan un stock menor al
 stock mínimo.
 c. Listar en pantalla los celulares del archivo cuya descripción contenga una
 cadena decaracteres proporcionada por el usuario.
 d. Exportar el archivo creado en el inciso a) a un archivo de texto denominado
 “celulares.txt” con todos los celulares del mismo. El archivo de texto generado
 podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que
 debería respetar el formato dado para este tipo de archivos en la NOTA 2.
 NOTA 1: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.
 NOTA 2: El archivo de carga debe editarse de manera que cada celular se especifique en
 tres líneas consecutivas. En la primera se especifica: código de celular, el precio y
 marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera
 nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo
 “celulares.txt”.
   
   preguntar inciso C como hago para recorrer la descripcion
}


program ej5p1;
type
	registro = record
		codCel: integer;
		nombre: string;
		descripcion: string;
		marca: string;
		precio: real;
		stockmin: integer;
		stockdisp: integer;
	end;
	lista =^nodo;
	nodo = record
		dato: registro;
		sig: lista;
		end;
	lista2 =^nodo2;
	nodo2 = record
		cel: string;
		sig: lista2;
		end;
	tienda = file of registro;
procedure leerR(var celu: registro);
begin
	with celu do begin
		writeln('leer cod '); readln(codCel);
		if codCel<> 0 then begin
			writeln('leer nombre '); readln(nombre);
			writeln('leer  descripcion'); readln(descripcion);
			writeln('leer marca '); readln(marca);
			writeln('leer  precio'); readln(precio);
			writeln('leer stock min '); readln(stockmin);
			writeln('leer  stock disp'); readln(stockdisp);
		end;
	end;
end;
procedure agregarL(r: registro; var l: lista);
var 
	nue: lista;
begin
	new (nue);
	nue^.dato:= r;
	nue^.sig:= l;
	l:= nue;
end;
procedure IncisoB(var a: tienda; var l: lista);
var e: registro;
begin
	Reset(a);
	while not eof(a) do begin
		Read(a, e);
		if (e.stockdisp < e.stockmin) then
			agregarL(e, l);
	end;
end;
var 
	archF: string;
	tiendaCelu:tienda;
	r: registro;
	l: lista;
BEGIN
	l:= nil;
	writeln('leer nombre del archivo');
	Read(archF);
	assign(tiendaCelu, archF);
	rewrite(tiendaCelu);
	leerR(r);
	while (r.codCel<> 0 ) do begin
		Write(tiendaCelu, r);
		leerR(r);
	end;
	close(tiendaCelu);
	
	IncisoB(tiendaCelu, l)
END.

