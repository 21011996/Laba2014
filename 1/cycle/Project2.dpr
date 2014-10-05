{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  answer:array of Integer;
  i,n,m,l1,l2:Integer;
  flag,flag2:Boolean;
  point:Integer;

procedure findcircle(x:Integer);
  var
    j:Integer;
  begin
    a[x][0]:=1;
    for j:=1 to Length(a[x])-1 do
      begin
        if flag=true then
          break;
        if a[a[x][j]][0] = 0 then
          findcircle(a[x][j]);
        if a[a[x][j]][0] = 1 then
          begin
            flag:=true;
            point:=a[x][j];
            Break;
          end;
      end;
    a[x][0]:=2;
    if x=point then
      begin
        SetLength(answer,Length(answer)+1);
        answer[Length(answer)-1]:=x;
        flag2:=True;
        Exit;
      end;
    if (flag=True) and (flag2 = False) then
      begin
        SetLength(answer,Length(answer)+1);
        answer[Length(answer)-1]:=x;
      end;
  end;

begin
  flag:=false;
  flag2:=False;

  Assign(f,'cycle.in');
  Assign(g,'cycle.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(answer,1);

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
        findcircle(i);
      if flag=True then
        begin
          break;
        end;
    end;
  if flag=false then
    begin
      writeln(g,'NO');
    end
  else
    begin
      Writeln(g,'YES');
      for i:=Length(answer)-1 downto 1  do
        begin
          write(g,answer[i],' ');
        end;
    end;
  Close(f);
  Close(g);
end.
