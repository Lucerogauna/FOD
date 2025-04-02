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
procedure op3(var a: archivoDeEmpleados);
var 
	e: empleado;
begin
	Reset(a);
	writeln('/////////////////////');
	writeln('ARCHIVO COMPLETO');
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
procedure op2( var a: archivoDeEmpleados; var l: lista);
var 
	e: empleado;
	x: string;
begin
	Reset(a);
	writeln('leer un nombre o apellido');
	readln(x); //nombre o apellido
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
procedure op4(var a: archivoDeEmpleados; var l2: lista);
var e: empleado;
begin
	Reset(a);
	while not eof(a) do begin
		Read(a, e);
		if (e.edad > 70) then
			cargarL(l2, e);
	end;
	close (a);
	writeln('imprimir las personas +70');
	imprimirLista(l2);
end;
procedure agregoEmpleado(var a: archivoDeEmpleados); //ESTO ESTA MAL 
var 
	e, e2: empleado;
	sigo: boolean;
begin
	Reset(a);
	writeln('leer un nuevo empleado');
	leerE(e2);
	while (e2.apellido <> 'fin') do begin //lee n registros 
		sigo:= true;
		while not eof(a) and (sigo=true) do begin
			Read(a, e); // lee lo que esta en el archivo
			if (e.nro = e2.nro) then begin // si coinciden YA EXISTE EL EMPLEADO
				sigo:= false;
				writeln('nro ya existente');
				end;
		end;
		if sigo then write(a, e); // HAGO ESTO PORQUE TERMINA Y NO HAY EMPLEADO QUE COINCIDA CON EL NUEVO
		seek(a,0); // SETEA EL PUNTERO PARA VOLVER A LA POSICION INICIAL
		leerE(e2); //LEE OTRO EMPLEADO y vuelve al while del principio
	end;
	close(a);
end;
procedure op1(var a: archivoDeEmpleados);
var 
  e: empleado;
begin
	rewrite(a); //creacion del archivo, puntero en pos 0
	leerE(e);
	while (e.apellido <> 'fin') do begin
		write(a, e);
		leerE(e);
	end;
	close(a);
end;
procedure modificarEdad(var a: archivoDeEmpleados);
var
	 n, ap: string;
	 e: empleado;
	 edadNueva: integer;
begin
	Reset(a);
	writeln('leer nombre y apellido');
	readln(n, ap);
	while not eof(a) do begin
		Read(a, e);
		if ((e.apellido = ap) and (e.nombre = n)) then begin
			writeln('modificar edad:');
			readln (edadNueva);
			E.edad:= edadNueva;
			Seek(a, filepos(a)-1);
			Write(a, e);
		end;
	end;
	close(a);
end;
procedure exportar (var a: archivoDeEmpleados);
var
	AT:text;
	emp: empleado;
begin
	assign(AT, 'todosEmpleados.txt');
	reset(a);
	rewrite(AT);
	while not eof (a) do 
		Read(a, emp);
		writeln(AT, emp.edad, ' ', emp.dni, ' ', emp.nombre);
		writeln(AT, emp.apellido);
	close(AT);
	close(a);
end;
procedure exportarEmpleadosSinDNI (var a: archivoDeEmpleados);
var
	SD:text;
	emp: empleado;
begin
	assign(SD, 'faltaDNIEmpleado.txt');
	reset(a);
	rewrite(SD);
	while not eof (a) do 
		Read(a, emp);
		if (emp.dni = 00) then
		writeln(SD, emp.edad, '',emp.dni,'',emp.nombre,emp.apellido); // SIEMPRE INTENTAR PONER ELOS WRITE MENOS POSIBLES POR EFICIENCIA 
		writeln(SD ,emp.apellido); 
	close(SD);
	close(a);
end;
var
	arch_name: string[30]; //archivo Fisico
	arch_log: archivoDeEmpleados;
	l, l2: lista;
	nro: integer;
BEGIN	
	l:= nil;
	l2:= nil;
	writeln('leer nombre del archivo');
	readln(arch_name);
	assign(arch_log, arch_name);
	writeln('INGRESO AL MENU');
	writeln(' 1 Para leer empleados | ');
	writeln('2 para buscar por nombre o apellido |'); 
	writeln('3 para mostrar los empleados | ');
	writeln('4 mostrar los mayores a 70, proximos a jubilarse');
	writeln('5 para agregar mas empleados');
	writeln('6 modificar la edad de x empleado');
	writeln('7 exportar ');
	writeln('8 exportar ');
	
	readln(nro);
	case nro of
		1: op1(arch_log);
		2: op2(arch_log, l);
		3: op3(arch_log);
		4: op4(arch_log, l2);
		5 : agregoEmpleado (arch_log);
		6: modificarEdad(arch_log);
		7: exportar(arch_log);
	else
		writeln('nro incorrecto');
	end;
	agregoEmpleado(arch_log);
	exportar(arch_log);
	exportarEmpleadosSinDNI(arch_log);
END.
