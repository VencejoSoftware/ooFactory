{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFactory_test;

interface

uses
  SysUtils,
  StdCtrls, Controls, Forms,
  ooFactory.List,
  ooControlClass.Factory, ooControlClass.Item,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TFactoryTest = class(TTestCase)
  private
    ControlClassFactory: TControlClassFactory;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
    procedure TestAddRepeated;
    procedure TestIndexOf;
    procedure TestExists;
    procedure TestFind;
    procedure TestFindError;
    procedure TestRegisteredClass;
    procedure TestFindByClass;
    procedure TestCreateControl;
  end;

implementation

procedure TFactoryTest.TestExists;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  CheckTrue(ControlClassFactory.Exists(TButton.ClassName));
  CheckFalse(ControlClassFactory.Exists(TLabel.ClassName));
end;

procedure TFactoryTest.TestFind;
var
  ControlClass: TControlClass;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  ControlClass := ControlClassFactory.Find(TButton.ClassName);
  CheckTrue(Assigned(ControlClass));
end;

procedure TFactoryTest.TestFindByClass;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  CheckTrue(Assigned(ControlClassFactory.FindByClass(TButton)));
end;

procedure TFactoryTest.TestFindError;
var
  HasError: Boolean;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  HasError := False;
  try
    ControlClassFactory.Find(TLabel.ClassName);
  except
    on E: EFactoryList do
      HasError := True;
  end;
  CheckTrue(HasError);
end;

procedure TFactoryTest.TestIndexOf;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  ControlClassFactory.Add(TControlClassItem.New(TLabel));
  CheckEquals(0, ControlClassFactory.IndexOf(TButton.ClassName));
  CheckEquals(1, ControlClassFactory.IndexOf(TLabel.ClassName));
  CheckEquals( - 1, ControlClassFactory.IndexOf(TListBox.ClassName));
end;

procedure TFactoryTest.TestRegisteredClass;
var
  ControlClass: TControlClass;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  ControlClass := ControlClassFactory.Find(TButton.ClassName);
  CheckTrue(ControlClass = TButton);
end;

procedure TFactoryTest.TestAdd;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  CheckEquals(1, ControlClassFactory.Count);
end;

procedure TFactoryTest.TestAddRepeated;
var
  HasError: Boolean;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  HasError := False;
  try
    ControlClassFactory.Add(TControlClassItem.New(TButton));
  except
    on E: EFactoryList do
      HasError := True;
  end;
  CheckTrue(HasError);
  CheckEquals(1, ControlClassFactory.Count);
end;

procedure TFactoryTest.TestCreateControl;
var
  Control: TControl;
begin
  ControlClassFactory.Add(TControlClassItem.New(TButton));
  Control := ControlClassFactory.CreateControl(Application, TButton);
  CheckTrue(Assigned(Control));
  CheckTrue(Control.ClassType = TButton);
  CheckTrue(Control.Owner = Application);
end;

procedure TFactoryTest.SetUp;
begin
  inherited;
  ControlClassFactory := TControlClassFactory.Create;
end;

procedure TFactoryTest.TearDown;
begin
  inherited;
  ControlClassFactory.Free;
end;

initialization

RegisterTest(TFactoryTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
