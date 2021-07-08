program VOSP;

uses
  Forms,
  FIRST in 'first\FIRST.pas' {MAIN},
  nrz_unit in 'nrz\nrz_unit.pas' {NRZ},
  rz_unit in 'rz\rz_unit.pas' {RZ},
  cmi_unit in 'cmi\cmi_unit.pas' {CMI},
  mcmi_unit in 'mcmi\mcmi_unit.pas' {MCMI},
  miller_unit in 'miller\miller_unit.pas' {MILLER},
  manches_unit in 'manches\manches_unit.pas' {MANCHES},
  fivebsixb_unit in 'fivebsixb\fivebsixb_unit.pas' {FIVEBSIXB},
  ami_unit in 'ami\ami_unit.pas' {AMI},
  hdbthree_unit in 'hdbthree\hdbthree_unit.pas' {HDBTHREE},
  test_unit in 'test\test_unit.pas' {TEST};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'VOSP';
  Application.CreateForm(TMAIN, MAIN);
  Application.CreateForm(TNRZ, NRZ);
  Application.CreateForm(TRZ, RZ);
  Application.CreateForm(TCMI, CMI);
  Application.CreateForm(TMCMI, MCMI);
  Application.CreateForm(TMILLER, MILLER);
  Application.CreateForm(TMANCHES, MANCHES);
  Application.CreateForm(TFIVEBSIXB, FIVEBSIXB);
  Application.CreateForm(TAMI, AMI);
  Application.CreateForm(THDBTHREE, HDBTHREE);
  Application.CreateForm(TTEST, TEST);
  Application.Run;
end.
