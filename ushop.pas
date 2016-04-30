unit UShop;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs, UMademan;
Type TShop = class TShop: TShop;
  Name: string;
  Income: integer;
  ShopID: Integer;
  Owner: Pointer;
  ShopIDsHad: Integer;

  protection: Integer;
  ProtectionPaid: boolean;

  Bombed: Boolean;
  SecondsBombedLeft: Integer;

  procedure GetTakenOver(Sender: Pointer; HenchMen: Array of TMadeMen; Target: TShop);
  //procedure GetBombed(Sender: TGodfather; HenchMen: Array of TMadeMen; Target: TShop);
  procedure GetRaided(Sender: Pointer; HenchMen: Array of TMadeMen; Target: TShop);
  procedure GetBombed(Sender: Pointer; HenchMan: TMadeMen; Target: TShop);

  constructor Create(ID: Integer);
  destructor Destroy; override;
  procedure handle;

  end;

Type TRacket = class(TShop)
  GoodID: Integer;

  constructor Create(ID: Integer);
  destructor Destroy; override;
  procedure handle;

  end;

Type TListOfAllShops = class(TList)
  constructor create;
  destructor Destroy; override;
end;

  var
    Shop: TShop;
    Racket: TRacket;
    ShopsHad: Integer;
    ListOfAllShops: TListOfAllShops;

implementation

uses UGodfather;

constructor TListOfAllShops.Create;
begin
     inherited create;
end;

destructor TListOfAllShops.Destroy;
begin
     inherited Destroy;
end;

{  ---  TSHOP  ---  }

Constructor TSHop.create(ID: Integer);
var
  p: Pointer;
begin
     Name:= 'McDonalds';
     Randomize;
     Income:= random(19) + 1;
     ShopID:= ShopsHad + 1;
     //OwnerID:= 6;
     protection:= random(3);
     ShopID:= ID;
     p:= Self;
     ListOfAllShops.Add(p);
end;

destructor TShop.Destroy;
begin
     self.free;
end;

procedure TShop.Handle;
var
  y: integer;
begin
     if bombed = false then
        begin
          Inc(TGodfather(Owner).Money, income);
        end;
     inc(y);
     if y > 300 then
     begin
       repeat
         begin
          if TGodfather(Owner).Money > (protection * 5) then
          begin
              ProtectionPaid:= true;
          end else
          begin
              ProtectionPaid:= False;
              Dec(Protection);
          end;
         end;
       until ProtectionPaid = true;
       Dec(TGodfather(Owner).Money, protection * 5);
       ProtectionPaid:= false;
       ShowMessage('Paid for shop protections worth $' + IntToStr(protection * 5));
     end;

     if Bombed = true then
     begin
       dec(SecondsBombedLeft);
       if SecondsBombedLeft = 0 then
       begin
         Bombed:= false;
       end;

     end;
end;

procedure TShop.GetTakenOver(Sender: Pointer; HenchMen: Array of TMadeMen; Target: TShop);
var
  i: Integer;
  TotalADamage: Integer;
  TotalAAim: Integer;
  TotalDDamage: Integer;
  TotalDAim: Integer;

  TotalAScore: Integer;
  TotalDScore: Integer;

  WinRatio: Integer;

  Outcome: Integer;
begin
     for i := low(HenchMen) to High(HenchMen) do
     Inc(TotalADamage, HenchMen[i].Damage * (1 + round(henchmen[i].GunLevel / 10)));
     Inc(TotalAAim, HenchMen[i].Aim * (1 + round(henchmen[i].GunLevel / 10)));

     TotalDDamage:= Target.protection * 3;
     TotalDAim:= Target.protection * 2;

     TotalAScore:= TotalAAim + TotalADamage;
     TotalDScore:= TotalDAim + TotalDDamage;

     WinRatio:= round((TotalAScore / TotalDScore)  * 100);
     randomize;
     Outcome:= random(99) + 1;
     if Outcome < WinRatio then
     begin
       Target.Owner:= Sender;
       Inc(TGodfather(Sender).Heat, 10);
       ShowMessage('Take over succeeded! You now own shop ' + Target.Name);
     end else
     for i := low(HenchMen) to High(HenchMen) do
     HenchMen[i].destroy;
     inc(TGodfather(Sender).Heat, 5);
     ShowMessage('Take over failed! You lost your men!');
end;

procedure TShop.GetBombed(Sender: Pointer; HenchMan: TMadeMen; Target: TShop);
var
  i: Integer;

  TotalAScore: Integer;
  TotalDScore: Integer;

  WinRatio: Integer;

  Outcome: Integer;
begin
     TotalAScore:= HenchMan.Smarts * (1 + round(HenchMan.Suitlevel / 10));
     TotalDScore:= Target.protection;

     WinRatio:= round((TotalAScore / TotalDScore)  * 100);
     randomize;
     Outcome:= random(99) + 1;
     if Outcome < WinRatio then
     begin
       Target.Bombed:= true;
       Target.SecondsBombedLeft:= 300;
       Inc(TGodfather(Sender).Heat, 20);
       ShowMessage('Bombing succeeded. Increase heat by 20 and shop ' + Target.Name + ' is now bombed for 300 seconds!');
     end else
     HenchMan.destroy;
     Inc(TGodfather(Sender).Heat, 10);
     ShowMessage('Bombin failed! Increase heat by 10!');

end;

procedure TShop.GetRaided(Sender: Pointer; HenchMen: Array of TMadeMen; Target: TShop);
var
  i: Integer;
  TotalADamage: Integer;
  TotalASmarts: Integer;
 // TotalAAim: Integer;
  TotalDDamage: Integer;
  TotalDSmarts: Integer;
  //TotalDAim: Integer;

  TotalAScore: Integer;
  TotalDScore: Integer;

  WinRatio: Integer;

  Outcome: Integer;
begin
     for i := low(HenchMen) to High(HenchMen) do
     Inc(TotalADamage, HenchMen[i].Damage * (1 + round(henchmen[i].GunLevel / 10)));
     //Inc(TotalAAim, HenchMen[i].Aim * (1 + round(henchmen[i].GunLevel / 10)));
     Inc(TotalASmarts, HenchMen[i].Smarts);

     TotalDDamage:= Target.protection * 3;
     TotalDSmarts:= Target.protection * 2;

     TotalAScore:= TotalASmarts + TotalADamage;
     TotalDScore:= TotalDSmarts + TotalDDamage;

     WinRatio:= round((TotalAScore / TotalDScore)  * 100);
     randomize;
     Outcome:= random(99) + 1;
     if Outcome < WinRatio then
     begin
       Inc(TGodfather(Sender).Money, Target.Income * 100);
       Target.Bombed:= true;
       Target.SecondsBombedLeft:= 100;
       Inc(TGodfather(Sender).Heat, 10);
       ShowMessage('You succeeded! Increasing heat by 10 and money by $' + IntToStr(Target.Income * 100));
     end else
     for i := low(HenchMen) to High(HenchMen) do
     HenchMen[i].destroy;
     Inc(TGodfather(Sender).Heat, 20);
end;

{procedure TShop.GetBombed(Sender: TGodfather; HenchMen: Array of TMadeMen; Target: TShop);
begin

end;}

{  ---  TRACKET  ---  }

Constructor TRacket.create(ID: Integer);
begin
     inherited create(ID);
     randomize;
     Income:= random(39) + 1;
     Name:= 'McSpek';
     protection:= random(4) + 11;
end;

destructor TRacket.Destroy;
begin
     inherited destroy;
end;

procedure TRacket.Handle;
begin
     Inherited handle;
end;

end.

