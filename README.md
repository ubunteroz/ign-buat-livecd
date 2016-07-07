# ign-buat-livecd, *guys*.
## Deskripsi Singkat
Ini adalah skrip sederhana yang digunakan untuk membuat *installable backup* dari sistem operasi IGOS Nusantara X, istilah kerennya adalah *remastering*. Skrip ini dibuat sesederhana mungkin, jadi jangan berharap ada fitur GUI.

## Penggunaan
Umum: `sudo ign-buat-livecd <opsi>`

Opsi                               | Penjelasan
-----------------------------------|-----------------------------------
`-c`, `--config <direktori>`       | Direktori konfigurasi LiveCD (default: /usr/share/buat-livecd/)
`-f`, `--fast`                     | Gunakan modus cepat, berguna untuk pengujian (kompresi GZip, tidak membuat MD5 sum, dll)
`-m`, `--modify`                   | Masuk ke *interactive shell* untuk memodifikasi LiveOS
`-o`, `--output <direktori>`       | Direktori keluaran (default: /root/)
`-r`, `--root <direktori>`         | Direktori sistem IGOS Nusantara (default: /)
`-s`, `--size <ukuran>`            | Ukuran kontainer LiveOS (dalam satuan GiB) (default: 3)
`-h`, `--help`                     | Tampilkan bantuan
`-v`, `--version`                  | Tampilkan versi skrip

## Lisensi
__ign-buat-livecd__ dirilis dengan lisensi GNU General Public License v3.
Skrip ini menggunakan komponen berikut:
* SysLinux (GNU GPL v2)
* Memtest86+ (GNU GPL v2)
