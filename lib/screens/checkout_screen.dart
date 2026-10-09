import 'package:flutter/material.dart';

import '../models/parfum_model.dart';
import '../models/pesanan_model.dart';
import '../services/api_service.dart';
import 'pesanan_saya_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Parfum> cartItems;
  final double totalHarga;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.totalHarga,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _metodePembayaran = 'Transfer Bank';
  final TextEditingController _alamatController = TextEditingController(
    text: 'Jl. Jend. Sudirman No. 123, Medan',
  );

  void _prosesCheckout() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Keranjang belanjaan masih kosong!')),
      );
      return;
    }

    final String idUnik = DateTime.now().millisecondsSinceEpoch.toString();
    final pesananBaru = Pesanan(
      idPesanan: 'PRT${idUnik.substring(idUnik.length - 6)}',
      items: List.from(widget.cartItems),
      totalHarga: widget.totalHarga + 15000,
      metodePembayaran: _metodePembayaran,
      alamat: _alamatController.text,
      status: 'Belum Bayar',
      nomorResi: 'JP${idUnik.substring(idUnik.length - 8)}',
    );

    ApiService.tambahPesanan(pesananBaru);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checkout Berhasil! Pesanan masuk ke "Belum Bayar".'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PesananSayaScreen()),
    );
  }

  Widget _buildOpsiPembayaran(String judul, IconData icon) {
    bool isSelected = _metodePembayaran == judul;
    return GestureDetector(
      onTap: () {
        setState(() {
          _metodePembayaran = judul;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.pinkAccent : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.pink.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.pinkAccent : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                judul,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.pinkAccent : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.pinkAccent,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double ongkir = 15000;
    double totalSemua = widget.totalHarga + ongkir;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Pesanan'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Alamat Pengiriman',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _alamatController,
            maxLines: 2,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Alamat Lengkap Penerima',
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ringkasan Produk',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          ...widget.cartItems.map(
            (item) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Image.asset(
                  item.gambar,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  item.nama,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  'Rp ${item.harga.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Metode Pembayaran',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          _buildOpsiPembayaran('Transfer Bank', Icons.account_balance),
          _buildOpsiPembayaran('COD', Icons.local_shipping),
          _buildOpsiPembayaran('ShopeePay', Icons.wallet),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Subtotal Produk:'),
              Text('Rp ${widget.totalHarga.toStringAsFixed(0)}'),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Biaya Pengiriman:'),
              Text('Rp ${ongkir.toStringAsFixed(0)}'),
            ],
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Pembayaran:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                'Rp ${totalSemua.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _prosesCheckout,
            child: const Text(
              'Buat Pesanan & Bayar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
