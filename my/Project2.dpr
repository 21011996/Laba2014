var
  i:Integer;
  g:Text;

function myround(r:Real):Integer;
  begin
    if (r-Trunc(r))<>0.5 then
    myround:=Trunc(r)
    else
      myround:=Trunc(r)+1;
  end;



begin
  Assign(g,'proof.txt');
  Rewrite(g);
  for i:=1 to 100 do
    begin
      Writeln(g,i,' : ',myround(i/3*myround((i-1)/2)),' ',Round(i*(i-1)/6));
    end;
  Close(g);
end.
