program Teste_InfoSistemas;

uses
  Vcl.Forms,
  uCadastro in 'uCadastro.pas' {frmCadastro},
  uEMail in 'uEMail.pas' {frmEmail};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCadastro, frmCadastro);
  Application.Run;
end.
