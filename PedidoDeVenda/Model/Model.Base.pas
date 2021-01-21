unit Model.Base;

interface

type

  TBaseModel = class
  private
    FID: Integer;
    FTable: string;
    FGenerator: string;
    FDataAlteracao: TDateTime;
    FDataEmissao: TDateTime;
    procedure SetID(const Value: Integer);
    procedure SetGenerator(const Value: string);
    procedure SetTable(const Value: string);
    procedure SetDataAlteracao(const Value: TDateTime);
    procedure SetDataEmissao(const Value: TDateTime);
    public
      property ID: Integer read FID write SetID;
      property Table: string read FTable write SetTable;
      property Generator: string read FGenerator write SetGenerator;
      property DataEmissao: TDateTime read FDataEmissao write SetDataEmissao;
      property DataAlteracao: TDateTime read FDataAlteracao write SetDataAlteracao;
  end;

implementation

{ TBaseModel }

procedure TBaseModel.SetDataAlteracao(const Value: TDateTime);
begin
  FDataAlteracao := Value;
end;

procedure TBaseModel.SetDataEmissao(const Value: TDateTime);
begin
  FDataEmissao := Value;
end;

procedure TBaseModel.SetGenerator(const Value: string);
begin
  FGenerator := Value;
end;

procedure TBaseModel.SetID(const Value: Integer);
begin
  FID := Value;
end;

procedure TBaseModel.SetTable(const Value: string);
begin
  FTable := Value;
end;

end.
