{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFactory.ClassItem;

interface

uses
{$IFNDEF FPC AND (CompilerVersion > 21)}
  RTTI,
{$ENDIF}
  ooFactory.Item.Intf;

type
  TFactoryItem<TClassType> = class(TInterfacedObject, IFactoryItem<TClassType>)
  strict private
    _ClassType: TClassType;
  private
{$IFNDEF FPC AND (CompilerVersion > 21)}
    function GetClassName: string;
{$ENDIF}
  public
    function Key: TFactoryKey;
    function ClassType: TClassType;

    constructor Create(const ClassType: TClassType);

    class function New(const ClassType: TClassType): IFactoryItem<TClassType>;
  end;

implementation

{$IFNDEF FPC AND (CompilerVersion > 21)}
function TFactoryItem<TClassType>.GetClassName: string;
begin
  Result := TValue.From<TClassType>(_ClassType).AsClass.ClassName;
end;
{$ENDIF}

function TFactoryItem<TClassType>.ClassType: TClassType;
begin
  Result := _ClassType;
end;

function TFactoryItem<TClassType>.Key: TFactoryKey;
begin
{$IFNDEF FPC AND (CompilerVersion > 21)}
  Result := GetClassName;
{$ELSE}
  Result := TClass(_ClassType).ClassName;
{$ENDIF}
end;

constructor TFactoryItem<TClassType>.Create(const ClassType: TClassType);
begin
  _ClassType := ClassType;
end;

class function TFactoryItem<TClassType>.New(const ClassType: TClassType): IFactoryItem<TClassType>;
begin
  Result := Create(ClassType);
end;

end.
