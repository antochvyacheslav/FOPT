unit fivebsixb_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TFIVEBSIXB = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    sg2: TStringGrid;
    Button2: TButton;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure risunok();
    procedure sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FIVEBSIXB: TFIVEBSIXB;
  kol,kol2:integer;
implementation

{$R *.dfm}

procedure TFIVEBSIXB.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\5b6b.txt');
kol:=sg1.ColCount-1;
kol2:=sg2.ColCount-1;
randomize;
button1.Click;
end;

procedure TFIVEBSIXB.Button1Click(Sender: TObject);
var i,j,s:integer;
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
j:=0;
s:=0;
for i:=0 to kol do
  begin
  sg2.cells[j,0]:=sg1.cells[i,0];
  s:=strtoint(sg2.cells[j,0]);
  j:=j+1;
  if (j+1) mod 6 =0 then
    begin
    if s mod 2 =0 then sg2.cells[j,0]:='0' else sg2.cells[j,0]:='1';
    s:=0;
    j:=j+1;
    end;
  end;
risunok();
end;

procedure Tfivebsixb.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=15;
x:=0;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(455,19);
for i:=0 to kol2 do
  begin
  if(sg2.cells[i,0]='1')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x+h+1,0);
    x:=x+h;
    end;
  if sg2.Cells[i,0]='0' then
    begin
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x+h+1,19);
    x:=x+h;
    end;
  end;
end;

procedure TFIVEBSIXB.Button2Click(Sender: TObject);
begin
fivebsixb.close;
end;

procedure TFIVEBSIXB.sg2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var x:real;
begin
if ((ACol+1) mod 6)=0 then
  begin
  sg2.Canvas.Brush.Color:=clRed;
  sg2.Canvas.FillRect(Rect); //Текст тоже будет закрашен, его нужно перерисовать:
  sg2.Canvas.TextOut(Rect.Left+2, Rect.Top+2, sg2.Cells[ACol, ARow]);
  end;
end;

end.
