unit DAO.Base;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Singleton.Connection,
  Model.Base, Data.DB;

type

TBaseDAO = class
  private
    FModel: TBaseModel;
    procedure SetModel(const Value: TBaseModel);
  public
  constructor Create; virtual;
  destructor Destroy; virtual;
  function GetNewID(AModel: TBaseModel): Integer;
  procedure SetParameters(var FDQuery: TFDQuery; const AModel: TBaseModel); virtual; abstract;
  function SetModelByDataSet(DataSet: TDataSet) : TBaseModel; virtual; abstract;
  function Insert(AModel: TBaseModel): Integer; virtual;
  function Delete(AModel: TBaseModel): Boolean; virtual;
  function InsertText : string; virtual; abstract;
  function AtualizaGrid(AID:integer) : string; virtual; abstract;
  function FindText(AID: Integer) : string; virtual; abstract;
  function FindByID(AID: Integer) : TBaseModel; virtual;
  property Model: TBaseModel read FModel write SetModel;
  function Search(AText: string) : string; virtual; abstract;
end;

implementation

uses
  Winapi.Windows, Vcl.Forms;



{ TBaseDAO }

constructor TBaseDAO.Create;
begin

end;

function TBaseDAO.Delete(AModel: TBaseModel): Boolean;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    try
      FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
      FDQuery.Close;
      FDQuery.SQL.Text := 'DELETE FROM '+AModel.Table+' where ID = '+IntToStr(AModel.ID);
      FDQuery.ExecSQL;
      Result := True;
    except on E: Exception do
      Application.MessageBox('Ocoreu um Erro durante o Processo de Exclusão!','Erro');
    end;
  finally
    FreeAndNil(FDQuery);
  end;

end;

destructor TBaseDAO.Destroy;
begin

end;

function TBaseDAO.FindByID(AID: Integer): TBaseModel;
var
  DataSet: TDataSet;
  FDQuery: TFDQuery;
begin
  try
    FDQuery := TFDQuery.Create(nil);
    FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
    FDQuery.Close;
    FDQuery.SQL.Text := FindText(AID);
    FDQuery.Open();
    DataSet := FDQuery;

    if DataSet.RecordCount = 1 then
      Result := SetModelByDataSet(DataSet)
    else
      Result := nil;
  finally
  end;
end;

function TBaseDAO.GetNewID(AModel: TBaseModel): Integer;
var
  FDQuery: TFDQuery;
  SB: TStringBuilder;
begin
  try
    SB := TStringBuilder.Create;
    FDQuery := TFDQuery.Create(nil);
    FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
    SB.Append('SELECT GEN_ID('+ AModel.Generator +', 1) FROM RDB$DATABASE; ');
    FDQuery.Close;
    FDQuery.SQL.Text := SB.ToString;
    FDQuery.Open();
    Result := FDQuery.Fields[0].AsInteger;
  finally
    FreeAndNil(FDQuery);
    FreeAndNil(SB);
  end;
end;

function TBaseDAO.Insert(AModel: TBaseModel): Integer;
var
  FDQuery: TFDQuery;
begin
  FDQuery := TFDQuery.Create(nil);
  try
    try
      FDQuery.Connection := TConnectionSingleton.GetInstance.Connection;
      FDQuery.Close;
      FDQuery.SQL.Text := InsertText;
      SetParameters(FDQuery, AModel);
      FDQuery.Open;
      Result := FDQuery.Fields[0].AsInteger;
    except on E: Exception do
      Application.MessageBox('Ocoreu um Erro durante o Processo de Gravação!','Erro');
    end;
  finally
    FreeAndNil(FDQuery);
  end;



end;


procedure TBaseDAO.SetModel(const Value: TBaseModel);
begin
  FModel := Value;
end;



end.
