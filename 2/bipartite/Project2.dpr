{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  i,n,m,l1,l2:Integer;
  flag:Boolean;

function BoolToInt(f:Boolean):Integer;
  begin
    if f then
      BoolToInt:=2
    else
      BoolToInt:=1;
  end;

procedure bipartite(x:Integer;color:Boolean);
  var
    j:Integer;
  begin
    a[x][0]:=BoolToInt(color);
    for j:=1 to Length(a[x])-1 do
      begin
        if a[a[x][j]][0] = a[x][0] then
          flag:=False;
        if a[a[x][j]][0] = 0 then
          bipartite(a[x][j],not color);
      end;
  end;

begin
  flag:=True;

  Assign(f,'bipartite.in');
  Assign(g,'bipartite.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0]:=0;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1]:=l2;
      SetLength(a[l2],Length(a[l2])+1);
      a[l2][Length(a[l2])-1]:=l1;
    end;
  for i:=1 to n do
    begin
      if a[i][0]=0 then
        begin
          bipartite(i,True);
        end;
    end;

  if flag=True then
    Writeln(g,'YES')
  else
    Writeln(g,'NO');

  Close(f);
  Close(g);
end.
