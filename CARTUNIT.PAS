unit cartunit;
interface
uses	crt;
const
	CARTESPAL=10;
	CARTESBARALLA=cartespal*4;
type
	Tpal=(ors,copes,espases,bastos);
	Tnum=(as,dos,tres,quatre,cinc,sis,sett,sota,cavall,rei);
	Tcarta=record
			pal:Tpal;
			num:Tnum;
	end;
	TcartaTaula=record
			carta:Tcarta;
			estat:boolean;
	end;
	Tbaralla=array[1..40] of Tcarta;
procedure Barallar(var baralla:Tbaralla);
procedure VeureCarta(c:Tcarta;x,y:integer);
procedure AmagaCarta(x,y:integer);
procedure LlevaCarta(x,y:integer);

implementation

procedure Barallar(var baralla:Tbaralla);
var
	i,j,k:integer;
	x:Tpal;
	y:Tnum;
	carta:Tcarta;
begin
        randomize;
	{inicialitzar baralla}
	i:=1;
	for x:=ors to bastos do
	begin
		for y:=as to rei do
		begin
			carta.pal:=x;
			carta.num:=y;
			baralla[i]:=carta;
			i:=i+1;
		end;
	end;

	{barallar}
	for i:=1 to 40 do
	begin
		j:=random(40)+1;
		repeat
			k:=random(40)+1;
		until j<>k;
		carta:=baralla[j];
		baralla[j]:=baralla[k];
		baralla[k]:=carta;
	end;
end;

procedure  VeureCarta(c:Tcarta;x,y:integer);
var
   xi,yi:integer;
begin
 	 case c.pal of
		  Ors:     TextColor(YELLOW);
		  Copes:   TextColor(LIGHTRED);
		  Espases: TextColor(LIGHTBLUE);
		  Bastos:  TextColor(GREEN);
	 end;
         xi:=x;
         yi:=y;
	 gotoxy(xi,yi);
	 write(' --- ');
	 gotoxy(xi,yi+1);
	 write('|');
	 case c.num of
		as:	write('as ');
		dos:	write(' 2 ');
		tres:	write(' 3 ');
		quatre:	write(' 4 ');
		cinc:	write(' 5 ');
		sis:	write(' 6 ');
		sett:	write(' 7 ');
		sota:	write('sot');
		cavall:	write('cav');
		rei:	write('rei');
	 end;
	 write('|');

	 gotoxy(xi,yi+2);
	 case c.pal of
		  Ors:     write('|ORS|');
		  Copes:   write('|COP|');
		  Espases: write('|ESP|');
		  Bastos:  write('|BAS|');
	 end;
	 gotoxy(xi,yi+3);
	 write(' --- ');
	 TextColor(WHITE);
end;

procedure  AmagaCarta(x,y:integer);
var
   xi,yi:integer;
begin
         textcolor(white);
	 xi:= x;
	 yi:= y;
	 gotoxy(xi,yi);
	 write(' --- ');
	 gotoxy(xi,yi+1);
	 write('|---|');
	 gotoxy(xi,yi+2);
	 write('|---|');
	 gotoxy(xi,yi+3);
	 write(' --- ');
end;

procedure  LlevaCarta(x,y:integer);
var
   xi,yi,i:integer;
begin
	 xi:= x;
	 yi:= y;
	 for i:=0 to 3 do
         begin
              gotoxy(xi,yi+i);
              write('     ');
         end;
end;
end.
