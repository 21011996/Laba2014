{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  i,n,m,start,l1,l2:Integer;
  answer:Boolean;

procedure findoutwinner(x:Integer; firstwin:Boolean);
  var
    j:Integer;
    flag:Boolean;
  begin
    flag:=False;
    for j:=1 to Length(a[x])-1 do
      begin
        flag:=True;
        if a[a[x][j]][0] = 0 then
          findoutwinner(a[x][j],not firstwin);
      end;
    if (flag=False) and (firstwin=True) then
      begin
        answer:=True;
        Exit;
      end;
  end;

begin
  answer:=False;

  Assign(f,'game.in');
  Assign(g,'game.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m,start);
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
    end;
  findoutwinner(start,False);
  if answer=True then
    begin
      Writeln(g,'First player wins');
    end
  else
    Writeln(g,'Second player wins');
  Close(f);
  Close(g);
end.
