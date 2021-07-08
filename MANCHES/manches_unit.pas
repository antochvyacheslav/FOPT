unit manches_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TMANCHES = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure risunok();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MANCHES: TMANCHES;
  kol:integer;
implementation

{$R *.dfm}

procedure TMANCHES.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\manches.txt');
kol:=sg1.ColCount-1;
button1.Click;
end;

procedure TMANCHES.Button1Click(Sender: TObject);
var i:integer;
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
for i:=0 to kol do
  if sg1.cells[i,0]='1' then sg1.cells[i,1]:='10' else sg1.cells[i,1]:='01';
risunok();
end;

procedure Tmanches.Risunok();
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
  end;
end;

procedure TMANCHES.Button2Click(Sender: TObject);
begin
manches.close;
end;

end.
