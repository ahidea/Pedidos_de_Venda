object frmAdicionarItem: TfrmAdicionarItem
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Adicionar item'
  ClientHeight = 199
  ClientWidth = 602
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  TextHeight = 15
  object Label1: TLabel
    Left = 16
    Top = 17
    Width = 102
    Height = 15
    Caption = 'C'#243'digo do produto'
  end
  object Label2: TLabel
    Left = 16
    Top = 67
    Width = 51
    Height = 15
    Caption = 'Descri'#231#227'o'
  end
  object Label3: TLabel
    Left = 17
    Top = 117
    Width = 62
    Height = 15
    Caption = 'Quantidade'
  end
  object Label4: TLabel
    Left = 168
    Top = 117
    Width = 89
    Height = 15
    Caption = 'Valor unit'#225'rio, R$'
  end
  object Label5: TLabel
    Left = 320
    Top = 117
    Width = 72
    Height = 15
    Caption = 'Valor total, R$'
  end
  object edCodigoProduto: TEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'edCodigo_produto'
    OnChange = edCodigoProdutoChange
    OnKeyPress = edCodigoProdutoKeyPress
  end
  object edQuantidade: TEdit
    Left = 16
    Top = 132
    Width = 121
    Height = 23
    NumbersOnly = True
    TabOrder = 2
    Text = 'edQuantidade'
    OnExit = edQuantidadeExit
  end
  object edValor_unitario: TEdit
    Left = 168
    Top = 132
    Width = 121
    Height = 23
    TabOrder = 3
    Text = 'edValor_unitario'
    OnExit = edValor_unitarioExit
    OnKeyPress = edValor_unitarioKeyPress
  end
  object edDescricao: TEdit
    Left = 16
    Top = 82
    Width = 457
    Height = 23
    TabStop = False
    ReadOnly = True
    TabOrder = 1
    Text = 'edDescricao'
  end
  object edValor_total: TEdit
    Left = 320
    Top = 132
    Width = 121
    Height = 23
    TabStop = False
    ReadOnly = True
    TabOrder = 4
    Text = 'edValor_total'
  end
  object bbAceitar: TBitBtn
    Left = 504
    Top = 31
    Width = 80
    Height = 25
    Caption = 'Aceitar'
    ModalResult = 1
    NumGlyphs = 2
    TabOrder = 5
    OnClick = bbAceitarClick
  end
  object bbCancelar: TBitBtn
    Left = 504
    Top = 81
    Width = 80
    Height = 25
    Caption = 'Cancelar'
    Kind = bkCancel
    NumGlyphs = 2
    TabOrder = 6
    OnClick = bbCancelarClick
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 180
    Width = 602
    Height = 19
    Panels = <
      item
        Text = '   F3 : Consulltar lista de produtos'
        Width = 200
      end
      item
        Width = 50
      end>
    ExplicitLeft = 440
    ExplicitTop = 184
    ExplicitWidth = 0
  end
end
