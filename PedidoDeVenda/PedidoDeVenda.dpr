program PedidoDeVenda;

uses
  Vcl.Forms,
  View.Menu in 'View\View.Menu.pas' {Form1},
  View.Produto in 'View\View.Produto.pas' {ProdutoView},
  Util.Enum in 'Util\Util.Enum.pas',
  Controller.Menu in 'Controller\Controller.Menu.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Controller.Produto in 'Controller\Controller.Produto.pas',
  DAO.Produto in 'DAO\DAO.Produto.pas',
  DAO.Base in 'DAO\DAO.Base.pas',
  Singleton.Connection in 'Singleton\Singleton.Connection.pas',
  Model.Base in 'Model\Model.Base.pas',
  Controller.Base in 'Controller\Controller.Base.pas',
  Template in 'Template\Template.pas' {TemplateVisView},
  View.Cliente in 'View\View.Cliente.pas' {ClienteView},
  Controller.Cliente in 'Controller\Controller.Cliente.pas',
  DAO.Cliente in 'DAO\DAO.Cliente.pas',
  Model.Cliente in 'Model\Model.Cliente.pas',
  View.PedidoDeVendaVis in 'View\View.PedidoDeVendaVis.pas' {PedidoDeVendaVisView},
  Controller.PedidoDeVenda in 'Controller\Controller.PedidoDeVenda.pas',
  DAO.PedidoDeVenda in 'DAO\DAO.PedidoDeVenda.pas',
  View.PedidoDeVenda in 'View\View.PedidoDeVenda.pas' {PedidoDeVendaView},
  View.ClienteVis in 'View\View.ClienteVis.pas' {ClienteVisView},
  Model.PedidoDeVenda in 'Model\Model.PedidoDeVenda.pas',
  Vcl.Themes,
  Vcl.Styles,
  View.ProdutoVis in 'View\View.ProdutoVis.pas' {ProdutoVisView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Black');
  Application.CreateForm(TMenuView, MenuView);
  Application.CreateForm(TProdutoVisView, ProdutoVisView);
  Application.Run;
end.
