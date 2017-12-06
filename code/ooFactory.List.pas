{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFactory.List;

interface

uses
  SysUtils,
  Generics.Collections,
  ooFactory.Item.Intf;

type
  EFactoryList = class(Exception)
  end;

  TFactoryList<T> = class(TObject)
  strict private
  type
{$IFDEF FPC}
     IFactoryItemT = IFactoryItem<T>;
    _TFactoryList = TList<IFactoryItemT>;
{$ELSE}
    _TFactoryList = TList<IFactoryItem<T>>;
{$ENDIF}
  strict private
    _List: _TFactoryList;
  public
    function Add(Item: IFactoryItem<T>): Integer;
    function IndexOf(const Key: TFactoryKey): Integer;
    function Exists(const Key: TFactoryKey): Boolean;
    function Find(const Key: TFactoryKey): T;
    function Count: Integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

function TFactoryList<T>.IndexOf(const Key: TFactoryKey): Integer;
var
  i: Integer;
begin
  Result := - 1;
  for i := 0 to Pred(_List.Count) do
    if CompareText(Key, _List.Items[i].Key) = 0 then
    begin
      Result := i;
      Break;
    end;
end;

function TFactoryList<T>.Exists(const Key: TFactoryKey): Boolean;
begin
  Result := IndexOf(Key) <> - 1;
end;

function TFactoryList<T>.Add(Item: IFactoryItem<T>): Integer;
begin
  if Exists(Item.Key) then
    raise EFactoryList.Create(Format('Key class "%s" already exists!', [Item.Key]))
  else
    Result := _List.Add(Item);
end;

function TFactoryList<T>.Find(const Key: TFactoryKey): T;
var
  IndexFounded: Integer;
begin
  Result := default(T);
  IndexFounded := IndexOf(Key);
  if IndexFounded < 0 then
    raise EFactoryList.Create(Format('Key class "%s" not found!', [Key]))
  else
    Result := _List.Items[IndexFounded].ClassType;
end;

function TFactoryList<T>.Count: Integer;
begin
  Result := _List.Count;
end;

constructor TFactoryList<T>.Create;
begin
  _List := _TFactoryList.Create;
end;

destructor TFactoryList<T>.Destroy;
begin
  _List.Free;
  inherited;
end;

end.
