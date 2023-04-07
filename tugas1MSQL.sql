CREATE DATABASE dbtoko;
Use dbtoko;


CREATE TABLE kartu(
id INT AUTO_INCREMENT PRIMARY KEY,
kode VARCHAR(6) UNIQUE,
nama VARCHAR(30) not null,
diskon DOUBLE,
iuran DOUBLE);


CREATE TABLE pelanggan(
id INT AUTO_INCREMENT PRIMARY KEY,
kode VARCHAR(10) UNIQUE,
nama_pelangganVARCHAR(45),
jk CHAR(1),
tmp_lahir VARCHAR(30),
tgl_lahir DATE,
email VARCHAR(45),
alamat VARCHAR(40),
kartu_id  INT NOT NULL,
FOREIGN KEY (kartu_id) REFERENCES kartu(id);
);


CREATE TABLE pesanan(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
tanggal DATE,
total DOUBLE,
pelanggan_id INT NOT NULL,
FOREIGN KEY (pelanggan_id) REFERENCES pelanggan(id)
);

CREATE TABLE pembayaran(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nokuitansi VARCHAR(10) UNIQUE,
tanggal DATE,
jumlah DOUBLE,
ke INT,
pesanan_id INT NOT NULL,
FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
);

CREATE TABLE jenis_produk(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nama VARCHAR(45)
);

CREATE TABLE produk(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
kode VARCHAR(10) UNIQUE,
nama VARCHAR(45),
harga_beli DOUBLE,
harga_jual DOUBLE,
stok INT,
min_stok INT,
jenis_produk_id INT NOT NULL,
FOREIGN KEY (jenis_produk_id) REFERENCES jenis_produk(id)
);

CREATE TABLE pesanan_items(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
produk_id INT NOT NULL,
pesanan_id INT NOT NULL,
FOREIGN KEY (produk_id) REFERENCES produk(id),
FOREIGN KEY (pesanan_id) REFERENCES pesanan(id)
qty INT,
harga DOUBLE
);

CREATE TABLE vendor(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nomor VARCHAR(4),
nama VARCHAR(40),
kota VARCHAR(30),
    kontak VARCHAR(30)
);

create table pembelian(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tanggal VARCHAR(45),
    nomor VARCHAR(10) UNIQUE,
    produk_id INT NOT NULL,
    FOREIGN KEY (produk_id) REFERENCES produk(id),
    jumlah INT,
    harga DOUBLE,
    vendor_id INT NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES vendor(id)
);