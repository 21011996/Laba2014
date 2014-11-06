{$M 16384,16777216}
const
  INFINITY=400001;
type
  pair=record
    where:Integer;
    cost:Integer;
  end;
var
  f,g:Text;
  a:array of array of pair;
  answer:array of array of Integer;
  used:array of Boolean;
  i,n,m,l1,l2,l3,j:Integer;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

procedure DeksterAndHisMethLab(begining:Integer);
  var
    o,p,v:Integer;
    u:array of Boolean;
  begin
    SetLength(u,n+1);
    for o:=1 to n do
      begin
        v:=-1;
        for p:=1 to n do
          if (not u[p]) and ((v=-1) or (answer[begining][p]<answer[begining][v])) then
            v:=p;
        if (answer[begining][v]=infinity) then
          Break;
        u[v]:=True;
        for p:=1 to Length(a[v])-1 do
          answer[begining][a[v][p].where]:=min(answer[begining][a[v][p].where],answer[begining][v]+a[v][p].cost);
      end;
  end;

procedure fillarray(var a:array of Integer; l:Integer);
  var
    i:Integer;
  begin
    for i:=1 to Length(a)-1 do
      a[i]:=l;
  end;


begin
  Assign(f,'pathsg.in');
  Assign(g,'pathsg.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(used,n+1);
  SetLength(answer,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      SetLength(answer[i],n+1);
      fillarray(answer[i],INFINITY);
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2,l3);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1].where:=l2;
      a[l1][Length(a[l1])-1].cost:=l3;
    end;

  for i:=1 to n do
    begin
      answer[i][i]:=0;
      DeksterAndHisMethLab(i);
      for j:=1 to n do
        if answer[i][j]<>infinity then
          write(g,answer[i][j],' ')
        else
          write(g,-1,' ');
      Writeln(g);
    end;
  Close(f);
  Close(g);
end.
