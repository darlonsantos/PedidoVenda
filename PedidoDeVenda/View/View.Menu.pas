unit View.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, Vcl.Imaging.pngimage;

type
  TMenuView = class(TForm)
    pnlMenu: TPanel;
    imgBackGround: TImage;
    lblModulos: TLabel;
    pnlProduto: TPanel;
    imgProduto: TImage;
    lblProduto: TLabel;
    pnlCliente: TPanel;
    imgCliente: TImage;
    lblCliente: TLabel;
    pnlPedidoDeVenda: TPanel;
    imgPedidoDeVenda: TImage;
    lblPedidoDeVenda: TLabel;
    shp1: TShape;
    procedure pnlProdutoMouseEnter(Sender: TObject);
    procedure pnlProdutoClick(Sender: TObject);
    procedure pnlClienteClick(Sender: TObject);
    procedure pnlPedidoDeVendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuView: TMenuView;

implementation

{$R *.dfm}

uses View.ProdutoVis, View.ClienteVis, View.PedidoDeVendaVis;

procedure TMenuView.pnlClienteClick(Sender: TObject);
begin
  Application.CreateForm(TClienteVisView, ClienteVisView);
  ClienteVisView.ShowModal;
end;

procedure TMenuView.pnlPedidoDeVendaClick(Sender: TObject);
begin
  Application.CreateForm(TPedidoDeVendaVisView, PedidoDeVendaVisView);
  PedidoDeVendaVisView.ShowModal;
end;

procedure TMenuView.pnlProdutoClick(Sender: TObject);
begin
  Application.CreateForm(TProdutoVisView, ProdutoVisView);
  ProdutoVisView.ShowModal;
end;

procedure TMenuView.pnlProdutoMouseEnter(Sender: TObject);
begin
  shp1.Top := TPanel(Sender).Top;
  pnlMenu.Repaint;
end;

end.
