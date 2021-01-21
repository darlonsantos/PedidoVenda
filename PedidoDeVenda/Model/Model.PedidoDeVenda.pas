unit Model.PedidoDeVenda;

interface

uses
  Model.Base, System.Generics.Collections, System.Classes;

type
  TPedidoDeVendaItensModel = class(TBaseModel)
  private
    FCustoUnitario: Double;
    FValorUnitario: Double;
    FIDProduto: integer;
    FValorTotal: Double;
    FQuantidade: Double;
    FIDPedido: integer;
    FNomeProduto: string;
    procedure SetCustoUnitario(const Value: Double);
    procedure SetIDPedido(const Value: integer);
    procedure SetIDProduto(const Value: integer);
    procedure SetNomeProduto(const Value: string);
    procedure SetQuantidade(const Value: Double);
    procedure SetValorTotal(const Value: Double);
    procedure SetValorUnitario(const Value: Double);
    public
      property IDPedido: integer read FIDPedido write SetIDPedido;
      property IDProduto: integer read FIDProduto write SetIDProduto;
      property NomeProduto: string read FNomeProduto write SetNomeProduto;
      property CustoUnitario: Double read FCustoUnitario write SetCustoUnitario;
      property ValorUnitario: Double read FValorUnitario write SetValorUnitario;
      property ValorTotal: Double read FValorTotal write SetValorTotal;
      property Quantidade: Double read FQuantidade write SetQuantidade;
      constructor Create;



  end;

  TPedidoDeVendaModel = class(TBaseModel)
  private
    FNomeCliente: string;
    FIDCliente: integer;
    FValorTotal: Double;
    FItens: TObjectList<TPedidoDeVendaItensModel>;
    procedure SetIDCliente(const Value: integer);
    procedure SetNomeCliente(const Value: string);
    procedure SetValorTotal(const Value: Double);
    procedure SetItens(const Value: TObjectList<TPedidoDeVendaItensModel>);


    public
    constructor Create;
     property IDCliente: integer read FIDCliente write SetIDCliente;
     property NomeCliente: string read FNomeCliente write SetNomeCliente;
     property ValorTotal: Double read FValorTotal write SetValorTotal;
     property Itens: TObjectList<TPedidoDeVendaItensModel> read FItens write SetItens;

  end;

implementation

{ TPedidoDeVendaModel }

constructor TPedidoDeVendaModel.Create;
begin
  Itens := TObjectList<TPedidoDeVendaItensModel>.Create;
  Table := 'PedidoDeVenda';
  Generator := 'GEN_PEDIDODEVENDA_ID';
end;

procedure TPedidoDeVendaModel.SetIDCliente(const Value: integer);
begin
  FIDCliente := Value;
end;

procedure TPedidoDeVendaModel.SetItens(
  const Value: TObjectList<TPedidoDeVendaItensModel>);
begin
  FItens := Value;
end;

procedure TPedidoDeVendaModel.SetNomeCliente(const Value: string);
begin
  FNomeCliente := Value;
end;

procedure TPedidoDeVendaModel.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

{ TPedidoDeVendaItensModel }

constructor TPedidoDeVendaItensModel.Create;
begin
  Table := 'PedidoDeVendaItens';
  Generator := 'GEN_PEDIDODEVENDAITENS_ID';
end;

procedure TPedidoDeVendaItensModel.SetCustoUnitario(const Value: Double);
begin
  FCustoUnitario := Value;
end;

procedure TPedidoDeVendaItensModel.SetIDPedido(const Value: integer);
begin
  FIDPedido := Value;
end;

procedure TPedidoDeVendaItensModel.SetIDProduto(const Value: integer);
begin
  FIDProduto := Value;
end;

procedure TPedidoDeVendaItensModel.SetNomeProduto(const Value: string);
begin
  FNomeProduto := Value;
end;

procedure TPedidoDeVendaItensModel.SetQuantidade(const Value: Double);
begin
  FQuantidade := Value;
end;

procedure TPedidoDeVendaItensModel.SetValorTotal(const Value: Double);
begin
  FValorTotal := Value;
end;

procedure TPedidoDeVendaItensModel.SetValorUnitario(const Value: Double);
begin
  FValorUnitario := Value;
end;

end.
