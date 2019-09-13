program aknakereso;
const N=10;
  B_no=5;
var a:array[1..N+2,1..N+2] of integer;
  b:array[1..N,1..N] of integer;
  palya:array[1..N,1..N] of char;
  x_of_bomb:array[1..N*N] of integer;
  y_of_bomb:array[1..N*N] of integer;
  i,j,k,l,szam,bomba,haladas:integer;



procedure bombaosztas; {}
var i,j,bx,by:integer;
begin
  {a keretekkel megnovelt palyat megtolti nullakkal:}
  for i:=1 to (szam+2) do begin
    for j:=1 to (szam+2) do begin
        a[i,j]:=0;
      end;
  end;
  {elhelyez az elobbi palyan B_no szamu bombat (1):}
  for i:=1 to B_no do begin
    repeat
    bx:=random(10)+2;
    by:=random(10)+2;
    {writeln(bx,' ',by);}
    until a[bx,by]=0;
    a[bx,by]:=1;
  end;
  {kiirja a nagy palyat, es a bombak koordinatait felveszi egy array-be (de minek...?)
  for i:=1 to szam+2 do begin
    for j:=1 to szam+2 do begin
      write(a[i,j],' ');
      if a[i,j]=1 then begin
        inc(bomba);
        x_of_bomb[bomba]:=i;
        y_of_bomb[bomba]:=j;
      end;
    end;
    writeln;
  end;}
end;

procedure szomszed_szamolas;
var i,j,k:integer;
begin
  {a nagy palya szeleit kihagyva kiszamolja egy adott mezo szomszedainak osszeget}
  for i:=2 to (N+1) do begin
    for j:=2 to (N+1) do begin
      k:=a[i-1,j-1]+a[i-1,j]+a[i-1,j+1]+
         a[i,j-1]           +a[i,j+1]+
         a[i+1,j-1]+a[i+1,j]+a[i+1,j+1];
      if a[i,j] = 0 then b[i-1,j-1]:=k
      {a bombakat kicsereljuk 9-re}
      else b[i-1,j-1]:=9;
      {write(b[i-1,j-1],' ');}
    end;
    {writeln;}
  end;
end;

procedure szuz_palya;
begin
  for i:=1 to (N) do begin
    for j:=1 to (N) do begin
        palya[i,j]:='*';
      end;
  end;
end;

function isOnField(x,y:integer):boolean;
begin
  isOnField := (0<x) and (x<N+1) and (0<y) and (y<N+1);
end;

procedure felfed(x,y:integer);
var mi_van_ott:integer;
begin
 if isOnField(x,y) then begin
  if palya[x,y] = '*' then begin
    if b[x,y] = 0 then begin
      palya[x,y]:= '0';
      inc(haladas);
      felfed(x-1,y-1);
      felfed(x-1,y);
      felfed(x-1,y+1);
      felfed(x,y-1);
      felfed(x,y+1);
      felfed(x+1,y-1);
      felfed(x+1,y);
      felfed(x+1,y+1);
      {write('itt');}
                      end
      else begin
        mi_van_ott:=b[x,y];
        inc(haladas);
        palya[x,y]:=chr(mi_van_ott+48);
      end;
  end;
 end;
end;

procedure palya_kirajzolas;
{a jatekos szamara megjeleniti a jatek aktualis allasat}
begin
  writeln;
  write('   ');
  for l:=1 to N do write(l,' ');
  writeln;
  for i:=1 to N do begin
    write(i:2,' ');
    for j:=1 to N do begin
      write(palya[i,j],' ');
    end;
    writeln;
  end;
end;

function tippeles:char;
{a jatekos megad ket koordinatat}
var i,j,x,y,mi_van_ott:integer;
begin
  writeln('tippelj ket koordinata megadasaval');
  write('x: ');
  readln(y);
  write('y: ');
  readln(x);
  felfed(x,y);
  mi_van_ott:=b[x,y];
  {osszefuggo 0-k felfedese}

  {if mi_van_ott=0 then begin
    writeln('yay!');
    repeat

    until ;
  end;}

  writeln('itt ez van: ',mi_van_ott);
  {felfed(y,x);
  palya[y,x]:=chr(mi_van_ott+48);}
  tippeles:=chr(mi_van_ott+48);
end;

procedure jatek;
var k:char;
begin
  repeat
  k:=tippeles;
  palya_kirajzolas;
  until (k='9') or (haladas=szam*szam-B_no);
  if (k='9') then writeln('bumm! vesztettel');
  if (haladas=szam*szam-B_no) then writeln('nyertel');
  writeln;
  {write('   ');
  for l:=1 to N do write(l,' ');
  writeln;
  for i:=1 to N do begin
    write(i:2,' ');
    for j:=1 to N do begin
      write(b[i,j],' ');
    end;
    writeln;
  end;}

end;




begin
  randomize;
  writeln('szia! ez itt az aknakereso. a palya merete: ',N,'x',N,', a bombak szama: ',B_no);
  writeln('tippelni ugy tudsz, hogy eloszor megadod a vizszintes koordinatat, majd egy entert kovetoen a fuggolegeset.');
  {write('mekkora legyen a palya? (1-10) ');}
  {readln(szam);} szam := 10;

  haladas:=0;
  writeln;
  bombaosztas;
  writeln;

  szomszed_szamolas;

  writeln;
  szuz_palya;
  {jatek bemutatasa}
  writeln;
  jatek;
  readln;
end.

