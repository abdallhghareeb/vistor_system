---
name: AVMS Kiosk API Endpoints
description: "AVMS OpenAPI endpoints for Auth, Areas, Devices, Invitations, Reports, Users, Roles, and Settings."
type: reference
lastUpdated: 2026-07-25T14:10
lastRecall: 2026-07-25T14:21
---

# AVMS Kiosk API Collection (Avms_Api.json)

**Source:** `C:/Users/abdal/OneDrive/Desktop/Avms_Api.json`
**Type:** OpenAPI 3.0.1 specification
**Base URL (implied):** `/api/v1/` (some endpoints use `/api/` directly)

## Endpoints by Tag

### Auth (7 endpoints)
| Method | Path | Description |
|--------|------|-------------|
| POST | /api/v1/auth/sign-in | Login |
| POST | /api/v1/auth/register | Register |
| POST | /api/v1/auth/change-password | Change password |
| POST | /api/v1/auth/forget-password | Forgot password |
| POST | /api/v1/auth/reset-password | Reset password |
| GET | /api/v1/auth/GenrateNewToken | Refresh token |
| POST | /api/v1/auth/user-role | Get user role |

### Areas (8 endpoints)
GET /api/v1/area/get (param: OwnerId), GET /api/v1/area/unit, GET /api/v1/area/{id}, POST /api/v1/area/create, POST /api/v1/area/delete/{id}, POST /api/v1/area/edit/{id}, POST /api/v1/area/edit-deleted-area/{id}, POST /api/v1/area/IsActive

### AreaTypes (6 endpoints)
POST create, POST delete/{id}, POST edit/{id}, POST edit-deleted-areatype/{id}, GET get, GET get/{id}

### BlackLists (6 endpoints)
POST create, POST delete, POST delete/{id}, POST edit/{id}, GET get-all, GET /{id}

### Dashboards (7 endpoints)
GET HourlyVisitorCount, GET MonthlyVisitorCount, GET TabsInfo, GET TopFiveInvitations, GET TotalVisitorLineChart, GET WeeklyVisitorCount, GET WeeklyVisitorPerDayCount

### Devices (8 endpoints)
POST create, POST delete/{id}, POST edit/{id}, POST edit-deleted-device, GET get, GET /{id}, GET device-Ip/{ip}, POST UpdateDeviceIsActive, POST UpdateShowAllUnits, POST UpdateUsingScanner

### DevicesTyepes [sic] (6 endpoints)
POST create, POST delete/{id}, POST edit/{id}, POST edit-deleted-devicetype, GET get, GET /{id}

### Documents (2 endpoints)
GET AllTransactionDocuments, GET InvitationDocuments

### Hardwares (1 endpoint)
POST /api/v1/hardware/printing

### Invitations (7 endpoints)
POST create, POST createGroup, POST cancle [sic], GET get-all, GET get-all-groups, GET get/{id}, GET getbydocumentid

### InvitationDocType (6 endpoints)
POST create, POST delete/{id}, POST edit/{id}, POST edit-deleted-InviatationDocType/{id}, GET get, GET /{id}

### License (3 endpoints)
POST InstalLic [sic], GET LicenseInfo, POST RequestLicense

### Report (~40+ endpoints)
Categories: AllVisitors, AllTransactionReport, BlackListSummary/Details, InvitationSummary/Details, TransactionSummary, TransactionInvitationDetails, UnitsDaily/Weekly/Monthly Transactions + Summary + Details, UnitsIdentificationSummary/Details, UserDaily/Weekly/Monthly Transactions + Summary + Details, UserIdentificationSummary/Details, VisitorDaily/Weekly/Monthly Transactions + Summary + Details, VisitorsIdentificationSummary/Details, VisitTypesSummary/Details

### Roles (5 endpoints)
POST create-permission, POST create-role, POST delete-role, GET get-role, GET get-role-permission/{roleId}

### Settings (8 endpoints)
GET /api/v1/setting, POST BackupSettings, POST EmailSetting, GET GetIntegrationSettings, GET GetRbhIntegrationSettings, POST TestConnection, POST TestConnectionEdit, POST TestRbhConnection, POST UpdateRbhIntegrationSettings

### Terminal (1 endpoint)
GET /api/v1/terminal/get-unit

### Transaction (2 endpoints)
POST /api/v1/transaction/create, GET /api/v1/transaction/get-last-status/{cardNumber}

### Users (11 endpoints)
GET /{id}, GET account-status, POST account-status, POST assign-role, POST delete, POST edit-deleted-users, GET get-user-roles/{userId}, GET get-users, POST UpdateUser, POST UserIsActive

### VisitTypes (5 endpoints)
POST create, POST delete/{id}, POST edit/{id}, GET get, GET /{id}

### AuditLog (1 endpoint)
GET /api/AuditLog/GetAllAuditLogs
