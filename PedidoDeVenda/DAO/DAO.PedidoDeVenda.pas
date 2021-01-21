unit DAO.PedidoDeVenda;

interface

uses
  DAO.Base, FireDAC.Comp.Client, Model.Base, Data.DB, Model.PedidoDeVenda,
  System.Generics.Collections;

type

  TPedidoDeVendaDAO = class(TBaseDAO)
    public
    constructor Create; overload;
    destructor Destroy; overload;
    procedure SetParameters(var FDQuery: TFDQuery; const AModel: TBaseModel); override;
    function InsertText : string; override;
    function InsertTextItens : string;
    function AtualizaGrid(AID: Integer): string; override;
    function FindText(AID: Integer) : string; override;
    function SetModelByDataSet(DataSet: TDataSet) : TBaseModel; override;
    function Search(AText: string): string; override;
    procedure GravarItens(AModel : TPedidoDeVendaModel);
    procedure DeleteItens(AModel : TPedidoDeVendaModel);
    function SetModelItensByDataSet(AModel :TBaseModel) : TObjectList<TPedidoDeVendaItensModel>;

  end;

implementation

uses
  System.SysUtils, Singleton.Connection, Model.Cliente,
  Vcl.Forms;

{ TPedidoDeVendaDAO }


function TPedidoDeVendaDAO.AtualizaGrid(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM PedidoDeVenda WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;


constructor TPedidoDeVendaDAO.Create;
begin
  Model := TClienteModel.Create;
end;

procedure TPedidoDeVendaDAO.DeleteItens(AModel: TPedidoDeVendaModel);
var
  FDQuery: TFDQuery;
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    FDQuery := TFDQuery.Create(nil);
    FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
    SB.Append('DELETE FROM PedidoDeVendaItens Where IDPEDIDO ='+IntToStr(AModel.ID)) ;
    FDQuery.Close;
    FDQuery.SQL.Text := SB.ToString;
    FDQuery.ExecSQL();
  finally
    FreeAndNil(FDQuery);
    FreeAndNil(SB);
  end;
end;

destructor TPedidoDeVendaDAO.Destroy;
begin

end;

function TPedidoDeVendaDAO.FindText(AID: Integer): string;
var
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM PedidoDeVenda WHERE ID = '+ IntToStr(AID));
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

procedure TPedidoDeVendaDAO.GravarItens(AModel : TPedidoDeVendaModel);
var
  I: Integer;
  ItemList: TPedidoDeVendaItensModel;
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;

    DeleteItens(AModel);

    FDQuery.Close;
    FDQuery.SQL.Text := InsertTextItens;
    FDQuery.Params.ArraySize := TPedidoDeVendaModel(AModel).Itens.Count;

    I := 0;
    for ItemList in TPedidoDeVendaModel(AModel).Itens do
    begin
      FDQuery.ParamByName('ID').AsIntegers[I] := GetNewID(ItemList);
      FDQuery.ParamByName('IDPedido').AsIntegers[I] := AModel.ID;
      FDQuery.ParamByName('IDProduto').AsIntegers[I] := ItemList.IDProduto;
      FDQuery.ParamByName('NomeProduto').AsStrings[I] := ItemList.NomeProduto;
      FDQuery.ParamByName('ValorUnitario').AsFloats[I] := ItemList.ValorUnitario;
      FDQuery.ParamByName('CustoUnitario').AsFloats[I] := ItemList.CustoUnitario;
      FDQuery.ParamByName('Quantidade').AsFloats[I] := ItemList.Quantidade;
      FDQuery.ParamByName('ValorTotal').AsFloats[I] := ItemList.ValorTotal;
      FDQuery.ParamByName('Sequencia').AsIntegers[I] := I;
      Inc(I);
    end;

    FDQuery.Execute(TPedidoDeVendaModel(AModel).Itens.Count, 0);
  finally
    FreeAndNil(FDQuery);
  end;

end;

function TPedidoDeVendaDAO.InsertText: string;
var
   SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('UPDATE OR INSERT INTO PedidoDeVenda (');
    SB.Append('ID, IDCLIENTE, NOMECLIENTE, VALORTOTAL)');
    SB.Append('VALUES (');
    SB.Append(':ID, :IDCLIENTE, :NOMECLIENTE, :VALORTOTAL)');
    SB.Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;

end;

function TPedidoDeVendaDAO.InsertTextItens: string;
var
   SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('UPDATE OR INSERT INTO PedidoDeVendaItens (');
    SB.Append('ID, IDPEDIDO, IDPRODUTO, NOMEPRODUTO, ValorUnitario, CustoUnitario, ValorTotal, Quantidade, Sequencia )');
    SB.Append('VALUES (');
    SB.Append(':ID, :IDPEDIDO, :IDPRODUTO, :NOMEPRODUTO, :ValorUnitario, :CustoUnitario, :ValorTotal, :Quantidade, :Sequencia )');
    SB.Append('MATCHING (ID) RETURNING ID');
    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;

end;

function TPedidoDeVendaDAO.Search(AText: string): string;
var
   SB: TStringBuilder;
   Value: integer;
begin
  try
    SB := TStringBuilder.Create;
    SB.Append('SELECT * FROM PedidoDeVenda WHERE 1=1');
    if TryStrToInt(AText,Value) then
      SB.Append('AND ID =' + AText)
    else
    begin
      SB.Append('AND NomeCliente LIKE ''%');
      SB.Append(AText +'%''');
    end;

    Result := SB.ToString;
  finally
    FreeAndNil(SB);
  end;
end;

function TPedidoDeVendaDAO.SetModelByDataSet(DataSet: TDataSet) : TBaseModel;
var
  ModelUpdate: TPedidoDeVendaModel;
begin
  ModelUpdate := TPedidoDeVendaModel.Create;
  with ModelUpdate , DataSet do
  begin
    Id := FieldByName('ID').AsInteger;
    IDCliente := FieldByName('IDCliente').AsInteger;
    NomeCliente := FieldByName('NomeCliente').AsString;
    ValorTotal := FieldByName('ValorTotal').AsFloat;
    Itens := SetModelItensByDataSet(ModelUpdate);
  end;

  Result := ModelUpdate;
end;

function TPedidoDeVendaDAO.SetModelItensByDataSet(
  AModel: TBaseModel): TObjectList<TPedidoDeVendaItensModel>;
var
  ModelUpdate: TPedidoDeVendaModel;
  FDQuery : TFDQuery;
  SB : TStringBuilder;
  I: integer;
begin
  ModelUpdate := TPedidoDeVendaModel.Create;
  SB := TStringBuilder.Create;

  SB.Append('Select * from PedidoDeVendaItens Where IDPEDIDO ='+IntToStr(AModel.ID)+' ORDER BY SEQUENCIA');

  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
  FDQuery.Close;
  FDQuery.SQL.Text := SB.ToString;
  FDQuery.Open();

  for I := 0 to FDQuery.RecordCount - 1 do
  begin
    ModelUpdate.Itens.Add(TPedidoDeVendaItensModel.Create);

    ModelUpdate.Itens[I].IDPedido := FDQuery.FieldByName('IDPedido').AsInteger;
    ModelUpdate.Itens[I].IDProduto := FDQuery.FieldByName('IDProduto').AsInteger;
    ModelUpdate.Itens[I].NomeProduto := FDQuery.FieldByName('NomeProduto').AsString;
    ModelUpdate.Itens[I].CustoUnitario := FDQuery.FieldByName('CustoUnitario').AsFloat;
    ModelUpdate.Itens[I].ValorUnitario := FDQuery.FieldByName('ValorUnitario').AsFloat;
    ModelUpdate.Itens[I].ValorTotal := FDQuery.FieldByName('ValorTotal').AsFloat;
    ModelUpdate.Itens[I].Quantidade := FDQuery.FieldByName('Quantidade').AsFloat;
    FDQuery.Next;
  end;


  Result := ModelUpdate.Itens;
end;

procedure TPedidoDeVendaDAO.SetParameters(var FDQuery: TFDQuery;
  const AModel: TBaseModel);
begin

  with FDQuery, TPedidoDeVendaModel(AModel) do
  begin
    if AModel.ID = 0 then
      AModel.ID := GetNewID(AModel);

    ParamByName('ID').AsInteger := AModel.ID;
    ParamByName('IDCliente').AsInteger := IDCliente;
    ParamByName('NomeCliente').AsString := NomeCliente;
    ParamByName('ValorTotal').AsFloat := ValorTotal;

  end;

end;



end.
