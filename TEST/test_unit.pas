unit test_unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TQUESTION = record//вопрос
    v:string;//вопрос
    o1:string;//вариант ответа 1
    o2:string;//вариант ответа 2
    o3:string;//вариант ответа 3
    o4:string;//вариант ответа 4
    otvet:string;//номер правльного ответа
    user:string;//номер пользовательского ответа
    end;
  TTEST = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button3: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Button4: TButton;
    ll1: TLabel;
    ll2: TLabel;
    ll3: TLabel;
    ll4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure ll1Click(Sender: TObject);
    procedure ll2Click(Sender: TObject);
    procedure ll3Click(Sender: TObject);
    procedure ll4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TEST: TTEST;
  t,ot,slu:textfile;//t - тест, ot - ответы на тест,slu-порядок вопросов
  s:string;
  i,j:integer;
  kol:integer;//количество вопросов
  q:array of tquestion;
  mark:integer;//оценка
  right,nonright:integer;//правильные/неправлиьные ответы
  ass,as2:array of byte;//массив для задания случайной посл-ти вопросов
  buf:byte;//буефер, перем. для обмена
  ar:array[0..8] of byte;

implementation

uses FIRST;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.Button1Click(Sender: TObject);
begin
test.Activate;
ass:=nil;
as2:=nil;
q:=nil;
button1.Enabled:=false;
button3.Enabled:=true;
button4.Enabled:=true;

checkbox1.Enabled:=not false;
checkbox2.Enabled:=not false;
checkbox3.Enabled:=not false;
checkbox4.Enabled:=not false;

assignfile(t,'test\1.txt');//открываем файл с тестом
reset(t);
kol:=0;
while not(eof(t)) do
  begin
  readln(t,s);
  if(s[1]='<')and(s[2]='>')then kol:=kol+1;
  end;

setlength(ass,kol);
setlength(as2,kol);
assignfile(slu,'test\3.txt');//открываем файл с посл-тью вопросов
reset(slu);
readln(slu,s);
closefile(slu);

//в массив записываются номера, для вывода вопросов в случ. порядке, каждый
//раз с нового
ass[0]:=strtoint(s);
randomize;
ass[kol-1]:=random(kol);
while ass[kol-1]=ass[0] do ass[kol-1]:=random(kol);
i:=0;
for j:=1 to kol-2 do
  begin
  while(i=ass[kol-1])or(i=ass[0]) do i:=i+1;
  ass[j]:=i;
  i:=i+1;
  end;
//номер случайной последовательности меняется местом с индексом массива, т.к. при
//обращении массив[ass[i]], мы с помощью ass[i] попадём на номер равный i,
//таким образом сформируется требуемая нам последоваетльность вопросов
for i:=0 to kol-1 do as2[i]:=ass[i];
for i:=0 to kol-1 do ass[as2[i]]:=i;
//запись в файил нового номера первого вопроса, неравного предыдуущему
buf:=random(kol);
while ass[0]=buf do buf:=random(kol);
rewrite(slu);
writeln(slu,buf);
closefile(slu);

setlength(q,kol+1);
reset(t);//устанавливаем указатель в начало файла

assignfile(ot,'test\2.txt');//открываем файл с ответами
reset(ot);

for i:=0 to kol-1 do
  begin
  readln(t,s);
  q[ (ass[i]) ].v:=s;
  readln(t,s);
  q[ (ass[i]) ].o1:=s;
  readln(t,s);
  q[ (ass[i]) ].o2:=s;
  readln(t,s);
  q[ (ass[i]) ].o3:=s;
  readln(t,s);
  q[ (ass[i]) ].o4:=s;
  readln(t);

  readln(ot,s);
  q[ (ass[i]) ].otvet:=s[3];
  q[ (ass[i]) ].user:='0';
  end;

memo1.Clear;

//закрытие открытых файлов
closefile(t);
closefile(ot);

i:=0;
with q[i] do
  begin
  memo1.lines.Add(v);
  ll1.Caption:=o1;
  ll2.Caption:=o2;
  ll3.Caption:=o3;
  ll4.Caption:=o4;
  end;
end;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.Button3Click(Sender: TObject);
begin
if checkbox1.Checked then q[i].user:='1';
if checkbox2.Checked then q[i].user:='2';
if checkbox3.Checked then q[i].user:='3';
if checkbox4.Checked then q[i].user:='4';

memo1.clear;
checkbox1.Checked:=false;
checkbox2.Checked:=false;
checkbox3.Checked:=false;
checkbox4.Checked:=false;

i:=i+1;
with q[i] do
  begin
  memo1.lines.Add(v);
  ll1.Caption:=o1;
  ll2.Caption:=o2;
  ll3.Caption:=o3;
  ll4.Caption:=o4;
  end;
if i=kol-1 then button3.Enabled:=false;
end;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.Button4Click(Sender: TObject);
begin
//записываем ответ на послед вопрос
if checkbox1.Checked then q[i].user:='1';
if checkbox2.Checked then q[i].user:='2';
if checkbox3.Checked then q[i].user:='3';
if checkbox4.Checked then q[i].user:='4';
//скрываем ненужные клавишы
button1.Enabled:=true;
button3.Enabled:=false;
button4.Enabled:=false;

checkbox1.Checked:=false;
checkbox2.Checked:=false;
checkbox3.Checked:=false;
checkbox4.Checked:=false;

ll1.caption:='';
ll2.caption:='';
ll3.caption:='';
ll4.caption:='';

checkbox1.Enabled:=false;
checkbox2.Enabled:=false;
checkbox3.Enabled:=false;
checkbox4.Enabled:=false;
//рассчитываем оценки
mark:=0;
right:=0;
nonright:=0;
for i:=0 to kol-1 do if q[i].otvet=q[i].user then  right:=right+1;
nonright:=kol-right;
mark:=round(5*right/kol);
if (right/kol)=0.5 then mark:=3;
if mark<2 then mark:=2;
memo1.Clear;
memo1.Lines.Add('Оценка '+inttostr(mark));
memo1.Lines.Add('Правильных '+inttostr(right));
memo1.Lines.Add('Неправильных '+inttostr(nonright));
end;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.FormActivate(Sender: TObject);
begin
memo1.clear;
memo1.lines.add('Тест по теме "Стыковые и линейные коды ВОСП"');

button1.Enabled:=true;
button3.Enabled:=false;
button4.Enabled:=false;

checkbox1.Checked:=false;
checkbox2.Checked:=false;
checkbox3.Checked:=false;
checkbox4.Checked:=false;

checkbox1.caption:='';
checkbox2.caption:='';
checkbox3.caption:='';
checkbox4.caption:='';

ll1.caption:='';
ll2.caption:='';
ll3.caption:='';
ll4.caption:='';

checkbox1.Enabled:=false;
checkbox2.Enabled:=false;
checkbox3.Enabled:=false;
checkbox4.Enabled:=false;
end;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.Button2Click(Sender: TObject);
begin
test.Close;
end;

////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

procedure TTEST.FormClose(Sender: TObject; var Action: TCloseAction);
begin
main.show;
end;

procedure TTEST.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then
  begin
  checkbox2.checked:=false;
  checkbox3.checked:=false;
  checkbox4.checked:=false;
  end;
end;

procedure TTEST.CheckBox2Click(Sender: TObject);
begin
if checkbox2.Checked then
  begin
  checkbox1.checked:=false;
  checkbox3.checked:=false;
  checkbox4.checked:=false;
  end;
end;

procedure TTEST.CheckBox3Click(Sender: TObject);
begin
if checkbox3.Checked then
  begin
  checkbox1.checked:=false;
  checkbox2.checked:=false;
  checkbox4.checked:=false;
  end;
end;

procedure TTEST.CheckBox4Click(Sender: TObject);
begin
if checkbox4.Checked then
  begin
  checkbox1.checked:=false;
  checkbox2.checked:=false;
  checkbox3.checked:=false;
  end;
end;

procedure TTEST.ll1Click(Sender: TObject);
begin
if checkbox1.Checked then checkbox1.Checked:=false
else checkbox1.Checked:=true;
end;

procedure TTEST.ll2Click(Sender: TObject);
begin
if checkbox2.Checked then checkbox2.Checked:=false
else checkbox2.Checked:=true;
end;

procedure TTEST.ll3Click(Sender: TObject);
begin
if checkbox3.Checked then checkbox3.Checked:=false
else checkbox3.Checked:=true;
end;

procedure TTEST.ll4Click(Sender: TObject);
begin
if checkbox4.Checked then checkbox4.Checked:=false
else checkbox4.Checked:=true;
end;

end.
