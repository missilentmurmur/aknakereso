program aknakereso;
const N=10;
  B_no=5;
var a:array[1..N+2,1..N+2] of integer;
  b:array[1..N,1..N] of integer;
  palya:array[1..N,1..N] of char;
  i,j,l,szam,haladas:integer;

procedure bombaosztas;
var i,j,bx,by:integer;
begin
  for i:=1 to (szam+2) do begin
    for j:=1 to (szam+2) do begin
        a[i,j]:=0;
      end;
  end;
  
  for i:=1 to B_no do begin
    repeat
    bx:=random(10)+2;
    by:=random(10)+2;
    until a[bx,by]=0;
    a[bx,by]:=1;
  end;
end;

procedure szomszed_szamolas;
var i,j,k:integer;
begin
  for i:=2 to (N+1) do begin
    for j:=2 to (N+1) do begin
      k:=a[i-1,j-1]+a[i-1,j]+a[i-1,j+1]+
         a[i,j-1]           +a[i,j+1]+
         a[i+1,j-1]+a[i+1,j]+a[i+1,j+1];
      if a[i,j] = 0 then b[i-1,j-1]:=k
      else b[i-1,j-1]:=9;
    end;
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
var x,y,mi_van_ott:integer;
begin
  writeln('tippelj ket koordinata megadasaval');
  write('x: ');
  readln(y);
  write('y: ');
  readln(x);
  felfed(x,y);
  mi_van_ott:=b[x,y];

  writeln('itt ez van: ',mi_van_ott);
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
end;

begin
  randomize;
  writeln('szia! ez itt az aknakereso. a palya merete: ',N,'x',N,', a bombak szama: ',B_no);
  writeln('tippelni ugy tudsz, hogy eloszor megadod a vizszintes koordinatat, majd egy entert kovetoen a fuggolegeset.');
  szam := 10;

  haladas:=0;
  writeln;
  bombaosztas;
  writeln;

  szomszed_szamolas;

  writeln;
  szuz_palya;
  writeln;
  jatek;
  readln;
end.

