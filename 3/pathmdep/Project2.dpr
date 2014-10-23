{$M 16384,16777216}
const
  INF=2000000000;
type
  rebratip=record
    a:Integer;
    b:Integer;
    cost:Integer;
  end;
var
  f,g:Text;
  answer:array of Integer;
  rebra:array of rebratip;
  i,j,n,start,finish,l:Integer;
  flag:Boolean;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

begin
  Assign(f,'pathmgep.in');
  Assign(g,'pathmgep.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,start,finish);
  SetLength(answer,n+1);
  SetLength(rebra,1);

  for i:=1 to n do
    begin
      answer[i]:=INF;
    end;
  for i:=1 to n do
    begin
      for j:=1 to n do
        begin
          read(f,l);
          if (l>=0) and (i<>j) then
            begin
              SetLength(rebra,Length(rebra)+1);
              rebra[Length(rebra)-1].a:=i;
              rebra[Length(rebra)-1].b:=j;
              rebra[Length(rebra)-1].cost:=l;
            end;
        end;
      Readln(f);
    end;

  answer[start]:=0;
  for i:=1 to n do
    begin
      for j:=1 to Length(rebra)-1 do
        answer[rebra[j].b]:=min(answer[rebra[j].b],answer[rebra[j].a]+rebra[j].cost);
    end;
  flag:=true;
  for j:=1 to Length(rebra)-1 do
        if answer[rebra[j].b]>answer[rebra[j].a]+rebra[j].cost then
          flag:=False;
  if flag and (answer[finish]<>inf) then
    Writeln(g,answer[finish])
  else
    Writeln(g,-1);
  Close(f);
  Close(g);
end.
