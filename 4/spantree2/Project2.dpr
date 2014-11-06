const
  INF=999999999;
type
  edge=record
    u,v,weight:Integer;
  end;

  mass=array of edge;

var
  f,g:Text;
  p:array of Integer;
  edges:mass;
  n,m,i:Integer;
  ves:Int64;


function dsuGet(v:Integer):Integer;
  var
    answer:Integer;
  begin
    if v=p[v] then
      answer:=v
    else
      answer:=dsuGet(p[v]);
    dsuGet:=answer;
  end;

procedure dsuUnite(a,b:Integer);
  begin
    a:=dsuGet(a);
    b:=dsuGet(b);
    if a<>b then
      p[a]:=b;
  end;

procedure qSort(var A: mass; min, max: Integer);
  var
    split:Integer;
  procedure merge(var A: mass; min,split,max: Integer);
    var
      pos1,pos2,pos3:Integer;
      temp:mass;
    begin
      pos1:=min;
      pos2:=split+1;
      pos3:=0;
      SetLength(temp,max-min+1);
      while (pos1<=split) and (pos2<=max) do
        if (a[pos1].weight<a[pos2].weight) then
          begin
            temp[pos3]:=a[pos1];
            Inc(pos3);
            Inc(pos1);
          end
        else
          begin

            temp[pos3]:=a[pos2];
            Inc(pos3);
            Inc(pos2);
          end;
      while pos2<=max do
        begin

          temp[pos3]:=a[pos2];
          Inc(pos3);
          Inc(pos2);
        end;
      while pos1<=split do
        begin

          temp[pos3]:=a[pos1];
          Inc(pos3);
          Inc(pos1);
        end;
      for pos3:=0 to max-min do
        a[min+pos3]:=temp[pos3];
    end;
  begin
    if min<max then
      begin
        split:=(min+max) div 2;
        qSort(a,min,split);
        qSort(a,split+1,max);
        merge(a,min,split,max);
      end;
  end;

begin
  Assign(f,'spantree2.in');
  Reset(f);
  Assign(g,'spantree2.out');
  Rewrite(g);

  Readln(f,n,m);
  SetLength(edges,m);

  for i:=0 to m-1 do
    begin
      Readln(f,edges[i].u,edges[i].v,edges[i].weight);
      Dec(edges[i].v);
      Dec(edges[i].u);
    end;

  qSort(edges,0,m-1);
  SetLength(p,n);
  ves:=0;
  for i:=0 to n-1 do
    p[i]:=i;

  for i:=0 to m-1 do
    if (dsuGet(edges[i].u) <> dsuGet(edges[i].v)) then
      begin
        ves:=ves+edges[i].weight;
        dsuUnite(edges[i].u,edges[i].v);
      end;

  Writeln(g,ves);

  Close(f);
  Close(g);
end.
