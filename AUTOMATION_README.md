# 📰 Script Automation: Generate 34 Portal Berita

Saya telah membuat sistem otomatis untuk generate **34 folder website portal berita** dengan tema yang berbeda-beda, tapi konten yang sama.

---

## 📋 File yang Dibuat

### 1. **`tools/sites-config.json`**
Template konfigurasi untuk 34 portal berita. Berisi:
- **folderName**: Nama folder untuk setiap site (site-01, site-02, dst)
- **siteName**: Nama portal berita (akan replace "Tribun Purwasuka")
- **email**: Email portal (akan replace "tribunpurwasuka@gmail.com")
- **socialHandle**: Handle social media (akan replace "tribunpurwasuka")
- **colors**: Tema warna
  - **primary**: Warna utama kuning (contoh: #FFCC00 → custom)
  - **dark**: Warna gelap hitam (contoh: #1E2024 → custom)
  - **secondary**: Warna sekunder

### 2. **`tools/generate-sites.js`**
Script Node.js yang akan:
1. Membaca `sites-config.json`
2. Untuk setiap dari 34 site:
   - Copy folder **Tribun Purwasuka** → folder baru
   - Replace otomatis di **semua file** (.html, .css, .js, .json):
     - Nama portal berita
     - Email
     - Handle social media
     - Warna tema

---

## 🚀 Cara Menggunakan

### **Langkah 1: Siapkan Daftar Portal & Warna**

Kumpulkan informasi untuk 34 portal Anda:
- Nama portal berita (contoh: "Tech Daily", "Sports News", dst)
- Email portal (contoh: "techdaily@gmail.com")
- Warna tema (primary color & dark color dalam format HEX, contoh: #FF6B35)

Contoh daftar bisa seperti ini:
```
1. Tech Daily - #FF6B35 (dark: #001E3C) - techdaily@gmail.com
2. Sports Daily - #FF1493 (dark: #0A0E27) - sportsdaily@gmail.com
3. Finance Daily - #00D9FF (dark: #0B3446) - financedaily@gmail.com
... (34 total)
```

### **Langkah 2: Edit `sites-config.json`**

Buka file `tools/sites-config.json` dan edit untuk setiap site:

```json
{
  "id": 1,
  "folderName": "site-01-techdaily",
  "siteName": "Tech Daily",
  "email": "techdaily@gmail.com",
  "socialHandle": "techdaily",
  "colors": {
    "primary": "#FF6B35",
    "dark": "#001E3C",
    "secondary": "#2C3E50"
  }
}
```

**Yang perlu di-edit:**
- `folderName`: Ganti nama folder (gunakan lowercase, no spaces)
- `siteName`: Ganti nama portal
- `email`: Ganti email
- `socialHandle`: Ganti handle social media (tanpa @)
- `colors.primary`: Ganti warna utama
- `colors.dark`: Ganti warna gelap
- `colors.secondary`: Ganti warna sekunder (opsional)

### **Langkah 3: Jalankan Script**

Buka **Terminal** di folder project dan jalankan:

```bash
cd tools
node generate-sites.js
```

Atau dari root folder:
```bash
node tools/generate-sites.js
```

### **Langkah 4: Hasilnya**

Script akan membuat 34 folder baru:
```
📁 site-01-techdaily/
📁 site-02-sportsdaily/
📁 site-03-financedaily/
...
📁 site-34-...
```

Setiap folder berisi website portal berita lengkap dengan:
- ✅ Nama portal + email + social handle custom
- ✅ Warna tema sesuai konfigurasi
- ✅ Konten/artikel sama persis

---

## 📝 Yang Akan Di-Replace Otomatis

Script akan mengganti di **semua file** (.html, .css, .js):

| Yang Direplac | Diganti Dengan |
|---|---|
| `Tribun Purwasuka` | `siteName` dari config |
| `tribunpurwasuka` | `siteName` (tanpa spaces) |
| `tribunpurwasuka` | `socialHandle` |
| `tribunpurwasuka@gmail.com` | `email` |
| `#FFCC00` (primary) | Warna primary dari config |
| `#1E2024` (dark) | Warna dark dari config |
| `#31404B` (secondary) | Warna secondary dari config |

---

## 🔄 Jika Ingin Generate Ulang

Kalau Anda ingin update warna atau nama portal, tinggal:
1. Edit `sites-config.json`
2. Jalankan `node tools/generate-sites.js` lagi
3. Script akan **otomatis delete folder lama dan bikin yang baru** dengan konfigurasi terbaru

---

## ⚡ Contoh Cepat (Pre-filled)

Di `sites-config.json` sudah ada **34 template dengan warna berbeda**. Kalau Anda ingin test cepat:

1. Jalankan langsung: `node tools/generate-sites.js`
2. Akan generate 34 folder dengan default values
3. Kemudian edit warna dan nama sesuai keinginan
4. Jalankan lagi untuk update

---

## 🎨 Color Palette Suggestions

Jika belum punya ide warna, berikut saran:

| Kategori | Warna Primary | Warna Dark |
|---|---|---|
| Tech/IT | #0099FF | #001E3C |
| Sports | #FF1493 | #0A0E27 |
| Finance | #00D9FF | #0B3446 |
| Health | #7FFF00 | #1A2E0E |
| Education | #FF4500 | #2B1A0F |
| Travel | #00CED1 | #0D2E37 |
| Food | #FFD700 | #2B2713 |
| Lifestyle | #FF69B4 | #3D1F2E |
| News | #FF6B35 | #001E3C |
| Business | #1E90FF | #0F1F3F |

---

## 📞 Troubleshooting

### Script error "Config not found"
- Pastikan Anda menjalankan dari folder yang tepat
- Periksa `tools/sites-config.json` ada di tempat yang benar

### Warna tidak berubah di website
- Periksa format HEX warna (#RRGGBB)
- Pastikan tidak ada typo di config
- Jalankan script lagi

### Folder duplikat
- Script otomatis akan delete folder lama sebelum membuat yang baru
- Jadi aman untuk re-run berkali-kali

---

## ✨ Keuntungan Sistem Ini

✅ **Otomatis**: Generate 34 folder sekaligus dalam hitungan detik  
✅ **Consistent**: Semua file ter-replace dengan sempurna  
✅ **Flexible**: Gampang di-edit dan di-update  
✅ **Scalable**: Bisa di-expand ke lebih dari 34 jika perlu  
✅ **Safe**: Original folder Tribun Purwasuka tidak akan di-delete  

---

Sekarang tinggal Anda cari nama-nama 34 portal berita dan warna-warnanya, terus edit config file dan jalankan scriptnya! 🚀

---

## Rebrand cepat via PowerShell

Jalankan langkah berikut dari root project untuk memastikan seluruh file `.html` diproses dengan UTF-8 dan `articles.json` otomatis dibackup menjadi `articles.json.bak`.

```powershell
Copy-Item .\articles.json .\articles.json.bak -Force
Get-ChildItem -Recurse -Include *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw -Encoding UTF8
    [System.IO.File]::WriteAllText($_.FullName, $content, [System.Text.UTF8Encoding]::new($false))
}
.\rebrand-to-tribun-purwasuka.ps1
```

Script di atas akan memastikan encoding tetap UTF-8 sebelum proses rebrand penuh dijalankan.

| Masalah | Penyebab | Status | Solusi |
|---------|---------|--------|--------|
| Search gambar salah | File img/beritaf1.jpg tidak ada | ⏳ Pending User | Upload file ke img/ |
| Category filter gambar salah | File img/beritaf1.jpg tidak ada | ⏳ Pending User | Upload file ke img/ |
| Berita1-f tidak ada di All News | hardcoded list | ✅ FIXED | Added js/load-news.js |

---

## Checklist Untuk User

- [ ] **Upload file gambar ke folder `img/`**
  - Nama file harus match kolom `image` di spreadsheet
  - Misal: spreadsheet isi "beritaf1.jpg" → upload file `img/beritaf1.jpg`

- [ ] **Test di website:**
  - [ ] Buka `news.html` → scroll down → cek berita1-f ada di "All News"
  - [ ] Search "Perhutani KPH Bandung" → berita1-f tampil dengan gambar benar
  - [ ] Footer klik kategori "Lingkungan" → berita1-f tampil dengan gambar benar

---

## Catatan Teknis

### Bagaimana search.html & category filter menampilkan gambar:
```javascript
// search.js line 82-83
img.src = m.image || 'img/berita10.png';
img.onerror = function() {
    this.src = 'img/berita10.png';
};
```
- Grab `image` field dari articles.json
- Jika tidak ada atau error load → fallback ke `berita10.png`

### Bagaimana news.html menampilkan artikel:
```javascript
// js/load-news.js
fetch('/articles.json')
    .then(articles => {
        articles.forEach(article => {
            // render setiap artikel dengan image path dari articles.json
        });
    });
```
- Fetch `articles.json`
- Loop setiap entry
- Render HTML dengan data dari JSON

### Alur Lengkap:
```
Google Sheets (image: "beritaf1.jpg")
    ↓
Generator → articles.json (image: "img/beritaf1.jpg")
    ↓
browser → folder img/beritaf1.jpg ❌ (not found)
    ↓
fallback → img/berita10.png ✓ (exists)
```

**FIX:** Upload file beritaf1.jpg ke folder img/

---

**Updated:** 2026-02-12
 = Get-Content .FullName -Raw -Encoding UTF8
    [System.IO.File]::WriteAllText(.FullName, # 🔧 Troubleshooting - Masalah & Solusi

## Masalah 1 & 2: Gambar Salah di Search & Category Filter
**Gejala:** Saat search atau klik kategori Lingkungan, berita1-f tampil tapi gambar menunjukkan `berita10.png` instead of gambar seharusnya.

### Root Cause:
- File gambar **`img/beritaf1.jpg` belum ada** di folder `img/`
- search.html & category filter membaca `image` field dari `articles.json`
- articles.json punya path: `"image": "img/beritaf1.jpg"`
- Browser coba load gambar yang tidak ada → fallback ke `berita10.png`

### Solusi:
**Option A: Upload File Gambar (Recommended)**
1. Siapkan file gambar (JPG/PNG)
2. Upload ke folder `img/` dengan nama **`beritaf1.jpg`** (sesuai yang di-spreadsheet)
3. Maka gambar akan tampil benar

**Option B: Gunakan URL Publik**
1. Di Google Sheets column `image`, isi dengan URL publik: `https://example.com/foto.jpg`
2. Generator akan gunakan URL langsung tanpa prepend `img/`
3. Gambar akan load dari URL publik

**Option C: Rename File**
1. Jika file gambar punya nama berbeda, rename di spreadsheet column `image`
2. Misal: column `image` isi "berita1-f.jpg" (sesuai nama file di folder img/)
3. Run generator sekali lagi

---

## Masalah 3: Berita1-f Tidak Muncul di News Listing (All News)
**Gejala:** Di halaman news.html, berita1-f tidak ada di daftar "All News" padahal sudah di-search dan di-category filter ketemu.

### Root Cause:
- news.html punya **hardcoded list artikel** (hanya 20+ artikel manual)
- Generated artikel tidak ter-integrasi ke hardcoded list
- Perlu update HTML atau gunakan dynamic loading

### Solusi (Sudah Ter-Fix ✅):
Script **`js/load-news.js`** sudah di-buat untuk:
- Otomatis fetch dari `articles.json`
- Clear hardcoded list
- Render dinamis dari database

**Yang sudah dilakukan:**
1. ✅ Buat `js/load-news.js` dengan logic untuk load articles.json
2. ✅ Add `<script src="js/load-news.js"></script>` ke news.html
3. ✅ Script akan auto-populate newsContainer dengan semua artikel

**Verifikasi:**
1. Refresh `news.html` di browser (Ctrl+F5 untuk clear cache)
2. Buka browser console (F12)
3. Lihat message: `✅ Loaded XX articles from articles.json`
4. Scroll ke bawah di All News → berita1-f harus ada di daftar

---

## Rekap Perbaikan

| Masalah | Penyebab | Status | Solusi |
|---------|---------|--------|--------|
| Search gambar salah | File img/beritaf1.jpg tidak ada | ⏳ Pending User | Upload file ke img/ |
| Category filter gambar salah | File img/beritaf1.jpg tidak ada | ⏳ Pending User | Upload file ke img/ |
| Berita1-f tidak ada di All News | hardcoded list | ✅ FIXED | Added js/load-news.js |

---

## Checklist Untuk User

- [ ] **Upload file gambar ke folder `img/`**
  - Nama file harus match kolom `image` di spreadsheet
  - Misal: spreadsheet isi "beritaf1.jpg" → upload file `img/beritaf1.jpg`

- [ ] **Test di website:**
  - [ ] Buka `news.html` → scroll down → cek berita1-f ada di "All News"
  - [ ] Search "Perhutani KPH Bandung" → berita1-f tampil dengan gambar benar
  - [ ] Footer klik kategori "Lingkungan" → berita1-f tampil dengan gambar benar

---

## Catatan Teknis

### Bagaimana search.html & category filter menampilkan gambar:
```javascript
// search.js line 82-83
img.src = m.image || 'img/berita10.png';
img.onerror = function() {
    this.src = 'img/berita10.png';
};
```
- Grab `image` field dari articles.json
- Jika tidak ada atau error load → fallback ke `berita10.png`

### Bagaimana news.html menampilkan artikel:
```javascript
// js/load-news.js
fetch('/articles.json')
    .then(articles => {
        articles.forEach(article => {
            // render setiap artikel dengan image path dari articles.json
        });
    });
```
- Fetch `articles.json`
- Loop setiap entry
- Render HTML dengan data dari JSON

### Alur Lengkap:
```
Google Sheets (image: "beritaf1.jpg")
    ↓
Generator → articles.json (image: "img/beritaf1.jpg")
    ↓
browser → folder img/beritaf1.jpg ❌ (not found)
    ↓
fallback → img/berita10.png ✓ (exists)
```

**FIX:** Upload file beritaf1.jpg ke folder img/

---

**Updated:** 2026-02-12
, [System.Text.UTF8Encoding]::new(False))
}
.\rebrand-to-tribun-purwasuka.ps1
`
