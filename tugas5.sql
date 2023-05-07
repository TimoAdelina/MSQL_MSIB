show databases;
use dbtoko;
-- -- buat fungsi  input pelanggan(),setelah itu ganti fungsinya
DELIMITER $$
CREATE PROCEDURE input_pelanggan(IN kode VARCHAR(10), IN nama VARCHAR(45), IN jk CHAR(1), IN tmp_lahir VARCHAR(30), IN tgl_lahir DATE, IN email VARCHAR(45), IN kartu_id INT(11), OUT id_pelanggan INT(11))
BEGIN
  -- memasukkan data pelanggan baru ke dalam tabel pelanggan
  INSERT INTO pelanggan(kode, nama, jk, tmp_lahir, tgl_lahir, email, kartu_id) VALUES (kode, nama, jk, tmp_lahir, tgl_lahir, email, kartu_id);
  
  -- menyimpan id pelanggan yang baru saja dibuat
  SET id_pelanggan = LAST_INSERT_ID();
END$$
DELIMITER ;

call input_pelanggan('arl01','arly','l','medan',2002-13-09,'arl@gmail.com',1);


-- buat fungsi  showpelanggan(),setelah itu panggil fungsinya
DELIMITER $$
create procedure show_pelanggan()
BEGIN
select * from pelanggan;
END$$
DELIMITER ;
call show_pelanggan();

-- buat fungsi input_produk(),setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE input_produk(
    IN kode varchar(10),
    IN nama VARCHAR(45),
    IN harga_beli DOUBLE,
    IN harga_jual DOUBLE,
    IN stok INT(11),
    IN min_stok INT(11),
    IN jenis_produk_id INT(11)
)
BEGIN
    INSERT INTO product(kode, nama,harga_beli, harga_jual,stok, min_stok,jenis_produk_id); 
    VALUES (kode, nama,harga_beli, harga_jual,stok, min_stok,jenis_produk_id);
END $$
DELIMITER ;
call input_produk('121','mouse','300000','320000',3,1,4);

-- buatlah fungsi showproduk() setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE show_produk()
BEGIN
select*from product;
END$$
call show_produk();

-- Buat fungsi totalPesanan(), setelah itu panggil fungsinya
DELIMITER $$
BEGIN
  SELECT pelanggan.kode AS kode_pelanggan, pelanggan.nama_pelanggan, SUM(pesanan_items.qty) AS total_produk, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
  FROM pesanan_items
  JOIN pesanan ON pesanan_items.pesanan_id = pesanan.id
  JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
  GROUP BY pelanggan.kode, pelanggan.nama_pelanggan;
END $$
DELIMITER ;
CALL totalPesanan();

-- Buat Function untuk menampilkan seluruh pesanan dari semua pelanggan
DELIMITER $$
CREATE PROCEDURE showAll_Pesanan()
BEGIN
  SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS pelanggan_kode, pelanggan.nama_pelanggan, produk.kode AS produk_kode, produk.nama AS nama_produk, pesanan_items.qty, produk.harga_jual, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;
END $$
DELIMITER ;
CALL showAll_Pesanan();

-- buatkan query panjang di atas menjadi sebuah view baru: pesanan_produk_vw (menggunakan join dari table pesanan,pelanggan dan produk)
CREATE VIEW pesanan_produk_view AS
SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS pelanggan_kode, pelanggan.nama_pelanggan, produk.kode AS produk_kode, produk.nama AS nama_produk, pesanan_items.qty, produk.harga_jual, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;

SELECT * FROM pesanan_produk_view;