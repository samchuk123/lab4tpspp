unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Newton(x1, eps: real; var x2: real; var k: integer);
    procedure Plot(x, y: real);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

function F(x: real): real;
begin
  F := arctan(2 * x) - (1 / (1 + x));
end;

function F1(x: real): real;
begin
  F1 := (2 / (4 * sqr(x) + 1)) + (1 / sqr(x + 1));
end;

procedure TForm1.Newton(x1, eps: real; var x2: real; var k: integer);
var
  b: real;
begin
  x2 := x1;
  k := 0;
  repeat
    b := x2;
    Memo1.Lines.Add('x1 = ' + FloatToStrF(x2, FFFixed, 2, 7));
    Inc(k);
    x2 := b - F(b) / F1(b);
    Memo1.Lines.Add('x2 = x1 - ' + '(' + FloatToStrF(F(b), FFFixed, 2, 7) +
      ')' + ' / ' + '(' + FloatToStrF(F1(b), FFFixed, 2, 7) + ')');
    Memo1.Lines.Add('');
  until abs(x2 - b) < eps;
end;

procedure TForm1.Plot(x, y: real);
begin
  x := 0;
  while x <= 1 do
  begin
    x := x + 0.001;
    y := arctan(2 * x) - (1 / (1 + x));
    Chart1LineSeries1.AddXY(x, y);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  x0, x, eps: real;
  ib1: string;
  code, k: integer;
begin
  eps := 0.001;
  ib1 := InputBox('Начальное приближение', 'Введите начальное приближение', '');
  val(ib1, x0, code);
  if (x0 < 0.0) or (x0 > 1.0) or (code <> 0) then
    MessageDlg('Ошибка ввода', mtError, [mbOK], 0)
  else
  begin
    Newton(x0, eps, x, k);
    Memo1.Lines.Add('x1 = ' + FloatToStrF(X, FFFixed, 2, 7));
    Memo1.Lines.Add('Искомый корень: ' + FloatToStrF(X, FFFixed, 2, 7));
    Memo1.Lines.Add('Количество итераций: ' + IntToStr(k));
    Plot(0,1);
    Chart1LineSeries1.AddXY(x, x0);
    Chart1Lineseries1.AddXY(x,0);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  Chart1LineSeries1.Clear;
end;

end.
