import '../models/parfum_model.dart';
import '../models/pesanan_model.dart';

class ApiService {
  static List<Parfum> daftarParfum = [
    Parfum(
      id: '1',
      nama: 'Parfum Signature 01',
      kategori: 'Floral',
      harga: 150000,
      gambar: 'assets/images/parfum1.jpeg',
      deskripsi: 'Aroma floral yang elegan dan tahan lama.',
    ),
    Parfum(
      id: '2',
      nama: 'Parfum Woody 02',
      kategori: 'Woody',
      harga: 175000,
      gambar: 'assets/images/parfum2.jpeg',
      deskripsi: 'Aroma kayu yang maskulin dan tegas.',
    ),
    Parfum(
      id: '3',
      nama: 'Parfum Fresh 03',
      kategori: 'Fresh',
      harga: 130000,
      gambar: 'assets/images/parfum3.jpeg',
      deskripsi: 'Kesegaran sepanjang hari untuk aktivitas.',
    ),
    Parfum(
      id: '4',
      nama: 'Parfum Sweet 04',
      kategori: 'Sweet',
      harga: 160000,
      gambar: 'assets/images/parfum4.jpeg',
      deskripsi: 'Sentuhan manis buah dan vanila.',
    ),
    Parfum(
      id: '5',
      nama: 'Parfum Elegant 05',
      kategori: 'Luxury',
      harga: 200000,
      gambar: 'assets/images/parfum5.jpeg',
      deskripsi: 'Parfum mewah berkelas tinggi.',
    ),
    Parfum(
      id: '6',
      nama: 'Parfum Ocean 06',
      kategori: 'Aquatic',
      harga: 140000,
      gambar: 'assets/images/parfum6.jpeg',
      deskripsi: 'Sensasi kesegaran laut yang menenangkan.',
    ),
    Parfum(
      id: '7',
      nama: 'Parfum Vanilla 07',
      kategori: 'Sweet',
      harga: 155000,
      gambar: 'assets/images/parfum7.jpeg',
      deskripsi: 'Aroma vanila lembut yang hangat.',
    ),
    Parfum(
      id: '8',
      nama: 'Parfum Musk 08',
      kategori: 'Musky',
      harga: 180000,
      gambar: 'assets/images/parfum8.jpeg',
      deskripsi: 'Kombinasi musk sensual yang tahan lama.',
    ),
    Parfum(
      id: '9',
      nama: 'Parfum Citrus 09',
      kategori: 'Citrus',
      harga: 135000,
      gambar: 'assets/images/parfum9.jpeg',
      deskripsi: 'Aroma jeruk ceria pembangkit semangat.',
    ),
    Parfum(
      id: '10',
      nama: 'Parfum Rose 10',
      kategori: 'Floral',
      harga: 165000,
      gambar: 'assets/images/parfum10.jpeg',
      deskripsi: 'Keharuman bunga mawar klasik.',
    ),
    Parfum(
      id: '11',
      nama: 'Parfum Night 11',
      kategori: 'Luxury',
      harga: 210000,
      gambar: 'assets/images/parfum11.jpeg',
      deskripsi: 'Eksklusif untuk malam istimewa.',
    ),
    Parfum(
      id: '12',
      nama: 'Parfum Sport 12',
      kategori: 'Fresh',
      harga: 125000,
      gambar: 'assets/images/parfum12.jpeg',
      deskripsi: 'Enerjik dan segar untuk berolahraga.',
    ),
    Parfum(
      id: '13',
      nama: 'Parfum Velvet 13',
      kategori: 'Woody',
      harga: 190000,
      gambar: 'assets/images/parfum13.jpeg',
      deskripsi: 'Wangi lembut bagai kain velvet.',
    ),
    Parfum(
      id: '14',
      nama: 'Parfum Amber 14',
      kategori: 'Oriental',
      harga: 195000,
      gambar: 'assets/images/parfum14.jpeg',
      deskripsi: 'Aroma amber hangat dan misterius.',
    ),
    Parfum(
      id: '15',
      nama: 'Parfum Lily 15',
      kategori: 'Floral',
      harga: 145000,
      gambar: 'assets/images/parfum15.jpeg',
      deskripsi: 'Keharuman bunga lily yang natural.',
    ),
    Parfum(
      id: '16',
      nama: 'Parfum Gold 16',
      kategori: 'Luxury',
      harga: 250000,
      gambar: 'assets/images/parfum16.jpeg',
      deskripsi: 'Edisi spesial emas paling tahan lama.',
    ),
  ];

  static List<Pesanan> daftarPesanan = [];

  static List<Parfum> fetchParfum() => daftarParfum;
  static void tambahParfum(Parfum p) => daftarParfum.add(p);
  static void updateParfum(String id, Parfum p) {
    int index = daftarParfum.indexWhere((item) => item.id == id);
    if (index != -1) daftarParfum[index] = p;
  }

  static void hapusParfum(String id) =>
      daftarParfum.removeWhere((item) => item.id == id);

  static void tambahPesanan(Pesanan pesanan) => daftarPesanan.add(pesanan);
  static List<Pesanan> fetchPesanan() => daftarPesanan;
}
