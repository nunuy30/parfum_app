import 'parfum_model.dart';

class Pesanan {
  final String idPesanan;
  final List<Parfum> items;
  final double totalHarga;
  final String metodePembayaran;
  final String alamat;
  String status; // 'Belum Bayar', 'Dikemas', 'Dikirim', 'Selesai'
  final String nomorResi;

  Pesanan({
    required this.idPesanan,
    required this.items,
    required this.totalHarga,
    required this.metodePembayaran,
    required this.alamat,
    required this.status,
    required this.nomorResi,
  });

  factory Pesanan.fromJson(Map<String, dynamic> json) {
    var listItems = (json['items'] as List)
        .map((itemJson) => Parfum.fromJson(itemJson))
        .toList();

    return Pesanan(
      idPesanan: json['idPesanan'].toString(),
      items: listItems,
      totalHarga: (json['totalHarga'] as num).toDouble(),
      metodePembayaran: json['metodePembayaran'],
      alamat: json['alamat'],
      status: json['status'],
      nomorResi: json['nomorResi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPesanan': idPesanan,
      'items': items.map((item) => item.toJson()).toList(),
      'totalHarga': totalHarga,
      'metodePembayaran': metodePembayaran,
      'alamat': alamat,
      'status': status,
      'nomorResi': nomorResi,
    };
  }
}
