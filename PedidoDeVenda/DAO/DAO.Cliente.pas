unit DAO.Cliente;

interface

uses
  DAO.Base, FireDAC.Comp.Client, Model.Base, Data.DB;

type

  TClienteDAO = class(TBaseDAO)
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
  System.SysUtils, Singleton.Connection, Model.Cliente;

{ TClienteDAO }


function TClienteDAO.AtualizaGrid(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM Cliente WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;


constructor TClienteDAO.Create;
begin
  Model := TClienteModel.Create;
end;

destructor TClienteDAO.Destroy;
begin

end;

function TClienteDAO.FindText(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM Cliente WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TClienteDAO.InsertText: string;
var
   SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('UPDATE OR INSERT INTO Cliente (');
    SB.Append('ID, RAZAOSOCIAL, NOMEFANTASIA, CNPJ, LOGRADOURO, ');
    SB.Append('NUMERO, BAIRRO, CIDADE, UF, CEP, EMAIL, TELEFONE )');
    SB.Append('VALUES (');
    SB.Append(':ID, :RAZAOSOCIAL, :NOMEFANTASIA, :CNPJ, :LOGRADOURO, ');
    SB.Append(':NUMERO, :BAIRRO, :CIDADE, :UF, :CEP, :EMAIL, :TELEFONE )');
    SB.Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;

end;

function TClienteDAO.Search(AText: string): string;
var
   SB: TStringBuilder;
   Value: integer;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM Cliente WHERE 1=1');
    if TryStrToInt(AText,Value) then
      SB.Append('AND ID =' + AText)
    else
    begin
      if Trim(AText) <> '' then
      begin
      SB.Append('AND RAZAOSOCIAL LIKE ''%');
      SB.Append(AText +'%''');
      end;
    end;

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TClienteDAO.SetModelByDataSet(DataSet: TDataSet) : TBaseModel;
var
  ModelUpdate: TClienteModel;
begin
  ModelUpdate := TClienteModel.Create;
  with ModelUpdate , DataSet do
  begin
    Id := FieldByName('ID').AsInteger;
    RazaoSocial := FieldByName('RazaoSocial').AsString;
    NomeFantasia := FieldByName('NomeFantasia').AsString;
    CNPJ := FieldByName('CNPJ').AsString;
    Logradouro := FieldByName('Logradouro').AsString;
    Numero := FieldByName('Numero').AsString;
    Bairro := FieldByName('Bairro').AsString;
    Cidade := FieldByName('Cidade').AsString;
    CEP := FieldByName('CEP').AsString;
    UF := FieldByName('UF').AsString;
    Email := FieldByName('Email').AsString;
    Telefone := FieldByName('Telefone').AsString;
  end;
  Result := ModelUpdate;
end;

procedure TClienteDAO.SetParameters(var FDQuery: TFDQuery;
  const AModel: TBaseModel);
begin

  with FDQuery, TClienteModel(AModel) do
  begin
    if AModel.ID <> 0 then
      ParamByName('ID').AsInteger := AModel.ID
    else
      ParamByName('ID').AsInteger := GetNewID(AModel);

    ParamByName('RazaoSocial').AsString := RazaoSocial;
    ParamByName('NomeFantasia').AsString := NomeFantasia;
    ParamByName('CNPJ').AsString := CNPJ;
    ParamByName('Logradouro').AsString := Logradouro;
    ParamByName('Numero').AsString := Numero;
    ParamByName('Bairro').AsString := Bairro;
    ParamByName('Cidade').AsString := Cidade;
    ParamByName('CEP').AsString := CEP;
    ParamByName('UF').AsString := UF;
    ParamByName('Email').AsString := Email;
    ParamByName('Telefone').AsString := Telefone;
  end;

end;

end.
