{$M 16384,16777216}

type
  dinmass=array of Integer;
var
  f,g:Text;
  a:array of array of Integer;
  used:array of Boolean;
  list:dinmass;
  i,n,m,l1,l2,pp,j:Integer;

procedure add(x:Integer);
  begin
    SetLength(list,Length(list)+1);
    list[Length(list)-1]:=x;
  end;

function pop():Integer;
  var
    answer:Integer;
  begin
    answer:=list[list[0]];
    inc(list[0]);
    pop:=answer;
  end;


begin
  Assign(f,'pathbge1.in');
  Assign(g,'pathbge1.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);
  SetLength(used,n+1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0]:=400001;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1]:=l2;
      SetLength(a[l2],Length(a[l2])+1);
      a[l2][Length(a[l2])-1]:=l1;
    end;
  a[1][0]:=0;
  SetLength(list,1);
  list[0]:=1;
  add(1);
  while (list[0]<=Length(list)-1) do
    begin
      pp:=pop();
      for j:=1 to Length(a[pp])-1 do
        begin
          if a[a[pp][j]][0]=400001 then
            begin
              a[a[pp][j]][0]:=a[pp][0]+1;
              add(a[pp][j]);
            end;
        end;

    end;

  for i:=1 to n do
    write(g,a[i][0],' ');
  Close(f);
  Close(g);
end.
