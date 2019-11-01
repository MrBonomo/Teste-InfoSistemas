unit uCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Mask, Vcl.StdCtrls, StrUtils, XMLDoc, XMLIntf, System.Json,
  IdHTTP, IdTCPConnection, IdTCPClient, IdSSLOpenSSL, IdComponent, IdBaseComponent;

type
  TfrmCadastro = class(TForm)
    Label1: TLabel;
    edtNome: TEdit;
    Label2: TLabel;
    edtIdentidade: TEdit;
    Label3: TLabel;
    mskCPF: TMaskEdit;
    Label4: TLabel;
    edtTelefone: TEdit;
    Label5: TLabel;
    edtEmail: TEdit;
    Label6: TLabel;
    mskCEP: TMaskEdit;
    Label7: TLabel;
    edtLogradouro: TEdit;
    Label8: TLabel;
    edtNumero: TEdit;
    Label9: TLabel;
    edtComplemento: TEdit;
    Label10: TLabel;
    edtBairro: TEdit;
    Label11: TLabel;
    edtCidade: TEdit;
    Label12: TLabel;
    edtEstado: TEdit;
    Label13: TLabel;
    edtPais: TEdit;
    btnCEP: TButton;
    btnFinalizar: TButton;
    procedure mskCPFExit(Sender: TObject);
    procedure edtEmailExit(Sender: TObject);
    procedure mskCEPExit(Sender: TObject);
    procedure btnCEPClick(Sender: TObject);
    procedure btnFinalizarClick(Sender: TObject);
  private
    { Private declarations }
    function CPFOK(sCPF: String): Boolean;
    function EmailOK(sEmail: String): Boolean;
    procedure CarregaCEP(sJSON: String);
    procedure GravaXML();
  public
    { Public declarations }
  end;

var
  frmCadastro: TfrmCadastro;

implementation

{$R *.dfm}

uses uEMail;

procedure TfrmCadastro.mskCPFExit(Sender: TObject);
var
  sCPF: String;
begin
  sCPF := ReplaceStr(ReplaceStr(mskCPF.Text, '.', ''), '-', '');
  if Trim(sCPF) <> '' then
  begin
    if not CPFOK(mskCPF.Text) then
    begin
      if Application.MessageBox(PChar('CPF inválido!' + chr(13) + 'Deseja corrigir?'), 'Confirmação', MB_YESNO + MB_ICONQUESTION) = IDYES then
         mskCPF.SetFocus;
    end;
  end;
end;

procedure TfrmCadastro.edtEmailExit(Sender: TObject);
begin
  if Trim(edtEmail.Text) <> '' then
  begin
    if not EmailOK(edtEmail.Text) then
    begin
      if Application.MessageBox(PChar('Endereço de e-mail inválido!' + chr(13) + 'Deseja corrigir?'), 'Confirmação', MB_YESNO + MB_ICONQUESTION) = IDYES then
         edtEmail.SetFocus;
    end;
  end;
end;

procedure TfrmCadastro.mskCEPExit(Sender: TObject);
begin
   btnCEPClick(Sender);
end;

procedure TfrmCadastro.btnCEPClick(Sender: TObject);
var
  IdHTTP: TIdHTTP;
  LHandler: TIdSSLIOHandlerSocketOpenSSL;
  sCEP, sJSON, sURL: String;
  iResp: Integer;
begin
  sCEP := ReplaceStr(mskCEP.Text, '-', '');
  if Trim(sCEP) = '' then
    Exit;
  IdHTTP := TIdHTTP.Create();
  LHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  try
    try
      Screen.Cursor := crHourGlass;
      IdHttp.IOHandler := LHandler;
      sURL := 'https://viacep.com.br/ws/' + sCEP + '/json/';
      sJSON := IdHTTP.Get(sURL);
      iResp := IdHTTP.ResponseCode;
    except
      iResp := IdHTTP.ResponseCode;
      Exit;
    end;
  finally
    Screen.Cursor := crDefault;
    FreeAndNil(LHandler);
    FreeAndNil(IdHTTP);
  end;
  CarregaCEP(sJSON);
  if edtLogradouro.Text = '' then edtLogradouro.SetFocus
  else edtNumero.SetFocus;
end;

procedure TfrmCadastro.btnFinalizarClick(Sender: TObject);
begin
  GravaXML();
  if not Assigned(frmEmail) then
    frmEmail := TfrmEmail.Create(Self);
  frmEmail.edtTo.Text := edtEmail.Text;
  frmEmail.ShowModal;
end;

// Função de validação do número CPF \\
function TfrmCadastro.CPFOK(sCPF: String): Boolean;
var
   sDig10, sDig11: string;
   i, iDigito, iFator, iResulta: integer;
begin
   sCPF := ReplaceStr(ReplaceStr(sCPF, '.', ''), '-', '');
   if ((sCPF = '00000000000') or (sCPF = '11111111111') or (sCPF = '22222222222') or
       (sCPF = '33333333333') or (sCPF = '44444444444') or (sCPF = '55555555555') or
       (sCPF = '66666666666') or (sCPF = '77777777777') or (sCPF = '88888888888') or
       (sCPF = '99999999999') or (length(sCPF) <> 11)) then
   begin
      Result := False;
      Exit;
   end;
   try
      // primeiro dígito verificador \\
      iDigito := 0;
      iFator := 10;
      for i := 1 to 9 do
      begin
         iDigito := iDigito + (StrToInt(sCPF[i]) * iFator);
         iFator := iFator - 1;
      end;
      iResulta := 11 - (iDigito mod 11);
      if ((iResulta = 10) or (iResulta = 11)) then
         sDig10 := '0'
      else
         Str(iResulta:1, sDig10);
      // segundo dígito verificador \\
      iDigito := 0;
      iFator := 11;
      for i := 1 to 10 do
      begin
         iDigito := iDigito + (StrToInt(sCPF[i]) * iFator);
         iFator := iFator - 1;
      end;
      iResulta := 11 - (iDigito mod 11);
      if ((iResulta = 10) or (iResulta = 11)) then
         sDig11 := '0'
      else
         Str(iResulta:1, sDig11);
      // Validação dos dígitos verificadores \\
      if ((sDig10 = sCPF[10]) and (sDig11 = sCPF[11])) then
         Result := True
      else
         Result := False;
   except
      Result := False;
   end;
end;

// Função de Validação do E-mail \\
function TfrmCadastro.EmailOK(sEmail: String): Boolean;
begin
  if (Pos('@', sEmail) >= 2) and (Pos('.', sEmail) >= 0) then
    Result := True
  else
    Result := False;
end;

// Rotina para carga dos campos da Busca do CEP \\
procedure TfrmCadastro.CarregaCEP(sJSON: String);
var
  JSONObject : TJSONObject;
begin
  try
    JSONObject:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(sJSON), 0) as TJSONObject;
    try
      edtLogradouro.Text  := JSONObject.Get('logradouro').JsonValue.Value;
      edtComplemento.Text := JSONObject.Get('complemento').JsonValue.Value;
      edtBairro.Text      := JSONObject.Get('bairro').JsonValue.Value;
      edtCidade.Text      := JSONObject.Get('localidade').JsonValue.Value;
      edtEstado.Text      := JSONObject.Get('uf').JsonValue.Value;
    except
      edtLogradouro.Clear;
      edtComplemento.Clear;
      edtBairro.Clear;
      edtCidade.Clear;
      edtEstado.Clear;
    end;
  finally
    FreeAndNil(JSONObject);
  end;
end;

// Rotina para gravação dos dados no arquivo XML \\
procedure TfrmCadastro.GravaXML();
var
  XMLDocument: TXMLDocument;
  NodeChave, NodeItem: IXMLNode;
  sArquivo: string;
begin
  sArquivo := ExtractFilePath(Application.ExeName) + 'Cadastro.XML';
  XMLDocument := TXMLDocument.Create(Self);
  try
    XMLDocument.Active := True;
    NodeChave := XMLDocument.AddChild('InfoSistemas');
    NodeChave.ChildValues['Nome']       := edtNome.Text;
    NodeChave.ChildValues['Identidade'] := edtIdentidade.Text;
    NodeChave.ChildValues['CPF']        := mskCPF.Text;
    NodeChave.ChildValues['Telefone']   := edtTelefone.Text;
    NodeChave.ChildValues['E-Mail']     := edtEmail.Text;
    NodeItem := NodeChave.AddChild('Endereco');
    NodeItem.ChildValues['CEP']         := mskCEP.Text;
    NodeItem.ChildValues['Logradouro']  := edtLogradouro.Text;
    NodeItem.ChildValues['Numero']      := edtNumero.Text;
    NodeItem.ChildValues['Complemento'] := edtComplemento.Text;
    NodeItem.ChildValues['Bairro']      := edtBairro.Text;
    NodeItem.ChildValues['Cidade']      := edtCidade.Text;
    NodeItem.ChildValues['Estado']      := edtEstado.Text;
    NodeItem.ChildValues['Pais']        := edtPais.Text;
    XMLDocument.SaveToFile(sArquivo);
    Application.MessageBox(PChar('Arquivo salvo com sucesso!' + chr(13) + sArquivo), 'Informação', MB_OK + MB_ICONINFORMATION);
  finally
    XMLDocument.Free;
  end;
end;

end.
