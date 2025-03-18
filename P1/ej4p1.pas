{ 4. Agregar al menú del programa del ejercicio 3, opciones para:
 a. Añadir uno o más empleados al final del archivo con sus datos ingresados por
 teclado. Tener en cuenta que no se debe agregar al archivo un empleado con
 un número de empleado ya registrado (control de unicidad).
 b. Modificar la edad de un empleado dado.
 c. Exportar el contenido del archivo a un archivo de texto llamado
 “todos_empleados.txt”.
 d. Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados
 que no tengan cargado el DNI (DNI en 00).
 NOTA: Las búsquedas deben realizarse por número de empleado
   
   PREGUNTAR PROCEDIMIENTO LEO EMPLEADOS
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
procedure agregoEmpleado(var a: archivoDeEmpleados); //ESTO ESTA MAL 
var 
	e, e2: empleado;
	sigo: boolean;
begin
	writeln('leer un nuevo empleado');
	leerE(e2);
	sigo:= true;
	while (not eof(a) and (sigo)) do begin
		Read(a, e);
		if (e.nro = e2.nro) then begin
			sigo:= false;
			writeln('nro ya existente');
			end;
	end;
	if (sigo = true) then begin
		Seek(a, filePos(a)-1);
		Write(a, e)
	end
	else 
		writeln('no se pudo agregar debido a que el nro de empleado ya existe');
	close(a);
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
	//PUNTO 4
	agregoEmpleado(arch_log);
END.

