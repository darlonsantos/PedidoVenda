unit View.Produto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TProdutoView = class(TForm)
    EdtDescricao: TLabeledEdit;
    EdtCusto: TLabeledEdit;
    EdtValorVenda: TLabeledEdit;
    btnGravar: TButton;
    btnCancelar: TButton;
    lblID: TLabel;
    lbl1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnGravarClick(Sender: TObject);
    procedure EdtCustoExit(Sender: TObject);
    procedure EdtValorVendaExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure EdtCustoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    Function ValidarCampos:Boolean;

  end;

var
  ProdutoView: TProdutoView;


implementation

uses
  Controller.Produto;

var
  ProdutoController : TProdutoController;


{$R *.dfm}


procedure TProdutoView.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TProdutoView.btnGravarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    ProdutoController.Gravar;
    Close;
  end;
end;

procedure TProdutoView.EdtCustoExit(Sender: TObject);
begin
  if Trim(EdtCusto.Text) <> '' then
    EdtCusto.Text:= FormatFloat('0.00', StrToFloatDef(EdtCusto.Text, 0.00));
end;

procedure TProdutoView.EdtCustoKeyPress(Sender: TObject; var Key: Char);
begin

  if CharInSet(Key, ['.', ',']) then
    if Pos(FormatSettings.DecimalSeparator, TEdit(Sender).Text) > 0 then
      Key := #0
    else
      Key := FormatSettings.DecimalSeparator;

  if not (Key in ['0'..'9', ',','.',#8]) then
    Key := #0;



end;

procedure TProdutoView.EdtValorVendaExit(Sender: TObject);
begin
  if Trim(EdtValorVenda.Text) <> '' then
    EdtValorVenda.Text:= FormatFloat('0.00', StrToFloatDef(EdtValorVenda.Text, 0.00));
end;

procedure TProdutoView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ProdutoController);
end;

procedure TProdutoView.FormCreate(Sender: TObject);
begin
  ProdutoController := TProdutoController.Create;
end;

function TProdutoView.ValidarCampos: Boolean;
begin
  Result := True;
  if Trim(EdtDescricao.Text) = '' then
  begin
    Result := False;
    Application.MessageBox('Não é possivel gravar Produto sem Descrição','Erro');
    Exit
  end;
  if Trim(EdtValorVenda.Text) = '' then
  begin
    Result := False;
    Application.MessageBox('Não é possivel gravar Produto sem Valor de Venda','Erro');
    Exit
  end;


end;

end.
