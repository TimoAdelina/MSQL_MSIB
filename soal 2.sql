-- soal 2.1
SELECT * FROM product ORDER BY harga_jual DESC;
SELECT kode, nama, tmp_lahir, tgl_lahir FROM pelanggan;
SELECT kode, nama,stok FROM product WHERE stok=4;
SELECT * FROM pelanggan WHERE tmp_lahir="jakarta";
SELECT kode, nama, tmp_lahir, tgl_lahir FROM pelanggan ORDER BY tgl_lahir desc;

-- soal 2.2
SELECT * FROM product WHERE stok=3 OR stok=10;
SELECT * FROM product WHERE harga_jual < 5000000 AND harga_jual > 500000;
SELECT * FROM product WHERE min_stok > stok;
SELECT * FROM pelanggan ORDER BY tgl_lahir DESC;
SELECT * FROM pelanggan WHERE tmp_lahir='jakarta' AND jk='P';
SELECT * FROM pelanggan WHERE id IN (2,4,6);
SELECT * FROM product WHERE harga_jual >= 500000 AND harga_jual<= 6000000;

--MANDIRI
-- SOAL 2.3
-- ampilkan produk yang kode awalnya huruf K dan huruf M
SELECT * FROM product WHERE kode LIKE 'K%' OR kode LIKE 'M%';
-- Tampilkan produk yang kode awalnya bukan huruf M
SELECT * FROM product WHERE kode NOT LIKE 'M%';
-- Tampilkan produk-produk televisi
SELECT * FROM product WHERE nama="TV";
-- Tampilkan pelanggan mengandung huruf 'SA'
SELECT * FROM pelanggan WHERE nama LIKE '%SA%';
-- Tampilkan pelanggan yang lahirnya bukan di Jakarta dan mengandung huruf ‘yo‘SELECT * FROM pelanggan WHERE nama LIKE '%sa%';
SELECT * FROM pelanggan WHERE tmp_lahir <> "jakarta" AND tmp_lahir LIKE '%yo%';
--Tampilkan pelanggan yang karakter huruf ke – 2 nya adalah A
SELECT * FROM pelanggan WHERE SUBSTR(nama, 2, 1) = 'A';

-- SOAL 2.4
-- Tampilkan 2 data produk termahal
SELECT * FROM product ORDER BY harga_beli DESC LIMIT 2;
-- Tampilkan produk yang paling murah
SELECT *FROM product ORDER BY harga_beli ASC LIMIT 1;
-- Tampilkan produk yang stoknya paling banyak
SELECT * FROM product ORDER BY stok DESC LIMIT 1;
-- Tampilkan dua produk yang stoknya paling sedikit
SELECT * FROM product ORDER BY stok ASC LIMIT 2;
-- Tampilkan pelanggan yang paling muda
SELECT * FROM pelanggan ORDER BY tgl_lahir DESC LIMIT 1;
--Tampilkan pelanggan yang paling tua
SELECT * FROM pelanggan ORDER BY tgl_lahir ASC LIMIT 1;
