-- =====================================================
-- UPDATE SCHEMA SUPABASE - SUMATIF AKHIR SMP THHK (UPDATE 26 MARET 2026)
-- Jalankan di Supabase SQL Editor:
-- =====================================================

-- 1. TABEL: LAPORAN SELESAI (Digunakan di Ruang Ujian & Dashboard)
CREATE TABLE IF NOT EXISTS public.laporan_selesai (
    id              BIGSERIAL PRIMARY KEY,
    nama_siswa      TEXT,
    kelas           TEXT,
    ruangan         TEXT,
    jam_selesai     TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- RLS untuk Laporan Selesai
ALTER TABLE public.laporan_selesai ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public insert laporan" ON public.laporan_selesai;
CREATE POLICY "Allow public insert laporan" ON public.laporan_selesai FOR INSERT WITH CHECK (true);
DROP POLICY IF EXISTS "Allow public read laporan" ON public.laporan_selesai;
CREATE POLICY "Allow public read laporan" ON public.laporan_selesai FOR SELECT USING (true);


-- 2. TABEL: MASTER DATA SISWA (Opsional: Memindahkan data dari JSON ke DB)
CREATE TABLE IF NOT EXISTS public.master_siswa (
    id              TEXT PRIMARY KEY, -- Nomor Peserta (Contoh: 2026-0303-0001)
    nama            TEXT,
    gender          TEXT,
    grade           INTEGER,
    room            INTEGER,
    religion        TEXT,
    created_at      TIMESTAMPTZ DEFAULT NOW()
);

-- RLS untuk Master Siswa
ALTER TABLE public.master_siswa ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public read master" ON public.master_siswa;
CREATE POLICY "Allow public read master" ON public.master_siswa FOR SELECT USING (true);


-- 3. PERBAIKAN: Rename berita_acara ke berita_acara_guru (Jika sudah ada data, gunakan RENAME)
-- Jika tabel berita_acara sudah ada dan ingin disesuaikan dengan kode:
-- ALTER TABLE IF EXISTS public.berita_acara RENAME TO berita_acara_guru;

-- Atau jika belum ada data, buat tabel baru dengan nama yang sesuai kode:
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
    p1_ttd              TEXT, -- Penampung Base64 Signature
    p2_ttd              TEXT, -- Penampung Base64 Signature
    created_at          TIMESTAMPTZ DEFAULT NOW()
);

-- RLS untuk Berita Acara Guru
ALTER TABLE public.berita_acara_guru ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS "Allow public insert ba_guru" ON public.berita_acara_guru;
CREATE POLICY "Allow public insert ba_guru" ON public.berita_acara_guru FOR INSERT WITH CHECK (true);
DROP POLICY IF EXISTS "Allow public read ba_guru" ON public.berita_acara_guru;
CREATE POLICY "Allow public read ba_guru" ON public.berita_acara_guru FOR SELECT USING (true);
DROP POLICY IF EXISTS "Allow public update ba_guru" ON public.berita_acara_guru;
CREATE POLICY "Allow public update ba_guru" ON public.berita_acara_guru FOR UPDATE USING (true);
