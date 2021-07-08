unit rz_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TRZ = class(TForm)
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
  RZ: TRZ;
  i:integer;
  kol:integer;//кол-во столбцов

implementation

{$R *.dfm}

procedure TRZ.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\rz.txt');
kol:=sg1.ColCount-1;
button1.Click;
end;

procedure TRZ.Button1Click(Sender: TObject);
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
for i:=0 to kol do
  if strtoint(sg1.Cells[i,0])=0 then sg1.cells[i,1]:='-10'
  else sg1.cells[i,1]:='10';
risunok();
end;

procedure TRZ.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=19;
x:=0;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=0 to kol do
  begin
  if(sg1.cells[i,1]='10')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+(h div 2),0);
    image1.Canvas.LineTo(x+(h div 2),19);
    //крышка
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x+(h div 2)+1,0);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='-10')then
    begin
    //вертик снизу слева
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x,39);
    //вертик снизу справа
    image1.Canvas.MoveTo(x+(h div 2),19);
    image1.Canvas.LineTo(x+(h div 2),39);
    //дно
    image1.Canvas.MoveTo(x,39);
    image1.Canvas.LineTo(x+(h div 2)+1,39);
    x:=x+h;
    end;
  end;
end;

procedure TRZ.Button2Click(Sender: TObject);
begin
rz.Close;
end;

end.
