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
procedure imprimirDatos (e: registro);
begin
	writeln(e.nombre);
	writeln(e.descripcion);
	writeln(e.marca);//completarDatos
end;
procedure IncisoB(var a: tienda);
var e: registro;
begin
	Reset(a);
	while not eof(a) do begin
		Read(a, e);
		if (e.stockdisp < e.stockmin) then
			imprimirDatos(e)
	end;
end;
{procedure IncisoC (var a: tienda);
var
  e: registro;
begin
	Reset(a);
	while not eof(a) do begin
		Read(a, e);
		if (e.descipcion = a.descripcion)
		* writeln ();
end;}
procedure ModificarStock(var t: tienda; codCel: integer);
var 
	e: registro; nm: real;
begin
	Reset(t);
	read(t, e);
	while not eof(t) and (codCel <> e.codCel) do  
		Read(t, e);
	if (codCel = e.codCel) then begin
		seek (t, filepos(t)-1);
		writeln('leer nuevo monto'); read(nm);
		e.precio:= nm;
		Write(t, e)
	end;
	close(t);
		
end;
procedure Agregar (var t: tienda); // pregunt<<r 
var 
  celu: registro;
begin
	Reset(t);
	leerR(celu);
	seek(t, filesize(t));
	while (celu.nombre <> '.') do begin
		Write(t, celu);
		leerR(celu)
	end;
	close(t);
end;
procedure ExportarC (var a: tienda; var at: text);
var
	r: registro;
begin
	reset(a);
	reset(at);
	while not eof(a) do begin
		read(a, r);
		if (r.stockdisp = 0) then begin
			//seek(a, filepos(a)-1); //vuelvo al ant
			write(at, r.nombre, r.marca, r.precio);
			end;
		end;
		close(a);
		close (at);
end;
var 
	archF: string;
	tiendaCelu:tienda;
	archT, sinStock: text;
	r: registro;
	celularX, op: integer;
	
BEGIN
	writeln('leer nombre del archivo');
	Read(archF);
	assign(tiendaCelu, archF);
	assign(archT, 'celulares.txt');
	rewrite(archT);
	assign(sinStock, 'sinStock.txt'); //esta bien aca o en el modulo?
	rewrite(sinStock);
	rewrite(tiendaCelu);
	Writeln ('bienvenido al menu');
	writeln('ingrese 1 para crear el archivo');
	writeln('ingrese 2 para listar los datos de celulares con stock menor al min');
	writeln('ingrese 3 para listar en pantalla los celulates con cadena x');
	writeln('ingrese 4 exportar a txt');
	read(op);
	case op of
	1 : begin
		leerR(r);
		while (r.codCel <> 0) do begin
			write(tiendaCelu, r);
			write (archT, r.codCel, r.precio, r.marca);
			write(archT, r.stockdisp, r.stockmin, r.descripcion);
			write(archT, r.nombre);
			leerR(r);
		end;
	end;
	2: incisoB(tiendaCelu);
	end;
	close(tiendaCelu);
	
	IncisoB(tiendaCelu);
	//falta inciso C preguntar
	Agregar(tiendaCelu); //inciso 6A
	writeln('leer celular X');
	read(celularX);
	ModificarStock(tiendaCelu, celularX);
	ExportarC(tiendaCelu, sinStock)
END.

