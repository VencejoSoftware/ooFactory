{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooControlClass.Item;

interface

uses
  Controls,
  ooFactory.ClassItem;

type
  TControlClassItem = class sealed(TFactoryItem<TControlClass>)

  end;

implementation

end.
