Program Generar_archivos;
    Procedure actualizar (var );//siemprepor referencia!!
    var 
    begin
        Reset ();
        while not eof () do begin
            Read();
            writeln();
            Seek ();
        end;
        close ();
    end;

    type archivo = file of integer; //archivo es un archivo de enteros
    var 
        arc_logico: archivo;// asigna el tipo de datos
        nro: integer;
        arc_fisico: string[12];

    begin
        write('ingrese el nombre del archivo');
        readln(arc_fisico);
        assign (arc_logico, arc_fisico); //
        rewrite(arc_logico);
        writeln('leer un numero');
        read(nro);
        while nro <>0 do begin
           write(arc_logico, nro);
           writeln('leer un numero ');
           read(nro);
        end;
        close (arc_logico);
    end.
