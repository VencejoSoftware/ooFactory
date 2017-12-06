{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooControlClass.Factory;

interface

uses
  Classes, Controls,
  ooFactory.List;

type
  TControlClassFactory = class sealed(TFactoryList<TControlClass>)
  public
    function FindByClass(const ClassType: TClass): TControlClass;
    function CreateControl(const Owner: TComponent; const ClassType: TClass): TControl;
  end;

implementation

function TControlClassFactory.CreateControl(const Owner: TComponent; const ClassType: TClass): TControl;
var
  ControlClass: TControlClass;
begin
  Result := nil;
  ControlClass := FindByClass(ClassType);
  if Assigned(ControlClass) then
  begin
    Result := ControlClass.Create(Owner);
    if Owner is TWinControl then
      Result.Parent := TWinControl(Owner);
  end;
end;

function TControlClassFactory.FindByClass(const ClassType: TClass): TControlClass;
begin
  Result := Find(ClassType.ClassName);
end;

end.
