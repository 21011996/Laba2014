{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  b:array of array[1..2] of Integer;
  tin,fup:array of Integer;
  i,n,m,l1,l2:Integer;
  count:Integer;
  answer:array of Integer;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

procedure findanswer(x,y:Integer);
  var
    k:Integer;
  begin
    k:=1;
    while ((b[k][1]<>x) or (b[k][2]<>y)) and ((b[k][2]<>x) or (b[k][1]<>y)) do
      Inc(k);
    answer[Length(answer)-1]:=k;
    SetLength(answer,Length(answer)+1);
  end;

procedure bridges(v,p:Integer);
  var
    j,gto:Integer;
  begin
    a[v][0]:=1;
    Inc(count);
    tin[v]:=count;
    fup[v]:=count;
    for j:=1 to Length(a[v])-1 do
      begin
        gto:=a[v][j];
        if gto=p then
          Continue;
        if a[gto][0]=1 then
          fup[v]:=min(fup[v],tin[gto])
        else
          begin
            bridges(gto,v);
            fup[v]:= min(fup[v],fup[gto]);
            if (fup[gto] > tin[v]) then
              findanswer(v,gto);
          end;
      end;
  end;


begin
  count:=0;

  Assign(f,'bridges.in');
  Assign(g,'bridges.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  SetLength(tin,n+1);
  SetLength(fup,n+1);
  SetLength(b,m+1);
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
      SetLength(a[l2],Length(a[l2])+1);
      a[l2][Length(a[l2])-1]:=l1;
      b[i][1]:=l1;
      b[i][2]:=l2;
    end;

  for i:=1 to n do
    if a[i][0]=0 then
      bridges(i,-1);

  Writeln(g,Length(answer)-1);
  for i:=0 to Length(answer)-2 do
    Writeln(g,answer[i]);

  Close(f);
  Close(g);
end.
