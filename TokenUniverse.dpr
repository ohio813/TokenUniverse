program TokenUniverse;

uses
  Vcl.Forms,
  TU.Tokens in 'Core\TU.Tokens.pas',
  UI.TokenListFrame in 'UI\UI.TokenListFrame.pas' {FrameTokenList: TFrame},
  UI.MainForm in 'UI\UI.MainForm.pas' {FormMain},
  UI.Modal.AccessAndType in 'UI\UI.Modal.AccessAndType.pas' {DialogAccessAndType},
  UI.HandleSearch in 'UI\UI.HandleSearch.pas' {FormHandleSearch},
  UI.Information in 'UI\UI.Information.pas' {InfoDialog},
  UI.ProcessList in 'UI\UI.ProcessList.pas' {ProcessListDialog},
  TU.RestartSvc in 'Core\TU.RestartSvc.pas',
  TU.Suggestions in 'Core\TU.Suggestions.pas',
  UI.Restrict in 'UI\UI.Restrict.pas' {DialogRestrictToken},
  UI.Colors in 'UI\UI.Colors.pas',
  UI.Prototypes in 'UI\UI.Prototypes.pas',
  TU.Credentials in 'Core\TU.Credentials.pas',
  UI.Modal.Logon in 'UI\UI.Modal.Logon.pas' {LogonDialog},
  UI.Prototypes.ChildForm in 'UI\UI.Prototypes.ChildForm.pas',
  UI.Modal.PickUser in 'UI\UI.Modal.PickUser.pas' {DialogPickUser},
  TU.ObjPicker in 'Core\TU.ObjPicker.pas',
  UI.CreateToken in 'UI\UI.CreateToken.pas' {DialogCreateToken},
  TU.Tokens.Types in 'Core\TU.Tokens.Types.pas',
  UI.Modal.Columns in 'UI\UI.Modal.Columns.pas' {DialogColumns},
  UI.Settings in 'UI\UI.Settings.pas',
  UI.Modal.Access in 'UI\UI.Modal.Access.pas' {DialogAccess},
  UI.Modal.ComboDlg in 'UI\UI.Modal.ComboDlg.pas' {ComboDialog},
  TU.Winapi in 'Core\TU.Winapi.pas',
  UI.Modal.ThreadList in 'UI\UI.Modal.ThreadList.pas' {ThreadListDialog},
  UI.Information.Access in 'UI\UI.Information.Access.pas' {DialogGrantedAccess},
  UI.Modal.PickToken in 'UI\UI.Modal.PickToken.pas' {DialogPickToken},
  UI.New.Safer in 'UI\UI.New.Safer.pas' {DialogSafer},
  UI.Prototypes.AuditFrame in 'UI\UI.Prototypes.AuditFrame.pas' {FrameAudit: TFrame},
  UI.Prototypes.Logon in 'UI\UI.Prototypes.Logon.pas' {FrameLogon: TFrame},
  UI.Prototypes.Privileges in 'UI\UI.Prototypes.Privileges.pas' {FramePrivileges: TFrame},
  UI.Prototypes.Groups in 'UI\UI.Prototypes.Groups.pas' {FrameGroups: TFrame},
  UI.Sid.View in 'UI\UI.Sid.View.pas' {DialogSidView},
  UI.Prototypes.Lsa.Rights in 'UI\UI.Prototypes.Lsa.Rights.pas' {FrameLsaRights: TFrame},
  UI.Prototypes.Lsa.Privileges in 'UI\UI.Prototypes.Lsa.Privileges.pas' {FrameLsaPrivileges: TFrame},
  UI.Audit.System in 'UI\UI.Audit.System.pas' {DialogSystemAudit},
  UI.Process.Run in 'UI\UI.Process.Run.pas' {DialogRun},
  Ntapi.ntdef in 'NtUtils\Headers\Ntapi.ntdef.pas',
  Ntapi.ntexapi in 'NtUtils\Headers\Ntapi.ntexapi.pas',
  Ntapi.ntioapi in 'NtUtils\Headers\Ntapi.ntioapi.pas',
  Ntapi.ntkeapi in 'NtUtils\Headers\Ntapi.ntkeapi.pas',
  Ntapi.ntldr in 'NtUtils\Headers\Ntapi.ntldr.pas',
  Ntapi.ntmmapi in 'NtUtils\Headers\Ntapi.ntmmapi.pas',
  Ntapi.ntobapi in 'NtUtils\Headers\Ntapi.ntobapi.pas',
  Ntapi.ntpebteb in 'NtUtils\Headers\Ntapi.ntpebteb.pas',
  Ntapi.ntpsapi in 'NtUtils\Headers\Ntapi.ntpsapi.pas',
  Ntapi.ntregapi in 'NtUtils\Headers\Ntapi.ntregapi.pas',
  Ntapi.ntrtl in 'NtUtils\Headers\Ntapi.ntrtl.pas',
  Ntapi.ntsam in 'NtUtils\Headers\Ntapi.ntsam.pas',
  Ntapi.ntseapi in 'NtUtils\Headers\Ntapi.ntseapi.pas',
  Ntapi.ntstatus in 'NtUtils\Headers\Ntapi.ntstatus.pas',
  Winapi.ntlsa in 'NtUtils\Headers\Winapi.ntlsa.pas',
  Winapi.NtSecApi in 'NtUtils\Headers\Winapi.NtSecApi.pas',
  Winapi.ProcessThreadsApi in 'NtUtils\Headers\Winapi.ProcessThreadsApi.pas',
  Winapi.Sddl in 'NtUtils\Headers\Winapi.Sddl.pas',
  Winapi.securitybaseapi in 'NtUtils\Headers\Winapi.securitybaseapi.pas',
  Winapi.Shell in 'NtUtils\Headers\Winapi.Shell.pas',
  Winapi.Shlwapi in 'NtUtils\Headers\Winapi.Shlwapi.pas',
  Winapi.Svc in 'NtUtils\Headers\Winapi.Svc.pas',
  Winapi.UserEnv in 'NtUtils\Headers\Winapi.UserEnv.pas',
  Winapi.Wdc in 'NtUtils\Headers\Winapi.Wdc.pas',
  Winapi.WinBase in 'NtUtils\Headers\Winapi.WinBase.pas',
  Winapi.WinError in 'NtUtils\Headers\Winapi.WinError.pas',
  Winapi.WinNt in 'NtUtils\Headers\Winapi.WinNt.pas',
  Winapi.WinSafer in 'NtUtils\Headers\Winapi.WinSafer.pas',
  Winapi.winsta in 'NtUtils\Headers\Winapi.winsta.pas',
  Winapi.WinUser in 'NtUtils\Headers\Winapi.WinUser.pas',
  DelphiUtils.Events in 'NtUtils\DelphiUtils.Events.pas',
  DelphiUtils.Strings in 'NtUtils\DelphiUtils.Strings.pas',
  NtUtils.Access.Expected in 'NtUtils\NtUtils.Access.Expected.pas',
  NtUtils.Access in 'NtUtils\NtUtils.Access.pas',
  NtUtils.Environment in 'NtUtils\NtUtils.Environment.pas',
  NtUtils.ErrorMsg in 'NtUtils\NtUtils.ErrorMsg.pas',
  NtUtils.Exceptions in 'NtUtils\NtUtils.Exceptions.pas',
  NtUtils.Exec.Nt in 'NtUtils\NtUtils.Exec.Nt.pas',
  NtUtils.Exec in 'NtUtils\NtUtils.Exec.pas',
  NtUtils.Exec.Shell in 'NtUtils\NtUtils.Exec.Shell.pas',
  NtUtils.Exec.Wdc in 'NtUtils\NtUtils.Exec.Wdc.pas',
  NtUtils.Exec.Win32 in 'NtUtils\NtUtils.Exec.Win32.pas',
  NtUtils.Exec.Wmi in 'NtUtils\NtUtils.Exec.Wmi.pas',
  NtUtils.Ldr in 'NtUtils\NtUtils.Ldr.pas',
  NtUtils.Lsa.Audit in 'NtUtils\NtUtils.Lsa.Audit.pas',
  NtUtils.Lsa.Logon in 'NtUtils\NtUtils.Lsa.Logon.pas',
  NtUtils.Lsa in 'NtUtils\NtUtils.Lsa.pas',
  NtUtils.Objects.Compare in 'NtUtils\NtUtils.Objects.Compare.pas',
  NtUtils.Objects in 'NtUtils\NtUtils.Objects.pas',
  NtUtils.Objects.Snapshots in 'NtUtils\NtUtils.Objects.Snapshots.pas',
  NtUtils.Processes in 'NtUtils\NtUtils.Processes.pas',
  NtUtils.Processes.Snapshots in 'NtUtils\NtUtils.Processes.Snapshots.pas',
  NtUtils.Security.Acl in 'NtUtils\NtUtils.Security.Acl.pas',
  NtUtils.Security.Sid in 'NtUtils\NtUtils.Security.Sid.pas',
  NtUtils.Strings in 'NtUtils\NtUtils.Strings.pas',
  NtUtils.Svc in 'NtUtils\NtUtils.Svc.pas',
  NtUtils.Svc.SingleTaskSvc in 'NtUtils\NtUtils.Svc.SingleTaskSvc.pas',
  NtUtils.Threads in 'NtUtils\NtUtils.Threads.pas',
  NtUtils.Tokens.Impersonate in 'NtUtils\NtUtils.Tokens.Impersonate.pas',
  NtUtils.Tokens.Logon in 'NtUtils\NtUtils.Tokens.Logon.pas',
  NtUtils.Tokens.Misc in 'NtUtils\NtUtils.Tokens.Misc.pas',
  NtUtils.Tokens in 'NtUtils\NtUtils.Tokens.pas',
  NtUtils.WinSafer in 'NtUtils\NtUtils.WinSafer.pas',
  NtUtils.WinStation in 'NtUtils\NtUtils.WinStation.pas',
  NtUtils.WinUser in 'NtUtils\NtUtils.WinUser.pas',
  VclEx.ListView in 'VclEx\VclEx.ListView.pas';

{$R *.res}

begin
  // Running as a service
  if ParamStr(1) = RESVC_PARAM then
  begin
    SvcxMain(RESVC_NAME, ReSvcRunInSession);
    Exit;
  end;

  // The user delegated us to create a service
  if ParamStr(1) = DELEGATE_PARAM then
  begin
    ReSvcCreateService(ParamStr(2) = RESVC_SYSPLUS_PARAM).RaiseOnError;
    Exit;
  end;

  // Normal mode
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Token Universe';
  Application.HintHidePause := 20000;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
