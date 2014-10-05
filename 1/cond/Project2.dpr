{$M 16384,16777216}

var
  f,g:Text;
  a,areversed:array of array of Integer;
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

procedure condensator2000(x:Integer);
  var
    j:Integer;
  begin
    areversed[x][0]:=count;
    for j:=1 to Length(areversed[x])-1 do
      begin
        if areversed[areversed[x][j]][0] = 0 then
          condensator2000(areversed[x][j]);
      end;
  end;

begin
  flag:=True;
  count:=0;

  Assign(f,'cond.in');
  Assign(g,'cond.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(areversed,n+1);
  SetLength(answer,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0]:=0;
      SetLength(areversed[i],1);
      areversed[i][0]:=0;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1]:=l2;
      SetLength(areversed[l2],Length(areversed[l2])+1);
      areversed[l2][Length(areversed[l2])-1]:=l1;
    end;
  for i:=1 to n do
    begin
      if a[i][0]<>2 then
        topsort(i);
    end;
  count:=0;
  for i:=n downto 1 do
    begin
      if areversed[answer[i]][0]=0 then
        begin
          count:=count+1;
          condensator2000(answer[i]);
        end;
    end;
  Writeln(g,count);
  for i:=1 to n do
    write(g,areversed[i][0],' ');

  Close(f);
  Close(g);
end.
