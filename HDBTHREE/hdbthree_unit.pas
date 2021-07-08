unit hdbthree_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  THDBTHREE = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure risunok();
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  HDBTHREE: THDBTHREE;
  kol:integer;
implementation

{$R *.dfm}

procedure THDBTHREE.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\hdb-3.txt');
kol:=sg1.ColCount-1;
randomize;
button1.Click;
end;

procedure THDBTHREE.Button1Click(Sender: TObject);
var i,j:integer;
    posl:string;//последнее значение
    b,v:string;//b-иверсия послед. знач.,v-повтор послед.знач.
    sum:integer;//проверка на чётность импульсов между двумя v, сумма импульсов
    prov:boolean;//проврека что 4 ипульса нули
    s:integer;
    a:array of integer;
begin
setlength(a,kol+1);
for i:=0 to kol do a[i]:=1;

for i:=0 to kol do sg1.cells[i,1]:='';//очистка нажней строки таблицы

randomize;

s:=0;
for i:=0 to kol do
  begin
  sg1.cells[i,0]:=inttostr(random(2));
  if sg1.cells[i,0]='0' then s:=s+1;
  end;
while s<(2*kol/3) do
for i:=0 to kol do
  if sg1.cells[i,0]<>'0' then
    begin
    sg1.cells[i,0]:=inttostr(random(2));
    if sg1.cells[i,0]='0' then s:=s+1;
    end;

posl:='-1';
sum:=0;
prov:=false;
for i:=3 to kol do
  begin/////////////////begin-end-1

  //если это блок из четырёх нулей
  if (sg1.cells[i-3,0]='0')and(sg1.cells[i-2,0]='0')
  and(sg1.cells[i-1,0]='0')and(sg1.cells[i-0,0]='0')
  and(a[i]=1)and(a[i-1]=1)and(a[i-2]=1)and(a[i-3]=1)
  then
    begin/////////////////begin-end-2
    if (sum mod 2=0) then
      begin
      if posl='-1' then
        begin
        sg1.cells[i-3,1]:='1b';
        sg1.cells[i,1]:='1v';
        posl:='1';
        end
      else
        begin
        sg1.cells[i-3,1]:='-1b';
        sg1.cells[i,1]:='-1v';
        posl:='-1';
        end;
      end
    else
      begin
      if posl='-1' then
        begin
        sg1.cells[i-3,1]:='0';
        sg1.cells[i,1]:='-1v';
        posl:='-1';
        end
      else
        begin
        sg1.cells[i-3,1]:='0';
        sg1.cells[i,1]:='1v';
        posl:='1';
        end;
      end;
    sg1.cells[i-2,1]:='0';
    sg1.cells[i-1,1]:='0';
    prov:=true;
    a[i]:=0;
    a[i-3]:=0;
    a[i-2]:=0;
    a[i-1]:=0;
    sum:=0;
    end/////////////////begin-end-2
  else prov:=false;

  if (not prov) then //если это не блок из четырёх нулей
    if(sg1.cells[i,0]<>'0') then
      begin
      if (posl='-1') then
        begin
        sg1.cells[i,1]:='1';
        posl:='1';
        end
      else
        begin
        sg1.cells[i,1]:='-1';
        posl:='-1';
        end;
      sum:=sum+1;
      end
    else sg1.cells[i,1]:='0';

  if (i=3)and(not prov)then
    for j:=3 downto 0 do //проверка первых 4 символов
      begin
      if(sg1.cells[i-j,0]<>'0') then
        begin
        if (posl='-1') then
          begin
          sg1.cells[i-j,1]:='1';
          posl:='1';
          end
        else
          begin
          sg1.cells[i-j,1]:='-1';
          posl:='-1';
          end;
        sum:=sum+1;
        end
      else sg1.cells[i-j,1]:='0';
      end;

  end;/////////////////begin-end-1

//for i:=0 to kol do ss.cells[i,0]:=inttostr(a[i]);//для проверка массива а
//ss-это stringgrid
a:=nil;

risunok();//вызов процедуры на рисование

end;

procedure THDBTHREE.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=19;
x:=0;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=0 to kol do
  begin
  if(sg1.cells[i,1]='1')or(sg1.cells[i,1]='1b')or(sg1.cells[i,1]='1v')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);
    image1.Canvas.LineTo(x,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);
    image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x,0);
    image1.Canvas.LineTo(x+h+1,0);
    if(sg1.cells[i,1]='1b')then image1.Canvas.TextOut(x+3,2,'1b');
    if(sg1.cells[i,1]='1v')then image1.Canvas.TextOut(x+3,2,'1v');
    x:=x+h;
    end;
  if sg1.Cells[i,1]='0' then
    begin
    image1.Canvas.MoveTo(x,19);
    image1.Canvas.LineTo(x+h+1,19);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='-1')or(sg1.cells[i,1]='-1b')or(sg1.cells[i,1]='-1v')then
    begin
    //вертик снизу слева
    image1.Canvas.MoveTo(x,19);
    image1.Canvas.LineTo(x,39);
    //вертик снизу справа
    image1.Canvas.MoveTo(x+h,19);
    image1.Canvas.LineTo(x+h,39);
    //дно
    image1.Canvas.MoveTo(x,39);
    image1.Canvas.LineTo(x+h+1,39);
    if(sg1.cells[i,1]='-1b')then image1.Canvas.TextOut(x+2,20,'-1b');
    if(sg1.cells[i,1]='-1v')then image1.Canvas.TextOut(x+2,20,'-1v');
    x:=x+h;
    end;
  end;
end;

procedure THDBTHREE.Button2Click(Sender: TObject);
begin
hdbthree.close;
end;

end.
