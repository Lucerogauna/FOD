{
  2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
 creado en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el
 promedio de los números ingresados. El nombre del archivo a procesar debe ser
 proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
 contenido del archivo en pantalla
}
{preguntar: Read, Write, no lo entiendo}

program ej1p1;

type
	numeros = file of integer;
procedure analizar(var archivo: numeros; var promedio: real; var mas1500: integer);
var
	n: integer;
	begin
	Reset (archivo);//actualiza el puntero al primero
	while not eof(archivo) do begin
		writeln('nombre del archivo N:', filepos(archivo)); // o filepos(archivo)+1 porque arranca de 0 
		Read(archivo, n);
		Seek(archivo,filepos(archivo)-1);
		Write(archivo, n);
		promedio := promedio + n ;
		writeln(n);
		if (n<1500) then
		  mas1500:= mas1500+1;
	end;
	writeln(' tamaño del archivo',filesize(archivo));
	promedio:= promedio/filesize(archivo);
	close(archivo);
	end;
var 
	nro: integer; max1500: integer;
	prom: real;
	arch_fisico: string[20];
	arch_nros : numeros;
BEGIN
	writeln('leer nombre del archivo fisico');
	readln (arch_fisico);
	assign(arch_nros, arch_fisico);
	rewrite(arch_nros);
	writeln('leer nro');
	readln (nro);
	while (nro <> 30000) do begin
		write(arch_nros, nro);
		writeln('leer nro');
		readln (nro);
	end;
	close(arch_nros);
	analizar(arch_nros,prom, max1500);
	writeln('promedio',prom:2:0);
	writeln('cant de numeros < 1500  ',max1500);
END.

