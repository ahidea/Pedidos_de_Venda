unit uConsultarClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmConsultarClientes = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private

  public
    { Public declarations }
  end;

var
  frmConsultarClientes: TfrmConsultarClientes;

implementation

{$R *.dfm}

uses uDM, uUteis;

procedure TfrmConsultarClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DM.tbClientes.Active := false;
end;

procedure TfrmConsultarClientes.FormCreate(Sender: TObject);
begin
  DM.tbClientes.Active := true;
  DBGrid1.Fields[0].Visible := false;
  AjustarColunasDBGrid( DBGrid1 );
end;

end.
