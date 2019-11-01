unit uEMail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, IdComponent, IdBaseComponent,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdIOHandler, IdIOHandlerStack,
  IdSSL, IdAttachmentFile, IdMessage, IdText, IdSMTP, IdIOHandlerSocket;

type
  TfrmEmail = class(TForm)
    Label5: TLabel;
    edtHost: TEdit;
    Label1: TLabel;
    edtPort: TEdit;
    Label2: TLabel;
    edtUser: TEdit;
    Label3: TLabel;
    edtPass: TEdit;
    Label4: TLabel;
    edtFrom: TEdit;
    Label6: TLabel;
    edtTo: TEdit;
    Label7: TLabel;
    edtSubject: TEdit;
    btnSendMail: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure edtPortKeyPress(Sender: TObject; var Key: Char);
    procedure edtUserChange(Sender: TObject);
    procedure btnSendMailClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmail: TfrmEmail;

implementation

{$R *.dfm}

procedure TfrmEmail.FormShow(Sender: TObject);
begin
  edtHost.Text    := 'smtp.gmail.com';
  edtPort.Text    := '465';
  edtSubject.Text := 'Cadastro InfoSistemas';
end;

procedure TfrmEmail.edtPortKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9']) then Key := #0;
end;

procedure TfrmEmail.edtUserChange(Sender: TObject);
begin
  edtFrom.Text := edtUser.Text;
end;

procedure TfrmEmail.btnSendMailClick(Sender: TObject);
var
  sMessage, sFile: String;
  IdMsg : TIdMessage;
  IdText : TIdText;
  IdSMTP : TIdSMTP;
  IdSSLIOHandlerSocket : TIdSSLIOHandlerSocketOpenSSL;
begin
  if Trim(edtHost.Text) = '' then
  begin
    Application.MessageBox('Informe o endereço do servidor SMTP.', 'Aviso', MB_OK + MB_ICONWARNING);
    edtHost.SetFocus;
    Exit;
  end;
  try
    StrtoInt(edtPort.Text);
  except On EConvertError do
    begin
      Application.MessageBox('Porta inválida.', 'Aviso', MB_OK + MB_ICONWARNING);
      edtPort.SetFocus;
      Exit;
    end;
  end;
  if Trim(edtUser.Text) = '' then
  begin
    Application.MessageBox('Informe o usuário', 'Aviso', MB_OK + MB_ICONWARNING);
    edtUser.SetFocus;
    Exit;
  end;
  if Trim(edtPass.Text) = '' then
  begin
    Application.MessageBox('Informe a senha.', 'Aviso', MB_OK + MB_ICONWARNING);
    edtPass.SetFocus;
    Exit;
  end;
  if Trim(edtFrom.Text) = '' then
  begin
    Application.MessageBox('Informe o remetente do e-mail.', 'Aviso', MB_OK + MB_ICONWARNING);
    edtFrom.SetFocus;
    Exit;
  end;
  if Trim(edtTo.Text) = '' then
  begin
    Application.MessageBox('Informe a destinatário do e-mail.', 'Aviso', MB_OK + MB_ICONWARNING);
    edtTo.SetFocus;
    Exit;
  end;
  sMessage := 'Envio de cadastro teste InfoSistemas';
  sFile    := ExtractFilePath(Application.ExeName) + 'Cadastro.XML';
  if not FileExists(sFile) then
     sFile := '';
  try
    Screen.Cursor := crHourGlass;
    try
      IdSSLIOHandlerSocket                   := TIdSSLIOHandlerSocketOpenSSL.Create(Self);
      IdSSLIOHandlerSocket.SSLOptions.Method := sslvSSLv23;
      IdSSLIOHandlerSocket.SSLOptions.Mode  := sslmClient;
      idMsg                            := TIdMessage.Create(Self);
      idMsg.CharSet                    := 'utf-8';
      idMsg.Encoding                   := meMIME;
      idMsg.From.Name                  := ''; //'TDevRocks Newsletter';
      idMsg.Priority                   := mpNormal;
      idMsg.From.Address               := edtFrom.Text;
      idMsg.Subject                    := edtSubject.Text;
      idMsg.Recipients.Add;
      idMsg.Recipients.EMailAddresses := edtTo.Text;
      idText := TIdText.Create(idMsg.MessageParts);
      idText.Body.Add(sMessage);
      idText.ContentType := 'text/html; text/plain; charset=iso-8859-1';
      // Conexão com o Servidor \\
      IdSMTP                           := TIdSMTP.Create(Self);
      IdSMTP.IOHandler                 := IdSSLIOHandlerSocket;
      IdSMTP.UseTLS                    := utUseImplicitTLS;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Host                      := edtHost.Text;
      IdSMTP.AuthType                  := satDefault;
      IdSMTP.Port                      := StrtoInt(edtPort.Text);
      IdSMTP.Username                  := edtUser.Text;
      IdSMTP.Password                  := edtPass.Text;
      IdSMTP.Connect;
      IdSMTP.Authenticate;
      if sFile <> '' then
        TIdAttachmentFile.Create(idMsg.MessageParts, sFile);
      if IdSMTP.Connected then
      begin
        try
          IdSMTP.Send(idMsg);
        except on E:Exception do
          begin
            Application.MessageBox(PChar('Erro no envio da mensagem...' + chr(13) + E.Message), 'Erro', MB_OK + MB_ICONERROR);
            Exit;
          end;
        end;
      end;
      if IdSMTP.Connected then
        IdSMTP.Disconnect;
      Application.MessageBox('Mensagem enviada com sucesso!', 'Informação', MB_OK + MB_ICONINFORMATION);
    finally
      Screen.Cursor := crDefault;
      UnLoadOpenSSLLibrary;
      FreeAndNil(idMsg);
      FreeAndNil(IdSSLIOHandlerSocket);
      FreeAndNil(idSMTP);
    end;
  except on E:Exception do
    begin
      Application.MessageBox(PChar('Erro na conexão com o servidor...' + chr(13) + E.Message), 'Erro', MB_OK + MB_ICONERROR);
    end;
  end;
end;

procedure TfrmEmail.btnCancelClick(Sender: TObject);
begin
   frmEmail.Close;
end;

end.
