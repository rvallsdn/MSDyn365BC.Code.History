// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------

permissionset 9175 "User Settings - Objects"
{
    Access = Internal;
    Assignable = false;

    IncludedPermissionSets = "Environment Info. - Objects";

    Permissions = Codeunit "User Settings Impl." = X,
                  Codeunit "User Settings" = X,
                  Page "Accessible Companies" = X,
                  Page "User Personalization" = X,
                  Page "User Settings FactBox" = X,
                  Page "User Settings List" = X,
                  Page "User Settings" = X,
                  Page Roles = X,
                  Table "Extra Settings" = X,
                  Table "User Settings" = X;
}
