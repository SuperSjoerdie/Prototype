unit Game;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, UGodfather, UMademan, ULawPerson, UPerson, UShop;

type

  { TForm1 }

  TForm1 = class(TForm)

    BttnMadeMan10: TButton;
    BttnMadeMan11: TButton;
    BttnMadeMan12: TButton;
    BttnMadeMan13: TButton;
    BttnMadeMan14: TButton;
    BttnMadeMan15: TButton;
    BttnMadeMan16: TButton;
    BttnMadeMan17: TButton;
    BttnMadeMan18: TButton;
    BttnMadeMan2: TButton;
    BttnMadeMan3: TButton;
    BttnMadeMan4: TButton;
    BttnMadeMan5: TButton;
    BttnMadeMan6: TButton;
    BttnMadeMan7: TButton;
    BttnMadeMan8: TButton;
    BttnMadeMan9: TButton;
    BttnShop1: TButton;
    BttnShop2: TButton;
    BttnShop3: TButton;
    BttnTakeOver: TButton;
    BttnBomb: TButton;
    BttnRaid: TButton;
    BttnMadeMan1: TButton;
    CBMan1: TCheckBox;
    CBMan10: TCheckBox;
    CBMan11: TCheckBox;
    CBMan12: TCheckBox;
    CBMan13: TCheckBox;
    CBMan14: TCheckBox;
    CBMan15: TCheckBox;
    CBMan16: TCheckBox;
    CBMan17: TCheckBox;
    CBMan18: TCheckBox;
    CBMan2: TCheckBox;
    CBMan3: TCheckBox;
    CBMan4: TCheckBox;
    CBMan5: TCheckBox;
    CBMan6: TCheckBox;
    CBMan7: TCheckBox;
    CBMan8: TCheckBox;
    CBMan9: TCheckBox;
    LblManSmarts: TLabel;
    LblManAge: TLabel;
    LblManAim: TLabel;
    LblManDamage: TLabel;
    LblManName: TLabel;
    LblShopGuarding: TLabel;
    LblShopIncome: TLabel;
    LblShopName: TLabel;
    LabelHeatMaxHeat: TLabel;
    LabelMoney: TLabel;
    RBMan1: TRadioButton;
    RBMan10: TRadioButton;
    RBMan11: TRadioButton;
    RBMan12: TRadioButton;
    RBMan13: TRadioButton;
    RBMan14: TRadioButton;
    RBMan15: TRadioButton;
    RBMan16: TRadioButton;
    RBMan17: TRadioButton;
    RBMan18: TRadioButton;
    RBMan2: TRadioButton;
    RBMan3: TRadioButton;
    RBMan4: TRadioButton;
    RBMan5: TRadioButton;
    RBMan6: TRadioButton;
    RBMan7: TRadioButton;
    RBMan8: TRadioButton;
    RBMan9: TRadioButton;
    Timer1: TTimer;


    procedure BttnBombClick(Sender: TObject);
    procedure BttnMadeMan10Click(Sender: TObject);
    procedure BttnMadeMan11Click(Sender: TObject);
    procedure BttnMadeMan12Click(Sender: TObject);
    procedure BttnMadeMan13Click(Sender: TObject);
    procedure BttnMadeMan14Click(Sender: TObject);
    procedure BttnMadeMan15Click(Sender: TObject);
    procedure BttnMadeMan16Click(Sender: TObject);
    procedure BttnMadeMan17Click(Sender: TObject);
    procedure BttnMadeMan18Click(Sender: TObject);
    procedure BttnMadeMan1Click(Sender: TObject);
    procedure BttnMadeMan2Click(Sender: TObject);
    procedure BttnMadeMan3Click(Sender: TObject);
    procedure BttnMadeMan4Click(Sender: TObject);
    procedure BttnMadeMan5Click(Sender: TObject);
    procedure BttnMadeMan6Click(Sender: TObject);
    procedure BttnMadeMan7Click(Sender: TObject);
    procedure BttnMadeMan8Click(Sender: TObject);
    procedure BttnMadeMan9Click(Sender: TObject);
    procedure BttnRaidClick(Sender: TObject);
    procedure BttnShop1Click(Sender: TObject);
    procedure BttnShop2Click(Sender: TObject);
    procedure BttnShop3Click(Sender: TObject);
    procedure BttnTakeOverClick(Sender: TObject);
 //   constructor Create(TheOwner: TComponent); override;
    procedure Create(Sender: TObject);
    destructor Destroy; override;
 //   procedure FormCreate(Sender: TObject);
    procedure handle;
    procedure Timer1Timer(Sender: TObject);

    procedure ShopScreenUpdate;

    procedure MadeManScreenUpdate;
    procedure MadeManButtonUpdate;


  private
    TargetedShop: TShop;
    TargetedShopID: Integer;

    TargetedMadeMan: TMadeMen;
    TargetedMadeManID: Integer;
    { private declarations }
  public
    SecondsHad: UInt64;
    { public declarations }
  end;

  type TListOfAllGodfathers = class(TList)
    constructor Create;
    destructor Destroy; override;
  end;

var

  Form1: TForm1;
  ListOfAllGodFathers: TList;

implementation

constructor TListOfAllGodfathers.Create;
begin
  Inherited Create;
end;

destructor TListOfAllGodfathers.Destroy;
begin
  Inherited Destroy;
end;

procedure TForm1.MadeManButtonUpdate;
begin
if Godfather.ListOfAllOwnedMadeMen.Count >= 1 then
begin
     BttnMadeMan1.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 2 then
begin
     BttnMadeMan2.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 3 then
begin
     BttnMadeMan3.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 4 then
begin
     BttnMadeMan4.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 5 then
begin
     BttnMadeMan5.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 6 then
begin
     BttnMadeMan6.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 7 then
begin
     BttnMadeMan7.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 8 then
begin
     BttnMadeMan8.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 9 then
begin
     BttnMadeMan9.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 10 then
begin
     BttnMadeMan10.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 11 then
begin
     BttnMadeMan11.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 12 then
begin
     BttnMadeMan12.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 13 then
begin
     BttnMadeMan13.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 14 then
begin
     BttnMadeMan14.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 15 then
begin
     BttnMadeMan15.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 16 then
begin
     BttnMadeMan16.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count >= 17 then
begin
     BttnMadeMan17.Visible:= True;
end;
if Godfather.ListOfAllOwnedMadeMen.Count = 18 then
begin
     BttnMadeMan18.Visible:= True;
end;

end;

procedure TForm1.MadeManScreenUpdate;
var
  i: Integer;
  p: Pointer;
begin
     for i := 0 to Godfather.ListOfAllOwnedMadeMen.count - 1 do
     begin
       p:= Godfather.ListOfAllOwnedMadeMen.Items[i];
       if TMadeMen(p).ID = TargetedMadeManID then
       begin
            LblManAge.Caption:= IntToStr(TMadeMen(p).Age);
            LblManAim.Caption:= IntToStr(TMadeMen(p).Aim);
            LblManDamage.Caption:= IntToStr(TMadeMen(p).Damage);
            LblManName.Caption:= TMadeMen(p).Name;
            LblManSmarts.Caption:= IntToStr(TMadeMen(p).Smarts);
       end;
     end;
    // LblManAge:= IntToStrTargetedMadeMan.Age;
end;

procedure TForm1.Create(Sender: TObject);
begin
  TargetedShopID:= 0;
     Shop.Create(1);
     Shop.Create(2);
     Shop.Create(3);

     Godfather.Create(1);
     Godfather.Create(2);
     Godfather.Create(3);
     Godfather.Create(4);
     Godfather.Create(5);

     NYPD.Create;
     NYPD.Create;
     NYPD.Create;
     Judge.Create;
     Judge.Create;
     Judge.Create;
     Judge.Create;
     Judge.Create;
     Agent.Create;
     Agent.Create;
end;

procedure TForm1.BttnShop1Click(Sender: TObject);
var
  i: Integer;
  p: Pointer;
begin
  TargetedShopID:= 1;
  for i:= 0 to ListOfAllShops.Count - 1 do
  begin
    P:= ListOfAllShops.Items[i];
    if TShop(p).ShopID = TargetedShopID then
    begin
      TargetedShop:= TShop(p);
      LblShopName.Caption:= TShop(p).Name;
      LblShopIncome.Caption:= IntToStr(TShop(p).Income);
      LblShopGuarding.Caption:= IntToStr(TShop(p).protection);
    end;

  end;
end;

procedure TForm1.BttnBombClick(Sender: TObject);
begin
  If TargetedShopID > 0 then
  begin
       Godfather.ShopTarget:= TargetedShop;
       Godfather.FireBomb;
  end;
end;


{  ---  MADEMEN BUTTONS ONCLICK  ---  }
procedure TForm1.BttnMadeMan10Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[9];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan11Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[10];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan12Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[11];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan13Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[12];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan14Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[13];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan15Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[14];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan16Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[15];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan17Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[16];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan18Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[17];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan1Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[0];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan2Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[1];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan3Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[2];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan4Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[3];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan5Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[4];
  TargetedMadeManID:= TMadeMen(p).ID;
end;

procedure TForm1.BttnMadeMan6Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[5];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan7Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[6];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan8Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[7];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnMadeMan9Click(Sender: TObject);
var
  p: pointer;
begin
  p:=Godfather.ListOfAllOwnedMadeMen.Items[8];
  TargetedMadeManID:= TMadeMen(p).ID;
  MadeManScreenUpdate;
end;

procedure TForm1.BttnRaidClick(Sender: TObject);
begin
  If TargetedShopID > 0 then
  begin
       Godfather.ShopTarget:= TargetedShop;
       Godfather.Raid;
  end;
end;

{  ///  MADE MEN BUTTONS ONCLICK  \\\  }

procedure TForm1.BttnShop2Click(Sender: TObject);
var
  i: Integer;
  p: Pointer;
begin
  TargetedShopID:= 2;
  for i:= 0 to ListOfAllShops.Count - 1 do
  begin
    P:= ListOfAllShops.Items[i];
    if TShop(p).ShopID = TargetedShopID then
    begin
      LblShopName.Caption:= TShop(p).Name;
      LblShopIncome.Caption:= IntToStr(TShop(p).Income);
      LblShopGuarding.Caption:= IntToStr(TShop(p).protection);
    end;

  end;
end;

procedure TForm1.BttnShop3Click(Sender: TObject);
var
  i: Integer;
  p: Pointer;
begin
  TargetedShopID:= 3;
  for i:= 0 to ListOfAllShops.Count - 1 do
  begin
    P:= ListOfAllShops.Items[i];
    if TShop(p).ShopID = TargetedShopID then
    begin
      LblShopName.Caption:= TShop(p).Name;
      LblShopIncome.Caption:= IntToStr(TShop(p).Income);
      LblShopGuarding.Caption:= IntToStr(TShop(p).protection);
    end;

  end;
end;

procedure TForm1.BttnTakeOverClick(Sender: TObject);
begin
  If TargetedShopID > 0 then
  begin
       Godfather.ShopTarget:= TargetedShop;
       Godfather.TakeOver;
  end;
end;

destructor TForm1.Destroy;
begin
  self.free;
end;

procedure TForm1.handle;
begin
     LabelMoney.Caption:= IntToStr(Godfather.Money);
     LabelHeatMaxHeat.Caption:= IntToStr(Godfather.Heat) + '/' + IntToStr(Godfather.MaxHeat);
end;

procedure TForm1.ShopScreenUpdate;
begin
     LblShopIncome.caption:= IntToStr(TargetedShop.Income);
     LblShopName.caption:= TargetedShop.Name;
     if TargetedShop.protection <= 3 then
     LblShopGuarding.Caption:= 'low'
     else
     if (TargetedShop.protection > 3) AND (TargetedShop.protection < 7) then
     LblShopGuarding.Caption:= 'medium'
     else
     LblShopGuarding.Caption:= 'High';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     Timer1.Enabled:= true;
     Inc(SecondsHad);
     Mademan.handle;
     NYPD.Handle;
     Judge.Handle;
     Agent.Handle;
     Shop.handle;
     Godfather.Handle;
     Person.Handle;
     Form1.Handle;
end;

{$R *.lfm}

end.

