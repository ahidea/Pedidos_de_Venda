object frmConsultarProdutos: TfrmConsultarProdutos
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frmConsultarProdutos'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Constraints.MaxHeight = 480
  Constraints.MaxWidth = 640
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 40
    Width = 624
    Height = 401
    Align = alClient
    DataSource = DM.ds_tbProdutos
    DrawingStyle = gdsGradient
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
end
