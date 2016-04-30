unit ULawPerson;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, UPerson;

Type TLawPerson = class(TPerson)
     loyalty: integer;

     NYPDbool: boolean;
     JudgeBool: boolean;
     AgentBool: boolean;

     BribedBy: Pointer;
     BribedByID: Integer;

     BribingPrice: Integer;
     function CalcBribingPrice: Integer;

     procedure GetBribed(Sender: Pointer; Bidding: Integer; Target: TLawPerson);

     destructor destroy; override;
     constructor create;


end;

Type  TNYPD = Class(TLawPerson)
      //Loyalty: Integer;


constructor Create;
destructor Destroy; override;
procedure handle;

end;

Type  TJudge = Class(TLawPerson)
      //Loyalty: Integer;


constructor Create;
destructor Destroy; override;
procedure handle;

end;

Type  TAgent = Class(TLawPerson)
      //Loyalty: Integer;


constructor Create;
destructor Destroy; override;
procedure handle;

end;

Type TListOfAllAgents = class(TList)
     constructor create;
     destructor Destroy; override;
end;

Type TListOfAllJudges = class(TList)
     constructor create;
     destructor Destroy; override;
end;

Type TListOfAllNYPD = class(TList)
     constructor create;
     destructor Destroy; override;
end;

  var
    NYPD: TNYPD;
    Agent: TAgent;
    Judge: TJudge;

    ListOfAllAgents: TListOfAllAgents;
    ListOfAllJudges: TListOfAllJudges;
    ListOfAllNYPD: TListOfAllNYPD;


implementation

uses UGodfather;

{  ---  LISTS  ---  }

constructor TListOfAllAgents.create;
begin
  inherited Create;
end;

destructor TListOfAllAgents.Destroy;
begin
  inherited Destroy;
end;

constructor TListOfAllJudges.create;
begin
  inherited Create;
end;

destructor TListOfAllJudges.Destroy;
begin
  inherited Destroy;
end;

constructor TListOfAllNYPD.create;
begin
  inherited Create;
end;

destructor TListOfAllNYPD.Destroy;
begin
  inherited Destroy;
end;

{  ---  LAW PERSON  ---  }
constructor TLawPerson.Create;
begin
  inherited create;

  AgentBool:= false;
  NYPDbool:= false;
  JudgeBool:= false;

  randomize;
  Loyalty:= random(9) + 1;
end;

destructor TLawPerson.destroy;
begin
  inherited Destroy;
end;

function TLawPerson.CalcBribingPrice: Integer;
begin
  result:= Loyalty * 100;
end;

procedure TLawPerson.GetBribed(Sender: Pointer; Bidding: Integer; Target: TLawPerson);
begin
  If Bidding > Target.BribingPrice then
  begin
    //Target.BribedBy:= TGodfather(Sender);
    Target.BribedByID:= TGodfather(Sender).ID;
    TGodfather(Sender).CheckForNYPD;
    TGodfather(Sender).CheckForJudges;
    TGodfather(Sender).CheckForAgents;
    Target.loyalty:= round(Bidding / 100);
    Target.BribingPrice:= Target.CalcBribingPrice;
  end else
  inc(TGodfather(Sender).Heat, 10);
end;

{  ---  Agent  ---  }
constructor TAgent.Create;
begin
  inherited create;
  AgentBool:= true;
  BribingPrice:= CalcBribingPrice;
end;

destructor TAgent.Destroy;
begin
  inherited destroy;
end;

procedure TAgent.handle;
begin

end;

{  ---  NYPD  ---  }
constructor TNYPD.Create;
begin
  inherited create;
  NYPDbool:= true;
  loyalty:= round(loyalty * 1.2);
  protection:= round(protection * 1.5);
  BribingPrice:= CalcBribingPrice;
end;

destructor TNYPD.Destroy;
begin
  inherited destroy;
end;

procedure TNYPD.handle;
begin

end;

{  ---  Judge  ---  }
constructor TJudge.Create;
begin
  inherited create;
  JudgeBool:= true;
  loyalty:= round(loyalty * 1.5);
  protection:= round(protection * 1.2);
  BribingPrice:= CalcBribingPrice;
end;

destructor TJudge.Destroy;
begin
  inherited destroy;
end;

procedure TJudge.handle;
begin

end;

end.

