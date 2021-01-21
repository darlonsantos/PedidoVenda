unit Controller.Base;

interface

uses
  Util.Enum, Model.Base;

type

  TBaseController = class
  private
    FModel: TBaseModel;
    procedure SetModel(const Value: TBaseModel);
  public
    procedure CreateView(AStatus : TAction; AModal: Boolean); virtual; abstract;
    procedure SetModelByView; virtual; abstract;
    procedure SetViewByModel; virtual; abstract;
    procedure Gravar; virtual; abstract;
    procedure Delete; virtual; abstract;
    property Model: TBaseModel read FModel write SetModel;

  end;

implementation

{ TBaseController }


{ TBaseController }

procedure TBaseController.SetModel(const Value: TBaseModel);
begin
  FModel := Value;
end;

end.
