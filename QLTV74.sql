USE [master]
GO
ALTER DATABASE QLTV74 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE QLTV74;
GO
-- 1. Tạo cơ sở dữ liệu


CREATE DATABASE [QLTV74]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QLTV74', FILENAME = N'D:\QLTV74.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QLTV74_log', FILENAME = N'D:\QLTV74_log.ldf' , SIZE = 3456KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

USE [QLTV74]
GO

-- 2. Tạo bảng DAUSACH
CREATE TABLE DAUSACH (
    MADAUSACH CHAR(10) NOT NULL PRIMARY KEY,
    TENSACH NVARCHAR(100) NOT NULL,
    TENTACGIA NVARCHAR(100) NOT NULL,
    THELOAI NVARCHAR(50) NULL,
    NAMXB INT NOT NULL,
    NXB NVARCHAR(100) NOT NULL,
    NDTOMTAT TEXT NULL,
    NGONNGU NVARCHAR(50) NULL,
    SOLUONG INT NOT NULL
);

-- Thêm ví dụ dữ liệu vào bảng DAUSACH
INSERT INTO DAUSACH VALUES ('DS001', N'Truyen Kieu', N'Nguyen Du', N'Truyen Tho', 1820, N'NXB Van Hoc', NULL, N'Tieng Viet', 10);
INSERT INTO DAUSACH VALUES ('DS002', N'Dac Nhan Tam', N'Dale Carnegie', N'Tam Ly', 1936, N'NXB Tre', NULL, N'Tieng Viet', 5);
INSERT INTO DAUSACH VALUES ('DS003', N'Tuoi Tre Dang Gia Bao Nhieu', N'Rosie Nguyen', N'Tu Van', 2016, N'NXB Tre', NULL, N'Tieng Viet', 8);
INSERT INTO DAUSACH VALUES ('DS004', N'Tam Quoc Dien Nghia', N'La Quan Trung', N'Lich Su', 1522, N'NXB Van Hoc', NULL, N'Tieng Viet', 6);
INSERT INTO DAUSACH VALUES ('DS005', N'Harry Potter', N'J.K. Rowling', N'Tieu Thuyet', 1997, N'NXB Tre', NULL, N'Tieng Anh', 15);

-- 3. Tạo bảng SACH
CREATE TABLE SACH (
    MASACH CHAR(10) NOT NULL PRIMARY KEY,
    MADAUSACH CHAR(10) NOT NULL,
    TINHTRANG NVARCHAR(50) NOT NULL,
    VITRI NVARCHAR(100) NULL,
    FOREIGN KEY (MADAUSACH) REFERENCES DAUSACH(MADAUSACH)
);

-- Thêm ví dụ dữ liệu vào bảng SACH
INSERT INTO SACH VALUES ('S001', 'DS001', N'Tot', N'Ke Sach A1');
INSERT INTO SACH VALUES ('S002', 'DS001', N'Hu Hong', N'Ke Sach A2');
INSERT INTO SACH VALUES ('S003', 'DS002', N'Tot', N'Ke Sach B1');
INSERT INTO SACH VALUES ('S004', 'DS003', N'Tot', N'Ke Sach C1');
INSERT INTO SACH VALUES ('S005', 'DS004', N'Tot', N'Ke Sach D1');
INSERT INTO SACH VALUES ('S006', 'DS005', N'Tot', N'Ke Sach E1');
INSERT INTO SACH VALUES ('S007', 'DS005', N'Mat', N'Ke Sach E2');

-- 4. Tạo bảng DOCGIA
CREATE TABLE DOCGIA (
    MADG CHAR(10) NOT NULL PRIMARY KEY,
    TENDG NVARCHAR(100) NOT NULL,
    NGAYSINH DATE NOT NULL,
    GT NVARCHAR(10) NOT NULL,
    DIACHI NVARCHAR(200) NULL,
    EMAIL NVARCHAR(100) NULL
);

-- Thêm ví dụ dữ liệu vào bảng DOCGIA
INSERT INTO DOCGIA VALUES ('DG001', N'Nguyen Van A', '1990-05-12', N'Nam', N'Hanoi', N'vana@gmail.com');
INSERT INTO DOCGIA VALUES ('DG002', N'Tran Thi B', '1995-03-18', N'Nu', N'HCM City', N'thib@gmail.com');
INSERT INTO DOCGIA VALUES ('DG003', N'Pham Van C', '1988-11-22', N'Nam', N'Da Nang', N'pvc@gmail.com');
INSERT INTO DOCGIA VALUES ('DG004', N'Le Thi D', '2000-01-01', N'Nu', N'Can Tho', N'led@gmail.com');
INSERT INTO DOCGIA VALUES ('DG005', N'Hoang Van E', '1992-07-15', N'Nam', N'Hue', N'hve@gmail.com');

-- 5. Tạo bảng PHIEUMUON
CREATE TABLE PHIEUMUON (
    MAPM CHAR(10) NOT NULL PRIMARY KEY,
    MADG CHAR(10) NOT NULL,
    NGAYMUON DATE NOT NULL,
    NGAYDKTRA DATE NOT NULL,
    MANV CHAR(10) NULL,
    TRANGTHAI NVARCHAR(50) NOT NULL DEFAULT 'Dang muon',
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG)
);

-- Thêm ví dụ dữ liệu vào bảng PHIEUMUON
INSERT INTO PHIEUMUON VALUES ('PM001', 'DG001', '2024-01-01', '2024-01-10', NULL, 'Dang muon');
INSERT INTO PHIEUMUON VALUES ('PM002', 'DG002', '2024-02-01', '2024-02-15', NULL, 'Dang muon');
INSERT INTO PHIEUMUON VALUES ('PM003', 'DG003', '2024-03-01', '2024-03-10', 'NV001', 'Dang muon');
INSERT INTO PHIEUMUON VALUES ('PM004', 'DG004', '2024-04-01', '2024-04-15', 'NV002', 'Dang tra');
INSERT INTO PHIEUMUON VALUES ('PM005', 'DG005', '2024-05-01', '2024-05-10', 'NV001', 'Qua han');

-- 6. Tạo bảng MUONTRA
CREATE TABLE MUONTRA (
    MAMT CHAR(10) NOT NULL PRIMARY KEY,
    MAPM CHAR(10) NOT NULL,
    MASACH CHAR(10) NOT NULL,
    NGAYTRA DATE NULL,
    FOREIGN KEY (MAPM) REFERENCES PHIEUMUON(MAPM),
    FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
);
CREATE TABLE CHITIETMUONTRA (
    MAMT CHAR(10) NOT NULL, -- Mã mượn trả
    MASACH CHAR(10) NOT NULL, -- Mã sách
    PRIMARY KEY (MAMT, MASACH), -- Khóa chính là sự kết hợp giữa MAMT và MASACH
    FOREIGN KEY (MAMT) REFERENCES MUONTRA(MAMT), -- Khóa ngoại tham chiếu tới bảng MUONTRA
    FOREIGN KEY (MASACH) REFERENCES SACH(MASACH) -- Khóa ngoại tham chiếu tới bảng SACH
	);
-- Thêm ví dụ dữ liệu vào bảng MUONTRA
INSERT INTO MUONTRA VALUES ('MT001', 'PM001', 'S001', NULL);
INSERT INTO MUONTRA VALUES ('MT002', 'PM002', 'S002', '2024-02-10');
INSERT INTO MUONTRA VALUES ('MT003', 'PM003', 'S003', NULL);
INSERT INTO MUONTRA VALUES ('MT004', 'PM004', 'S004', '2024-04-16');
INSERT INTO MUONTRA VALUES ('MT005', 'PM005', 'S005', NULL);

-- 7. Tạo bảng NHANVIEN
CREATE TABLE NHANVIEN (
    MANV CHAR(10) NOT NULL PRIMARY KEY,
    TENNV NVARCHAR(100) NOT NULL,
    CHUCVU NVARCHAR(50) NOT NULL,
    DIENTHOAI NVARCHAR(15) NULL,
    EMAIL NVARCHAR(100) NULL,
    NGAYVAOLAM DATE NOT NULL
);

-- Thêm ví dụ dữ liệu vào bảng NHANVIEN
INSERT INTO NHANVIEN VALUES ('NV001', N'Le Van C', N'Thu Thu', '0123456789', N'c.le@gmail.com', '2020-01-01');
INSERT INTO NHANVIEN VALUES ('NV002', N'Pham Thi D', N'Quan Ly', '0987654321', N'd.pham@gmail.com', '2018-06-15');
INSERT INTO NHANVIEN VALUES ('NV003', N'Nguyen Van F', N'Thu Thu', '0934567890', N'vanf@gmail.com', '2021-07-01');
INSERT INTO NHANVIEN VALUES ('NV004', N'Tran Thi G', N'Quan Ly', '0912345678', N'g.tran@gmail.com', '2019-03-20');

-- 8. Tạo bảng PHAT
CREATE TABLE PHAT (
    MAPHAT CHAR(10) NOT NULL PRIMARY KEY,
    MADG CHAR(10) NOT NULL,
    MASACH CHAR(10) NOT NULL,
    LYDOPHAT NVARCHAR(200) NOT NULL,
    SOTIENPHAT DECIMAL(10, 2) NOT NULL,
    NGAYPHAT DATE NOT NULL,
    TRANGTHAI NVARCHAR(50) NULL,
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
);

-- Thêm ví dụ dữ liệu vào bảng PHAT
INSERT INTO PHAT VALUES ('P001', 'DG001', 'S001', N'Muon qua han', 50000, '2024-01-15', N'Chua dong');
INSERT INTO PHAT VALUES ('P002', 'DG002', 'S002', N'Thiet hai sach', 100000, '2024-02-20', N'Da dong');
INSERT INTO PHAT VALUES ('P003', 'DG003', 'S003', N'Muon qua han', 30000, '2024-03-15', N'Chua dong');
INSERT INTO PHAT VALUES ('P004', 'DG004', 'S004', N'Thiet hai sach', 150000, '2024-04-20', N'Da dong');

-- 9. Tạo bảng NGUOIDUNG
CREATE TABLE NGUOIDUNG (
    TENDANGNHAP NVARCHAR(50) NOT NULL PRIMARY KEY,
    MATKHAU NVARCHAR(100) NOT NULL,
    LOAI INT NOT NULL,
    MANV CHAR(10) NULL,
    MADG CHAR(10) NULL,
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG)
);

-- Thêm ví dụ dữ liệu vào bảng NGUOIDUNG
INSERT INTO NGUOIDUNG VALUES ('admin', 'admin123', 1, 'NV002', NULL);
INSERT INTO NGUOIDUNG VALUES ('dg001', 'pass123', 2, NULL, 'DG001');
INSERT INTO NGUOIDUNG VALUES ('dg002', 'pass456', 2, NULL, 'DG002');
INSERT INTO NGUOIDUNG VALUES ('nv001', 'nvpass1', 1, 'NV001', NULL);
INSERT INTO NGUOIDUNG VALUES ('nv003', 'nvpass3', 1, 'NV003', NULL);

-- 10. Tạo bảng THE
CREATE TABLE THE (
    MATHE CHAR(10) NOT NULL PRIMARY KEY,
    MADG CHAR(10) NOT NULL,
    NGAYCAP DATE NOT NULL,
    NGAYHETHAN DATE NOT NULL,
    TRANGTHAI NVARCHAR(50) NOT NULL DEFAULT 'Con hieu luc',
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG)
);

-- Thêm ví dụ dữ liệu vào bảng THE
INSERT INTO THE VALUES ('T001', 'DG001', '2023-01-01', '2025-01-01', 'Con hieu luc');
INSERT INTO THE VALUES ('T002', 'DG002', '2023-06-01', '2025-06-01', 'Con hieu luc');
INSERT INTO THE VALUES ('T003', 'DG003', '2023-03-01', '2025-03-01', 'Con hieu luc');
INSERT INTO THE VALUES ('T004', 'DG004', '2023-07-01', '2025-07-01', 'Con hieu luc');
INSERT INTO THE VALUES ('T005', 'DG005', '2023-09-01', '2025-09-01', 'Het hieu luc');

-- 11. Tạo bảng HOADON
CREATE TABLE HOADON (
    MAHD CHAR(10) NOT NULL PRIMARY KEY,
    NGAYHD DATE NOT NULL,
    MANV CHAR(10) NULL,
    MADG CHAR(10) NULL,
    TONGTIEN DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG)
);

-- Thêm ví dụ dữ liệu vào bảng HOADON
INSERT INTO HOADON VALUES ('HD001', '2024-01-05', 'NV001', 'DG001', 50000);
INSERT INTO HOADON VALUES ('HD002', '2024-02-10', 'NV002', 'DG002', 100000);
INSERT INTO HOADON VALUES ('HD003', '2024-03-15', 'NV003', 'DG003', 150000);
INSERT INTO HOADON VALUES ('HD004', '2024-04-20', 'NV004', 'DG004', 200000);

-- 12. Tạo bảng DANGKYMUON
CREATE TABLE DANGKYMUON (
    MADK CHAR(10) NOT NULL PRIMARY KEY,
    MADG CHAR(10) NOT NULL,
    MASACH CHAR(10) NOT NULL,
    NGAYDANGKY DATE NOT NULL,
    TRANGTHAI NVARCHAR(50) NOT NULL DEFAULT 'Cho xu ly',
    FOREIGN KEY (MADG) REFERENCES DOCGIA(MADG),
    FOREIGN KEY (MASACH) REFERENCES SACH(MASACH)
);

-- Thêm ví dụ dữ liệu vào bảng DANGKYMUON
INSERT INTO DANGKYMUON VALUES ('DK001', 'DG001', 'S001', '2024-03-01', 'Cho xu ly');
INSERT INTO DANGKYMUON VALUES ('DK002', 'DG002', 'S002', '2024-03-05', 'Da xu ly');
INSERT INTO DANGKYMUON VALUES ('DK003', 'DG003', 'S003', '2024-04-01', 'Cho xu ly');
INSERT INTO DANGKYMUON VALUES ('DK004', 'DG004', 'S004', '2024-05-01', 'Da xu ly');
INSERT INTO DANGKYMUON VALUES ('DK005', 'DG005', 'S005', '2024-06-01', 'Cho xu ly');


-- Thêm khóa ngoại cho bảng SACH
ALTER TABLE SACH
ADD CONSTRAINT FK_MADAUSACH FOREIGN KEY (MADAUSACH)
REFERENCES DAUSACH (MADAUSACH)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng PHIEUMUON
ALTER TABLE PHIEUMUON
ADD CONSTRAINT FK_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng MUONTRA
ALTER TABLE MUONTRA
ADD CONSTRAINT FK_MaPM FOREIGN KEY (MAPM)
REFERENCES PHIEUMUON (MaPM)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng PHAT
ALTER TABLE PHAT
ADD CONSTRAINT FK_PHAT_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

ALTER TABLE PHAT
ADD CONSTRAINT FK_PHAT_MASACH FOREIGN KEY (MASACH)
REFERENCES SACH (MASACH)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng NGUOIDUNG
ALTER TABLE NGUOIDUNG
ADD CONSTRAINT FK_NGUOIDUNG_MANV FOREIGN KEY (MANV)
REFERENCES NHANVIEN (MANV)
ON DELETE CASCADE;

ALTER TABLE NGUOIDUNG
ADD CONSTRAINT FK_NGUOIDUNG_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng THE
ALTER TABLE THE
ADD CONSTRAINT FK_THE_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng HOADON
ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MANV FOREIGN KEY (MANV)
REFERENCES NHANVIEN (MANV)
ON DELETE CASCADE;

ALTER TABLE HOADON
ADD CONSTRAINT FK_HOADON_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

-- Thêm khóa ngoại cho bảng DANGKYMUON
ALTER TABLE DANGKYMUON
ADD CONSTRAINT FK_DANGKYMUON_MADG FOREIGN KEY (MADG)
REFERENCES DOCGIA (MADG)
ON DELETE CASCADE;

ALTER TABLE DANGKYMUON
ADD CONSTRAINT FK_DANGKYMUON_MASACH FOREIGN KEY (MASACH)
REFERENCES SACH (MASACH)
ON DELETE CASCADE;
ALTER TABLE MUONTRA
ALTER COLUMN MAMT NVARCHAR(10);

 SELECT SACH.MASACH, DAUSACH.TENSACH, DAUSACH.TENTACGIA, SACH.TINHTRANG, COALESCE(DAUSACH.SOLUONG, 0) AS SOLUONG 
FROM SACH 
JOIN DAUSACH ON SACH.MADAUSACH = DAUSACH.MADAUSACH 
WHERE SACH.TINHTRANG = N'Tot' AND COALESCE(DAUSACH.SOLUONG, 0) > 0;
INSERT INTO PHIEUMUON (MAPM, NGAYMUON, NGAYDKTRA, MADG,MANV) 
VALUES ('PM006', '2024-12-17', '2024-12-19', 'DG003  ','Null');
INSERT INTO MUONTRA (MAMT,MAPM, MASACH,NGAYTRA) VALUES ('MT00100','PM006','S004    ','2024-12-19');
BEGIN TRANSACTION; 
UPDATE DAUSACH
SET SOLUONG = CASE WHEN SOLUONG > 0 THEN SOLUONG - 1 ELSE 0 END
WHERE MADAUSACH = 'DS004';
COMMIT;
SELECT SACH.MASACH, DAUSACH.TENSACH, DAUSACH.TENTACGIA, SACH.TINHTRANG,DAUSACH.MADAUSACH, COALESCE(DAUSACH.SOLUONG, 0) AS SOLUONG FROM SACH JOIN DAUSACH ON SACH.MADAUSACH = DAUSACH.MADAUSACH WHERE SACH.TINHTRANG = N'Tot' AND COALESCE(DAUSACH.SOLUONG, 0) > 0;
select * from phieumuon;
;