-- =========================================================
-- Add tables for:
--  - RoomRequests: sinh viên gửi yêu cầu thuê (PENDING/APPROVED/REJECTED)
--  - Contracts: hợp đồng đã được admin duyệt
--
-- Assumes existing tables:
--   dbo.[User] (id, email, password, full_name, role, created_at)
--   dbo.Room   (id, code, area, price_month, status, description, created_at)
--
-- Run in SSMS against database QuanLyNhaTro.
-- =========================================================

USE QuanLyNhaTro;
GO

/* ---------- RoomRequests ---------- */
IF OBJECT_ID(N'dbo.RoomRequests', N'U') IS NOT NULL
    DROP TABLE dbo.RoomRequests;
GO

CREATE TABLE dbo.RoomRequests (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    room_id INT NOT NULL,
    start_date DATE NOT NULL,
    duration_months INT NOT NULL,
    note NVARCHAR(1000) NULL,
    status NVARCHAR(20) NOT NULL CONSTRAINT DF_RoomRequests_status DEFAULT N'PENDING', -- PENDING | APPROVED | REJECTED
    created_at DATETIME2 NOT NULL CONSTRAINT DF_RoomRequests_created_at DEFAULT SYSUTCDATETIME(),

    CONSTRAINT FK_RoomRequests_User FOREIGN KEY (user_id) REFERENCES dbo.[User](id),
    CONSTRAINT FK_RoomRequests_Room FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
    CONSTRAINT CK_RoomRequests_status CHECK (status IN (N'PENDING', N'APPROVED', N'REJECTED')),
    CONSTRAINT CK_RoomRequests_duration CHECK (duration_months > 0)
);
GO

CREATE INDEX IX_RoomRequests_status_created_at ON dbo.RoomRequests(status, created_at DESC);
GO

/* ---------- Contracts ---------- */
IF OBJECT_ID(N'dbo.Contracts', N'U') IS NOT NULL
    DROP TABLE dbo.Contracts;
GO

CREATE TABLE dbo.Contracts (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    room_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NULL,
    status NVARCHAR(20) NOT NULL CONSTRAINT DF_Contracts_status DEFAULT N'ACTIVE', -- ACTIVE | ENDED | CANCELLED
    created_at DATETIME2 NOT NULL CONSTRAINT DF_Contracts_created_at DEFAULT SYSUTCDATETIME(),

    CONSTRAINT FK_Contracts_User FOREIGN KEY (user_id) REFERENCES dbo.[User](id),
    CONSTRAINT FK_Contracts_Room FOREIGN KEY (room_id) REFERENCES dbo.Room(id),
    CONSTRAINT CK_Contracts_status CHECK (status IN (N'ACTIVE', N'ENDED', N'CANCELLED')),
    CONSTRAINT CK_Contracts_end_date CHECK (end_date IS NULL OR end_date >= start_date)
);
GO

-- (Optional) phòng hoặc user chỉ có tối đa 1 hợp đồng ACTIVE
CREATE UNIQUE INDEX UX_Contracts_ActiveRoom
ON dbo.Contracts(room_id)
WHERE status = N'ACTIVE';
GO

CREATE UNIQUE INDEX UX_Contracts_ActiveUser
ON dbo.Contracts(user_id)
WHERE status = N'ACTIVE';
GO

