object frmEmail: TfrmEmail
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Envio de-mail...'
  ClientHeight = 290
  ClientWidth = 328
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'Servidor SMTP'
  end
  object Label1: TLabel
    Left = 248
    Top = 8
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label3: TLabel
    Left = 198
    Top = 56
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label4: TLabel
    Left = 8
    Top = 134
    Width = 17
    Height = 13
    Caption = 'De:'
  end
  object Label6: TLabel
    Left = 8
    Top = 161
    Width = 26
    Height = 13
    Caption = 'Para:'
  end
  object Label7: TLabel
    Left = 8
    Top = 188
    Width = 43
    Height = 13
    Caption = 'Assunto:'
  end
  object edtHost: TEdit
    Left = 8
    Top = 27
    Width = 227
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 100
    TabOrder = 0
  end
  object edtPort: TEdit
    Left = 248
    Top = 27
    Width = 70
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 5
    TabOrder = 1
    OnKeyPress = edtPortKeyPress
  end
  object edtUser: TEdit
    Left = 8
    Top = 75
    Width = 177
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 100
    TabOrder = 2
    OnChange = edtUserChange
  end
  object edtPass: TEdit
    Left = 198
    Top = 75
    Width = 120
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 20
    PasswordChar = '*'
    TabOrder = 3
  end
  object edtFrom: TEdit
    Left = 56
    Top = 131
    Width = 262
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 100
    TabOrder = 4
  end
  object edtTo: TEdit
    Left = 56
    Top = 158
    Width = 262
    Height = 21
    CharCase = ecLowerCase
    MaxLength = 100
    TabOrder = 5
  end
  object edtSubject: TEdit
    Left = 56
    Top = 185
    Width = 262
    Height = 21
    MaxLength = 100
    TabOrder = 6
  end
  object btnSendMail: TButton
    Left = 24
    Top = 232
    Width = 113
    Height = 41
    Caption = 'Enviar E-mail'
    TabOrder = 7
    OnClick = btnSendMailClick
  end
  object btnCancel: TButton
    Left = 184
    Top = 232
    Width = 113
    Height = 41
    Caption = 'Cancelar'
    TabOrder = 8
    OnClick = btnCancelClick
  end
end
