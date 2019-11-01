object frmCadastro: TfrmCadastro
  Left = 0
  Top = 0
  Caption = 'Teste InfoSistemas - Marcel Bonomo'
  ClientHeight = 411
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 27
    Height = 13
    Caption = 'Nome'
  end
  object Label2: TLabel
    Left = 24
    Top = 64
    Width = 52
    Height = 13
    Caption = 'Identidade'
  end
  object Label3: TLabel
    Left = 240
    Top = 64
    Width = 19
    Height = 13
    Caption = 'CPF'
  end
  object Label4: TLabel
    Left = 24
    Top = 112
    Width = 42
    Height = 13
    Caption = 'Telefone'
  end
  object Label5: TLabel
    Left = 150
    Top = 112
    Width = 28
    Height = 13
    Caption = 'e-mail'
  end
  object Label6: TLabel
    Left = 24
    Top = 160
    Width = 19
    Height = 13
    Caption = 'CEP'
  end
  object Label7: TLabel
    Left = 24
    Top = 208
    Width = 55
    Height = 13
    Caption = 'Logradouro'
  end
  object Label8: TLabel
    Left = 311
    Top = 208
    Width = 37
    Height = 13
    Caption = 'N'#250'mero'
  end
  object Label9: TLabel
    Left = 24
    Top = 256
    Width = 65
    Height = 13
    Caption = 'Complemento'
  end
  object Label10: TLabel
    Left = 175
    Top = 256
    Width = 28
    Height = 13
    Caption = 'Bairro'
  end
  object Label11: TLabel
    Left = 24
    Top = 304
    Width = 33
    Height = 13
    Caption = 'Cidade'
  end
  object Label12: TLabel
    Left = 184
    Top = 304
    Width = 33
    Height = 13
    Caption = 'Estado'
  end
  object Label13: TLabel
    Left = 264
    Top = 302
    Width = 19
    Height = 13
    Caption = 'Pa'#237's'
  end
  object edtNome: TEdit
    Left = 24
    Top = 35
    Width = 353
    Height = 21
    MaxLength = 50
    TabOrder = 0
  end
  object edtIdentidade: TEdit
    Left = 24
    Top = 83
    Width = 145
    Height = 21
    MaxLength = 20
    TabOrder = 1
  end
  object mskCPF: TMaskEdit
    Left = 240
    Top = 83
    Width = 134
    Height = 21
    EditMask = '999\.999\.999\-99;1;_'
    MaxLength = 14
    TabOrder = 2
    Text = '   .   .   -  '
    OnExit = mskCPFExit
  end
  object edtTelefone: TEdit
    Left = 24
    Top = 131
    Width = 113
    Height = 21
    MaxLength = 20
    TabOrder = 3
  end
  object edtEmail: TEdit
    Left = 150
    Top = 131
    Width = 227
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 100
    TabOrder = 4
    OnExit = edtEmailExit
  end
  object mskCEP: TMaskEdit
    Left = 24
    Top = 179
    Width = 70
    Height = 21
    EditMask = '99999\-999;1;_'
    MaxLength = 9
    TabOrder = 5
    Text = '     -   '
    OnExit = mskCEPExit
  end
  object edtLogradouro: TEdit
    Left = 24
    Top = 227
    Width = 281
    Height = 21
    MaxLength = 100
    TabOrder = 7
  end
  object edtNumero: TEdit
    Left = 311
    Top = 227
    Width = 66
    Height = 21
    MaxLength = 10
    TabOrder = 8
  end
  object edtComplemento: TEdit
    Left = 24
    Top = 275
    Width = 97
    Height = 21
    MaxLength = 50
    TabOrder = 9
  end
  object edtBairro: TEdit
    Left = 175
    Top = 275
    Width = 202
    Height = 21
    MaxLength = 50
    TabOrder = 10
  end
  object edtCidade: TEdit
    Left = 24
    Top = 323
    Width = 145
    Height = 21
    MaxLength = 50
    TabOrder = 11
  end
  object edtEstado: TEdit
    Left = 184
    Top = 323
    Width = 49
    Height = 21
    MaxLength = 2
    TabOrder = 12
  end
  object edtPais: TEdit
    Left = 264
    Top = 321
    Width = 113
    Height = 21
    MaxLength = 30
    TabOrder = 13
  end
  object btnCEP: TButton
    Left = 103
    Top = 177
    Width = 75
    Height = 25
    Caption = 'Consultar CEP'
    TabOrder = 6
    OnClick = btnCEPClick
  end
  object btnFinalizar: TButton
    Left = 138
    Top = 368
    Width = 121
    Height = 25
    Caption = 'Finalizar Cadastro'
    TabOrder = 14
    OnClick = btnFinalizarClick
  end
end
