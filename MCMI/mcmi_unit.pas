unit mcmi_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TMCMI = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
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
  MCMI: TMCMI;
  i,kol:integer;

implementation

{$R *.dfm}

procedure TMCMI.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\mcmi.txt');
kol:=sg1.ColCount-1;
button1.Click;
end;

procedure TMCMI.Button1Click(Sender: TObject);
var prov:boolean;//проверка, какое значеие имел прдыдущий символ 1: 11 или 00
begin
randomize;
prov:=true;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
for i:=0 to kol do
  if sg1.cells[i,0]='0' then sg1.cells[i,1]:='01'
  else
     if prov then
     begin sg1.cells[i,1]:='11';prov:=false; end
     else
     begin sg1.cells[i,1]:='00';prov:=true;end;
risunok();
end;

procedure Tmcmi.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=19;
x:=0;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=0 to kol do
  begin
  if(sg1.cells[i,1]='11')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x,19);
    //вертик сверху по центру
    image1.Canvas.MoveTo(x+(h div 2),0);
    image1.Canvas.LineTo(x+(h div 2),19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);
    image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x,0);
    image1.Canvas.LineTo(x+h+1,0);
    x:=x+h;
    end;
  if sg1.Cells[i,1]='00' then
    begin
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x+h+1,19);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='01')then
    begin
    //вертик сверху справа
    image1.Canvas.MoveTo(x+(h div 2),0);
    image1.Canvas.LineTo(x+(h div 2),19);
    //вертик сверху слева
    image1.Canvas.MoveTo(x+h,0);image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x+(h div 2),0);
    image1.Canvas.LineTo(x+h+1,0);
    x:=x+h;
    end;
  end;
end;

procedure TMCMI.Button2Click(Sender: TObject);
begin
mcmi.Close;
end;

end.
