{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  tin,fup:array of Integer;
  i,n,m,l1,l2:Integer;
  count,answers:Integer;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

procedure findanswer(x:Integer);
  begin
    if a[x][0]<> 2 then
    begin
      a[x][0]:=2;
      inc(answers);
    end;
  end;

procedure points(v,p:Integer);
  var
    j,gto,littlechild:Integer;
  begin
    a[v][0]:=1;
    Inc(count);
    tin[v]:=count;
    fup[v]:=count;
    littlechild:=0;
    for j:=1 to Length(a[v])-1 do
      begin
        gto:=a[v][j];
        if gto=p then
          Continue;
        if a[gto][0]>0 then
          fup[v]:=min(fup[v],tin[gto])
        else
          begin
            points(gto,v);
            fup[v]:= min(fup[v],fup[gto]);
            if (fup[gto] >= tin[v]) and (p<>-1) then
              findanswer(v);
            Inc(littlechild);
          end;
      end;
    if (p=-1) and (littlechild>1) then
      findanswer(v);
  end;


begin
  count:=0;
  answers:=0;

  Assign(f,'points.in');
  Assign(g,'points.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  SetLength(tin,n+1);
  SetLength(fup,n+1);

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
  for i:=1 to n do
    if a[i][0]=0 then
      points(i,-1);

  Writeln(g,answers);
  for i:=1 to n do
    if a[i][0]=2 then
      write(g,i,' ');

  Close(f);
  Close(g);
end.
