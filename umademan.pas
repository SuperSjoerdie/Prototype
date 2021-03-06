unit UMademan;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UPerson;

Type

{ TMadeMen }

 TMadeMen = class(TPerson)
     Damage: Integer;
     GunLevel: Integer;
     SuitLevel: Integer;
     Aim: Integer;
     Smarts: Integer;
     Respect: Integer;
     Rank: Integer;
     Costs: Integer;

     Boss: Pointer;
     BossID: Integer;

     ID: Integer;
     IDHad: Integer;

     maxDamage: Integer;
     MaxGunLevel: Integer;
     MaxSuitLevel: Integer;
     MaxAim: Integer;
     MaxSmarts: Integer;
     MaxRespect: Integer;

     AllMadeMen: array of TMadeMen;

     AmmountOfButtonMen: integer;
     AmmountOfSoldiers: integer;
     AmmountOfCapo: integer;
     AmmountOfUnderboss: integer;

     available: boolean;
     Busted: Boolean;
     BustedSecondsLeft: Integer;

     destructor destroy; override;
     constructor create (Sender: Pointer);
     procedure handle;

     class procedure CreateNew(Sender: pointer);

     procedure RankUp(Target: TMadeMen);
     procedure RankUpCheck(Target: TMadeMen);

     procedure GetHired (Sender: Pointer);

end;

type TListOfAllMadeMen = Class(TList)
     constructor Create;
     destructor Destroy; override;
end;

  var
    mademan: TMadeMen;
    ListOfAllMadeMen: TListOfAllMadeMen;
    MadeMenIDHad: Integer;

implementation

uses UGodfather;

constructor TListOfAllMadeMen.Create;
begin
  inherited Create;
end;

destructor TListOfAllMadeMen.Destroy;
begin
  inherited Destroy;
end;

constructor TMadeMen.create(Sender: Pointer);
begin
  inherited create;
  randomize;
  Damage:= random(9) + 1;
  Gunlevel:= 1;
  SuitLevel:= 1;
  Aim:= random(9) + 1;
  Smarts:= random(9) + 1;
  respect:= 1;
  Rank:= 1;
  Costs:= 100;

  BustedSecondsLeft:= 0;

  ID:= MadeMenIDHad + 1;
  Inc(MadeMenIDHad);

  available:= true;

  maxDamage:= 20;
  MaxGunLevel:= 3;
  MaxSuitLevel:= 3;
  MaxAim:= 20;
  MaxSmarts:= 20;
  MaxRespect:= 10;

  BossID:= TGodfather(Sender).ID;

  if damage + Aim + Smarts < 5 then
  inc(Smarts);
  Inc(Damage);
end;

destructor TMadeMen.destroy;
begin
  Self.Free;
end;

procedure TMadeMen.handle;
begin
     if BustedSecondsLeft > 0 then
     begin
     Dec(BustedSecondsLeft);
     end;
     if bustedSecondsLeft = 0 then
     begin
     Busted := False;
     end;
end;

class procedure TMadeMen.CreateNew(Sender: Pointer);
var
p: TMadeMen;
begin
     p:= TMadeMen.create(Sender);
     ListOfAllMadeMen.Add(p);
end;

procedure TMadeMen.GetHired(Sender: Pointer);
var
p: TMadeMen;
begin
  inc(AmmountOfButtonMen);
  inc(TGodfather(Sender).AOButtonMen);
  P:= Tmademen.create(Sender);
  ListOfAllMadeMen.Add(p);
end;

procedure TMadeMen.RankUpCheck(Target: TMadeMen);
var
  p: pointer;
begin
  if rank = 1 then
  begin
    if AmmountOfSoldiers < 9 then
    begin
      inc(AmmountOfSoldiers);
      p:= Target.Boss;
      Inc(TGodfather(p).AOSoldiers);
      Dec(TGodfather(p).AOButtonMen);
      Target.MaxSuitLevel:= 5;
      Target.MaxGunLevel:= 5;
      MadeMan.Rankup(Target);
      Inc(Rank);
    end;
  end else
  if rank = 2 then
  begin
    if AmmountOfCapo < 3 then
    begin
      inc(AmmountOfCapo);
      Inc(Rank);
      p:= Target.Boss;
      inc(TGodfather(p).AOCapo);
      dec(TGodfather(p).AOSoldiers);
      mademan.Rankup(Target);
    end;
  end else
  if rank = 3 then
  begin
    if AmmountOfUnderboss < 1 then
    begin
      p:= Target.Boss;
      Inc(Rank);
      inc(AmmountOfUnderboss);
      inc(TGodfather(p).AOUnderboss);
      dec(TGodfather(p).AOCapo);
      MadeMan.Rankup(Target);
      Inc(Target.MaxRespect, 5);
      Inc(Target.Costs, 100);
    end;
  end;
end;

procedure TMadeMen.RankUp(Target: TMadeMen);
begin
  inc(Target.MaxAim, 10);
  Inc(Target.maxDamage, 10);
  Inc(Target.MaxSmarts, 10);
  Inc(Target.MaxRespect, 5);
  Inc(Target.Costs, 100);
end;

end.

