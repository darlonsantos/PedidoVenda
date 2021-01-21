unit Model.Cliente;

interface

uses
  Model.Base;

type

TClienteModel = Class(TBaseModel)
  private
    FLogradouro: string;
    FCNPJ: string;
    FEmail: string;
    FBairro: string;
    FUF: string;
    FCEP: string;
    FNumero: string;
    FRazaoSocial: string;
    FCidade: string;
    FTelefone: string;
    FNomeFantasia: string;
    procedure SetBairro(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetCNPJ(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetLogradouro(const Value: string);
    procedure SetNomeFantasia(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetRazaoSocial(const Value: string);
    procedure SetTelefone(const Value: string);
    procedure SetUF(const Value: string);

  public
    constructor Create;
    destructor Destroy;
    property RazaoSocial: string read FRazaoSocial write SetRazaoSocial;
    property NomeFantasia: string read FNomeFantasia write SetNomeFantasia;
    property CNPJ: string read FCNPJ write SetCNPJ;
    property Logradouro: string read FLogradouro write SetLogradouro;
    property Numero: string read FNumero write SetNumero;
    property Bairro: string read FBairro write SetBairro;
    property Cidade: string read FCidade write SetCidade;
    property UF: string read FUF write SetUF;
    property CEP: string read FCEP write SetCEP;
    property Email: string read FEmail write SetEmail;
    property Telefone: string read FTelefone write SetTelefone;


  End;

implementation

{ TClienteModel }

constructor TClienteModel.Create;
begin
  Table := 'Cliente';
  Generator := 'GEN_CLIENTE_ID';
end;

destructor TClienteModel.Destroy;
begin

end;


procedure TClienteModel.SetBairro(const Value: string);
begin
  FBairro := Value;
end;

procedure TClienteModel.SetCEP(const Value: string);
begin
  FCEP := Value;
end;

procedure TClienteModel.SetCidade(const Value: string);
begin
  FCidade := Value;
end;

procedure TClienteModel.SetCNPJ(const Value: string);
begin
  FCNPJ := Value;
end;

procedure TClienteModel.SetEmail(const Value: string);
begin
  FEmail := Value;
end;

procedure TClienteModel.SetLogradouro(const Value: string);
begin
  FLogradouro := Value;
end;

procedure TClienteModel.SetNomeFantasia(const Value: string);
begin
  FNomeFantasia := Value;
end;

procedure TClienteModel.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TClienteModel.SetRazaoSocial(const Value: string);
begin
  FRazaoSocial := Value;
end;

procedure TClienteModel.SetTelefone(const Value: string);
begin
  FTelefone := Value;
end;

procedure TClienteModel.SetUF(const Value: string);
begin
  FUF := Value;
end;

end.
