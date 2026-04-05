# Saksi Kegabutan - Eksperimen Sosial

Website mobile-first yang diakses via QR Code untuk melihat seberapa gabut orang-orang di sekitar Anda. 

## Tech Stack
- **HTML5 & Tailwind CSS (CDN)**
- **GSAP (GreenSock)** untuk animasi smooth premium
- **Firebase Realtime Database** untuk Live Counter
- **Glassmorphism Design** dengan Dark Mode

## Cara Deployment (Netlify + Supabase)

1. **Setup Supabase:**
   - Buat proyek baru di [Supabase](https://supabase.com/).
   - Buka **SQL Editor** dan tempelkan isi dari file **[supabase_setup.sql](file:///d:/Documents/Code/Gabut/supabase_setup.sql)**, lalu jalankan (Run). Ini akan membuat tabel, mengaktifkan Realtime, dan membuat fungsi increment.

2. **Deploy ke Netlify:**
   - Hubungkan repo ini ke Netlify.
   - Pastikan struktur folder menyertakan `netlify/functions/` dan `netlify.toml`.

3. **Environment Variables di Netlify (PENTING):**
   Tambahkan key berikut di Dashboard Netlify (**Site Configuration > Environment variables**):
   - `SUPABASE_URL`: (Ambil dari Project Settings > API)
   - `SUPABASE_ANON_KEY`: (Ambil dari Project Settings > API)

4. **Aktifkan Realtime di UI Supabase:**
   - Pergi ke **Database > Replication**.
   - Pastikan tabel `kegabutan_stats` sudah tercentang/aktif di dalam publikasi `supabase_realtime`.

5. **Pretty URLs:**
   Fitur *Pretty URLs* sudah aktif via `netlify.toml`.

## Konten (10 Tahap)
- **Intro Live Counter:** "Saksi Kegabutan: [Angka] orang".
- **Animasi Card:** GSAP `y: 50, opacity: 0` transition.
- **Sarkasme:** Level tinggi, dirancang untuk membuat user menyesal namun terpaku.

---
*Dibuat khusus untuk mereka yang memiliki terlalu banyak waktu luang.*
