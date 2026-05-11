# E-Portofolio Tia Kamalini
Website portofolio PPG berbasis HTML + Supabase, siap deploy ke Vercel.

---

## 📁 Struktur File

```
eportotia/
├── public/
│   └── index.html          ← File website utama
├── vercel.json             ← Konfigurasi Vercel
├── SUPABASE_SETUP.sql      ← SQL untuk setup database
└── README.md
```

---

## 🗄️ LANGKAH 1 — Setup Supabase

1. Buka **https://supabase.com** → login → buka project Anda
2. Klik **SQL Editor** di sidebar kiri
3. Copy seluruh isi file `SUPABASE_SETUP.sql`
4. Paste ke SQL Editor → klik **Run**
5. Pastikan tidak ada error (akan membuat tabel `site_settings`, `pages`, `media_items`)

### Buat Storage Bucket (untuk upload file besar)
1. Di Supabase → klik **Storage**
2. Klik **New Bucket** → nama: `portfolio-media` → centang **Public** → Save
3. Buka bucket → **Policies** → tambahkan policy "Allow all" untuk anon

---

## 🚀 LANGKAH 2 — Deploy ke Vercel

### Opsi A: Via GitHub (Direkomendasikan)
1. Upload folder `eportotia/` ke GitHub repository baru
2. Buka **https://vercel.com** → login → **New Project**
3. Import repository tersebut
4. Framework: **Other** (static)
5. Root Directory: `./` (biarkan default)
6. Klik **Deploy**

### Opsi B: Via Vercel CLI
```bash
npm install -g vercel
cd eportotia
vercel --prod
```

---

## 🔐 Login Admin Default

| Field    | Value    |
|----------|----------|
| Username | `admin`  |
| Password | `tia2024`|

> Ganti password melalui Dashboard Admin → menu **Ganti Password**

---

## ✏️ Cara Edit Konten

1. Buka website → klik tombol **⚙ Admin** di navbar kanan atas
2. Login dengan kredensial admin
3. Pilih halaman yang ingin diedit dari sidebar kiri
4. Edit konten, upload foto/video, atau tambah item baru
5. Klik **Simpan** — perubahan langsung tersimpan ke Supabase & tampil di website

---

## 📋 Fitur Website

### Halaman Publik
- **Halaman Muka** — Hero banner, peta lokasi LPTK & Sekolah PPL, kartu shortcut menu
- **Profil** → Identitas, Keunikan Daerah, Inspirasi dan Tujuan
- **Artefak** → Siklus 1, Siklus 2, Siklus 3 (dengan tab navigasi)
- **Lampiran** → Penilaian Perangkat Pembelajaran, Penilaian Praktik Mengajar
- **Model Guru**

### Tipe Media yang Didukung
| Tipe | Keterangan |
|------|-----------|
| Teks | Judul + deskripsi teks biasa |
| Foto/Gambar | Upload langsung atau URL |
| Video | Upload file video MP4 |
| YouTube | Embed video YouTube |
| Google Drive Doc | Embed dokumen Google Docs |
| Google Drive Sheet | Embed spreadsheet/Excel |
| Google Slides | Embed presentasi |
| Link Eksternal | Tombol buka link |

### Admin Panel
- Edit semua halaman & konten
- Upload foto profil & background banner
- Edit peta lokasi (embed Google Maps)
- Tambah/edit/hapus item media per halaman
- Ganti username & password admin

---

## 🔗 URL Embed Tips

### YouTube
```
Video URL: https://www.youtube.com/watch?v=ABC123
Embed URL: https://www.youtube.com/embed/ABC123
```

### Google Drive Dokumen/Sheet
```
Share URL:  https://drive.google.com/file/d/ID/view
Embed URL:  https://drive.google.com/file/d/ID/preview
```

### Google Drive (via Embed langsung)
```
https://docs.google.com/document/d/ID/edit?usp=sharing
→ https://docs.google.com/document/d/ID/preview
```

### Google Maps Embed
```
Buka Google Maps → cari lokasi → Bagikan → Sematkan peta → salin src dari iframe
```

---

## 📞 Kontak
- Email: madetia92@gmail.com
- HP: +62 878-2566-2597
