class Parfum {
  final String id;
  final String nama;
  final String kategori;
  final double harga;
  final String gambar;
  final String deskripsi;

  Parfum({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.gambar,
    required this.deskripsi,
  });

  factory Parfum.fromJson(Map<String, dynamic> json) {
    return Parfum(
      id: json['id'].toString(),
      nama: json['nama'],
      kategori: json['kategori'],
      harga: (json['harga'] as num).toDouble(),
      gambar: json['gambar'],
      deskripsi: json['deskripsi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'kategori': kategori,
      'harga': harga,
      'gambar': gambar,
      'deskripsi': deskripsi,
    };
  }
}
