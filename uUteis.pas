unit uUteis;

interface

uses
  Vcl.DBGrids;

procedure AjustarColunasDBGrid( G : TDBGrid );

// ex: 12,34 --> 12.34   mask = '%0.2f'
function FloatToStrDot( Value : double; Mask : string ) : string;


implementation

uses
  Data.DB, System.SysUtils;

procedure AjustarColunasDBGrid( G : TDBGrid );
var contCol: integer;
    AValue: integer;
    MStrValue, AStrValue : string;
    Mascara: string;
    Ponto: TBookmark;
    PAD : string;
begin
  if not Assigned(G) then begin
    exit;
  end;

  PAD := '@w';

  //verifica se o TDataSet do DataSource referenciado no DBGrid est? ativo (haha)
  if not G.DataSource.DataSet.Active then begin
    Exit;
  end;

  //verifica se existem colunas
  if (G.Columns.Count = 0) then begin
    Exit;
  end;

  Ponto := G.DataSource.DataSet.GetBookmark;
  G.DataSource.DataSet.DisableControls;
  try
    //varre todas as colunas do dbgrid
    for contCol := 0 to G.Columns.Count-1 do begin
      AValue := 0;
      AStrValue := '';

      G.DataSource.DataSet.First;

      // Seta o primeiro valor como o T?TULO da coluna para evitar que os campos
      // fiquem "invis?veis", quando n?o houver campo preenchido.
      MStrValue := PAD + G.Columns[contCol].Title.Caption;

      while not G.DataSource.DataSet.Eof do begin
        if Trim(G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsString) <> '' then begin
          //Num?rico
          if (G.Columns[contCol].Field.DataType in [ftFloat, ftFMTBcd, ftInteger, ftSmallint, ftLargeint, ftBCD]) then begin
            if G.Columns[contCol].Field.DataType = ftFloat then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TFloatField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftFMTBcd then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TFMTBCDField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftInteger then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TIntegerField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftSmallint then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TSmallintField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftLargeint then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TLargeintField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftBCD then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TBCDField).DisplayFormat;

            if Mascara <> '' then begin
              AStrValue := PAD + FormatFloat(Mascara, G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsFloat);
              AValue := G.Canvas.TextWidth(AStrValue);
            end
            else begin
              AStrValue := G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsString;
              AValue := G.Canvas.TextWidth(AStrValue);
            end;
          end //Data
          else if (G.Columns[contCol].Field.DataType in [ftTimeStamp, ftDateTime, ftDate]) then begin
            if G.Columns[contCol].Field.DataType = ftTimeStamp then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TSQLTimeStampField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftDateTime then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TDateTimeField).DisplayFormat
            else if G.Columns[contCol].Field.DataType = ftDate then
              Mascara := (G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName) as TDateField).DisplayFormat;

            if Mascara <> '' then begin
              AStrValue := PAD + FormatDateTime(Mascara, G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsDateTime);
              AValue := G.Canvas.TextWidth(AStrValue);
            end
            else begin
              AStrValue := PAD + G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsString;
              AValue := G.Canvas.TextWidth(AStrValue);
            end;
          end
          else begin
            AStrValue := G.DataSource.DataSet.FieldByName(G.Columns[contCol].FieldName).AsString;
            AValue := G.Canvas.TextWidth(AStrValue);
          end;

          //verifica se a pr?xima vari?vel ? maior que a anterior
          //e mant?m a maior.
          if G.Canvas.TextWidth(MStrValue) < AValue then
            MStrValue := AStrValue;
        end;

        G.DataSource.DataSet.Next;
      end;

      //seta a largura atual com o tamanho do campo maior capturado
      //anteriormente (Observe que h? uma convers?o de texto para Width,
      //isto ? para capturar o valor real da largura do texto.)
      if Round(G.Canvas.TextWidth(MStrValue) * 1.08) > 450 then
        G.Columns[contCol].Width := 450
      else if Round(G.Canvas.TextWidth(MStrValue) * 1.08) < 24 then
        G.Columns[contCol].Width := 24
      else
        G.Columns[contCol].Width := Round(G.Canvas.TextWidth(MStrValue) * 1.08);
    end;
  finally
    G.DataSource.DataSet.GotoBookmark(Ponto);
    G.DataSource.DataSet.FreeBookmark(Ponto);
    G.DataSource.DataSet.EnableControls;
  end;
end;

function FloatToStrDot( Value : double; Mask : string ) : string;
begin
  Result := Mask.Format(Mask,[Value]).Replace(',','.');
end;

end.
