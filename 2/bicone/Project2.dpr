{$M 16384,16777216}

var
  f,g:Text;
  a:array of array of Integer;
  enter,ret:array of Integer;
  i,n,m,l1,l2,maxcolor:Integer;
  count,answers:Integer;
  colors:array of integer;

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

procedure bicone(v,p:Integer);
  var
    j:integer;
  begin
    a[v][0]:=1;
    inc(count);
    enter[v]:=count;
    ret[v]:=count;
    for j:=1 to Length(a[v])-1 do
      begin
        if a[v][j]=p then
          continue;
        if a[a[v][j]][0]=1 then
          ret[v]:=min(ret[v],enter[a[v][j]])
        else
          begin
            bicone(a[v][j],v);
            ret[v]:=min(ret[v],ret[a[v][j]]);
          end;
      end;
  end;

procedure paint(v,color:integer);
  var
    j:integer;
  begin
    colors[v]:=color;
    for j:=1 to length(a[v])-1 do
      begin
        if (colors[a[v][j]]=0) then
          if (ret[a[v][j]]=enter[a[v][j]]) then
            begin
              inc(maxcolor);
              paint(a[v][j],maxcolor);
            end
          else
            paint(a[v][j],color);
      end;
  end;


begin
  count:=0;
  answers:=0;
  maxcolor:=0;

  Assign(f,'bicone.in');
  Assign(g,'bicone.out');
  Reset(f);
  Rewrite(g);

  Readln(f,n,m);
  SetLength(a,n+1);

  SetLength(enter,n+1);
  SetLength(ret,n+1);
  Setlength(colors,n+1);

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
      bicone(i,-1);

  for i:=1 to n do
    begin
      if colors[i]=0 then
        begin
          inc(maxcolor);
          paint(i,maxcolor);
        end;
    end;

  Writeln(g,maxcolor);
  for i:=1 to n do
    write(g,colors[i],' ');

  Close(f);
  Close(g);
end.
