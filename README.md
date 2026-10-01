# PEMUDA KARANG BARU — Next.js + Supabase

Website organisasi pemuda dengan halaman publik `/` dan dashboard admin `/admin`.

## Fitur
- Profil, tujuan, pengurus, anggota, kegiatan, galeri.
- Data tersimpan online di Supabase PostgreSQL.
- Foto tersimpan di Supabase Storage bucket `activity-photos`.
- Login admin menggunakan Supabase Auth (email + password).
- Siap deploy ke Vercel.

## 1. Buat project Supabase
1. Buka Supabase dan buat project baru.
2. Masuk **SQL Editor**.
3. Copy seluruh isi `supabase.sql`, lalu Run.
4. Masuk **Authentication → Users → Add user** dan buat akun admin dengan email/password yang Anda pilih.

## 2. Ambil API keys
Di Supabase: **Project Settings → API**.
Ambil:
- Project URL
- Publishable/anon key (gunakan key publik untuk browser)

## 3. Environment Vercel
Tambahkan:
`NEXT_PUBLIC_SUPABASE_URL=...`
`NEXT_PUBLIC_SUPABASE_ANON_KEY=...`

Jangan pernah memasukkan `service_role` key ke website atau GitHub.

## 4. Jalankan lokal
```bash
npm install
npm run dev
```

## 5. Deploy
Push project ke GitHub lalu Import Repository di Vercel. Framework: Next.js. Install Command: `npm install`. Build Command: `npm run build`.
