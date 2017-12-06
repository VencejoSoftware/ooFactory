{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,
  ooControlClass.Factory, ooControlClass.Item;

type
  TMainForm = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    ControlClassFactory: TControlClassFactory;
    LastTopPos: Integer;
  end;

var
  NewMainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Button1Click(Sender: TObject);
var
  LabelTmp: TLabel;

  procedure AlignControl(Control: TControl; const Left: Integer);
  begin
    Control.Left := Left;
    Control.Top := LastTopPos;
    Control.Height := 22;
    Control.Width := 100;
  end;

begin
  Inc(LastTopPos, 30);
  AlignControl(ControlClassFactory.CreateControl(Self, TButton), 10);
  AlignControl(ControlClassFactory.CreateControl(Self, TSpeedButton), 130);

  LabelTmp := TLabel(ControlClassFactory.CreateControl(Self, TLabel));
  AlignControl(LabelTmp, 240);
  LabelTmp.Caption := 'Test';
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  LastTopPos := 0;
  ControlClassFactory := TControlClassFactory.Create;
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  ControlClassFactory.Add(TControlClassItem.New(TSpeedButton));
  ControlClassFactory.Add(TControlClassItem.New(TLabel));
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ControlClassFactory.Free;
end;

end.
