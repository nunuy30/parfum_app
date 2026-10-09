import 'package:flutter/material.dart';

import '../models/pesanan_model.dart';
import '../services/api_service.dart';

class PesananSayaScreen extends StatefulWidget {
  const PesananSayaScreen({super.key});

  @override
  State<PesananSayaScreen> createState() => _PesananSayaScreenState();
}

class _PesananSayaScreenState extends State<PesananSayaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    List<Pesanan> semuaPesanan = ApiService.fetchPesanan();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Saya'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Belum Bayar'),
            Tab(text: 'Dikemas'),
            Tab(text: 'Dikirim'),
            Tab(text: 'Penilaian'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListPesanan(semuaPesanan, 'Belum Bayar'),
          _buildListPesanan(semuaPesanan, 'Dikemas'),
          _buildListPesanan(semuaPesanan, 'Dikirim'),
          _buildListPesanan(semuaPesanan, 'Selesai'),
        ],
      ),
    );
  }

  Widget _buildListPesanan(List<Pesanan> list, String statusTarget) {
    final filtered = list.where((p) => p.status == statusTarget).toList();

    if (filtered.isEmpty) {
      const pesannya = {
        'Belum Bayar': 'Tidak ada pesanan belum bayar',
        'Dikemas': 'Belum ada pesanan yang dikemas',
        'Dikirim': 'Belum ada pesanan dalam pengiriman',
        'Selesai': 'Belum ada riwayat penilaian',
      };
      return Center(
        child: Text(
          pesannya[statusTarget] ?? 'Tidak ada pesanan',
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final pesanan = filtered[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ID: ${pesanan.idPesanan}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      pesanan.status,
                      style: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ...pesanan.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            item.gambar,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.nama,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                'Rp ${item.harga.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                if (pesanan.nomorResi.isNotEmpty &&
                    pesanan.status != 'Belum Bayar')
                  Text(
                    'No. Resi: ${pesanan.nomorResi}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueAccent,
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: Rp ${pesanan.totalHarga.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),

                    // Tombol Aksi Berdasarkan Status
                    if (pesanan.status == 'Belum Bayar')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        onPressed: () {
                          setState(() {
                            pesanan.status = 'Dikemas';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pembayaran Berhasil! Pesanan dipindah ke Dikemas.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Bayar Sekarang',
                          style: TextStyle(fontSize: 11),
                        ),
                      )
                    else if (pesanan.status == 'Dikemas')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        onPressed: () {
                          setState(() {
                            pesanan.status = 'Dikirim';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pesanan dikirim! Cek tab Dikirim untuk melihat Resi.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Kirim Pesanan',
                          style: TextStyle(fontSize: 11),
                        ),
                      )
                    else if (pesanan.status == 'Dikirim')
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(80, 30),
                        ),
                        onPressed: () {
                          setState(() {
                            pesanan.status = 'Selesai';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Pesanan diterima! Silakan beri penilaian.',
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Pesanan Diterima',
                          style: TextStyle(fontSize: 11),
                        ),
                      )
                    else if (pesanan.status == 'Selesai')
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.pinkAccent,
                          minimumSize: const Size(80, 30),
                        ),
                        onPressed: () {
                          _tampilkanDialogNilai(context);
                        },
                        child: const Text(
                          'Beri Penilaian',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _tampilkanDialogNilai(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Beri Penilaian Produk'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
                Icon(Icons.star, color: Colors.amber, size: 30),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Tulis ulasan parfum ini...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Terima kasih atas penilaian Anda!'),
                ),
              );
            },
            child: const Text('Kirim'),
          ),
        ],
      ),
    );
  }
}
