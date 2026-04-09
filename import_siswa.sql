-- =====================================================
-- IMPORT DATA SISWA - SUMATIF AKHIR SMP THHK
-- =====================================================

INSERT INTO public.master_siswa (id, nama, gender, grade, room, religion) VALUES 
('2026-0404-0001', 'Anceline Sharon Susanto', 'Perempuan', 9, 1, 'Kristen'),
('2026-0404-0002', 'Andica Jose Wirokusumo', 'Laki-laki', 9, 1, 'Katolik'),
('2026-0404-0003', 'Christian Nathanael Daniello', 'Laki-laki', 9, 1, 'Kristen'),
('2026-0404-0004', 'Doddy Saputra', 'Laki-laki', 9, 1, 'Katolik'),
('2026-0404-0005', 'Evangeline Sheron Loriensa', 'Perempuan', 9, 1, 'Kristen'),
('2026-0404-0006', 'Henri Untoro', 'Laki-laki', 9, 1, 'Katolik'),
('2026-0404-0007', 'Juanita Adeline Wijaya', 'Perempuan', 9, 1, 'Budha'),
('2026-0404-0008', 'Mathea Elite Wijaya', 'Perempuan', 9, 1, 'Katolik'),
('2026-0404-0009', 'Matthew Geraldo Soetjipto', 'Laki-laki', 9, 1, 'Katolik'),
('2026-0404-0010', 'Nauli Widi Siddhatta', 'Laki-laki', 9, 1, 'Kristen'),
('2026-0404-0011', 'Yehezkiel Joenard Christensen', 'Laki-laki', 9, 1, 'Kristen')
ON CONFLICT (id) DO UPDATE SET 
    nama = EXCLUDED.nama,
    gender = EXCLUDED.gender,
    grade = EXCLUDED.grade,
    room = EXCLUDED.room,
    religion = EXCLUDED.religion;
