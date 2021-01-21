unit Singleton.Connection;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt;

type
  TConnectionSingleton = class
  private
    FConnection: TFDConnection;
    FUserPassword: String;
    FDatabasePath: String;
    FUserName: String;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    procedure SetConnection(const Value: TFDConnection);
    procedure SetDatabasePath(const Value: String);
    procedure SetUserName(const Value: String);
    procedure SetUserPassword(const Value: String);
    class var FInstance: TConnectionSingleton;

    class destructor Destroy;
    public
    class function GetInstance: TConnectionSingleton;
    procedure Free;
    constructor Create;
    property Connection: TFDConnection read FConnection write SetConnection;
    property DatabasePath: String read FDatabasePath write SetDatabasePath;
    property UserName: String read FUserName write SetUserName;
    property UserPassword: String read FUserPassword write SetUserPassword;
  end;

implementation

{ TConnectionSingleton }


constructor TConnectionSingleton.Create;
begin
  FConnection := TFDConnection.Create(nil);
  FConnection.LoginPrompt := False;
  FConnection.DriverName := 'FB';
  FConnection.ConnectionDefName := 'FBConnection';
  FConnection.FetchOptions.Mode := FmAll;
  FConnection.ResourceOptions.AutoReConnect := True;

  FConnection.Connected := True;

  FDGUIxWaitCursor := TFDGUIxWaitCursor.Create(nil);
  FDPhysFBDriverLink := TFDPhysFBDriverLink.Create(nil);
end;

class destructor TConnectionSingleton.Destroy;
begin
  if TConnectionSingleton.GetInstance <> nil then
  begin
    FreeAndNil(TConnectionSingleton.GetInstance.FInstance.FConnection);
    FreeAndNil(TConnectionSingleton.GetInstance.FInstance.FDGUIxWaitCursor);
    FreeAndNil(TConnectionSingleton.GetInstance.FInstance.FDPhysFBDriverLink);
    TConnectionSingleton.GetInstance.Free;
  end
end;

procedure TConnectionSingleton.Free;
begin
   if FInstance <> nil then
     FreeAndNil(FInstance);
end;

class function TConnectionSingleton.GetInstance: TConnectionSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := Create;
  Result := FInstance;
end;

procedure TConnectionSingleton.SetConnection(const Value: TFDConnection);
begin
  FConnection := Value;
end;

procedure TConnectionSingleton.SetDatabasePath(const Value: String);
begin
  FDatabasePath := Value;
end;

procedure TConnectionSingleton.SetUserName(const Value: String);
begin
  FUserName := Value;
end;

procedure TConnectionSingleton.SetUserPassword(const Value: String);
begin
  FUserPassword := Value;
end;

end.
