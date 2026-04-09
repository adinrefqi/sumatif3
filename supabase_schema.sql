-- =====================================================
-- SCHEMA SUPABASE - SUMATIF AKHIR SMP THHK (VERSI LENGKAP)
-- Jalankan di Supabase SQL Editor:
-- =====================================================

-- 1. TABEL: DAFTAR HADIR SISWA
CREATE TABLE IF NOT EXISTS public.presensi_siswa (
    id              BIGSERIAL PRIMARY KEY,
    mata_pelajaran  TEXT,
    tanggal         TEXT,
    ruang           TEXT,
    pukul           TEXT,
    pengawas_1_nama TEXT,
    pengawas_1_niy  TEXT,
    pengawas_2_nama TEXT,
    pengawas_2_niy  TEXT,
    data_siswa      JSONB,      -- objek/array: {no, nomor_peserta, nama, ttd}
    p1_ttd          TEXT,      -- signature pengawas 1
    p2_ttd          TEXT,      -- signature pengawas 2
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- 2. TABEL: BERITA ACARA GURU
CREATE TABLE IF NOT EXISTS public.berita_acara_guru (
    id                  BIGSERIAL PRIMARY KEY,
    mata_pelajaran      TEXT,
    hari                TEXT,
    tanggal             TEXT,
    bulan               TEXT,
    tahun               TEXT,
    pukul_mulai         TEXT,
    pukul_selesai       TEXT,
    lokasi              TEXT,
    ruang               TEXT,
    jumlah_seharusnya   TEXT,
    jumlah_hadir        TEXT,
    nomor_hadir         TEXT,
    jumlah_tidak_hadir  TEXT,
    nomor_tidak_hadir   TEXT,
    lembar_soal         TEXT,
    lembar_ba           TEXT,
    lembar_jawab        TEXT,
    catatan             TEXT,
    pengawas_1_nama     TEXT,
    pengawas_1_niy      TEXT,
    pengawas_2_nama     TEXT,
    pengawas_2_niy      TEXT,
    p1_ttd              TEXT,
    p2_ttd              TEXT,
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

-- 3. TABEL: LAPORAN SELESAI (Monitoring Selesai Ujian)
CREATE TABLE IF NOT EXISTS public.laporan_selesai (
    id              BIGSERIAL PRIMARY KEY,
    nama_siswa      TEXT,
    kelas           TEXT,
    ruangan         TEXT,
    jam_selesai     TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- 4. TABEL: MASTER DATA SISWA
CREATE TABLE IF NOT EXISTS public.master_siswa (
    id              TEXT PRIMARY KEY, -- Nomor Peserta
    nama            TEXT,
    gender          TEXT,
    grade           INTEGER,
    room            INTEGER,
    religion        TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- =====================================================
-- ROW LEVEL SECURITY (RLS) - PUBLIC ACCESS
-- =====================================================

ALTER TABLE public.presensi_siswa ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public all" ON public.presensi_siswa FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.berita_acara_guru ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public all" ON public.berita_acara_guru FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.laporan_selesai ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public all" ON public.laporan_selesai FOR ALL USING (true) WITH CHECK (true);

ALTER TABLE public.master_siswa ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Allow public read" ON public.master_siswa FOR SELECT USING (true);

-- =====================================================
-- IMPORT DATA SISWA (52 SISWA)
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

-- 5. TABEL: MASTER DATA GURU
CREATE TABLE IF NOT EXISTS public.master_guru (
    id              TEXT PRIMARY KEY, -- NIY / ID Guru
    nama            TEXT,
    role            TEXT,             -- 'Guru' atau 'Admin'
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- RLS untuk Master Guru
ALTER TABLE public.master_guru ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public read guru" ON public.master_guru;
CREATE POLICY "Allow public read guru" ON public.master_guru FOR SELECT USING (true);

-- IMPORT DATA GURU
TRUNCATE public.master_guru; -- Hapus data lama agar bersih
INSERT INTO public.master_guru (id, nama, role) VALUES
('Widaningsih', 'Widaningsih', 'Guru'),
('Morys', 'Morys', 'Guru'),
('Faizal', 'Faizal', 'Guru'),
('Dyfa', 'Dyfa', 'Guru'),
('Yanuar', 'Yanuar', 'Guru'),
('Sunedi', 'Sunedi', 'Guru'),
('Thevea', 'Thevea', 'Guru'),
('Atmo', 'Atmo', 'Guru'),
('ADMIN-OK', 'Kurikulum / Admin', 'Admin');


