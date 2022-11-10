unit Model.Produto;

interface

type
  TProduto = class
    constructor Create;

  private
    FCodigo: integer;
    FDescricao: string;
    FPreco_de_venda: double;

  public

    function PesquisarProduto( aCodigo: integer ): boolean;

    class function PesquisarDescricaoProduto( aCodigo: integer ): string;

    property Codigo: integer read FCodigo;
    property Descricao: string read FDescricao;
    property Preco_de_venda: double read FPreco_de_venda;

  end;

implementation

uses
  FireDAC.Comp.Client, uDM, System.SysUtils;

{ TProduto }

constructor TProduto.Create;
begin
  FCodigo         := 0;
  FDescricao      := '';
  FPreco_de_venda := 0.0;
end;

class function TProduto.PesquisarDescricaoProduto(aCodigo: integer): string;
var Q: TFDQuery;
begin
  Result := '';
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.FDConn;
    Q.Open('SELECT descricao FROM PRODUTOS WHERE codigo='+IntToStr(aCodigo) );
    if not Q.Eof then begin
      Result := Q.FieldByName('descricao').AsString;
    end;
  finally
    FreeAndNil( Q );
  end;

end;

function TProduto.PesquisarProduto(aCodigo: integer): boolean;
var Q: TFDQuery;
begin
  Result := false;
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := DM.FDConn;
    Q.Open('SELECT * FROM PRODUTOS WHERE codigo='+IntToStr(aCodigo) );
    if not Q.Eof then begin
      FCodigo         := aCodigo;
      FDescricao      := Q.FieldByName('descricao').AsString;
      FPreco_de_venda := Q.FieldByName('preco_de_venda').AsFloat;

      Result := true;
    end;
  finally
    FreeAndNil( Q );
  end;

end;

end.
