unit uConsultarProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls;

type
  TfrmConsultarProdutos = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultarProdutos: TfrmConsultarProdutos;

implementation

{$R *.dfm}

uses uDM, uUteis;

procedure TfrmConsultarProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.tbProdutos.Active := false;
end;

procedure TfrmConsultarProdutos.FormCreate(Sender: TObject);
begin
  DM.tbProdutos.Active := true;

  DBGrid1.Fields[0].Visible := false;
  AjustarColunasDBGrid( DBGrid1 );

end;

end.
