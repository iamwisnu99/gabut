-- 1. Buat tabel untuk menyimpan statistik kegabutan
CREATE TABLE IF NOT EXISTS public.kegabutan_stats (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT UNIQUE NOT NULL,
    count BIGINT DEFAULT 0
);

-- 2. Masukkan data awal (counter mulai dari 0 jika belum ada)
INSERT INTO public.kegabutan_stats (name, count)
VALUES ('total_scans', 0)
ON CONFLICT (name) DO NOTHING;

-- 3. Aktifkan Realtime untuk tabel ini
-- Pastikan publikasi 'supabase_realtime' sudah ada, jika belum:
-- CREATE PUBLICATION supabase_realtime FOR TABLE kegabutan_stats;
-- Jika sudah ada, tambahkan tabel ke publikasi:
ALTER PUBLICATION supabase_realtime ADD TABLE public.kegabutan_stats;

-- 4. Aktifkan Row Level Security (RLS) agar database aman
ALTER TABLE public.kegabutan_stats ENABLE ROW LEVEL SECURITY;

-- 5. Berikan akses SELECT (Baca) ke publik (anonim)
CREATE POLICY "Izinkan baca publik" 
ON public.kegabutan_stats 
FOR SELECT 
USING (true);

-- 6. Berikan akses UPDATE (Ubah) ke publik (anonim) 
-- Catatan: Di produksi biasanya dibatasi, tapi untuk eksperimen sosial ini diperbolehkan.
CREATE POLICY "Izinkan update publik" 
ON public.kegabutan_stats 
FOR UPDATE 
USING (true)
WITH CHECK (true);

-- 7. Buat fungsi database untuk Increment (tambah 1) secara atomik
-- Ini lebih aman daripada melakukan increment di sisi client.
CREATE OR REPLACE FUNCTION increment_counter(row_name TEXT)
RETURNS void AS $$
BEGIN
    UPDATE public.kegabutan_stats
    SET count = count + 1
    WHERE name = row_name;
END;
$$ LANGUAGE plpgsql;

-- 8. Menambahkan Kolom Rating (Realtime Community Rating)
ALTER TABLE public.kegabutan_stats ADD COLUMN IF NOT EXISTS total_rating_sum DOUBLE PRECISION DEFAULT 0;
ALTER TABLE public.kegabutan_stats ADD COLUMN IF NOT EXISTS rating_count BIGINT DEFAULT 0;

-- 9. Buat fungsi database untuk Submit Rating secara atomik
CREATE OR REPLACE FUNCTION submit_rating(new_val DOUBLE PRECISION) 
RETURNS void AS $$
BEGIN
    UPDATE public.kegabutan_stats
    SET total_rating_sum = COALESCE(total_rating_sum, 0) + new_val,
        rating_count = COALESCE(rating_count, 0) + 1
    WHERE name = 'total_scans';
END;
$$ LANGUAGE plpgsql;
