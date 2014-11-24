{$M 16384,16777216}
type
  pair=record
  x,y:Integer;
  end;

  edge=record
  u,v,weight:Integer;
  end;
label
  exxit;
var
  f,g:Text;
  n:Integer;
  graph:array of array of Integer;
  used:array of array of Boolean;
  answer:array of Integer;
  i,j,a,edges,oddCount,deg:Integer;

procedure findPath(v:Integer);
  var
    i,j,tot:Integer;
  begin
    for i:=0 to Length(graph[v])-1 do
      begin
        if used[v][i]=True then
          Continue;
        used[v][i]:=True;
        tot:=graph[v][i];
        for j:=0 to Length(graph[tot])-1 do
          if (used[tot][j]=False) and (graph[tot][j]=v) then
            begin
              used[tot][j]:=True;
              Break;
            end;
        findPath(tot);
      end;
    SetLength(answer,Length(answer)+1);
    answer[Length(answer)-1]:=v;
  end;

begin
  Assign(f,'euler.in');
  Reset(f);
  Assign(g,'euler.out');
  Rewrite(g);

  Readln(f,n);
  SetLength(graph,n);
  SetLength(used,n);
  edges:=0;
  oddCount:=0;

  for i:=0 to n-1 do
    begin
      Read(f,deg);
      Inc(edges,deg);
      if deg mod 2 <> 0 then
        Inc(oddCount);
      if oddCount>2 then
        begin
          Writeln(g,-1);
          goto exxit;
        end;
      for j:=0 to deg-1 do
        begin
          read(f,a);
          Dec(a);
          SetLength(graph[i],Length(graph[i])+1);
          graph[i][Length(graph[i])-1]:=a;
          SetLength(used[i],Length(used[i])+1);
        end;
      readln(f);
    end;

  findPath(0);

  if Length(answer)-1<>edges div 2 then
    Writeln(g,-1)
  else
    begin
      Writeln(g,Length(answer)-1);
      for i:=0 to Length(answer)-1 do
        write(g,answer[i]+1,' ');
    end;


  exxit:Close(f);
    Close(g);
end.
