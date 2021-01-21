unit DAO.Produto;

interface

uses
  DAO.Base, Model.Produto, FireDAC.Comp.Client, Model.Base, Data.DB;

type

  TProdutoDAO = class(TBaseDAO)
    public
    constructor Create; overload;
    destructor Destroy; overload;
    procedure SetParameters(var FDQuery: TFDQuery; const AModel: TBaseModel); override;
    function InsertText : string; override;
    function AtualizaGrid(AID: Integer): string; override;
    function FindText(AID: Integer) : string; override;
    function SetModelByDataSet(DataSet: TDataSet) : TBaseModel; override;
    function Search(AText: string): string; override;



  end;

implementation

uses
  System.SysUtils, Singleton.Connection;

{ TProdutoDAO }


function TProdutoDAO.AtualizaGrid(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM Produto WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;


constructor TProdutoDAO.Create;
begin
  Model := TProdutoModel.Create;
end;

destructor TProdutoDAO.Destroy;
begin

end;

function TProdutoDAO.FindText(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM Produto WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TProdutoDAO.InsertText: string;
var
   SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('UPDATE OR INSERT INTO PRODUTO (');
    SB.Append('ID, DESCRICAO, CUSTO, VALORVENDA)');
    SB.Append('VALUES (');
    SB.Append(':ID, :DESCRICAO, :CUSTO, :VALORVENDA)');
    SB.Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;

end;

function TProdutoDAO.Search(AText: string): string;
var
   SB: TStringBuilder;
   Value: integer;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM PRODUTO WHERE 1=1 ');
    if TryStrToInt(AText,Value) then
      SB.Append('AND ID =' + AText)
    else
    begin
      if Trim(AText) <> '' then
      begin
      SB.Append('AND DESCRICAO LIKE ''%');
      SB.Append(AText +'%''');
      end;
    end;

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TProdutoDAO.SetModelByDataSet(DataSet: TDataSet) : TBaseModel;
var
  ModelUpdate: TProdutoModel;
begin
  ModelUpdate := TProdutoModel.Create;
  with ModelUpdate , DataSet do
  begin
    Id := FieldByName('ID').AsInteger;
    Descricao := FieldByName('Descricao').AsString;
    Custo := FieldByName('Custo').AsFloat;
    ValorVenda := FieldByName('ValorVenda').AsFloat;
  end;
  Result := ModelUpdate;
end;

procedure TProdutoDAO.SetParameters(var FDQuery: TFDQuery;
  const AModel: TBaseModel);
begin

  with FDQuery, TProdutoModel(AModel) do
  begin
    if AModel.ID <> 0 then
      ParamByName('ID').AsInteger := AModel.ID
    else
      ParamByName('ID').AsInteger := GetNewID(AModel);

    ParamByName('Descricao').AsString := Descricao;
    ParamByName('Custo').AsFloat := Custo;
    ParamByName('ValorVenda').AsFloat := ValorVenda;
  end;

end;

end.
