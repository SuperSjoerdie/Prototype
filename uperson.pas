unit UPerson;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Type TPerson = class TPerson: TPerson;
  protection: Integer;
  Name: string;

  constructor Create;
  destructor Destroy; override;
  procedure handle;

  end;

  var
    Person: TPerson;

implementation

Constructor TPerson.create;
begin
     Name:= 'Donald Duck';
     randomize;
     protection:= random(9) + 1;
end;

destructor TPerson.Destroy;
begin
     self.free;
end;

procedure TPerson.Handle;
begin

end;

end.

