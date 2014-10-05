{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  answer:array of Integer;
  i,n,m,l1,l2,count:Integer;
  flag:Boolean;

procedure topsort(x:Integer);
  var
    j:Integer;
  begin
    a[x][0]:=1;
    for j:=1 to Length(a[x])-1 do
      begin
        if a[a[x][j]][0] = 0 then
          topsort(a[x][j]);
      end;
    count:=count+1;
    answer[count]:=x;
    a[x][0]:=2;
  end;

function reachablenot(x,y:Integer):Boolean;
  var
    j:Integer;
    ft:Boolean;
  begin
    ft:=true;
    for j:=1 to Length(a[x])-1 do
      if a[x][j]=y then
        ft:=false;
    reachablenot:=ft;
  end;

begin
  flag:=True;
  count:=0;

  Assign(f,'hamiltonian.in');
  Assign(g,'hamiltonian.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(answer,n+1);

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
    end;
  for i:=1 to n do
    begin
      if a[i][0]<>2 then
        topsort(i);
    end;
  for i:=n downto 2 do
    if reachablenot(answer[i],answer[i-1]) then
      flag:=False;
  if flag=True then
    Writeln(g,'YES')
  else
    Writeln(g,'NO');

  Close(f);
  Close(g);
end.
