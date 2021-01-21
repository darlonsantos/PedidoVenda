unit Template;

interface

uses
  Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TTemplateVisView = class(TForm)
    DataSource1: TDataSource;
    FDQueryGrid: TFDQuery;
    DBGrid1: TDBGrid;
    pnlMenu: TPanel;
    imgBackGround: TImage;
    lblModulos: TLabel;
    shp1: TShape;
    pnlIncluir: TPanel;
    imgProduto: TImage;
    lblProduto: TLabel;
    pnlAlterar: TPanel;
    imgCliente: TImage;
    lblCliente: TLabel;
    pnlDeletar: TPanel;
    imgPedidoDeVenda: TImage;
    lblPedidoDeVenda: TLabel;
    pnlPesquisa: TPanel;
    pnl1: TPanel;
    imgPesquisaBG: TImage;
    pnlLimpar: TPanel;
    imgLimpar: TImage;
    lblLimpar: TLabel;
    Label1: TLabel;
    pnlPesquisar: TPanel;
    imgPesquisa: TImage;
    lblPesquisar: TLabel;
    lbl1: TLabel;
    lblRecordCount: TLabel;
    procedure pnlIncluirMouseEnter(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TemplateVisView: TTemplateVisView;

implementation

uses
  Winapi.Windows;

{$R *.dfm}

procedure TTemplateVisView.DBGrid1DblClick(Sender: TObject);
var
  Shift: TShiftState;
  LKey: Word;
begin
  LKey := VK_Return;
  DBGrid1.OnKeyDown(Sender,LKey,Shift);
end;

procedure TTemplateVisView.pnlIncluirMouseEnter(Sender: TObject);
begin
  shp1.Top := TPanel(Sender).Top;
  pnlMenu.Repaint;
end;

end.
