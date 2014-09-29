{$M 16384,16777216}

type
  pair = array[1..2] of Integer;

var
  f,g:Text;
  a:array of array of pair;
  answer:Int64;
  i,n,m,s,t,l1,l2,l3:Integer;
  flag:Boolean;

procedure findtheway(x:Integer;length:Integer);
  var
    j:Integer;
  begin
    for j:=1 to a[x][0][2]-1 do
      begin
        if a[a[x][j][1]][0][1] = 0 then
          findtheway(a[x][j][1],length + a[x][j][2]);
      end;
    if x=t then
      if flag = False then
        begin
          answer:=length;
          flag:=true;
        end
      else
        if answer>length then
          answer:=length;
  end;

begin
  flag:=False;

  Assign(f,'shortpath.in');
  Assign(g,'shortpath.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m,s,t);
  SetLength(a,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0][1]:=0;
      a[i][0][2]:=1;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2,l3);
      a[l1][0][2]:=a[l1][0][2]+1;
      SetLength(a[l1],a[l1][0][2]);
      a[l1][Length(a[l1])-1][1]:=l2;
      a[l1][Length(a[l1])-1][2]:=l3;
    end;
  findtheway(s,0);

  if flag = True then
    Writeln(g,answer)
  else
    Writeln(g,'Unreachable');
  Close(f);
  Close(g);
end.
