
-- 8. Hiển thị tên và cấp độ của tất cả các kỹ năng của chuyên gia có MaChuyenGia là 1.
SELECT k.TenKyNang, ck.CapDo
FROM ChuyenGia_KyNang ck
JOIN KyNang k ON ck.MaKyNang = k.MaKyNang
WHERE ck.MaChuyenGia = 1;

-- 9. Liệt kê tên các chuyên gia tham gia dự án có MaDuAn là 2.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_DuAn cgd ON cg.MaChuyenGia = cgd.MaChuyenGia
WHERE cgd.MaDuAn = 2;

-- 10. Hiển thị tên công ty và tên dự án của tất cả các dự án.
SELECT c.TenCongTy, d.TenDuAn
FROM DuAn d
JOIN CongTy c ON d.MaCongTy = c.MaCongTy;

-- 11. Đếm số lượng chuyên gia trong mỗi chuyên ngành.
SELECT ChuyenNganh, COUNT(*) AS SoLuongChuyenGia
FROM ChuyenGia
GROUP BY ChuyenNganh;

-- 12. Tìm chuyên gia có số năm kinh nghiệm cao nhất.
SELECT TOP 1 HoTen, NamKinhNghiem
FROM ChuyenGia
ORDER BY NamKinhNghiem DESC;

-- 13. Liệt kê tên các chuyên gia và số lượng dự án họ tham gia.
SELECT cg.HoTen, COUNT(cgd.MaDuAn) AS SoLuongDuAn
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_DuAn cgd ON cg.MaChuyenGia = cgd.MaChuyenGia
GROUP BY cg.HoTen;

-- 14. Hiển thị tên công ty và số lượng dự án của mỗi công ty.
SELECT c.TenCongTy, COUNT(d.MaDuAn) AS SoLuongDuAn
FROM CongTy c
LEFT JOIN DuAn d ON c.MaCongTy = d.MaCongTy
GROUP BY c.TenCongTy;

-- 15. Tìm kỹ năng được sở hữu bởi nhiều chuyên gia nhất.
SELECT TOP 1 k.TenKyNang, COUNT(ck.MaChuyenGia) AS SoLuongChuyenGia
FROM KyNang k
JOIN ChuyenGia_KyNang ck ON k.MaKyNang = ck.MaKyNang
GROUP BY k.TenKyNang
ORDER BY SoLuongChuyenGia DESC;

-- 16. Liệt kê tên các chuyên gia có kỹ năng 'Python' với cấp độ từ 4 trở lên.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
JOIN KyNang k ON ck.MaKyNang = k.MaKyNang
WHERE k.TenKyNang = 'Python' AND ck.CapDo >= 4;

-- 17. Tìm dự án có nhiều chuyên gia tham gia nhất.
SELECT TOP 1 d.TenDuAn, COUNT(cd.MaChuyenGia) AS SoLuongChuyenGia
FROM DuAn d
JOIN ChuyenGia_DuAn cd ON d.MaDuAn = cd.MaDuAn
GROUP BY d.TenDuAn
ORDER BY SoLuongChuyenGia DESC;

-- 18. Hiển thị tên và số lượng kỹ năng của mỗi chuyên gia.
SELECT cg.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
GROUP BY cg.HoTen;

-- 19. Tìm các cặp chuyên gia làm việc cùng dự án.
SELECT cg1.HoTen AS ChuyenGia1, cg2.HoTen AS ChuyenGia2, d.TenDuAn
FROM ChuyenGia_DuAn cgd1
JOIN ChuyenGia_DuAn cgd2 ON cgd1.MaDuAn = cgd2.MaDuAn AND cgd1.MaChuyenGia < cgd2.MaChuyenGia
JOIN ChuyenGia cg1 ON cgd1.MaChuyenGia = cg1.MaChuyenGia
JOIN ChuyenGia cg2 ON cgd2.MaChuyenGia = cg2.MaChuyenGia
JOIN DuAn d ON cgd1.MaDuAn = d.MaDuAn;

-- 20. Liệt kê tên các chuyên gia và số lượng kỹ năng cấp độ 5 của họ.
SELECT cg.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNangCap5
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
WHERE ck.CapDo = 5
GROUP BY cg.HoTen;

-- 21. Tìm các công ty không có dự án nào.
SELECT c.TenCongTy
FROM CongTy c
LEFT JOIN DuAn d ON c.MaCongTy = d.MaCongTy
WHERE d.MaDuAn IS NULL;

-- 22. Hiển thị tên chuyên gia và tên dự án họ tham gia, bao gồm cả chuyên gia không tham gia dự án nào.
SELECT cg.HoTen, d.TenDuAn
FROM ChuyenGia cg
LEFT JOIN ChuyenGia_DuAn cgd ON cg.MaChuyenGia = cgd.MaChuyenGia
LEFT JOIN DuAn d ON cgd.MaDuAn = d.MaDuAn;

-- 23. Tìm các chuyên gia có ít nhất 3 kỹ năng.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
GROUP BY cg.HoTen
HAVING COUNT(ck.MaKyNang) >= 3;

-- 24. Hiển thị tên công ty và tổng số năm kinh nghiệm của tất cả chuyên gia trong các dự án của công ty đó.
SELECT c.TenCongTy, SUM(cg.NamKinhNghiem) AS TongNamKinhNghiem
FROM CongTy c
JOIN DuAn d ON c.MaCongTy = d.MaCongTy
JOIN ChuyenGia_DuAn cgd ON d.MaDuAn = cgd.MaDuAn
JOIN ChuyenGia cg ON cgd.MaChuyenGia = cg.MaChuyenGia
GROUP BY c.TenCongTy;

-- 25. Tìm các chuyên gia có kỹ năng 'Java' nhưng không có kỹ năng 'Python'.
SELECT cg.HoTen
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck1 ON cg.MaChuyenGia = ck1.MaChuyenGia
JOIN KyNang k1 ON ck1.MaKyNang = k1.MaKyNang
WHERE k1.TenKyNang = 'Java' 
AND NOT EXISTS (
    SELECT 1
    FROM ChuyenGia_KyNang ck2
    JOIN KyNang k2 ON ck2.MaKyNang = k2.MaKyNang
    WHERE ck2.MaChuyenGia = cg.MaChuyenGia AND k2.TenKyNang = 'Python'
);

-- 76. Tìm chuyên gia có số lượng kỹ năng nhiều nhất.
SELECT TOP 1 cg.HoTen, COUNT(ck.MaKyNang) AS SoLuongKyNang
FROM ChuyenGia cg
JOIN ChuyenGia_KyNang ck ON cg.MaChuyenGia = ck.MaChuyenGia
GROUP BY cg.HoTen
ORDER BY SoLuongKyNang DESC;

-- 77. Liệt kê các cặp chuyên gia có cùng chuyên ngành.
SELECT cg1.HoTen AS ChuyenGia1, cg2.HoTen AS ChuyenGia2, cg1.ChuyenNganh
FROM ChuyenGia cg1
JOIN ChuyenGia cg2 ON cg1.MaChuyenGia < cg2.MaChuyenGia AND cg1.ChuyenNganh = cg2.ChuyenNganh;

-- 78. Tìm công ty có tổng số năm kinh nghiệm của các chuyên gia trong dự án cao nhất.
WITH KinhNghiemPerCongTy AS (
    SELECT c.MaCongTy, c.TenCongTy, SUM(cg.NamKinhNghiem) AS TongNamKinhNghiem
    FROM CongTy c
    JOIN DuAn d ON c.MaCongTy = d.MaCongTy
    JOIN ChuyenGia_DuAn cgd ON d.MaDuAn = cgd.MaDuAn
    JOIN ChuyenGia cg ON cgd.MaChuyenGia = cg.MaChuyenGia
    GROUP BY c.MaCongTy, c.TenCongTy
)
SELECT TOP 1 TenCongTy, TongNamKinhNghiem
FROM KinhNghiemPerCongTy
ORDER BY TongNamKinhNghiem DESC;

-- 79. Tìm kỹ năng được sở hữu bởi tất cả các chuyên gia.
SELECT k.TenKyNang
FROM KyNang k
JOIN ChuyenGia_KyNang ck ON k.MaKyNang = ck.MaKyNang
GROUP BY k.TenKyNang
HAVING COUNT(DISTINCT ck.MaChuyenGia) = (SELECT COUNT(*) FROM ChuyenGia);
