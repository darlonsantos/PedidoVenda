unit View.PedidoDeVendaVis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Template, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg, FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  frxClass, frxDBSet;

type
  TPedidoDeVendaVisView = class(TTemplateVisView)
    edtID: TLabeledEdit;
    edtCliente: TLabeledEdit;
    frxPedidoVenda: TfrxReport;
    frxDBPedido: TfrxDBDataset;
    pnlImprimir: TPanel;
    imgImprimir: TImage;
    lblImprimir: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure pnlPesquisarClick(Sender: TObject);
    procedure pnlIncluirClick(Sender: TObject);
    procedure pnlDeletarClick(Sender: TObject);
    procedure pnlAlterarClick(Sender: TObject);
    procedure pnlLimparClick(Sender: TObject);
    procedure pnlImprimirClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtIDKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PedidoDeVendaVisView: TPedidoDeVendaVisView;

implementation

uses
  View.PedidoDeVenda, Singleton.Connection, Controller.PedidoDeVenda,
  Util.Enum;

var
  PedidoDeVendaController: TPedidoDeVendaController;

{$R *.dfm}


procedure TPedidoDeVendaVisView.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  case Key of

    VK_RETURN:
    begin
      PedidoDeVendaController.CreateView(stShow,True);
    end;

  end;


end;

procedure TPedidoDeVendaVisView.edtIDKeyDown(Sender: TObject; var Key: Word;
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

procedure TPedidoDeVendaVisView.FormCreate(Sender: TObject);
begin
  inherited;
  FDQueryGrid.Connection := TConnectionSingleton.GetInstance.Connection;
  PedidoDeVendaController := TPedidoDeVendaController.Create;
end;

procedure TPedidoDeVendaVisView.FormShow(Sender: TObject);
begin
  inherited;
pnlPesquisarClick(Sender);
end;

procedure TPedidoDeVendaVisView.pnlAlterarClick(Sender: TObject);
begin
  inherited;
  if FDQueryGrid.RecordCount > 0 then
    PedidoDeVendaController.CreateView(stUpdate,True);
end;

procedure TPedidoDeVendaVisView.pnlDeletarClick(Sender: TObject);
begin
  inherited;
  if FDQueryGrid.RecordCount > 0 then
    if Application.MessageBox('Você tem certeza que quer excluir esse Pedido?','Exclusão',mb_yesno + mb_iconquestion) = id_yes then
      PedidoDeVendaController.Delete;
end;

procedure TPedidoDeVendaVisView.pnlImprimirClick(Sender: TObject);
var
  FDQueryRelatorio: TFDQuery;
  SB: TStringBuilder;
begin
  inherited;
    SB := TStringBuilder.Create;
    FDQueryRelatorio:= TFDQuery.Create(nil);
    FDQueryRelatorio.Connection := TConnectionSingleton.GetInstance.Connection;
    SB.Clear;
    SB.Append('select * from pedidodeVenda p');
    SB.Append(' inner join pedidodevendaitens i on i.IDPEDIDO = p.ID ');
    SB.Append(' inner join Cliente c on c.id = p.idcliente ');
    SB.Append(' where p.id = ' + FDQueryGrid.FieldByName('ID').AsString );
    FDQueryRelatorio.Close;
    FDQueryRelatorio.SQL.Text:= SB.ToString;
    FDQueryRelatorio.Open;

    frxDBPedido.DataSet := FDQueryRelatorio;
    with frxPedidoVenda do
    begin
      LoadFromFile(ExtractFilePath(Application.ExeName) + 'Report\frxPedido.fr3');
      PrepareReport(True);
      ShowReport(True);
    end;
end;

procedure TPedidoDeVendaVisView.pnlIncluirClick(Sender: TObject);
begin
  inherited;
  PedidoDeVendaController.CreateView(stInsert,True);
end;

procedure TPedidoDeVendaVisView.pnlLimparClick(Sender: TObject);
begin
  inherited;
  edtID.Text := '';
  edtCliente.Text := '';
end;

procedure TPedidoDeVendaVisView.pnlPesquisarClick(Sender: TObject);
begin
  inherited;

  if Trim(edtID.Text) <> '' then
  begin
    PedidoDeVendaController.Search(edtID.Text);
  end
  else if Trim(edtCliente.Text) <> '' then
  begin
    PedidoDeVendaController.Search(edtCliente.Text);
  end
  else
  begin
    PedidoDeVendaController.Search('');
  end;
  lblRecordCount.Caption := IntToStr(FDQueryGrid.RecordCount);
end;

end.
