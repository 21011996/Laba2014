{$M 16384,16777216}

type
  pair=record
    first:Integer;
    second:Integer;
  end;
var
  f,g:Text;
  a:array of array of pair;
  timeIn,fup,colors,stack:array of Integer;
  i,n,m,l1,l2:Integer;
  count,maxcolor:Integer;

function min(a,b:Integer):Integer;
  begin
    if a>b then
      min:=b
    else
      min:=a;
  end;

procedure biconv(u,p:Integer);
  var
    j:Integer;
  begin
    a[u][0].first:=1;
    Inc(count);
    fup[u]:=count;
    timeIn[u]:=count;
    for j:=1 to Length(a[u])-1 do
      begin
        if a[u][j].first=p then
          Continue;
        if a[a[u][j].first][0].first=0 then
          begin
            SetLength(stack,Length(stack)+1);
            stack[Length(stack)-1]:=a[u][j].second;
            biconv(a[u][j].first,u);
            if (fup[a[u][j].first]>=timeIn[u]) then
              begin
                inc(maxcolor);
                while stack[Length(stack)-1]<>a[u][j].second do
                  begin
                    colors[stack[Length(stack)-1]]:=maxcolor;
                    SetLength(stack,Length(stack)-1);
                  end;
                colors[stack[Length(stack)-1]]:=maxcolor;
                SetLength(stack,Length(stack)-1);
              end;
            fup[u]:=min(fup[u],fup[a[u][j].first]);
          end
        else
          begin
            if timeIn[a[u][j].first]<timeIn[u] then
              begin
                SetLength(stack,Length(stack)+1);
                stack[Length(stack)-1]:=a[u][j].second;
              end;
            //if fup[u]>timeIn[a[u][j].first] then
            //  fup[u]:=timeIn[a[u][j].first];
            fup[u]:=min(fup[u],timeIn[a[u][j].first]);
          end;
      end;
  end;




begin
  count:=0;
  maxcolor:=0;

  Assign(f,'biconv.in');
  Assign(g,'biconv.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  SetLength(timeIn,n+1);
  SetLength(fup,n+1);
  SetLength(colors,m+1);
  SetLength(stack,1);

  for i:=1 to n do
    begin
      SetLength(a[i],1);
      a[i][0].first:=0;
    end;

  for i:=1 to m do
    begin
      Readln(f,l1,l2);
      SetLength(a[l1],Length(a[l1])+1);
      a[l1][Length(a[l1])-1].first:=l2;
      a[l1][Length(a[l1])-1].second:=i;
      SetLength(a[l2],Length(a[l2])+1);
      a[l2][Length(a[l2])-1].first:=l1;
      a[l2][Length(a[l2])-1].second:=i;
    end;

  for i:=1 to n do
    if a[i][0].first=0 then
      biconv(i,-1);

  Writeln(g,maxcolor);
  for i:=1 to m do
    write(g,colors[i],' ');

  Close(f);
  Close(g);
end.
