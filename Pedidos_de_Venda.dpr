program Pedidos_de_Venda;

uses
  Vcl.Forms,
  uPedidosDeVenda in 'uPedidosDeVenda.pas' {frmPedidosDeVenda},
  uDM in 'uDM.pas' {DM: TDataModule},
  Model.Cliente in 'Model\Model.Cliente.pas',
  Model.Produto in 'Model\Model.Produto.pas',
  Model.Pedido in 'Model\Model.Pedido.pas',
  View.Show in 'View\View.Show.pas',
  Contr.Controller in 'Contr\Contr.Controller.pas',
  uUteis in 'uUteis.pas',
  uAdicionarItem in 'uAdicionarItem.pas' {frmAdicionarItem},
  uConsultarClientes in 'uConsultarClientes.pas' {frmConsultarClientes},
  uConsultarProdutos in 'uConsultarProdutos.pas' {frmConsultarProdutos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmPedidosDeVenda, frmPedidosDeVenda);
  Application.Run;
end.
