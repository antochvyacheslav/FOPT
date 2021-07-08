unit nrz_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TNRZ = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    sg2: TStringGrid;
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
  NRZ: TNRZ;
  i:integer;
  kol:integer;//кол-во столбцов

implementation

uses FIRST;

{$R *.dfm}

procedure TNRZ.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\nrz.txt');
kol:=sg1.ColCount-1;
randomize;
button1.Click;
end;

procedure TNRZ.Button1Click(Sender: TObject);
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
for i:=0 to kol do sg2.cells[i,0]:=sg1.cells[i,0];//задаём вторую таблицу
for i:=0 to kol do sg1.cells[i,1]:=sg1.cells[i,0];
for i:=0 to kol do if sg2.cells[i,0]='0' then sg2.cells[i,1]:='-1'
                   else sg2.Cells[i,1]:=sg2.cells[i,0];
risunok();
end;

procedure TNRZ.Risunok();
var x1,x2,h,i:integer;
begin
image1.picture:=nil;
image2.picture:=nil;
h:=19;
x1:=0;x2:=0;
image2.Canvas.MoveTo(0,19);image2.Canvas.LineTo(495,19);
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=0 to kol do
  begin
  if(sg1.cells[i,1]='1')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x1,0);image1.Canvas.LineTo(x1,19);
    image2.Canvas.MoveTo(x2,0);image2.Canvas.LineTo(x2,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x1+h,0);image1.Canvas.LineTo(x1+h,19);
    image2.Canvas.MoveTo(x2+h,0);image2.Canvas.LineTo(x2+h,19);
    //крышка
    image1.Canvas.MoveTo(x1,0);image1.Canvas.LineTo(x1+h+1,0);
    image2.Canvas.MoveTo(x2,0);image2.Canvas.LineTo(x2+h+1,0);
    x1:=x1+h;
    x2:=x2+h;
    end;
  if sg1.Cells[i,1]='0' then
    begin
    image1.Canvas.MoveTo(x1,19);image1.Canvas.LineTo(x1+h+1,19);
    x1:=x1+h;
    end;
  if(sg2.cells[i,1]='-1')then
    begin
    //вертик снизу слева
    image2.Canvas.MoveTo(x2,19);image2.Canvas.LineTo(x2,39);
    //вертик снизу справа
    image2.Canvas.MoveTo(x2+h,19);image2.Canvas.LineTo(x2+h,39);
    //дно
    image2.Canvas.MoveTo(x2,39);image2.Canvas.LineTo(x2+h+1,39);
    x2:=x2+h;
    end;
  end;
end;

procedure TNRZ.Button2Click(Sender: TObject);
begin
NRZ.Close;
end;

end.
