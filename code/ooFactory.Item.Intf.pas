{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooFactory.Item.Intf;

interface

type
  TFactoryKey = String;

  IFactoryItem<TClassType> = interface
    ['{47E95B9B-25E7-491B-895E-F75E2B297F76}']
    function Key: TFactoryKey;
    function ClassType: TClassType;
  end;

implementation

end.
