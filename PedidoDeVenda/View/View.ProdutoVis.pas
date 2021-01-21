unit View.ProdutoVis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Template, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Controller.Produto, Model.Produto;

type
  TProdutoVisView = class(TTemplateVisView)
    edtDescricao: TLabeledEdit;
    edtID: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure pnlPesquisarClick(Sender: TObject);
    procedure pnlIncluirClick(Sender: TObject);
    procedure pnlAlterarClick(Sender: TObject);
    procedure pnlDeletarClick(Sender: TObject);
    procedure pnlLimparClick(Sender: TObject);
    procedure edtIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FViewPesquisa: Boolean;
  private
    FProduto: TProdutoModel;
    procedure SetViewPesquisa(const Value: Boolean);
    procedure SetProduto(const Value: TProdutoModel);
  published
    { Private declarations }
  public
    { Public declarations }
     property ViewPesquisa: Boolean read FViewPesquisa write SetViewPesquisa;
     property Produto: TProdutoModel read FProduto write SetProduto;
     function DevolverPesquisa(Model: TProdutoModel): TProdutoModel;
  end;

var
  ProdutoVisView: TProdutoVisView;
  ProdutoController : TProdutoController;

implementation

uses
  Util.Enum, System.TypInfo, Singleton.Connection;

{$R *.dfm}

procedure TProdutoVisView.btnAlterarClick(Sender: TObject);
begin
  ProdutoController.CreateView(stUpdate,True);
end;

procedure TProdutoVisView.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    case Key of

      VK_RETURN:
      begin
         if ViewPesquisa then
        begin
         Produto := DevolverPesquisa(Produto);
         Close;
        end
        else
        begin
          ProdutoController.CreateView(stShow,True);
        end;
      end;



    end;

end;

function TProdutoVisView.DevolverPesquisa(Model: TProdutoModel): TProdutoModel;
begin
  Model := TProdutoModel.Create;
  Model.ID := FDQueryGrid.FieldByName('ID').AsInteger;
  Model.Descricao := FDQueryGrid.FieldByName('Descricao').AsString;
  Model.Custo := FDQueryGrid.FieldByName('Custo').AsFloat;
  Model.ValorVenda := FDQueryGrid.FieldByName('ValorVenda').AsFloat;
  Result := Model;
end;

procedure TProdutoVisView.edtIDKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
   case Key of
     VK_RETURN:
     begin
         pnlPesquisarClick(Sender);
     end;

  end;
end;

procedure TProdutoVisView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ProdutoController);
end;

procedure TProdutoVisView.FormCreate(Sender: TObject);
begin
  ProdutoController := TProdutoController.Create;
  FDQueryGrid.Connection := TConnectionSingleton.GetInstance.Connection;
end;


procedure TProdutoVisView.FormShow(Sender: TObject);
begin
  DBGrid1.SetFocus;
  if ViewPesquisa then
  begin
    ProdutoVisView.WindowState := wsNormal;
    ProdutoVisView.BorderStyle := bsDialog;
  end;
      pnlPesquisarClick(Sender);
end;

procedure TProdutoVisView.pnlAlterarClick(Sender: TObject);
begin
  inherited;
  if FDQueryGrid.RecordCount > 0 then
    ProdutoController.CreateView(stUpdate,True);
end;

procedure TProdutoVisView.pnlDeletarClick(Sender: TObject);
begin
  inherited;
  if FDQueryGrid.RecordCount > 0 then
    if Application.MessageBox('Você tem certeza que quer excluir esse Produto?','Exclusão',mb_yesno + mb_iconquestion) = id_yes then
      ProdutoController.Delete;
end;

procedure TProdutoVisView.pnlIncluirClick(Sender: TObject);
begin
  inherited;
  ProdutoController.CreateView(stInsert,True);
end;

procedure TProdutoVisView.pnlLimparClick(Sender: TObject);
begin
  inherited;
  edtID.Text := '';
  edtDescricao.Text := '';
end;

procedure TProdutoVisView.pnlPesquisarClick(Sender: TObject);
begin
  inherited;
  if Trim(edtID.Text) <> '' then
  begin
    ProdutoController.Search(edtID.Text);
  end
  else if Trim(edtDescricao.Text) <> '' then
  begin
    ProdutoController.Search(edtDescricao.Text);
  end
  else
  begin
    ProdutoController.Search('');
  end;
  lblRecordCount.Caption := IntToStr(FDQueryGrid.RecordCount);
end;

procedure TProdutoVisView.SetProduto(const Value: TProdutoModel);
begin
  FProduto := Value;
end;

procedure TProdutoVisView.SetViewPesquisa(const Value: Boolean);
begin
  FViewPesquisa := Value;
end;

end.
