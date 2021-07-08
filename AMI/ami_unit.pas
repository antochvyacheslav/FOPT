unit ami_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TAMI = class(TForm)
    Memo1: TMemo;
    sg1: TStringGrid;
    Button1: TButton;
    Image1: TImage;
    Button2: TButton;
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
  AMI: TAMI;
  kol:integer;

implementation

{$R *.dfm}

procedure TAMI.Button1Click(Sender: TObject);
var i:integer;
    prov:string;  //prov-проверка каким был элемент +1 или -1
begin
randomize;
for i:=0 to kol do sg1.cells[i,0]:=inttostr(random(2));
sg1.cells[0,1]:=sg1.cells[0,0];
prov:='-1';
for i:=1 to kol do
begin
if sg1.cells[i-1,1]<>'0' then prov:=sg1.cells[i-1,1];
if (sg1.cells[i,0]='1') and (prov='1') then sg1.cells[i,1]:='-1';
if (sg1.cells[i,0]='1') and (prov='-1') then sg1.cells[i,1]:='1';
if sg1.cells[i,0]='0' then sg1.cells[i,1]:='0';
end;
risunok();
end;

procedure Tami.Risunok();
var x,h,i:integer;
begin
image1.picture:=nil;
h:=19;
x:=0;
image1.Canvas.MoveTo(0,19);image1.Canvas.LineTo(495,19);
for i:=0 to kol do
  begin
  if(sg1.cells[i,1]='1')then
    begin
    //вертик сверху слева
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x,19);
    //вертик сверху справа
    image1.Canvas.MoveTo(x+h,0);image1.Canvas.LineTo(x+h,19);
    //крышка
    image1.Canvas.MoveTo(x,0);image1.Canvas.LineTo(x+h+1,0);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='-1')then
    begin
    //вертик снизу слева
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x,39);
    //вертик снизу справа
    image1.Canvas.MoveTo(x+h,19);image1.Canvas.LineTo(x+h,39);
    //дно
    image1.Canvas.MoveTo(x,39);image1.Canvas.LineTo(x+h+1,39);
    x:=x+h;
    end;
  if(sg1.cells[i,1]='0')then
    begin
    image1.Canvas.MoveTo(x,19);image1.Canvas.LineTo(x+h+1,19);
    x:=x+h;
    end;
  end;
end;

procedure TAMI.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\ami.txt');
kol:=sg1.ColCount-1;
randomize;
button1.Click;
end;

procedure TAMI.Button2Click(Sender: TObject);
begin
ami.close;
end;

end.
