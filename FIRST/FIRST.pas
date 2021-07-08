unit FIRST;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMAIN = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label2: TLabel;
    Button8: TButton;
    Button9: TButton;
    Memo1: TMemo;
    Button10: TButton;
    Button11: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MAIN: TMAIN;

implementation

uses nrz_unit, rz_unit, cmi_unit, mcmi_unit, miller_unit, manches_unit,
  fivebsixb_unit, ami_unit, hdbthree_unit, test_unit;

{$R *.dfm}

procedure TMAIN.FormActivate(Sender: TObject);
begin
memo1.lines.LoadFromFile('text_files\first.txt');
end;

procedure TMAIN.Button11Click(Sender: TObject);
begin
close();
end;

procedure TMAIN.Button1Click(Sender: TObject);
begin
nrz.showmodal;
end;

procedure TMAIN.Button2Click(Sender: TObject);
begin
rz.showmodal;
end;

procedure TMAIN.Button3Click(Sender: TObject);
begin
cmi.ShowModal
end;

procedure TMAIN.Button4Click(Sender: TObject);
begin
mcmi.ShowModal;
end;

procedure TMAIN.Button5Click(Sender: TObject);
begin
miller.showmodal;
end;

procedure TMAIN.Button6Click(Sender: TObject);
begin
manches.ShowModal;
end;

procedure TMAIN.Button7Click(Sender: TObject);
begin
fivebsixb.ShowModal;
end;

procedure TMAIN.Button8Click(Sender: TObject);
begin
ami.ShowModal;
end;

procedure TMAIN.Button9Click(Sender: TObject);
begin
hdbthree.ShowModal;
end;

procedure TMAIN.Button10Click(Sender: TObject);
begin
main.hide;
test.ShowModal;
end;

end.
