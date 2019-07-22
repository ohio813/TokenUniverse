unit NtUtils.Tokens.Misc;

interface

uses
  Winapi.WinNt, Ntapi.ntseapi, NtUtils.Exceptions, NtUtils.Security.Sid;

{ Error formatting }

// Format error locations for querying/setting token information
procedure NtxFormatTokenQuery(var Result: TNtxStatus;
  InfoClass: TTokenInformationClass);
procedure NtxFormatTokenSet(var Result: TNtxStatus;
  InfoClass: TTokenInformationClass);

{ Allocations }

// Prepare PTokenPrivileges
function NtxpAllocPrivileges(Privileges: TArray<TLuid>;
  Attribute: Cardinal): PTokenPrivileges;
function NtxpAllocPrivileges2(Privileges: TArray<TPrivilege>): PTokenPrivileges;

// Prepare PTokenGroups
function NtxpAllocGroups(Sids: TArray<ISid>; Attribute: Cardinal): PTokenGroups;
function NtxpAllocGroups2(Groups: TArray<TGroup>): PTokenGroups;

implementation

{ Error formatting }

procedure NtxFormatTokenQuery(var Result: TNtxStatus;
  InfoClass: TTokenInformationClass);
begin
  Result.Location := 'NtQueryInformationToken';
  Result.LastCall.CallType := lcQuerySetCall;
  Result.LastCall.InfoClass := Cardinal(InfoClass);
  Result.LastCall.InfoClassType := TypeInfo(TTokenInformationClass);
end;

procedure NtxFormatTokenSet(var Result: TNtxStatus;
  InfoClass: TTokenInformationClass);
begin
  Result.Location := 'NtSetInformationToken';
  Result.LastCall.CallType := lcQuerySetCall;
  Result.LastCall.InfoClass := Cardinal(InfoClass);
  Result.LastCall.InfoClassType := TypeInfo(TTokenInformationClass);
end;

{ Allocations }

function NtxpAllocPrivileges(Privileges: TArray<TLuid>;
  Attribute: Cardinal): PTokenPrivileges;
var
  i: Integer;
begin
  Result := AllocMem(SizeOf(Integer) +
    Length(Privileges) * SizeOf(TLUIDAndAttributes));

  Result.PrivilegeCount := Length(Privileges);

  for i := 0 to High(Privileges) do
  begin
    Result.Privileges{$R-}[i]{$R+}.Luid := Privileges[i];
    Result.Privileges{$R-}[i]{$R+}.Attributes := Attribute;
  end;
end;

function NtxpAllocPrivileges2(Privileges: TArray<TPrivilege>): PTokenPrivileges;
var
  i: Integer;
begin
  Result := AllocMem(SizeOf(Integer) +
    Length(Privileges) * SizeOf(TLUIDAndAttributes));

  Result.PrivilegeCount := Length(Privileges);

  for i := 0 to High(Privileges) do
    Result.Privileges{$R-}[i]{$R+} := Privileges[i];
end;

function NtxpAllocGroups(Sids: TArray<ISid>; Attribute: Cardinal): PTokenGroups;
var
  i: Integer;
begin
  Result := AllocMem(SizeOf(Integer) + Length(Sids) * SizeOf(TSIDAndAttributes));

  Result.GroupCount := Length(Sids);

  for i := 0 to High(Sids) do
  begin
    Result.Groups{$R-}[i]{$R+}.Sid := Sids[i].Sid;
    Result.Groups{$R-}[i]{$R+}.Attributes := Attribute;
  end;
end;

function NtxpAllocGroups2(Groups: TArray<TGroup>): PTokenGroups;
var
  i: Integer;
begin
  Result := AllocMem(SizeOf(Integer) +
    Length(Groups) * SizeOf(TSIDAndAttributes));

  Result.GroupCount := Length(Groups);

  for i := 0 to High(Groups) do
  begin
    Result.Groups{$R-}[i]{$R+}.Sid := Groups[i].SecurityIdentifier.Sid;
    Result.Groups{$R-}[i]{$R+}.Attributes := Groups[i].Attributes;
  end;
end;

end.
