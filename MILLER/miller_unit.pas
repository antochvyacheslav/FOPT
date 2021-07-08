unit miller_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TMILLER = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure risunok();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MILLER: TMILLER;
  i,kol:integer;

implementation

{$R *.dfm}

procedure TMILLER.Button1Click(Sender: TObject);
var
  perv:integer;//первые два символа первой строки таблицы
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
perv:=strtoint(sg1.Cells[0,0]+sg1.Cells[1,0]);
case perv of
  11:if sg1.Cells[2,0]='1' then sg1.cells[2,1]:='10' else sg1.cells[2,1]:='00';
  00:if sg1.Cells[2,0]='1' then sg1.cells[2,1]:='01' else sg1.cells[2,1]:='11';
  10:if sg1.Cells[2,0]='1' then sg1.cells[2,1]:='01' else sg1.cells[2,1]:='00';
  01:if sg1.Cells[2,0]='1' then sg1.cells[2,1]:='10' else sg1.cells[2,1]:='11';
  end;
for i:=3 to kol do
begin
if sg1.cells[i-1,1]='11' then
  if sg1.Cells[i,0]='1' then sg1.cells[i,1]:='10' else sg1.cells[i,1]:='00';
if sg1.cells[i-1,1]='00' then
  if sg1.Cells[i,0]='1' then sg1.cells[i,1]:='01' else sg1.cells[i,1]:='11';
if sg1.cells[i-1,1]='10' then
  if sg1.Cells[i,0]='1' then sg1.cells[i,1]:='01' else sg1.cells[i,1]:='00';
if sg1.cells[i-1,1]='01' then
  if sg1.Cells[i,0]='1' then sg1.cells[i,1]:='10' else sg1.cells[i,1]:='11';
end;
risunok();
end;

procedure TMILLER.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\miller.txt');
kol:=sg1.ColCount-1;
button1.Click;
end;

procedure Tmiller.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=19;
x:=h+h;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=2 to kol do
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
  if(sg1.cells[i,1]='01')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x+(h div 2),0);
    image1.Canvas.LineTo(x+(h div 2),19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x+(h div 2)+1,0);image1.Canvas.LineTo(x+h,0);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='11')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x+h+1,0);
    x:=x+h;
    end;
  if sg1.Cells[i,1]='00' then
    begin
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x+h+1,19);
    x:=x+h;
    end;
  end;
end;

procedure TMILLER.Button2Click(Sender: TObject);
begin
miller.close;
end;

end.
