unit uAdicionarItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Model.Pedido,
  Model.Produto, Vcl.ComCtrls;

type
  TfrmAdicionarItem = class(TForm)
    edCodigoProduto: TEdit;
    edQuantidade: TEdit;
    edValor_unitario: TEdit;
    edDescricao: TEdit;
    edValor_total: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    bbAceitar: TBitBtn;
    bbCancelar: TBitBtn;
    StatusBar1: TStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyPress(Sender: TObject; var Key: Char);

    procedure edValor_unitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edQuantidadeExit(Sender: TObject);
    procedure edValor_unitarioExit(Sender: TObject);
    procedure bbAceitarClick(Sender: TObject);
    procedure edCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure bbCancelarClick(Sender: TObject);
    procedure edCodigoProdutoChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    Item : TPedidoItem;
    Modo : string;
    Produto : TProduto;
    PodeFechar : boolean;

    procedure LimparCampos;

    procedure PreencherCampos;

    procedure Calcular_Valor_total;

  public
    ItemEditado : TPedidoItem;

    procedure ModoEditar( aItem: TPedidoItem );

    procedure ModoPreencher;

  end;

var
  frmAdicionarItem: TfrmAdicionarItem;

implementation

uses
  uConsultarProdutos;

{$R *.dfm}


{ TfrmAdicionarItem }

procedure TfrmAdicionarItem.bbAceitarClick(Sender: TObject);
begin
  PodeFechar := false;
  // validar campos
  if StrToIntDef( edQuantidade.Text, -1 ) < 1 then begin
    MessageBox( 0, PChar('Quantidade inválida'), PChar('Alerta'), MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1 + MB_TASKMODAL );
    if edQuantidade.CanFocus then begin
      edQuantidade.SetFocus;
    end;
    exit;
  end;
  if StrToFloatDef( edValor_unitario.Text, -1.0 ) < 0.0 then begin
    MessageBox( 0, PChar('Valor unitário inválida'), PChar('Alerta'), MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1 + MB_TASKMODAL );
    if edValor_unitario.CanFocus then begin
      edValor_unitario.SetFocus;
    end;
    exit;
  end;
  PodeFechar := true;

  if Modo = 'Editar' then begin
    // devolve apenas os dados editados
    ItemEditado := TPedidoItem.Create;
    ItemEditado.Quantidade     := StrToIntDef( edQuantidade.Text, 0 );
    ItemEditado.Valor_unitario := StrToFloatDef( edValor_unitario.Text, 0.0 );
  end
  else if Modo = 'Preencher' then begin
    // devolve apenas os dados editados
    ItemEditado := TPedidoItem.Create;
    ItemEditado.Codigo_produto := edCodigoProduto.Tag;
    ItemEditado.Codigo_produto := StrToIntDef( edCodigoProduto.Text, 0 );
    ItemEditado.Quantidade     := StrToIntDef( edQuantidade.Text, 0 );
    ItemEditado.Valor_unitario := StrToFloatDef( edValor_unitario.Text, 0.0 );
  end;
end;

procedure TfrmAdicionarItem.bbCancelarClick(Sender: TObject);
begin
  PodeFechar := true;
  if Assigned( ItemEditado ) then begin
    ItemEditado.Free;
  end;
end;

procedure TfrmAdicionarItem.Calcular_Valor_total;
var vQuantidade: integer;
    vValor_unitario, vValor_total: double;
begin
  vQuantidade     := StrToIntDef( edQuantidade.Text, 0 );
  vValor_unitario := StrToFloatDef( edValor_unitario.Text, 0.0 );
  vValor_total    := vQuantidade * vValor_unitario;
  // :.
  edValor_total.Text := FormatFloat('#0.00', vValor_total );
end;

procedure TfrmAdicionarItem.edCodigoProdutoChange(Sender: TObject);
begin
  bbAceitar.Enabled := false;
  edCodigoProduto.Tag := 0;
end;

procedure TfrmAdicionarItem.edCodigoProdutoKeyPress(Sender: TObject; var Key: Char);
var aCodigo: integer;
    produto: TProduto;
begin
  if Key = #13 then begin

    aCodigo := StrToIntDef( edCodigoProduto.Text, -1 );
    if aCodigo = -1 then begin
      exit;
    end;

    Produto := TProduto.Create;
    try
      if not produto.PesquisarProduto( aCodigo ) then begin
        edCodigoProduto.Tag := 0;
        Showmessage('Código de produto '+edCodigoProduto.Text+' não existe');
        LimparCampos;
        edCodigoProduto.SetFocus;
        exit;
      end;

      edDescricao.Text      := produto.Descricao;
      edCodigoProduto.Tag   := produto.Codigo;
      edValor_unitario.Text := FormatFloat('#0.00', produto.Preco_de_venda );

      Calcular_Valor_total;

      bbAceitar.Enabled := true;

    finally
      FreeAndNil( Produto );
    end;

  end;
end;

procedure TfrmAdicionarItem.edQuantidadeExit(Sender: TObject);
begin
  Calcular_Valor_total;
end;

procedure TfrmAdicionarItem.edValor_unitarioExit(Sender: TObject);
var vValor_unitario: double;
begin
  // ajusta para duas casas
  vValor_unitario := round( 100.0* StrToFloatDef( edValor_unitario.Text, 0.0 ) )/100.0;
  edValor_unitario.Text := FormatFloat('#0.00', vValor_unitario );

  Calcular_Valor_total;
end;

procedure TfrmAdicionarItem.edValor_unitarioKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#8]) then begin
    Key := #0;
  end;
end;

procedure TfrmAdicionarItem.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if not PodeFechar then begin
    Action := caNone;
    exit;
  end;
  Action := caHide;

  if Assigned( ItemEditado ) then begin
    ItemEditado.Free;
  end;
end;

procedure TfrmAdicionarItem.FormCreate(Sender: TObject);
begin
  Modo := '';
  ItemEditado := nil;
  Produto := nil;
  LimparCampos;
end;

procedure TfrmAdicionarItem.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var f: TfrmConsultarProdutos;
begin
  if Key = VK_F3 then begin
    f := TfrmConsultarProdutos.Create( self );
    try
      f.ShowModal;
    finally
      f.Free;
    end;
  end;

end;

procedure TfrmAdicionarItem.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then begin
    SendMessage( self.handle, WM_NEXTDLGCTL, 0, 0 )
  end;
end;

procedure TfrmAdicionarItem.LimparCampos;
begin
  edCodigoProduto.Clear;
  edQuantidade.Clear;
  edValor_unitario.Clear;
  edDescricao.Clear;
  edValor_total.Clear;
end;

procedure TfrmAdicionarItem.ModoEditar(aItem: TPedidoItem);
begin
  Modo := 'Editar';

  Item := aItem;
  // editável ?
  edCodigoProduto.Enabled  := false;
  edQuantidade.Enabled     := true;
  edValor_unitario.Enabled := true;
  edDescricao.Enabled      := false;
  edValor_total.Enabled    := false;
  //
  PreencherCampos;
  //
  bbAceitar.Enabled := true;
end;

procedure TfrmAdicionarItem.ModoPreencher;
begin
  Modo := 'Preencher';

  Item := nil;
  // editável ?
  edCodigoProduto.Enabled  := true;
  edQuantidade.Enabled     := true;
  edValor_unitario.Enabled := true;
  edDescricao.Enabled      := false;
  edValor_total.Enabled    := false;
  //
  PreencherCampos;
  //
  bbAceitar.Enabled := false;
end;

procedure TfrmAdicionarItem.PreencherCampos;
begin
  if Assigned( Item ) then begin
    edCodigoProduto.Text  := item.Codigo_produto.ToString;
    edQuantidade.Text     := item.Quantidade.ToString;
    edValor_unitario.Text := FormatFloat('#0.00', item.Valor_unitario );
    edValor_total.Text    := FormatFloat('#0.00', item.Valor_total );
    //
    edDescricao.Text      := TProduto.PesquisarDescricaoProduto( item.Codigo_produto );

  end;
end;

end.


