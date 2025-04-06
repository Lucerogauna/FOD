{2. El encargado de ventas de un negocio de productos de limpieza desea administrar el stock 
de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los 
productos que comercializa. De cada producto se maneja la siguiente información: código de 
producto, nombre comercial, precio de venta, stock actual y stock mínimo. Diariamente se 
genera un archivo detalle donde se registran todas las ventas de productos realizadas. De 
cada venta se registran: código de producto y cantidad de unidades vendidas. Se pide 
realizar un programa con opciones para: 
a. Actualizar el archivo maestro con el archivo detalle, sabiendo que: 
● Ambos archivos están ordenados por código de producto. 
● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del 
archivo detalle. 
● El archivo detalle sólo contiene registros que están en el archivo maestro. 
b. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo 
stock actual esté por debajo del stock mínimo permitido.
   
}


program e2p2;
	const valorAlto= -1
type
	producto = record
		cod : integer;
		nombre: string;
		precio : real;
		stock: integer;
		stockMin: integer;
	end;
	ventas = record
		cod: integer;
		unidVend: integer;
	end;
	maestro = file of producto;
	detalle = file of ventas;
	
procedure actualizarMaestro (var maest: maestro; var det: detalle);
var 

	var vent: ventas; prod: producto; act: integer;
begin
	reset(maest);
	reset(det);
	while (not eof(det)) do begin//pongo como conidicion detalle porque cuando se termina no se actualiza mas el maesto
		read(det , vent);//leo detalle
		read(maest, prod)//leo maestro
		while (prod.cod <> vent.cod) do // se busca en el maestro el registro del detalle que lei recien
			read(maest, prod);
		prod.stock:= prod.stock - vent.unidVend;
		seek (maest , filepos(maest)-1); //seteo el punteo primero antes de actualizar!! acordarse que lee y avanza
		write(maest, prod);
		
			
	close(maest);
	close(det);
	
	//Preguntar no se puede acumular de archivo detalle y eespues sumarlo a maestro
end;

procedure leer( var archiv: archivo; var dato: ventas);
begin
	if (not(EOF(archiv))) then
		read (archiv, dato)
	else
		dato.cod := valorAlto;

end;
procedure actualizarMaestroAcumulo (var maest: maestro; var det: detalle);// ver ppt
var 

	var vent: ventas; prod: producto; actDetCod,unidVend: integer;
begin
	reset(maest);
	reset(det);
	leer(det, vent);
	while (vent.cod <> valorAlto) do begin
		actDetCod:= vent.cod;
		unidVend:= 0;
		while (actDet  = venta.cod) do begin
			unidVend:= vent.unidVend + unidVend
			leer(det, vent);
			end;
		while (prod.cod <> actDetCod) do // se busca en el maestro el registro del detalle que lei recien
			read(maest, prod);
		prod.stock:= prod.stock - unidVend; // le resto la cantidad total
		seek (maest , filepos(maest)-1); //seteo el punteo primero antes de actualizar!! acordarse que lee y avanza
		write(maest, prod);
		if (not eof(a))then
			read(a, e); //preguntar
			
	close(maest);
	close(det);
			
	
end;
procedure analizarStock(var m: maestro);
var 
	archivoT: text; registro: producto;
begin
	assign (archivoT, 'stock_minimo.txt')
	reset(m);
	while not eof(m) do begin
		read(m, registro);
		if (registro.stock < registro.strockMin) do
			write(archivoT, 'cod' , registro.cod, 'nombre', nombre)
	end;
close (m);
// los archivos de texto se cierran?
end;
var
	det: detalle;
	master: maestro;
BEGIN
	assign(master, 'ej2tp2');
	assign(det, 'det2');
	rewrite(master);
	rewrite(det);
	
	close(master);
	close(det);
	
	actualizarMaestro(master, det);
	analizarStock(master);
	
END.

