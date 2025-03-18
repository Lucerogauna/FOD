{
   1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del
archivo debe ser proporcionado por el usuario desde teclado.
}


program ej1p1;

type
	numeros = file of integer;
var 
	nro: integer;
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
	
END.

