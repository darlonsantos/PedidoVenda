unit Controller.Produto;

interface

uses
  Util.Enum, DAO.Produto, Model.Produto, View.Produto, Controller.Base, Winapi.Windows,
  Model.Base;

type

TProdutoController = class(TBaseController)
  public
  constructor Create; overload;
  destructor Destroy; overload;
  procedure CreateView(AStatus : TAction; AModal: Boolean); override;
  procedure SetModelByView; override;
  procedure Gravar; override;
  procedure SetViewByModel; override;
  procedure Search(AText : string);
  procedure Delete; override;



  var
  DAO : TProdutoDAO;
  View : TProdutoView;


end;

implementation

uses
  Vcl.Forms, System.SysUtils, View.ProdutoVis, Vcl.Controls;

{ TProdutoController }

constructor TProdutoController.Create;
begin
  DAO := TProdutoDAO.Create;
  Model := TProdutoModel.Create;
  //View := TProdutoView.Create(Nil);
end;

procedure TProdutoController.CreateView(AStatus: TAction; AModal: Boolean);
var
  I: integer;
begin

  case AStatus of
    stInsert:
    begin
      Application.CreateForm(TProdutoView, ProdutoView);
      if AModal then
        ProdutoView.ShowModal
      else
        ProdutoView.Show;
    end;
    stUpdate:
     begin
      Application.CreateForm(TProdutoView, ProdutoView);
      Model := DAO.FindByID(ProdutoVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      ProdutoView.lbl1.Visible := True;
      ProdutoView.lblID.Visible := True;
      SetViewByModel;
      if AModal then
        ProdutoView.ShowModal
      else
        ProdutoView.Show;
    end;
    stShow:
    begin
      Application.CreateForm(TProdutoView, ProdutoView);
      Model := DAO.FindByID(ProdutoVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      ProdutoView.lbl1.Visible := True;
      ProdutoView.lblID.Visible := True;
      ProdutoView.btnGravar.Visible := False;
      ProdutoView.btnCancelar.Visible := False;
      SetViewByModel;
      for I := 0 to ProdutoView.ComponentCount - 1 do
      begin
        if ProdutoView.Components[I] is TWinControl then
        begin
           (ProdutoView.Components[I] as TWinControl).Enabled := False;
        end;
      end;
      if AModal then
        ProdutoView.ShowModal
      else
        ProdutoView.Show;

    end;
  end;

end;

procedure TProdutoController.Delete;
begin
  Model := DAO.FindByID(ProdutoVisView.FDQueryGrid.FieldByName('ID').AsInteger);
  DAO.Delete(Model);
  ProdutoVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(Model.ID);
  ProdutoVisView.FDQueryGrid.Active := true;
end;

destructor TProdutoController.Destroy;
begin
  FreeAndNil(DAO);
  FreeAndNil(View);
end;


procedure TProdutoController.Gravar;
begin
  SetModelByView;
  ProdutoVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(DAO.Insert(Model));
  ProdutoVisView.FDQueryGrid.Active := true;

end;

procedure TProdutoController.Search(AText: string);
begin
  ProdutoVisView.FDQueryGrid.SQL.Text:= DAO.Search(AText);
  ProdutoVisView.FDQueryGrid.Active := true;
end;

procedure TProdutoController.SetModelByView;
begin
  with TProdutoModel(Model), ProdutoView do
  begin
    if lblID.Caption <> ''  then
      ID := StrToInt(lblID.Caption);
    Descricao := EdtDescricao.Text;
    Custo := StrToFloat(EdtCusto.Text);
    ValorVenda := StrToFloat(EdtValorVenda.Text);
  end;
end;

procedure TProdutoController.SetViewByModel;
begin
  with TProdutoModel(Model), ProdutoView do
  begin
    lblID.Caption := IntToStr(ID);
    EdtDescricao.Text := Descricao;
    EdtCusto.Text := FormatFloat('0.00',Custo);
    EdtValorVenda.Text := FormatFloat('0.00',ValorVenda);
  end;

end;

end.
