UNIT soliunit;
 INTERFACE
  USES cartunit,crt;
  TYPE
   ptrnodo1=^tnodo1;
   tnodo1=RECORD
     carta:tcarta;
     sig:ptrnodo1;
     end;
   tpila=ptrnodo1;
   ptrnodo2=^tnodo2;
   tnodo2=RECORD
     carta:tcarta;
     sig:ptrnodo2;
     end;
   tmazo=ptrnodo2;
   temporal=ARRAY[1..12]OF tcartataula;
   palos=ARRAY[1..4]OF tcartataula;
  PROCEDURE comenzar (VAR baralla:tbaralla;VAR p:tpila;VAR m:tmazo);
  PROCEDURE visualmesa(m:tmazo;p:tpila;v:temporal;pl:palos);
  IMPLEMENTATION
   PROCEDURE meter(VAR p:tpila;nuevoelemento:tcarta);
    VAR
     nuevonodo:ptrnodo1;
    begin
     new(nuevonodo);
     nuevonodo^.sig:=p;
     nuevonodo^.carta:=nuevoelemento;
     p:=nuevonodo;
    end;
   PROCEDURE metermazo(VAR p:tmazo;nuevoelemento:tcarta);
    VAR
     nuevonodo:ptrnodo2;
    begin
     new(nuevonodo);
     nuevonodo^.sig:=p;
     nuevonodo^.carta:=nuevoelemento;
     p:=nuevonodo;
    end;
   PROCEDURE sacar(VAR p:tpila;VAR elemsacado:tcarta);
    VAR
     signodo:ptrnodo1;
    begin
     IF p<>nil THEN
      begin
       elemsacado:=p^.carta;
       signodo:=p^.sig;
       dispose(p);
       p:=signodo
      end;
     end;
   PROCEDURE sacarm(VAR p:tmazo;VAR elemsacado:tcarta);
    VAR
     signodo:ptrnodo2;
    begin
     IF p<>nil THEN
      begin
       elemsacado:=p^.carta;
       signodo:=p^.sig;
       dispose(p);
       p:=signodo
      end;
     end;
    PROCEDURE vaciarpila(VAR p:tpila);
     begin
      p:=nil;
     end;
    PROCEDURE vaciarmazo(VAR p:tmazo);
     begin
      p:=nil;
     end;
    FUNCTION pilallena(p:tpila):boolean;
     begin
      pilallena:=p=nil;
     end;
    PROCEDURE visualtemp(v:temporal);
     VAR
      i,j,k:integer;
     begin
      i:=2;
      k:=1;
      WHILE i<=17 DO
       begin
       j:=12;
        WHILE j<=36 DO
         begin
          IF v[k].estat=true THEN
           veurecarta(v[k].carta,j,i)
          ELSE
           llevacarta(j,i);
          j:=j+8;
          k:=k+1;
         end;
        i:=i+15;
       end;
      j:=12;
      i:=7;
      WHILE i<=12 DO
       begin
        j:=12;
        WHILE j<=36 DO
         begin
          IF v[k].estat=true THEN
           veurecarta(v[k].carta,j,i)
          ELSE
           llevacarta(j,i);
          j:=j+24;
          k:=k+1;
         end;
        i:=i+5;
       end;
     end;
    PROCEDURE visualpalos(pl:palos);
     VAR
      i,j,k:integer;
     begin
      i:=7;
      k:=1;
      WHILE i<=12 DO
       begin
        j:=20;
        WHILE j<=28 DO
         begin
          IF pl[k].estat=true THEN
           veurecarta(pl[k].carta,j,i)
          ELSE
           llevacarta(j,i);
          j:=j+8;
          k:=k+1;
         end;
        i:=i+5;
       end;
     end;
    PROCEDURE visualpila(p:tpila);
     VAR
      i:integer;
     begin
      IF p<>nil THEN
       veurecarta(p^.carta,50,9)
      ELSE
       llevacarta(50,9)
     end;
    PROCEDURE visualmazo(m:tmazo);
     VAR
      i:integer;
     begin
      IF m<>nil THEN
       amagacarta(50,17)
      ELSE
       begin
        llevacarta(50,17);
       end;
     end;
    PROCEDURE visualmesa(m:tmazo;p:tpila;v:temporal;pl:palos);
     begin
      visualtemp(v);
      visualpalos(pl);
      visualpila(p);
      visualmazo(m);
      readln;
     end;
    PROCEDURE comppila(p:tpila;pl:palos;VAR a:integer;VAR compp:boolean);
     VAR
       i:integer;
     begin
      compp:=false;
      i:=1;
      IF p<>nil THEN
        WHILE (i<=4) and (compp=false) DO
         begin
          IF (pl[i].estat=false) THEN
           begin
            IF (p^.carta.num=as) THEN
             begin
              compp:=true;
              a:=i;
             end;
           end
          ELSE
           IF p^.carta.pal=pl[i].carta.pal THEN
            IF p^.carta.num=succ(pl[i].carta.num) THEN
             begin
              compp:=true;
              a:=i;
             end;
          i:=i+1;
         end;
     end;
    PROCEDURE comptemp (v:temporal;pl:palos;VAR b:integer;VAR posv:integer;VAR compt:boolean);
     VAR
      i,j:integer;
     begin
      compt:=false;
      FOR i:=1 TO 12 DO
       IF v[i].estat=true THEN
        FOR j:=1 TO 4 DO
         IF (v[i].carta.pal=pl[j].carta.pal) and (pl[j].estat=true) THEN
          IF v[i].carta.num=succ(pl[j].carta.num) THEN
           begin
            b:=j;
            posv:=i;
            compt:=true;
           end;
     end;
    PROCEDURE compalm (p:tpila;v:temporal;VAR posv:integer;VAR compa:boolean);
     VAR
      i:integer;
     begin
      i:=1;
      compa:=false;
      IF p<>nil THEN
       begin
        WHILE (i<=12) and (compa=false) DO
         IF v[i].estat=false THEN
          begin
           compa:=true;
           posv:=i;
          end
         ELSE
        i:=i+1;
       end;
     end;
    PROCEDURE comenzar (VAR baralla:tbaralla;VAR p:tpila;VAR m:tmazo);
     VAR
      i,a,b,posv,posv2:integer;
      s:tcarta;
      v:temporal;
      pl:palos;
      compp,compt,compa:boolean;
     begin
      vaciarpila(p);
      vaciarmazo(m);    {INICIALITZE LES PILES I ELS VECTORS}
      FOR i:=1 TO 12 DO
        v[i].estat:=false;
      FOR i:=1 TO 4 DO
       pl[i].estat:=false;
      barallar(baralla);
      FOR i:=1 TO 40 DO
        metermazo(m,baralla[i]);{pose les cartes barallades dintre del mazo}
      p:=nil;
      WHILE (m<>nil) or (compp) or (compa)or(compt)  DO
       begin
        IF (not compp) and (not compt)and (not compa) THEN
         begin
          sacarm(m,s);
          meter(p,s);
         end;
        visualmesa(m,p,v,pl);
        comppila(p,pl,a,compp);
        IF compp THEN
         begin
          sacar(p,s);
          pl[a].carta:=s;
          pl[a].estat:=true;
          visualmesa(m,p,v,pl);
          comppila(p,pl,a,compp);
         end
        ELSE
         begin
          comptemp(v,pl,b,posv,compt);
          IF compt THEN
           begin
            pl[b].carta:=v[posv].carta;
            v[posv].estat:=false;
            pl[b].estat:=true;
            visualmesa(m,p,v,pl);
            comptemp(v,pl,b,posv,compt);
           end
          ELSE
           begin
            compalm(p,v,posv,compa);
            IF (compa) and (p<>nil) THEN
            begin
             sacar(p,s);
             v[posv].carta:=s;
             v[posv].estat:=true;
             visualmesa(m,p,v,pl);
             compalm(p,v,posv,compa);
            end;
           end;
         end;
       comppila(p,pl,a,compp);
       comptemp(v,pl,b,posv,compt);
       compalm(p,v,posv,compa);

       end;
      compp:=true;
      FOR i:=1 TO 4 DO
       IF pl[i].carta.num<>rei THEN
        compp:=false;
      IF compp THEN
        begin
         gotoxy(12,24);
         writeln('El solitari ha finalitzat amb exit');
         Sound(220);        { Bip }
         Delay(200);        { Durante 200 ms }
         NoSound;
         readln;
        end
      ELSE
       begin
        gotoxy(12,24);
        writeln('El solitari no ha finalitzat amb exit');
        Sound(220);        { Bip }
        Delay(200);        { Durante 200 ms }
        NoSound;
        readln;
       end;
     end;
  end.
 end.
 end.
