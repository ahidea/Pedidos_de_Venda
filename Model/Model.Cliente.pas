unit Model.Cliente;

interface

uses uDM;

type
  TCliente = class
    constructor Create;

  private
    FCodigo: integer;
    FNome: string;
    FCidade: string;
    FUF: string;

  public

    function PesquisarCliente( aCodigo: integer ): boolean;

    property Codigo: integer read FCodigo;
    property Nome: string read FNome;
    property Cidade: string read FCidade;
    property UF: string read FUF;

  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;

{ TCliente }

constructor TCliente.Create;
begin
    FCodigo  := 0;
    FNome    := '';
    FCidade  := '';
    FUF      := '';
end;

function TCliente.PesquisarCliente(aCodigo: integer): boolean;
var Q: TFDQuery;
begin
  Result := false;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.FDConn;
    Q.Open('SELECT * FROM CLIENTES WHERE codigo='+IntToStr(aCodigo) );
    if not Q.Eof then begin
      FCodigo  := aCodigo;
      FNome    := Q.FieldByName('nome').AsString;
      FCidade  := Q.FieldByName('cidade').AsString;
      FUF      := Q.FieldByName('uf').AsString;

      Result := true;
    end;
  finally
    FreeAndNil( Q );
  end;

end;

end.
