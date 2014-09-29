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
        if a[a[x][j]][0] = 1 then
          flag:=False;
      end;
    count:=count+1;
    answer[count]:=x;
    a[x][0]:=2;
  end;

begin
  flag:=True;
  count:=0;

  Assign(f,'topsort.in');
  Assign(g,'topsort.out');
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
      if flag=False then
        begin
          Writeln(g,-1);
          break;
        end;
    end;
  if flag=True then
    begin
      for i:=n downto 1 do
        begin
          write(g,answer[i],' ');
        end;
    end;
  Close(f);
  Close(g);
end.
