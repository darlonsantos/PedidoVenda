unit View.PedidoDeVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TPedidoDeVendaView = class(TForm)
    edtCliente: TLabeledEdit;
    pnl1: TPanel;
    pnl2: TPanel;
    stgrdItens: TStringGrid;
    pnl3: TPanel;
    btnGravar: TButton;
    btnCancelar: TButton;
    lbl2: TLabel;
    lbl1: TLabel;
    lblItens: TLabel;
    lblValorTotal: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblID: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure stgrdItensDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure edtClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgrdItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgrdItensKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure stgrdItensExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Upper(var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  var
    GroupColum : TStringList;
  end;

var
  PedidoDeVendaView: TPedidoDeVendaView;

implementation

uses
  Controller.PedidoDeVenda;


var
  PedidoVendaController: TPedidoDeVendaController;

{$R *.dfm}

procedure TPedidoDeVendaView.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TPedidoDeVendaView.btnGravarClick(Sender: TObject);
begin
  if edtCliente.Tag > 0 then
  begin
    PedidoVendaController.Gravar;
    Close;
  end;
end;

procedure TPedidoDeVendaView.edtClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of

    VK_RETURN:
    begin
      if edtCliente.Text <> '' then
       PedidoVendaController.SearchCliente(edtCliente.Text);

    end;



  end;
end;

procedure TPedidoDeVendaView.FormCreate(Sender: TObject);
begin

  PedidoVendaController := TPedidoDeVendaController.Create;

  GroupColum := TStringList.Create;

  GroupColum.Add('Produto');
  GroupColum.Add('Quantidade');
  GroupColum.Add('ValorUnitario');
  GroupColum.Add('ValorTotal');
  GroupColum.Add('CustoUnitario');
  GroupColum.Add('ID');

end;

procedure TPedidoDeVendaView.FormShow(Sender: TObject);
begin

  stgrdItens.Cells[GroupColum.IndexOf('Produto'),0] := 'Produto';
  stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),0] := 'Qtd.';
  stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),0] := 'Vlr. Unitário';
  stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),0] := 'Vlr. Total';
  if lblValorTotal.Caption = '' then
    lblValorTotal.Caption := FormatFloat('0.00', 0);

  stgrdItens.ColWidths[GroupColum.IndexOf('Produto')] := 350;
  stgrdItens.ColWidths[GroupColum.IndexOf('Quantidade')] := 64;
  stgrdItens.ColWidths[GroupColum.IndexOf('ValorUnitario')] := 100;
  stgrdItens.ColWidths[GroupColum.IndexOf('ValorTotal')] := 100;
  stgrdItens.ColWidths[GroupColum.IndexOf('CustoUnitario')] := -1;
  stgrdItens.ColWidths[GroupColum.IndexOf('ID')] := -1;
end;

procedure TPedidoDeVendaView.stgrdItensDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if ARow = 0 then
    stgrdItens.Canvas.Font.Style := [fsBold];
end;

procedure TPedidoDeVendaView.stgrdItensExit(Sender: TObject);
var
  I: Integer;
begin

  lblValorTotal.Caption := FormatFloat('0.00', 0);
  for I := 1 to stgrdItens.RowCount - 1 do
  begin
    if Trim(stgrdItens.Cells[GroupColum.IndexOf('ID'),I]) <> '' then
    begin
      lblValorTotal.Caption := FormatFloat('0.00', StrToFloatDef(lblValorTotal.Caption, 0.00) + StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),I], 0.00) );
      lblItens.Caption := IntToStr(stgrdItens.RowCount - 1);
    end;
  end;
end;

procedure TPedidoDeVendaView.stgrdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  I: Integer;
begin
  case Key of

    VK_RETURN:
    begin

      if stgrdItens.Cells[GroupColum.IndexOf('ID'),stgrdItens.Row] = '' then
      begin
        if stgrdItens.Col = GroupColum.IndexOf('Produto') then
        begin

         PedidoVendaController.SearchProduto(stgrdItens.Cells[GroupColum.IndexOf('Produto'),stgrdItens.Row],stgrdItens.Row);

        end;
      end;

    end;

    VK_TAB:
    begin
      if (stgrdItens.Col = GroupColum.IndexOf('Quantidade')) or (stgrdItens.Col = GroupColum.IndexOf('ValorUnitario')) then
      begin
        if Trim(stgrdItens.Cells[GroupColum.IndexOf('ID'),stgrdItens.Row]) <> '' then
        begin
          stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),stgrdItens.Row] := FormatFloat('0.00', StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),stgrdItens.Row], 0.00));
          stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),stgrdItens.Row] := FormatFloat('0.00', StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),stgrdItens.Row], 0.00));
          stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),stgrdItens.Row] := FormatFloat('0.00', StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('Quantidade'),stgrdItens.Row], 0.00) * StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('ValorUnitario'),stgrdItens.Row], 0.00))
        end;
      end;
      lblValorTotal.Caption := FormatFloat('0.00', 0);
      for I := 1 to stgrdItens.RowCount - 1 do
      begin
        if Trim(stgrdItens.Cells[GroupColum.IndexOf('ID'),I]) <> '' then
        begin
          lblValorTotal.Caption := FormatFloat('0.00', StrToFloatDef(lblValorTotal.Caption, 0.00) + StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),I], 0.00) );
          lblItens.Caption := IntToStr(stgrdItens.RowCount - 1);
        end;
      end;
    end;

    VK_DOWN:
    begin
      if stgrdItens.Cells[GroupColum.IndexOf('ID'),stgrdItens.Row] <> '' then
      begin
        lblValorTotal.Caption := FormatFloat('0.00', 0);
        for I := 1 to stgrdItens.RowCount - 1 do
        begin
          lblValorTotal.Caption := FormatFloat('0.00', StrToFloatDef(lblValorTotal.Caption, 0.00) + StrToFloatDef(stgrdItens.Cells[GroupColum.IndexOf('ValorTotal'),I], 0.00) );
          lblItens.Caption := IntToStr(stgrdItens.RowCount - 1);
        end;
        stgrdItens.RowCount := stgrdItens.RowCount + 1;
        stgrdItens.Col := GroupColum.IndexOf('Produto');
        stgrdItens.Row := stgrdItens.Row + 1;
      end;
    end;

    VK_DELETE:
    begin

        if Shift = [ssShift] then
        begin
          stgrdItens.Rows[stgrdItens.Row].Clear;
          if (stgrdItens.RowCount - 1 = stgrdItens.Row) then
          begin
            if (stgrdItens.RowCount - 1 > 1) then
            begin
              stgrdItens.RowCount := stgrdItens.RowCount - 1;
            end;
          end;
        end;


    end;

  end;



end;

procedure TPedidoDeVendaView.Upper(var Key: Char);
begin
  if CharInSet(Key, ['a'..'z']) then
    Key := UpCase(Key);
  if Key = 'ç' then Key := 'Ç';
  if Key = 'ã' then Key := 'Ã';
  if Key = 'õ' then Key := 'Õ';
  if Key = 'á' then Key := 'Á';
  if Key = 'é' then Key := 'É';
  if Key = 'í' then Key := 'Í';
  if Key = 'ó' then Key := 'Ó';
  if Key = 'ú' then Key := 'Ú';
end;

procedure TPedidoDeVendaView.stgrdItensKeyPress(Sender: TObject; var Key: Char);
begin

    Upper(Key);

   if CharInSet(Key, ['.', ',']) then
    if Pos(FormatSettings.DecimalSeparator, TEdit(Sender).Text) > 0 then
      Key := #0
    else
      Key := FormatSettings.DecimalSeparator;


  if (Key <> Char(VK_RETURN)) and (Key <> Char(VK_TAB)) then
  begin
     if stgrdItens.Col = GroupColum.IndexOf('Produto') then
     begin

       stgrdItens.Cells[GroupColum.IndexOf('ID'),stgrdItens.Row] := '';

     end;
  end;

  if stgrdItens.Col = GroupColum.IndexOf('ValorTotal') then
  begin
    Key := Char(0);
  end;
end;

end.
