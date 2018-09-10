unit UI.Colors;

interface

uses
  Vcl.Graphics, Winapi.Windows, TU.Tokens;

const
  clStale: TColor = $F5DCC2;
  clEnabledByDefault: TColor = $C0F0C0;
  clEnabled: TColor = $E0F0E0;
  clDisabled: TColor = $E0E0F0;
  clUseForDenyOnly: TColor = $D0D0F0;
  clIntegrity: TColor = $F0D0D0;

function GroupAttributesToColor(Attributes: TGroupAttributes;
  Default: TColor = clWindow): TColor;

function PrivilegeToColor(Privilege: TPrivilege;
  Default: TColor = clWindow): TColor;

implementation

function GroupAttributesToColor(Attributes: TGroupAttributes;
  Default: TColor = clWindow): TColor;
begin
  if Attributes.Contain(GroupIntegrityEnabled) then
    Result := clIntegrity
  else if Attributes.Contain(GroupEnabledByDefault) then
    Result := clEnabledByDefault
  else if Attributes.Contain(GroupEnabled) then
    Result := clEnabled
  else if Attributes.Contain(GroupUforDenyOnly) then
    Result := clUseForDenyOnly
  else
    Result := clDisabled;
end;

function PrivilegeToColor(Privilege: TPrivilege;
  Default: TColor = clWindow): TColor;
begin
  if Privilege.AttributesContain(SE_PRIVILEGE_ENABLED_BY_DEFAULT) then
    Result := clEnabledByDefault
  else if Privilege.AttributesContain(SE_PRIVILEGE_ENABLED) then
    Result := clEnabled
  else if Privilege.Attributes = 0 then
    Result := clDisabled
  else
    Result := Default;
end;

end.
