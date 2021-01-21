inherited PedidoDeVendaVisView: TPedidoDeVendaVisView
  Caption = 'PedidoDeVendaVisView'
  ClientHeight = 522
  ClientWidth = 919
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 925
  ExplicitHeight = 551
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMenu: TPanel
    Height = 522
    ExplicitHeight = 502
    inherited imgBackGround: TImage
      Height = 522
    end
    inherited lbl1: TLabel
      Top = 480
    end
    inherited lblRecordCount: TLabel
      Top = 479
    end
    inherited pnlIncluir: TPanel
      OnClick = pnlIncluirClick
      inherited imgProduto: TImage
        OnClick = pnlIncluirClick
      end
      inherited lblProduto: TLabel
        OnClick = pnlIncluirClick
      end
    end
    inherited pnlAlterar: TPanel
      OnClick = pnlAlterarClick
      inherited imgCliente: TImage
        OnClick = pnlAlterarClick
      end
      inherited lblCliente: TLabel
        OnClick = pnlAlterarClick
      end
    end
    inherited pnlDeletar: TPanel
      OnClick = pnlDeletarClick
      inherited imgPedidoDeVenda: TImage
        OnClick = pnlDeletarClick
      end
      inherited lblPedidoDeVenda: TLabel
        OnClick = pnlDeletarClick
      end
    end
    inherited pnlPesquisar: TPanel
      OnClick = pnlPesquisarClick
      inherited imgPesquisa: TImage
        OnClick = pnlPesquisarClick
      end
      inherited lblPesquisar: TLabel
        OnClick = pnlPesquisarClick
      end
    end
    object pnlImprimir: TPanel
      Left = 1
      Top = 225
      Width = 201
      Height = 41
      Cursor = crHandPoint
      Anchors = [akLeft, akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 4
      OnClick = pnlImprimirClick
      OnMouseEnter = pnlIncluirMouseEnter
      object imgImprimir: TImage
        AlignWithMargins = True
        Left = 16
        Top = 3
        Width = 33
        Height = 35
        Cursor = crHandPoint
        Margins.Left = 16
        Align = alLeft
        Anchors = [akLeft, akTop, akRight]
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000200000
          00200806000000737A7AF4000000097048597300000B1300000B1301009A9C18
          000000A64944415478DA63FCFFFF3FC34002C651070C150790EB4AC661E70082
          0692AA7ED401A30EC0E60076206E01E268209624D24242E039102F06E25A20FE
          45C8019D405C46258BB1995D41C801CFA03EB706E26354B2D806880F43CD9626
          E400E4F83B0AC4FF80D8960A8EC09A2E0839E030946F37500EA02618DA0EA046
          65343C1C40494938F41C800D90EA0082660C4A07E033706454C7F80C24150C1F
          07D00C8C3A60C01D0000194C99C163B823B30000000049454E44AE426082}
        Transparent = True
        OnClick = pnlImprimirClick
      end
      object lblImprimir: TLabel
        AlignWithMargins = True
        Left = 57
        Top = 3
        Width = 72
        Height = 35
        Cursor = crHandPoint
        Margins.Left = 5
        Align = alLeft
        Alignment = taCenter
        Caption = 'Imprimir'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        OnClick = pnlImprimirClick
        ExplicitHeight = 19
      end
    end
  end
  inherited pnl1: TPanel
    Width = 718
    Height = 522
    ExplicitHeight = 502
    inherited pnlPesquisa: TPanel
      Width = 718
      inherited imgPesquisaBG: TImage
        Width = 718
      end
      inherited pnlLimpar: TPanel
        OnClick = pnlLimparClick
        inherited imgLimpar: TImage
          OnClick = pnlLimparClick
        end
        inherited lblLimpar: TLabel
          OnClick = pnlLimparClick
        end
      end
      object edtID: TLabeledEdit
        Left = 160
        Top = 34
        Width = 121
        Height = 21
        BevelOuter = bvNone
        CharCase = ecUpperCase
        EditLabel.Width = 21
        EditLabel.Height = 15
        EditLabel.Caption = 'ID:'
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWhite
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 1
        OnKeyDown = edtIDKeyDown
      end
      object edtCliente: TLabeledEdit
        Left = 360
        Top = 34
        Width = 329
        Height = 21
        BevelOuter = bvNone
        CharCase = ecUpperCase
        EditLabel.Width = 56
        EditLabel.Height = 15
        EditLabel.Caption = 'Cliente:'
        EditLabel.Color = clWhite
        EditLabel.Font.Charset = ANSI_CHARSET
        EditLabel.Font.Color = clWhite
        EditLabel.Font.Height = -13
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        LabelPosition = lpLeft
        TabOrder = 2
        OnKeyDown = edtIDKeyDown
      end
    end
    inherited DBGrid1: TDBGrid
      Width = 718
      Height = 448
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      OnKeyDown = DBGrid1KeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          Width = 34
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMECLIENTE'
          Title.Caption = 'Cliente'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALORTOTAL'
          Title.Caption = 'Vlr. Total'
          Width = 100
          Visible = True
        end>
    end
  end
  inherited FDQueryGrid: TFDQuery
    SQL.Strings = (
      
        'select * from pedidodeVenda p inner join pedidodevendaitens i on' +
        ' i.IDPEDIDO = p.ID inner join Cliente c on c.id = p.idcliente wh' +
        'ere p.id = 17')
  end
  object frxPedidoVenda: TfrxReport
    Version = '6.2.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 43760.400913530100000000
    ReportOptions.LastChange = 43760.575831620370000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 697
    Top = 344
    Datasets = <
      item
        DataSet = frxDBPedido
        DataSetName = 'frxDBDataset1'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      Frame.Typ = []
      object PageHeader1: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 71.811070000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        object Memo1: TfrxMemoView
          Align = baCenter
          AllowVectorExport = True
          Top = 3.149608330000000000
          Width = 718.110700000000000000
          Height = 34.645691670000000000
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -27
          Font.Name = 'Consolas'
          Font.Style = [fsBold]
          Frame.Typ = []
          HAlign = haCenter
          Memo.UTF8W = (
            'PEDIDO DE VENDA')
          ParentFont = False
        end
        object frxDBDataset1ID: TfrxMemoView
          AllowVectorExport = True
          Left = 574.488560000000000000
          Top = 49.133890000000000000
          Width = 143.622140000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Num. Pedido: [frxDBDataset1."ID"]')
          ParentFont = False
        end
      end
      object GroupHeader1: TfrxGroupHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 180.889868330000000000
        Top = 151.181200000000000000
        Width = 718.110700000000000000
        Condition = 'frxDBDataset1."ID"'
        object frxDBDataset1RAZAOSOCIAL: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 37.795300000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Raz'#227'o Social: [frxDBDataset1."RAZAOSOCIAL"]')
          ParentFont = False
        end
        object frxDBDataset1NOMEFANTASIA: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 60.472480000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Nome Fantasia: [frxDBDataset1."NOMEFANTASIA"]')
          ParentFont = False
        end
        object frxDBDataset1CNPJ: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 37.795300000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'CNPJ: [frxDBDataset1."CNPJ"]')
          ParentFont = False
        end
        object frxDBDataset1LOGRADOURO: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 86.929190000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Rua: [frxDBDataset1."LOGRADOURO"]')
          ParentFont = False
        end
        object frxDBDataset1NUMERO: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 86.929190000000000000
          Width = 226.771800000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'N'#250'mero: [frxDBDataset1."NUMERO"]')
          ParentFont = False
        end
        object frxDBDataset1BAIRRO: TfrxMemoView
          AllowVectorExport = True
          Left = 18.897650000000000000
          Top = 109.606370000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Bairro: [frxDBDataset1."BAIRRO"]')
          ParentFont = False
        end
        object frxDBDataset1CIDADE: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 109.606370000000000000
          Width = 264.567100000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Cidade: [frxDBDataset1."CIDADE"] - [frxDBDataset1."UF"]')
          ParentFont = False
        end
        object frxDBDataset1TELEFONE: TfrxMemoView
          AllowVectorExport = True
          Left = 427.086890000000000000
          Top = 60.472480000000000000
          Width = 238.110390000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Frame.Typ = []
          Memo.UTF8W = (
            'Telefone: [frxDBDataset1."TELEFONE"]')
          ParentFont = False
        end
        object frxDBDataset1ID_2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 7.559060000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Cliente: [frxDBDataset1."ID_2"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Top = 166.401670000000000000
          Width = 38.425221670000000000
          Height = 14.488198330000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'ID')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 37.795300000000000000
          Top = 166.401670000000000000
          Width = 329.449031670000000000
          Height = 14.488198330000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Produto')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 453.543600000000000000
          Top = 166.401670000000000000
          Width = 151.811121670000000000
          Height = 14.488198330000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. Unit'#225'rio')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Top = 166.401670000000000000
          Width = 113.385826770000000000
          Height = 14.488198330000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. Total')
          ParentFont = False
        end
        object Line1: TfrxLineView
          AllowVectorExport = True
          Top = 166.299320000000000000
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 143.622140000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = []
          Memo.UTF8W = (
            'Itens:')
          ParentFont = False
        end
        object Line2: TfrxLineView
          AllowVectorExport = True
          Left = -0.220470000000000000
          Top = 166.299320000000000000
          Height = -166.299320000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Line3: TfrxLineView
          AllowVectorExport = True
          Left = 718.110700000000000000
          Top = 166.299320000000000000
          Height = -166.299320000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Line4: TfrxLineView
          AllowVectorExport = True
          Width = 718.110700000000000000
          Color = clBlack
          Frame.Typ = []
          Diagonal = True
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 366.614410000000000000
          Top = 166.299320000000000000
          Width = 87.559111670000000000
          Height = 14.488198330000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            'Qtd.')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 355.275820000000000000
        Width = 718.110700000000000000
        DataSet = frxDBPedido
        DataSetName = 'frxDBDataset1'
        RowCount = 0
        object frxDBDataset1IDPRODUTO: TfrxMemoView
          AllowVectorExport = True
          Width = 37.795300000000000000
          Height = 18.897650000000000000
          DataField = 'IDPRODUTO'
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."IDPRODUTO"]')
          ParentFont = False
        end
        object frxDBDataset1NOMEPRODUTO: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Left = 37.795300000000000000
          Width = 328.819110000000000000
          Height = 18.897650000000000000
          DataField = 'NOMEPRODUTO'
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '[frxDBDataset1."NOMEPRODUTO"]')
          ParentFont = False
        end
        object frxDBDataset1VALORUNITARIO: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Left = 453.543600000000000000
          Width = 151.181200000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALORUNITARIO"]')
          ParentFont = False
        end
        object frxDBDataset1VALORTOTAL_1: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALORTOTAL_1"]')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Align = baLeft
          AllowVectorExport = True
          Left = 366.614410000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."QUANTIDADE"]')
          ParentFont = False
        end
      end
      object GroupFooter1: TfrxGroupFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 18.897650000000000000
        Top = 396.850650000000000000
        Width = 718.110700000000000000
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 604.724800000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          DataSet = frxDBPedido
          DataSetName = 'frxDBDataset1'
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxDBDataset1."VALORTOTAL"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 453.543600000000000000
          Width = 151.181126770000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'consolas'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'Vlr. Total:')
          ParentFont = False
        end
      end
    end
  end
  object frxDBPedido: TfrxDBDataset
    UserName = 'frxDBDataset1'
    CloseDataSource = False
    DataSet = FDQueryGrid
    BCDToCurrency = False
    Left = 777
    Top = 368
  end
end
