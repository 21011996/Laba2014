{$M 16384,16777216}

type
  pair = record
    point:Integer;
    way:Integer;
  end;

var
  f,g:Text;
  a:array of array of pair;
  answer:Int64;
  i,n,m,s,t,l1,l2,l3:Integer;
  flag:Boolean;

procedure findtheway(x:Integer);
  var
    j:Integer;
  begin
    a[x][0].point:=1;
    for j:=1 to Length(a[x])-1 do
      begin
        if a[a[x][j].point][0].point = 1 then
          begin
            if  a[a[x][j].point][0].way > (a[x][0].way+a[x][j].way) then
              begin
                a[a[x][j].point][0].way:=a[x][0].way+a[x][j].way;
                findtheway(a[x][j].point);
              end;
          end;
        if a[a[x][j].point][0].point = 0 then
          begin
            a[a[x][j].point][0].way:=a[x][0].way+a[x][j].way;
            findtheway(a[x][j].point);
          end;
      end;
  end;

begin
  flag:=False;

  Assign(f,'shortpath.in');
  Assign(g,'shortpath.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m,t,s);
  SetLength(a,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0].point:=0;
      a[i][0].way:=0;
    end;

  for i:=1 to m do
    begin
      Readln(f,l2,l1,l3);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1].point:=l2;
      a[l1][Length(a[l1])-1].way:=l3;
    end;
  findtheway(s);

  if a[t][0].point = 1 then
    Writeln(g,a[t][0].way)
  else
    Writeln(g,'Unreachable');
  Close(f);
  Close(g);
end.
