{ 3. Realizar un programa que presente un menú con opciones para:
 a. Crear un archivo de registros no ordenados de empleados y completarlo con
 datos ingresados desde teclado. De cada empleado se registra: número de
 empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con
 DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
 b. Abrir el archivo anteriormente generado y
 i.
 ii.
 iii.
 Listar en pantalla los datos de empleados que tengan un nombre o apellido
 determinado, el cual se proporciona desde el teclado.
 Listar en pantalla los empleados de a uno por línea.
 Listar en pantalla los empleados mayores de 70 años, próximos a jubilarse.
 NOTA: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.
   
   
}


program ej3p1;
type 
	empleado = record
		nro: integer;
		apellido: string[20];
		nombre: string[20];
		edad: integer;
		dni: integer;
	end;
	lista= ^nodo;
	nodo= record
		dato: empleado;
		sig: lista;
	end;
	archivoDeEmpleados= file of empleado;
procedure imprimirRegistro (e: empleado);
begin
	with e do begin
	writeln('Nombre: ',nombre);
	writeln('Apellido: ', apellido );
	writeln('Nro: ', nro);
	writeln('Edad: ',edad);
	writeln('Dni: ', dni);
end;
end;
procedure imprimirArchivo(var a: archivoDeEmpleados);
var 
	e: empleado;
begin
	Reset(a);
	while not eof (a) do begin
		Read(a, e); //lee el reg del archivo
		imprimirRegistro(e);// imprime
	end;
	close(a);
end;
procedure cargarL (var l: lista; e: empleado);
var
	nue: lista;
begin
	new(nue);
	nue^.dato:=e;
	nue^.sig:= l;
	l:= nue; 
end;
procedure imprimirLista(l: lista);
begin
	while (l<> nil) do begin
		imprimirRegistro(l^.dato);
		l:= l^.sig;
	end;
end;
procedure buscar(x: string; var a: archivoDeEmpleados; var l: lista);
var 
	e: empleado;
begin
	Reset(a);
	while not eof(a) do begin
		Read(a, e);
		if ((e.nombre = x) or (e.apellido = x)) then
			cargarL(l, e);
	end;
	close(a);
	writeln('imprimirLista');
	imprimirLista(l);
end;

procedure leerE (var e: empleado);
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
var
	arch_name: string[30]; //archivo Fisico
	arch_log: archivoDeEmpleados;
	e: empleado;
	l: lista;
	nombreoapellido: string;
BEGIN	
	l:= nil;
	writeln('leer nombre del archivo');
	readln(arch_name);
	assign(arch_log, arch_name);
	rewrite(arch_log); //creacion del archivo, puntero en pos 0
	leerE(e);
	while (e.apellido <> 'fin') do begin
		write(arch_log, e);
		leerE(e);
	end;
	close(arch_log);
	writeln('leer un nombre o apellido');
	readln(nombreoapellido);
	buscar(nombreoapellido, arch_log, l); //inciso i
	writeln('/////////////////////');
	writeln('ARCHIVO COMPLETO');
	imprimirArchivo(arch_log); //inciso ii
END.

