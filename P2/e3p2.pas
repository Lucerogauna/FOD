{A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un 
archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas 
alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos 
agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de 
localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos 
necesarios para actualizar el archivo maestro a partir de los dos archivos detalle. 
NOTA: Los archivos están ordenados por nombre de provincia y en los archivos detalle      
pueden venir 0, 1 ó más registros por cada provincia. 
   
}


program e3tp2;
	const valorAlto= -1
type
	datos = record 
		nombreProv: string;
		cantAlfabet: integer;
		totalEncuestados: integer;
	end;
	det = record
		nombreProv : string;
		codLocalidad: int;
		cantAlfabet: integer;
		totalEncuestados: integer;
	end;
	maestro = file of datos;
	detalle = file of det:
	
var
	det1, det2: detalle;
	 master: maestro;
procedure leer( var archiv: archivo; var dato: det);
begin
	if (not(EOF(archiv))) then
		read (archiv, dato)
	else
		dato.cod := valorAlto;

end;
procedure minimo ( var min, d1, d2: det);
begin
	if (d1.nombreProv < d2.nombreProv) then begin //compara cual es el menor de los dos, si uno llego al fin va a trabajar con el otro
			min:= d1;
			leer(det1, d1);
	end
	else begin
		min := d2;
		leer(det2, d2);
	end;
		
end;
procedure actualizarMaster (var maest: maestro; var d1,d2 : detalle);
var det1, det2: det; reg, aux: datos;
begin
	reset(maest);
	reset(d1);
	reset(d2);
	leer(d1, det1); //leo para no cargar basura cuando llamo a min
	leer(d2, det2);
	minimio(det1, det2, min);
	{se procesan los detalles}
	while (min.cod <> valorAlto) do begin // mientras no se llegue al fin de los archivos detalle
		read (maest, reg);
		{se asignan valores para registro del archivo maestro}
		aux.nombreProv:= min.nombreProv; //actual
		aux.totalEncuest:=0; // o aux.total + reg total
		aux.cantAlfabet:=0; //idem arriba
		{se procesan los registros de una misma provincia}
		while (aux.nombreProv = min.nombreProv) do begin
			aux.totalEncuest:= aux.totalEncuest + min.totalEncuest
			aux.cantAlfabet:= aux.cantAlfabet + min.cantAlfabet;
			minimo(det1,det2, min);
		end;
		{se guarda en el archivo maestro}
		write(maest, aux);
		//hago un seek?
	end;
	close(maest);
	close(d1);
	close(d2);
end;
BEGIN
	assign(maestro, 'ej3tp2');
	
	actualizarMaster(master, det1, det2);
	
END.

