unit Controller.PedidoDeVenda;

interface

uses
  Util.Enum, Controller.Base,
  Model.Base, DAO.PedidoDeVenda, View.PedidoDeVenda, Model.Cliente,
  Model.Produto, Model.PedidoDeVenda;

type

TPedidoDeVendaController = class(TBaseController)
  private
    FCliente: TClienteModel;
    FProduto: TProdutoModel;
    procedure SetCliente(const Value: TClienteModel);
    procedure SetProduto(const Value: TProdutoModel);
  public
  constructor Create; overload;
  destructor Destroy; overload;
  procedure CreateView(AStatus : TAction; AModal: Boolean); override;
  procedure SetModelByView; override;
  procedure Gravar; override;
  procedure SetViewByModel; override;
  procedure Search(AText : string);
  procedure SearchCliente(AText : string);
  procedure SearchProduto(AText : string; ARow: integer);
  procedure Delete; override;
  property Cliente: TClienteModel read FCliente write SetCliente;
  property Produto: TProdutoModel read FProduto write SetProduto;



  var
  DAO : TPedidoDeVendaDAO;
  View : TPedidoDeVendaView;
  Model : TPedidoDeVendaModel;


end;

implementation

uses
  Vcl.Forms, System.SysUtils, View.PedidoDeVendaVis,
  View.ClienteVis, FireDAC.Comp.Client, DAO.Cliente, Singleton.Connection,
  DAO.Produto, View.ProdutoVis, System.Generics.Collections, Winapi.Windows,
  Vcl.Controls;

{ TPedidoDeVendaController }

constructor TPedidoDeVendaController.Create;
begin
  DAO := TPedidoDeVendaDAO.Create;
  Model := TPedidoDeVendaModel.Create;
  Cliente := TClienteModel.Create;
end;

procedure TPedidoDeVendaController.CreateView(AStatus: TAction; AModal: Boolean);
var
  I: integer;
begin

  case AStatus of
    stInsert:
    begin
      Application.CreateForm(TPedidoDeVendaView, PedidoDeVendaView);
      if AModal then
        PedidoDeVendaView.ShowModal
      else
        PedidoDeVendaView.Show;
    end;
    stUpdate:
     begin
      Application.CreateForm(TPedidoDeVendaView, PedidoDeVendaView);
      TBaseModel(Model) := DAO.FindByID(PedidoDeVendaVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      PedidoDeVendaView.lbl5.Visible := True;
      PedidoDeVendaView.lblID.Visible := True;
      SetViewByModel;
      if AModal then
        PedidoDeVendaView.ShowModal
      else
        PedidoDeVendaView.Show;
    end;
    stShow:
    begin
      Application.CreateForm(TPedidoDeVendaView, PedidoDeVendaView);
      TBaseModel(Model) := DAO.FindByID(PedidoDeVendaVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      PedidoDeVendaView.lbl1.Visible := True;
      PedidoDeVendaView.lblID.Visible := True;
      PedidoDeVendaView.btnGravar.Visible := False;
      PedidoDeVendaView.btnCancelar.Visible := False;
      SetViewByModel;
      for I := 0 to PedidoDeVendaView.ComponentCount - 1 do
      begin
        if PedidoDeVendaView.Components[I] is TWinControl then
        begin
           (PedidoDeVendaView.Components[I] as TWinControl).Enabled := False;
        end;
      end;
      if AModal then
        PedidoDeVendaView.ShowModal
      else
        PedidoDeVendaView.Show;

    end;
  end;

end;

procedure TPedidoDeVendaController.Delete;
begin
  TBaseModel(Model) := DAO.FindByID(PedidoDeVendaVisView.FDQueryGrid.FieldByName('ID').AsInteger);
  DAO.Delete(Model);
  PedidoDeVendaVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(Model.ID);
  PedidoDeVendaVisView.FDQueryGrid.Active := true;
end;

destructor TPedidoDeVendaController.Destroy;
begin
  FreeAndNil(DAO);
  FreeAndNil(View);
end;


procedure TPedidoDeVendaController.Gravar;
begin
     SetModelByView;
    PedidoDeVendaVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(DAO.Insert(Model));
    DAO.GravarItens(TPedidoDeVendaModel(Model));
    PedidoDeVendaVisView.FDQueryGrid.Active := true;
    if Application.MessageBox('Você deseja Imprimir?','Impressão',mb_yesno + mb_iconquestion) = id_yes then
      PedidoDeVendaVisView.pnlImprimir.OnClick(Self);

end;

procedure TPedidoDeVendaController.Search(AText: string);
begin
  PedidoDeVendaVisView.FDQueryGrid.SQL.Text:= DAO.Search(AText);
  PedidoDeVendaVisView.FDQueryGrid.Active := true;
end;

procedure TPedidoDeVendaController.SearchCliente(AText: string);
var
  FDQuery: TFDQuery;
  DAOCliente : TClienteDAO;
begin
  DAOCliente := TClienteDAO.Create;
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
  FDQuery.Close;
  FDQuery.SQL.Text := DAOCliente.Search(AText);
  FDQuery.Open;

  if FDQuery.RecordCount = 1 then
  begin
    PedidoDeVendaView.edtCliente.Tag := FDQuery.FieldByName('ID').AsInteger;
    PedidoDeVendaView.edtCliente.Text := FDQuery.FieldByName('RazaoSocial').AsString;
  end
  else
  begin
    Application.CreateForm(TClienteVisView, ClienteVisView);
    ClienteVisView.ViewPesquisa := True;
    ClienteVisView.FDQueryGrid.SQL.Text := FDQuery.SQL.Text;
    ClienteVisView.FDQueryGrid.Active := True;
    ClienteVisView.ShowModal;
    if Assigned(ClienteVisView.Cliente) then
    begin
      Cliente := ClienteVisView.Cliente;
      PedidoDeVendaView.edtCliente.Tag := Cliente.ID;
      PedidoDeVendaView.edtCliente.Text := Cliente.RazaoSocial;
    end;
  end;



end;

procedure TPedidoDeVendaController.SearchProduto(AText: string; ARow: integer);
var
  FDQuery: TFDQuery;
  DAOProduto : TProdutoDAO;
begin
  DAOProduto := TProdutoDAO.Create;
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
  FDQuery.Close;
  FDQuery.SQL.Text := DAOProduto.Search(AText);
  FDQuery.Open;

  if FDQuery.RecordCount = 1 then
  begin

    with PedidoDeVendaView do
    begin
      stgrdItens.Cells[GroupColum.IndexOf('ID'), ARow] := IntToStr(FDQuery.FieldByName('ID').AsInteger);
      stgrdItens.Cells[GroupColum.IndexOf('Produto'), ARow] := FDQuery.FieldByName('DESCRICAO').AsString;
      stgrdItens.Cells[GroupColum.IndexOf('CustoUnitario'), ARow] := FormatFloat('0.00', FDQuery.FieldByName('Custo').AsFloat);
      stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'), ARow] := FormatFloat('0.00',FDQuery.FieldByName('VALORVENDA').AsFloat);
      stgrdItens.Cells[GroupColum.IndexOf('Quantidade'), ARow] := '1.00';
      stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'), ARow] := FormatFloat('0.00', FDQuery.FieldByName('VALORVENDA').AsFloat);

    end;
  end
  else
  begin
    Application.CreateForm(TProdutoVisView, ProdutoVisView);
    ProdutoVisView.ViewPesquisa := True;
    ProdutoVisView.FDQueryGrid.SQL.Text := FDQuery.SQL.Text;
    ProdutoVisView.FDQueryGrid.Active := True;
    ProdutoVisView.ShowModal;
    if Assigned(ProdutoVisView.Produto) then
    begin
      Produto := ProdutoVisView.Produto;
      with PedidoDeVendaView do
      begin

        stgrdItens.Cells[GroupColum.IndexOf('ID'), ARow] := IntToStr(Produto.ID);
        stgrdItens.Cells[GroupColum.IndexOf('Produto'), ARow] := Produto.Descricao;
        stgrdItens.Cells[GroupColum.IndexOf('CustoUnitario'), ARow] := FormatFloat('0.00', Produto.Custo);
        stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'), ARow] := FormatFloat('0.00', Produto.ValorVenda);
        stgrdItens.Cells[GroupColum.IndexOf('Quantidade'), ARow] := '1.00';
        stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'), ARow] := FormatFloat('0.00', Produto.ValorVenda);


      end;
    end;
  end;
end;

procedure TPedidoDeVendaController.SetCliente(const Value: TClienteModel);
begin
  FCliente := Value;
end;

procedure TPedidoDeVendaController.SetModelByView;
var
  I: integer;
  ModelItens: TPedidoDeVendaItensModel;

begin

  ModelItens := TPedidoDeVendaItensModel.Create;

  with TPedidoDeVendaModel(Model), PedidoDeVendaView do
  begin
    if lblID.Caption <> ''  then
      ID := StrToInt(lblID.Caption);

      IDCliente := edtCliente.Tag;
      NomeCliente := edtCliente.Text;
      ValorTotal := StrToFloat(lblValorTotal.Caption);

  end;

  TPedidoDeVendaModel(Model).Itens.Clear;
  with Model, PedidoDeVendaView do
  begin
    for I := 0 to stgrdItens.RowCount - 2 do
    begin
      if Trim(stgrdItens.Cells[GroupColum.IndexOf('ID'),I+1]) <> '' then
      begin
        TPedidoDeVendaModel(Model).Itens.Add(TPedidoDeVendaItensModel.Create);
        if lblID.Caption <> ''  then
          Itens[I].IDPedido := StrToInt(lblID.Caption);

        Itens[I].IDProduto := StrToInt(stgrdItens.Cells[GroupColum.IndexOf('ID'),I+1]);
        Itens[I].NomeProduto := stgrdItens.Cells[GroupColum.IndexOf('Produto'),I+1];
        Itens[I].CustoUnitario := StrToFloat(stgrdItens.Cells[GroupColum.IndexOf('CustoUnitario'),I+1]);
        Itens[I].ValorUnitario := StrToFloat(stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),I+1]);
        Itens[I].ValorTotal := StrToFloat(stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),I+1]);
        Itens[I].Quantidade := StrToFloat(stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),I+1]);
      end;



    end;
  end;


end;


procedure TPedidoDeVendaController.SetProduto(const Value: TProdutoModel);
begin
  FProduto := Value;
end;

procedure TPedidoDeVendaController.SetViewByModel;
var
  I: integer;
  ItemList: TPedidoDeVendaItensModel;

begin

  ItemList := TPedidoDeVendaItensModel.Create;

  with TPedidoDeVendaModel(Model), PedidoDeVendaView do
  begin
      lblID.Caption := IntToStr(ID);
      edtCliente.Tag := IDCliente;
      edtCliente.Text := NomeCliente;
      lblValorTotal.Caption := FormatFloat('0.00',ValorTotal);
  end;

  with PedidoDeVendaView do
  begin
    stgrdItens.RowCount:= TPedidoDeVendaModel(Model).Itens.Count+1;
    I := 1;
    for ItemList in TPedidoDeVendaModel(Model).Itens do
    begin
      stgrdItens.Cells[GroupColum.IndexOf('ID'),I] := IntToStr(ItemList.IDProduto);
      stgrdItens.Cells[GroupColum.IndexOf('Produto'),I] := ItemList.NomeProduto;
      stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),I] := FormatFloat('0.00',ItemList.ValorUnitario);
      stgrdItens.Cells[GroupColum.IndexOf('CustoUnitario'),I] := FormatFloat('0.00',ItemList.CustoUnitario);
      stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),I] := FormatFloat('0.00',ItemList.Quantidade);
      stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),I] := FormatFloat('0.00',ItemList.ValorTotal);
      Inc(I);
    end;
    lblItens.Caption := IntToStr(stgrdItens.RowCount - 1);
  end;


end;

end.
