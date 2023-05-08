
DELIMITER $$
CREATE PROCEDURE ubah_status_pembayaran(IN id_pesanan INT, IN status_baru VARCHAR(20))
BEGIN
  DECLARE total_bayar DECIMAL(10,2);
  DECLARE total_pesanan DECIMAL(10,2);
  
  SELECT total INTO total_pesanan FROM pesanan WHERE id = id_pesanan;
  SELECT SUM(jumlah_bayar) INTO total_bayar FROM pembayaran WHERE pesanan_id = id_pesanan;
  
  IF total_bayar >= total_pesanan THEN
    UPDATE pembayaran SET status_pembayaran = 'Lunas' WHERE pesanan_id = id_pesanan AND jumlah_bayar > 0;
  ELSE
    UPDATE pembayaran SET status_pembayaran = 'BelumLunas' WHERE pesanan_id = id_pesanan;
  END IF;
  IF status_baru IS NOT NULL THEN
    UPDATE pembayaran SET status_pembayaran = status_baru WHERE pesanan_id = id_pesanan;
  END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER `trigger_pesanan_after_insert` AFTER INSERT ON `pesanan`
FOR EACH ROW
BEGIN
    DECLARE jumlah_bayar INT;
    DECLARE jumlah_pemesanan INT;
    DECLARE total_pesanan DECIMAL(10,2);

    SELECT COUNT(*) INTO jumlah_pemesanan FROM pesanan WHERE pelanggan_id = NEW.pelanggan_id AND id <= NEW.id;
    SELECT total INTO total_pesanan FROM pesanan WHERE id = NEW.id;
    IF total_pesanan = 0 THEN
        SET jumlah_bayar = 0;
    ELSE
        SET jumlah_bayar = NEW.total;
    END IF;

    INSERT INTO pembayaran (nokuitansi, tanggal, jumlah_bayar, jumlah_pemesanan, pesanan_id, status_pembayaran) 
    VALUES (CONCAT('INV-', NEW.tanggal, '-', NEW.id, '-', jumlah_pemesanan), NEW.tanggal, jumlah_bayar, jumlah_pemesanan, NEW.id, 'Belum Lunas');
    
    CALL ubah_status_pembayaran(NEW.id, NULL);
END 
DELIMITER ;