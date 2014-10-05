{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  i,n,m,l1,l2,count:Integer;

procedure components(x:Integer);
  var
    j:Integer;
  begin
    a[x][0]:=count;
    for j:=1 to Length(a[x])-1 do
      begin
        if a[a[x][j]][0] = 0 then
          components(a[x][j]);
      end;
  end;

begin
  count:=0;

  Assign(f,'components.in');
  Assign(g,'components.out');
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
  count:=1;
  for i:=1 to n do
    begin
      if a[i][0]=0 then
        begin
          components(i);
          count:=count+1;
        end;
    end;
  Writeln(g,count-1);
  for i:=1 to n do
    write(g,a[i][0],' ');

  Close(f);
  Close(g);
end.
