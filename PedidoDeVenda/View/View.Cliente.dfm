object ClienteView: TClienteView
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Cliente'
  ClientHeight = 397
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
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
  object lbl2: TLabel
    Left = 61
    Top = 89
    Width = 29
    Height = 13
    Caption = 'CNPJ:'
  end
  object lbl3: TLabel
    Left = 67
    Top = 248
    Width = 23
    Height = 13
    Caption = 'CEP:'
  end
  object lbl4: TLabel
    Left = 44
    Top = 302
    Width = 46
    Height = 13
    Caption = 'Telefone:'
  end
  object lbl5: TLabel
    Left = 73
    Top = 221
    Width = 17
    Height = 13
    Caption = 'UF:'
  end
  object edtRazaoSocial: TLabeledEdit
    Left = 96
    Top = 32
    Width = 313
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 67
    EditLabel.Height = 13
    EditLabel.Caption = 'Raz'#227'o Social: '
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 0
  end
  object edtNomeFantasia: TLabeledEdit
    Left = 96
    Top = 59
    Width = 313
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 75
    EditLabel.Height = 13
    EditLabel.Caption = 'Nome Fantasia:'
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 1
  end
  object edtLogradouro: TLabeledEdit
    Left = 96
    Top = 113
    Width = 201
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 59
    EditLabel.Height = 13
    EditLabel.Caption = 'Logradouro:'
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 3
  end
  object edtNumero: TLabeledEdit
    Left = 96
    Top = 137
    Width = 57
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 41
    EditLabel.Height = 13
    EditLabel.Caption = 'Numero:'
    LabelPosition = lpLeft
    MaxLength = 10
    TabOrder = 4
  end
  object edtBairro: TLabeledEdit
    Left = 96
    Top = 164
    Width = 201
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'Bairro:'
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 5
  end
  object edtCidade: TLabeledEdit
    Left = 96
    Top = 191
    Width = 201
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 37
    EditLabel.Height = 13
    EditLabel.Caption = 'Cidade:'
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 6
  end
  object edtEmail: TLabeledEdit
    Left = 96
    Top = 272
    Width = 201
    Height = 21
    CharCase = ecUpperCase
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Email:'
    LabelPosition = lpLeft
    MaxLength = 100
    TabOrder = 9
  end
  object btnGravar: TButton
    Left = 96
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 11
    OnClick = btnGravarClick
  end
  object btnCancelar: TButton
    Left = 222
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 12
    OnClick = btnCancelarClick
  end
  object mskCnpj: TMaskEdit
    Left = 96
    Top = 86
    Width = 200
    Height = 21
    CharCase = ecUpperCase
    EditMask = '00.000.000/0000-00;0'
    MaxLength = 18
    TabOrder = 2
    Text = ''
  end
  object mskCep: TMaskEdit
    Left = 96
    Top = 245
    Width = 120
    Height = 21
    CharCase = ecUpperCase
    EditMask = '00000-000;0;_'
    MaxLength = 9
    TabOrder = 8
    Text = ''
  end
  object mskTelefone: TMaskEdit
    Left = 96
    Top = 299
    Width = 123
    Height = 21
    CharCase = ecUpperCase
    EditMask = '(00)0000-0000;0;_'
    MaxLength = 13
    TabOrder = 10
    Text = ''
    OnKeyPress = mskTelefoneKeyPress
  end
  object cbbUF: TComboBox
    Left = 96
    Top = 218
    Width = 41
    Height = 22
    Style = csOwnerDrawFixed
    ItemIndex = 0
    TabOrder = 7
    Text = 'AC'
    Items.Strings = (
      'AC'
      'AL'
      'AM'
      'AP'
      'BA'
      'CE'
      'DF'
      'ES'
      'GO'
      'MA'
      'MG'
      'MS'
      'MT'
      'PA'
      'PB'
      'PE'
      'PI'
      'PR'
      'RJ'
      'RN'
      'RO'
      'RR'
      'RS'
      'SC'
      'SE'
      'SP'
      'TO')
  end
end
