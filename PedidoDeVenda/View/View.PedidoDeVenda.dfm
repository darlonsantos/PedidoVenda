object PedidoDeVendaView: TPedidoDeVendaView
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Pedido de Venda'
  ClientHeight = 437
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 81
    Align = alTop
    TabOrder = 0
    object lblID: TLabel
      Left = 61
      Top = 8
      Width = 4
      Height = 18
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbl5: TLabel
      Left = 32
      Top = 8
      Width = 23
      Height = 18
      Caption = 'ID:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edtCliente: TLabeledEdit
      Left = 160
      Top = 39
      Width = 593
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 13
      EditLabel.Caption = 'Cliente:'
      LabelPosition = lpLeft
      TabOrder = 0
      OnKeyDown = edtClienteKeyDown
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 81
    Width = 938
    Height = 248
    Align = alTop
    TabOrder = 1
    object stgrdItens: TStringGrid
      Left = 1
      Top = 1
      Width = 936
      Height = 246
      Align = alClient
      ColCount = 6
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goTabs]
      ParentFont = False
      TabOrder = 0
      OnDrawCell = stgrdItensDrawCell
      OnExit = stgrdItensExit
      OnKeyDown = stgrdItensKeyDown
      OnKeyPress = stgrdItensKeyPress
      ColWidths = (
        64
        64
        64
        64
        64
        64)
    end
  end
  object pnl3: TPanel
    Left = 0
    Top = 329
    Width = 938
    Height = 96
    Align = alTop
    TabOrder = 2
    object lbl2: TLabel
      Left = 690
      Top = 16
      Width = 87
      Height = 18
      Caption = 'Valor Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 8
      Top = 16
      Width = 87
      Height = 18
      Caption = 'Num. Itens:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblItens: TLabel
      Left = 101
      Top = 16
      Width = 4
      Height = 18
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 784
      Top = 16
      Width = 4
      Height = 18
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl3: TLabel
      Left = 8
      Top = 64
      Width = 219
      Height = 13
      Caption = 'PESQUISAR TODOS: [ ESPA'#199'O + ENTER] '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl4: TLabel
      Left = 240
      Top = 64
      Width = 170
      Height = 13
      Caption = 'DELETAR ITEM: [ SHIFT + DEL] '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl6: TLabel
      Left = 8
      Top = 80
      Width = 117
      Height = 13
      Caption = 'PESQUISAR: [ENTER] '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl7: TLabel
      Left = 131
      Top = 80
      Width = 229
      Height = 13
      Caption = 'ADICIONAR LINHA: [SETA PARA BAIXO '#8595'] '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnGravar: TButton
      Left = 640
      Top = 56
      Width = 113
      Height = 25
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 767
      Top = 56
      Width = 113
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
end
