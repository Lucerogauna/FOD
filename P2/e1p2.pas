{1. Una empresa posee un archivo con información de los ingresos percibidos por diferentes 
empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado, 
nombre y monto de la comisión. La información del archivo se encuentra ordenada por 
código de empleado y cada empleado puede aparecer más de una vez en el archivo de 
comisiones.  
Realice un procedimiento que reciba el archivo anteriormente descrito y lo compacte. En 
consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una 
única vez con el valor total de sus comisiones. 
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser 
recorrido una única vez. 
   PREGUNTAR MERCH
   * ver ppt con el ejemplo que tiene  
		if (not eof(a))then
			read(a, e); al final del while interno
}


program ej1tp2;
const valorAlto = -1;
type
	empleado = record
		cod : integer;
		nombre: string[30];
		montoCom: real;
end;
	archivo = file of empleado;
procedure leerE (var e: empleado);
begin
	with e do begin
		writeln('leer cod del empleado');
		readln(cod);
		if (cod <> 0) then begin	
			writeln('leer nombre del empleado');
			readln(nombre);
			writeln('leer monto comision ');
			readln(montoCom);
		end;
	end;
end;
procedure cargar(var a: archivo);
var 
	e: empleado;
	act: integer;
begin
	leerE(e);
	while (e.cod <> 0) do begin
		act := e.cod;
		while ((e.cod<> 0) and (e.cod = act)) do begin
			write(a, e);
			leerE(e);
		end;
	end;
end;

procedure imprimirRegistro (e: empleado);
begin
	with e do begin
	writeln('codigo: ', cod );
	writeln('Nombre: ',nombre);
	writeln('monto de comision: ', montoCom:2:0);
end;
end;
procedure imprimirBenditoArchivo (var a: archivo);
var e: empleado;
begin
	reset(a);
	while not eof(a) do begin
		read(a, e);
		imprimirRegistro(e);
	end;
	close(a);
end;
procedure leer( var archiv: archivo; var dato: empleado);
begin
	if (not(EOF(archiv))) then
		read (archiv, dato)
	else
		dato.cod := valorAlto;

end;
procedure merch (var a, anuevo: archivo);
var 
	e, nuevo: empleado;  act: integer; comTot: real; nombreAct: String;
begin
	assign (anuevo, 'archivoNuevo');
	rewrite(anuevo);
	reset(a);
	leer(a, e);
	while (e.cod <> valorAlto) do begin // se procesan los datos del archivo
		act := e.cod;
		comTot:=0;
		nombreAct:= e.nombre; //guardo el nombre act porque sino lo pierdo cuando leo !!!
		while (act = e.cod) do begin
			comTot:= comTot + e.montoCom; //suma para el archivo merge
			leer(a, e);
		end;
		nuevo.cod := act; // creo un nueevo registro donde guardo los datos porque no puedo hacer write(amuevo, campo campo)
		nuevo.nombre := nombreAct;
		nuevo.montoCom := comTot;

		write(anuevo, nuevo); 
		 
		{if (not eof(a))then
			read(a, e); // o read(a,e) preguntar //no estaria leyendo lo mismo dos veces? linea 91 ver
		}
	end;
	
	close(a);
	close(anuevo);
end;
var
	//nombre: string;
	arch, archcompax: archivo;
BEGIN
	assign(arch, 'ej1tp2'); // o puedo asignarle nombre
	//rewrite (arch);
	//cargar(arch); //hago esto porque ya tengo cargado el archivo
	//close (arch);
	imprimirBenditoArchivo(arch);
	merch(arch, archcompax);
	writeln('');
	writeln('archivo merch');
	imprimirBenditoArchivo(archcompax);
	
END.

