unit UGodfather;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, UPerson, UMadeMan, ULawPerson, UShop;

{  ---  LISTS  ---  }
Type TListOfAllOwnedMadeMen = class(TList)
constructor create;
destructor Destroy; override;

end;

Type TListOfAgents = class(TList)
constructor Create;
destructor Destroy; Override;
end;

Type TListOfJudges = class(TList)
constructor Create;
Destructor Destroy;
end;

Type

{ TListOfNYPD }

 TListOfNYPD = class(TList)
constructor Create;
destructor Destroy; Override;
end;

Type

{ TListOfGodfathers }

 TListOfGodfathers = class(TList)
constructor Create;
 destructor Destroy; override;
end;

type

{ TGodfather }

 TGodfather = class(TPerson)
     Money: Integer;
     ID: Integer;
     Heat: Integer;
     MaxHeat: Integer;

     PaydaySecondsLeft: Integer;

     RankUpTarget: TMadeMen;
     ShopTarget: TShop;

     ListOfAllOwnedMadeMen: TListOfAllOwnedMadeMen;
     ListOfJudges: TListOfJudges;
     ListOfAgents: TListOfAgents;
     ListOfNYPD: TListOfNYPD;

     Infiltrator: TMadeMen;
     Assassin: TMadeMen;
     MenOnJob: Array of TMadeMen;

    // BiddingToBribe: Integer;
     BribingBidding: Integer;
     BribingTarget: TLawPerson;
    // BribeTarget: TLawPerson;

     AssassinationTarget: TPerson;

     AmmountOfAgents: Integer;
     AmmountOfJudges: Integer;
     AmmountOfNYPD: Integer;

     FamilyGuarding: Integer;

     AOButtonMen: Integer;
     AOSoldiers: Integer;
     AOCapo: Integer;
     AOUnderboss: Integer;

     Procedure Busted; //Done

{  ---  SHOP ACTIONS  ---  }
     procedure TakeOver; //Done
     procedure FireBomb;  //Done
     procedure Raid;  //Done
    // procedure Infiltrate;

{  ---  PERSON ACTIONS  ---  }
   procedure assassination(Sender: TGodfather; ATarget: TPerson); //done
   procedure bribe; //done

   procedure CheckForJudges; //done
   procedure CheckForNYPD;         //done
   procedure CheckForAgents;             //done

{  ---  FAMILY ACTIONS  ---  }
   procedure PayMen;  //Done
   procedure HireMen;
   procedure RankUpMen;
   procedure CheckForMen;  //Done



     constructor Create(SendID: Integer);
     destructor destroy; override;
     procedure handle;

     Class procedure CreateNew(NewID: Integer);



end;


       var
        Godfather: TGodfather;
        ListOfGodfathers: TListOfGodfathers;
        //BiddingToBribe: Integer;

        //AssassinationTarget: TPerson;
        //Assassin: TPerson;

implementation

uses Game;

 { TListOfGodfathers }

  constructor TListOfGodfathers.Create;
 begin
   inherited Create;
 end;

  destructor TListOfGodfathers.Destroy;
begin
  inherited Destroy;
end;

//var
 //RankUpTarget: TMadeMen;
 //ShopTarget: TShop;
 //MenOnJob: Array of TMadeMen;
 //Infiltrator: TMadeMen;
 //BribeTarget: TLawPerson;
 //AllHenchMen: array of TMadeMen;

 //Assassin: TMadeMen;

 //BribingTarget: TLawPerson;
 //BribingBidding: Integer;

{  ---  LISTS  ---  }

 constructor TListOfAllOwnedMadeMen.Create;
 begin
      inherited create;
 end;

 destructor TListOfAllOwnedMadeMen.destroy;
 begin
      Inherited destroy;
 end;

constructor TListOfAgents.create;
begin
     inherited create;
end;

destructor TListOfAgents.Destroy;
begin
     inherited destroy;
end;

constructor TListOfJudges.create;
begin
     inherited create;
end;

destructor TListOfJudges.Destroy;
begin
     inherited destroy;
end;

constructor TListOfNYPD.Create;
begin
     inherited create;
end;

destructor TListOfNYPD.Destroy;
begin
     inherited Destroy;
end;

{  ---  TGODFATHER  ---  }
constructor TGodfather.Create(SendID: Integer);
begin
  inherited create;
  Money:= 500;
  MaxHeat:= 50;
  Heat:= 0;
  PaydaySecondsLeft:= 300;
  AOButtonMen:= 2;
  ID:= SendID;

  //ListOfAllGodFathers.Add(self);

  Tmademen.create(Godfather);
  Tmademen.create(Godfather);
end;

destructor TGodfather.destroy;
begin
  inherited Destroy;
end;

procedure TGodfather.handle;
begin
     if heat> MaxHeat then
     begin
       Godfather.Busted;
     end;
     dec(PaydaySecondsLeft);
     if PaydaySecondsLeft < 1 then
     begin
       Godfather.PayMen;
       inc(PaydaySecondsLeft, 300);
     end;

end;

class procedure TGodfather.CreateNew(NewID: Integer);
var
 p: TGodfather;
begin
  P:= TGodfather.Create(NewID);
  ListOfAllGodFathers.Add(p);
end;

procedure TGodfather.Busted;
var
 i: integer;
 p: pointer;
 y: integer;
begin
     randomize;
     y:= random(ListOfAllOwnedMadeMen.Count + 1) + 1;
     for i := 0 to (ListOfAllOwnedMadeMen.Count - 1) do
     if i = y then
     begin
       p:= ListOfAllOwnedMadeMen.Items[i];
       TMadeMen(p).Busted:= true;
       TMadeMen(p).BustedSecondsLeft:= 300;
     end;

end;

procedure TGodfather.CheckForAgents;
var
 i: Integer;
 p: pointer;
 a: pointer;
 y: Integer;
begin
for i:= 0 to ListOfAllAgents.Count - 1 do
begin
     p:= ListOfAllAgents[i];
     y:= TAgent(p).BribedByID;
     if y = Self.ID then
     begin
       ListOfAgents.Add(TAgent(p));
     end;
end;

end;

procedure TGodfather.CheckForJudges;
var
 i: Integer;
 p: pointer;
 a: pointer;
 y: Integer;
begin
for i:= 0 to ListOfAllJudges.Count - 1 do
begin
     p:= ListOfAllJudges[i];
     y:= TJudge(p).BribedByID;
     if y = Self.ID then
     begin
       ListOfJudges.Add(TJudge(p));
     end;
end;

end;

procedure TGodfather.CheckForNYPD;
var
 i: Integer;
 p: pointer;
 a: pointer;
 y: Integer;
begin
for i:= 0 to ListOfAllNYPD.Count - 1 do
begin
     p:= ListOfAllNYPD[i];
     y:= TNYPD(p).BribedByID;
     if y = Self.ID then
     begin
       ListOfNYPD.Add(TNYPD(p));
     end;
end;

end;

{  ---  SHOP ACTIONS  ---  }
procedure TGodfather.TakeOver;
begin
     if ShopTarget.Bombed = false then;
     ShopTarget.GetTakenOver(self, MenOnJob, ShopTarget);
end;

{procedure TGodfather.FireBomb;
begin
     if ShopTarget.Bombed = false then;
     ShopTarget.GetBombed(self, MenOnJob, ShopTarget);
end;  }

procedure TGodfather.Raid;
begin
     if ShopTarget.Bombed = false then;
     ShopTarget.GetRaided(self, MenOnJob, ShopTarget);
end;

procedure TGodfather.FireBomb;
begin
     if ShopTarget.Bombed = false then
     ShopTarget.GetBombed(self, Infiltrator, ShopTarget);
end;

{  ---  PERSON ACTIONS  ---  }
procedure TGodfather.bribe;
begin
     BribingTarget.GetBribed(Self, BribingBidding, BribingTarget);
end;

procedure TGodfather.assassination(Sender: TGodfather; ATarget: TPerson);
var
 ATotalDamage, ATotalAim, ATotalSmarts, ATotalScore: Integer;
 DTotalScore: Integer;
begin
    ATotalDamage:= Sender.Assassin.Damage;
    ATotalAim:= Sender.Assassin.Aim;
    ATotalSmarts:= Sender.Assassin.Smarts;
    AtotalScore:= ATotalDamage + ATotalAim + ATotalSmarts;

    DTotalScore:= ATarget.protection * 9;
end;

{  ---  FAMILY ACTIONS  ---  }
procedure TGodfather.PayMen;
var
 totalprice: Integer;
begin
     //totalprice:= (AOButtonMen * 100) + (AOSoldiers * 200) + (AOCapo * 300) + (AOUnderboss * 500);
     TotalPrice:= ListOfAllOwnedMadeMen.count - 1;
     dec(Money, totalprice);
end;

procedure TGodfather.HireMen;
var
 i: Integer;
 y: integer;
 a: Integer;
 p: Pointer;
begin
     if money > 500 then
     begin
       for y:= 0 to ListOfAllOwnedMadeMen.Count - 1 do
       begin
       p:= ListOfAllOwnedMadeMen.Items[y];
       If Tmademen(p).Rank = 1 then
       begin
         inc(a);
         if a < 5 then
         begin
           dec(Money, 500);
           mademan.GetHired(Godfather);
           Inc(AOButtonMen);
           CheckForMen;
         end else
         begin
         ShowMessage('You already have 5 buttonmen. Either rank one up or fire him!')
         end;
       end;

       end;
       end else
       begin
       ShowMessage('You need to pay $500 in order to do that!');
       end;
end;

procedure TGodfather.RankUpMen;
begin
     RankUpTarget.RankUpCheck(RankUpTarget);
end;

procedure TGodfather.CheckForMen;
var
 i: integer;
 p: Pointer;
 GF: Pointer;
 x: Integer;
begin
     for i := 0 to (ListOfAllMadeMen.Count - 1) do
     begin
     p:= ListOfAllMadeMen.Items[i];
     GF:= TMadeMen(p).Boss;
     if TGodfather(GF).ID = Self.ID then
     begin
      // x:= ListOfAllOwnedMadeMen.Count - 1;
       ListOfAllOwnedMadeMen.Add(p);
     end;
     end;
end;

end.

