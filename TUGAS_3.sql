
show databases;
 use dbtoko;
--  SOAL 3.1
-- 1.	Tampilkan produk yang asset nya diatas 20jt
SELECT * FROM produk WHERE harga_beli * stok > 20000000; 
-- 2.	Tampilkan data produk beserta selisih stok dengan minimal stok
SELECT sum(stok) as total_asset from produk;
-- Tampilkan total asset produk secara keseluruhan
SELECT sum(stok) as total_asset from produk;
-- 4.	Tampilkan data pelanggan yang lahirnya antara tahun 1999 sampai 2004
SELECT * FROM pelanggan WHERE YEAR(tgl_lahir) BETWEEN 1999 AND 2004;
-- 5.	Tampilkan data pelanggan yang lahirnya tahun 1998
SELECT * FROM pelanggan WHERE YEAR(tgl_lahir)=1998;
-- 6.	Tampilkan data pelanggan yang berulang tahun bulan agustus
SELECT * FROM pelanggan WHERE MONTH(tgl_lahir)=08;
-- 7.	Tampilkan data pelanggan : nama, tmp_lahir, tgl_lahir dan umur (selisih tahun sekarang dikurang tahun kelahiran)
SELECT nama, tmp_lahir, tgl_lahir, (YEAR(NOW())-YEAR(tgl_lahir)) AS umur FROM pelanggan;

-- SOAL 3.2
-- 1.	Berapa jumlah pelanggan yang tahun lahirnya 1998
SELECT COUNT(*) as jumlahpelanggan_yanglahirtahun1998 FROM pelanggan WHERE YEAR(tgl_lahir) = 1998 ;
-- 2.	Berapa jumlah pelanggan perempuan yang tempat lahirnya di Jakarta
select count(*) as jumlahperempuan_yanglahirdijakarta FROM pelanggan where jk="p"AND tmp_lahir LIKE"%jakarta%";
-- 3.	Berapa jumlah total stok semua produk yang harga jualnya dibawah 10rb
select count(stok) as jumlah from product where harga_jual<10000;
-- 4.	Ada berapa produk yang mempunyai kode awal K
select count(kode) as jmlh from product where kode LIKE 'k%';
-- 5.	Berapa harga jual rata-rata produk yang diatas 1jt
select average(harga_jual) from produk where harga_jual>1000000;
-- 6.	Tampilkan jumlah stok yang paling besar
select max(stok) from product;
-- 7.	Ada berapa produk yang stoknya kurang dari minimal stok
select count(*) as " jumlah produk kurang dari minimal stok"from product where stok<min_stok;
--  8.	Berapa total asset dari keseluruhan produk
select sum(harga_beli*stok) as "total asset" from product;

-- SOAL 3.3
-- 1.	Tampilkan data produk : id, nama, stok dan informasi jika stok telah sampai batas minimal atau kurang dari minimum stok dengan informasi ‘segera belanja’ jika tidak ‘stok aman’.
select id,nama,stok,
case 
when stok < min_stok then 'segera belanja'
else 'stok aman'
end as informasi
from product;
-- 2.	Tampilkan data pelanggan: id, nama, umur dan kategori umur : jika umur < 17 → ‘muda’ , 17-55 → ‘Dewasa’, selainnya ‘Tua’
select id,nama,(year(now())-year(tgl_lahir)) as umur,
CASE
when (year(now())-year(tgl_lahir))<17 then "muda"
when  (year(now())-year(tgl_lahir)) BETWEEN 17 and 55 then 'dewasa'
else 'tua'
end as kategori_umur
from pelanggan;
-- 3.	Tampilkan data produk: id, kode, nama, dan bonus untuk kode ‘TV01’ →’DVD Player’ , ‘K001’ → ‘Rice Cooker’ selain dari diatas ‘Tidak Ada’
select id,kode,nama,
CASE
when kode ='TV01' then 'DVD Player'
when kode ='K001' then 'Rice Cooker'
else 'tidak ada'
end as bonus
from product;


-- SOAL 3.4
-- 1.	Tampilkan data statistik jumlah tempat lahir pelanggan
select tmp_lahir,count(*) as "jumlah tempat lahir pelanggan" from pelanggan group by tmp_lahir;
-- 2.	Tampilkan jumlah statistik produk berdasarkan jenis produk
select jenis_produk_id,count(*) as "jumlah produk"  from product group by jenis_produk_id;
-- 3.	Tampilkan data pelanggan yang usianya dibawah rata usia pelanggan
select *from pelanggan where (year(now())-year(tgl_lahir))<(select AVG(year(now())-year(tgl_lahir)) from pelanggan);
-- 4.	Tampilkan data produk yang harganya diatas rata-rata harga produk
select * from product where harga_beli>(select avg(harga_beli) from product);
-- 5.	Tampilkan data pelanggan yang memiliki kartu dimana iuran tahunan kartu diatas 90rb
select * from kartu where iuran>90000;
-- 6.	Tampilkan statistik data produk dimana harga produknya dibawah rata-rata harga produk secara keseluruhan
select count(*) as jumlah_produk,min(harga_jual) as harga_minimal,max(harga_jual) as harga_maksimal,avg(harga_jual) as harga_ratarata from product where harga_jual<(select avg(harga_jual*stok) from product);
-- 7.	Tampilkan data pelanggan yang memiliki kartu dimana diskon kartu yang diberikan diatas 3%
select* from kartu where diskon>0.03;