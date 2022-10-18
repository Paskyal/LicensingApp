permissionset 70100 "EVT PermissionSet"
{
    Assignable = true;
    Caption = 'PermissionSet', MaxLength = 30;
    Permissions =
        table "EVT License Setup" = X,
        tabledata "EVT License Setup" = RMID,
        table "EVT Customer License" = X,
        tabledata "EVT Customer License" = RMID,
        page "EVT License Setup list" = X,
        tabledata "EVT License Entry" = RMID,
        table "EVT License Entry" = X;
}
