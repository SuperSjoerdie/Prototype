unit Game;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, UGodfather, UMademan, ULawPerson, UPerson, UShop;

type

  { TForm1 }

  TForm1 = class(TForm)
    BttnShop1: TButton;
    BttnShop2: TButton;
    BttnShop3: TButton;
    BttnTakeOver: TButton;
    BttnBomb: TButton;
    BttnRaid: TButton;
    LblShopGuarding: TLabel;
    LblShopIncome: TLabel;
    LblShopName: TLabel;
    LabelHeatMaxHeat: TLabel;
    LabelMoney: TLabel;
    Timer1: TTimer;


    procedure BttnBombClick(Sender: TObject);
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


  private
    TargetedShop: TShop;
    TargetedShopID: Integer;
    { private declarations }
  public
    SecondsHad: UInt64;
    { public declarations }
  end;

var

  Form1: TForm1;

implementation

procedure TForm1.Create(Sender: TObject);
begin
  TargetedShopID:= 0;
     Shop.Create(1);
     Shop.Create(2);
     Shop.Create(3);

     Godfather.Create;

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

procedure TForm1.BttnRaidClick(Sender: TObject);
begin
  If TargetedShopID > 0 then
  begin
       Godfather.ShopTarget:= TargetedShop;
       Godfather.Raid;
  end;
end;

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

