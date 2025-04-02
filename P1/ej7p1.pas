{
   7. Realizar un programa que permita:
 a) Crear un archivo binario a partir de la información almacenada en un archivo de
 texto. El nombre del archivo de texto es: “novelas.txt”. La información en el
 archivo de texto consiste en: código de novela, nombre, género y precio de
 diferentes novelas argentinas. Los datos de cada novela se almacenan en dos
 líneas en el archivo de texto. La primera línea contendrá la siguiente información:
 código novela, precio y género, y la segunda línea almacenará el nombre de la
 novela.
 b) Abrir el archivo binario y permitir la actualización del mismo. Se debe poder
 agregar una novela y modificar una existente. Las búsquedas se realizan por
 código de novela.
 NOTA: El nombre del archivo binario es proporcionado por el usuario desde el teclado.
   
   
}


program untitled;
type
novel = record
	cod: integer;
	nombre: string;
	genero: string;
	precio: real;
	end;

archivo_bi= file of novel;
procedure leerN(var n: novel);
begin
	writeln('leer codigo, precio y genero'); readln(n.cod); read(n.precio); read(n.genero);
	writeln('leer nombre'); read(n.nombre);
end;
procedure cargarArchivoDeTexto(var at: text);
var n: novel;
begin
	leerN(n);
	while (n.nombre <> '.') do begin
		write(at, 'Codigo de novela: ',n.cod,'Precio', n.precio,'Genero ', n.genero );
		writeln(at, 'Nombre de la novela', n.nombre);
		leerN(n);
	end;
end;
procedure agregarA(var a: archivo_bi); //preguntt
var 
n: novel;
begin
	reset(a);
	leerN(n);
	seek(a, filesize(a));
	write(a, n);
	close (a);
end;
procedure modificarA(var a: archivo_bi);
var n: novel; cod: integer;
ok: boolean;
begin
	reset(a);
	writeln('leer codigo a modificas');
	read(cod);
	ok := true;
	while not eof(a) and (ok)do begin
		read(a, n);
		if (n.cod = cod) then begin //significa que encontro pero el puntero quedo adelante
			ok := false; //Para quepare eñ while
			seek(a, filepos(a)-1); // vuelvo una pos atras para escribir
			writeln('modificar genero');
			write(a, n); //aca ya lo modifico o tengoqw ue leerlo nuevamente?
		end;
	end;
	close(a);
end;
var
	archivo: archivo_bi;
	archivoT: text;
	e: novel;
BEGIN
	assign (archivoT, 'novelas.txt');
	assign(archivo, 'archivoBinario');
	rewrite(archivo);
	rewrite (archivoT);
	cargarArchivoDeTexto(archivoT);
	while not eof(archivoT) do begin
		read(archivoT, e.cod, e.precio, e.genero);
		read(archivoT, e.nombre);
		write(archivo, e);
	end;
	agregarA(archivo);
	modificarA(archivo);
END.

