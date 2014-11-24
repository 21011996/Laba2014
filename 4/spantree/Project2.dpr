const
  INF=999999999;
type
  pair=record
    x:Integer;
    y:Integer;
  end;

var
  f,g:Text;
  n,i,j,x,y,v:Integer;
  used:array of Boolean;
  a:array of pair;
  min_e:array of pair;
  answer:Real;

function rasstoyanie(x1,y1,x2,y2:Integer):Real;
  begin
    rasstoyanie:=Sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
  end;

function rasstoyanielite(x1,y1,x2,y2:Integer):Integer;
  begin
    rasstoyanielite:=(x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
  end;

begin
  Assign(f,'spantree.in');
  Reset(f);
  Assign(g,'spantree.out');
  Rewrite(g);

  Readln(f,n);
  SetLength(a,n+1);
  SetLength(used,n+1);
  SetLength(min_e,n+1);

  for i:=1 to n do
    begin
      min_e[i].x:=INF;
      min_e[i].y:=-1;
      readln(f,x,y);
      a[i].x:=x;
      a[i].y:=y;
    end;

  min_e[1].x:=0;
  for i:=1 to n do
    begin
      v:=-1;
      for j:=1 to n do
        if (used[j]=False) and ((v=-1) or (min_e[j].x<min_e[v].x)) then
          v:=j;
      used[v]:=True;
      if (min_e[v].y<>x-1) then
        answer:=answer+sqrt(min_e[v].x);
      for j:=1 to n do
        if rasstoyanielite(a[v].x,a[v].y,a[j].x,a[j].y) < min_e[j].x then
          begin
            min_e[j].x:=rasstoyanielite(a[v].x,a[v].y,a[j].x,a[j].y);
            min_e[j].y:=v;
          end;
    end;


  Writeln(g,answer);

  Close(f);
  Close(g);
end.
