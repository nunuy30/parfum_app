import 'package:flutter/material.dart';

import '../models/parfum_model.dart';
import '../services/api_service.dart';

class FormParfumScreen extends StatefulWidget {
  final Parfum?
  parfumToEdit; // Kalau null berarti Tambah, kalau ada isinya berarti Edit

  const FormParfumScreen({super.key, this.parfumToEdit});

  @override
  State<FormParfumScreen> createState() => _FormParfumScreenState();
}

class _FormParfumScreenState extends State<FormParfumScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaController;
  late TextEditingController _kategoriController;
  late TextEditingController _hargaController;
  late TextEditingController _deskripsiController;
  late TextEditingController _gambarController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(
      text: widget.parfumToEdit?.nama ?? '',
    );
    _kategoriController = TextEditingController(
      text: widget.parfumToEdit?.kategori ?? '',
    );
    _hargaController = TextEditingController(
      text: widget.parfumToEdit != null
          ? widget.parfumToEdit!.harga.toString()
          : '',
    );
    _deskripsiController = TextEditingController(
      text: widget.parfumToEdit?.deskripsi ?? '',
    );
    _gambarController = TextEditingController(
      text: widget.parfumToEdit?.gambar ?? 'assets/images/parfum1.jpeg',
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _kategoriController.dispose();
    _hargaController.dispose();
    _deskripsiController.dispose();
    _gambarController.dispose();
    super.dispose();
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      final id =
          widget.parfumToEdit?.id ??
          DateTime.now().millisecondsSinceEpoch.toString();
      final parfumBaru = Parfum(
        id: id,
        nama: _namaController.text,
        kategori: _kategoriController.text,
        harga: double.parse(_hargaController.text),
        deskripsi: _deskripsiController.text,
        gambar: _gambarController.text,
      );

      if (widget.parfumToEdit == null) {
        ApiService.tambahParfum(parfumBaru);
      } else {
        ApiService.updateParfum(id, parfumBaru);
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.parfumToEdit != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Produk Parfum' : 'Tambah Produk Baru'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama Parfum'),
                validator: (val) => val == null || val.isEmpty
                    ? 'Nama tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori (cth: Floral, Woody)',
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Kategori tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Harga (Rp)'),
                validator: (val) => val == null || val.isEmpty
                    ? 'Harga tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _deskripsiController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Produk',
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Deskripsi tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _gambarController,
                decoration: const InputDecoration(
                  labelText: 'Path Gambar (cth: assets/images/parfum1.jpeg)',
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Gambar tidak boleh kosong'
                    : null,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: _simpanData,
                child: Text(
                  isEdit ? 'Simpan Perubahan' : 'Tambah Produk',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
