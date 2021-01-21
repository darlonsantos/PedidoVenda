unit Controller.Cliente;

interface

uses
  Util.Enum, Controller.Base,
  Model.Base, DAO.Cliente, View.Cliente;

type

TClienteController = class(TBaseController)
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
  DAO : TClienteDAO;
  View : TClienteView;


end;

implementation

uses
  Vcl.Forms, System.SysUtils, View.ProdutoVis, View.ClienteVis, Model.Cliente,
  Data.DB, Vcl.Controls;

{ TClienteController }

constructor TClienteController.Create;
begin
  DAO := TClienteDAO.Create;
  Model := TClienteModel.Create;
  //View := TClienteView.Create(Nil);
end;

procedure TClienteController.CreateView(AStatus: TAction; AModal: Boolean);
var
  I: Integer;
begin

  case AStatus of
    stInsert:
    begin
      Application.CreateForm(TClienteView, ClienteView);
      if AModal then
        ClienteView.ShowModal
      else
        ClienteView.Show;
    end;
    stUpdate:
     begin
      Application.CreateForm(TClienteView, ClienteView);
      Model := DAO.FindByID(ClienteVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      ClienteView.lbl1.Visible := True;
      ClienteView.lblID.Visible := True;
      SetViewByModel;
      if AModal then
        ClienteView.ShowModal
      else
        ClienteView.Show;
    end;
    stShow:
    begin
      Application.CreateForm(TClienteView, ClienteView);
      Model := DAO.FindByID(ClienteVisView.FDQueryGrid.FieldByName('ID').AsInteger);
      ClienteView.lbl1.Visible := True;
      ClienteView.lblID.Visible := True;
      ClienteView.btnGravar.Visible := true;
      ClienteView.btnCancelar.Visible := true;
      SetViewByModel;
      for I := 0 to ClienteView.ComponentCount - 1 do
      begin
        if ClienteView.Components[I] is TWinControl then
        begin
           (ClienteView.Components[I] as TWinControl).Enabled := TRUE;
        end;
      end;
      if AModal then
        ClienteView.ShowModal
      else
        ClienteView.Show;

    end;
  end;

end;

procedure TClienteController.Delete;
begin
  Model := DAO.FindByID(ClienteVisView.FDQueryGrid.FieldByName('ID').AsInteger);
  DAO.Delete(Model);
  ClienteVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(Model.ID);
  ClienteVisView.FDQueryGrid.Active := true;
end;

destructor TClienteController.Destroy;
begin
  FreeAndNil(DAO);
  FreeAndNil(View);
end;


procedure TClienteController.Gravar;
begin
  SetModelByView;
  ClienteVisView.FDQueryGrid.SQL.Text:= DAO.AtualizaGrid(DAO.Insert(Model));
  ClienteVisView.FDQueryGrid.Active := true;

end;

procedure TClienteController.Search(AText: string);
begin
  ClienteVisView.FDQueryGrid.SQL.Text:= DAO.Search(AText);
  ClienteVisView.FDQueryGrid.Active := true;

end;

procedure TClienteController.SetModelByView;
begin
  with TClienteModel(Model), ClienteView do
  begin
    if lblID.Caption <> ''  then
      ID := StrToInt(lblID.Caption);

    RazaoSocial := edtRazaoSocial.Text;
    NomeFantasia := edtNomeFantasia.Text;
    CNPJ := mskCNPJ.Text;
    Logradouro := edtLogradouro.Text;
    Numero := edtNumero.Text;
    Bairro := edtBairro.Text;
    Cidade := edtCidade.Text;
    CEP := mskCEP.Text;
    UF := cbbUF.Text;
    Email := edtEmail.Text;
    Telefone := mskTelefone.Text;
  end;
end;

procedure TClienteController.SetViewByModel;
begin
  with TClienteModel(Model), ClienteView do
  begin
    lblID.Caption := IntToStr(ID);
    edtRazaoSocial.Text := RazaoSocial;
    edtNomeFantasia.Text := NomeFantasia;
    mskCNPJ.Text := CNPJ;
    edtLogradouro.Text := Logradouro;
    edtNumero.Text := Numero;
    edtBairro.Text := Bairro;
    edtCidade.Text := Cidade;
    mskCEP.Text := CEP;
    cbbUF.ItemIndex := cbbUF.Items.IndexOf(UF);
    edtEmail.Text := Email;
    if Length(Telefone) > 10 then
    begin
      mskTelefone.EditMask := '(00)00000-0000;0;_'
    end;
    mskTelefone.Text := Telefone;
  end;

end;

end.
