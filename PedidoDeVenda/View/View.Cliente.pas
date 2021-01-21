unit View.Cliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask;

type
  TClienteView = class(TForm)
    edtRazaoSocial: TLabeledEdit;
    edtNomeFantasia: TLabeledEdit;
    edtLogradouro: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtEmail: TLabeledEdit;
    btnGravar: TButton;
    btnCancelar: TButton;
    lbl1: TLabel;
    lblID: TLabel;
    mskCnpj: TMaskEdit;
    lbl2: TLabel;
    mskCep: TMaskEdit;
    mskTelefone: TMaskEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    cbbUF: TComboBox;
    lbl5: TLabel;
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mskTelefoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    Function ValidarCampos:Boolean;

    { Public declarations }
  end;

var
  ClienteView: TClienteView;


implementation

uses
  Controller.Cliente;


var
    ClienteController : TClienteController;

{$R *.dfm}

procedure TClienteView.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TClienteView.btnGravarClick(Sender: TObject);
begin
  if ValidarCampos then
  begin
    ClienteController.Gravar;
    Close;
  end;
end;

procedure TClienteView.FormCreate(Sender: TObject);
begin
  ClienteController := TClienteController.Create;
end;

procedure TClienteView.mskTelefoneKeyPress(Sender: TObject; var Key: Char);
begin
    if Length(Trim(mskTelefone.Text)) >= 10 then
    begin
      if (Key in ['0'..'9']) then
      begin
      mskTelefone.EditMask := '(00)00000-0000;0;_'
      end;
    end
    else
      mskTelefone.EditMask := '(00)0000-0000;0;_';

end;

function TClienteView.ValidarCampos: Boolean;
begin
  if Trim(edtRazaoSocial.Text) = '' then
  begin
    Result:= False;
    Application.MessageBox('Não é possivel gravar Cliente sem Razão Social','Erro');
    Exit;
  end
  else
    Result:= True;

end;

end.
