-- =========================================================
-- Seed demo pending RoomRequests so admin can click "Duyệt"
-- without waiting for student to create request.
-- =========================================================

USE QuanLyNhaTro;
GO

DECLARE @studentId INT =
    (SELECT TOP 1 id FROM dbo.[User] WHERE role = N'STUDENT' ORDER BY id DESC);

IF @studentId IS NULL
BEGIN
    PRINT N'Không tìm thấy student trong dbo.[User]. Hãy seed User trước.';
    RETURN;
END

-- Nếu bạn muốn xoá dữ liệu request cũ trước khi seed:
DELETE FROM dbo.RoomRequests;
GO

INSERT INTO dbo.RoomRequests (user_id, room_id, start_date, duration_months, note, status)
SELECT TOP (5)
    @studentId,
    r.id,
    CONVERT(date, GETDATE()),
    3,
    N'Demo request từ script seed',
    N'PENDING'
FROM dbo.Room r
WHERE r.status = N'AVAILABLE'
ORDER BY r.id DESC;
GO

