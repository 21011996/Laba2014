{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  b:array of array[0..2] of Integer;
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

procedure findanswer(x,y:Integer);
  var
    k,ans,r:Integer;
  begin
    k:=1;
    r:=0;
    while k<=m do
      begin
        if ((b[k][1]=x) and (b[k][2]=y)) or ((b[k][2]=x) and (b[k][1]=y)) then
          begin
            r:=r+1;
            ans:=k;
          end;
        Inc(k);
      end;
    if r=1 then
      begin
        b[ans][0]:=1;
        Inc(answers);
      end;
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
  answers:=0;

  Assign(f,'bridges.in');
  Assign(g,'bridges.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  SetLength(tin,n+1);
  SetLength(fup,n+1);
  SetLength(b,m+1);

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
      b[i][0]:=0;
      b[i][1]:=l1;
      b[i][2]:=l2;
    end;

  for i:=1 to n do
    if a[i][0]=0 then
      bridges(i,-1);

  Writeln(g,answers);
  for i:=1 to m do
    if b[i][0]=1 then
      write(g,i,' ');

  Close(f);
  Close(g);
end.
