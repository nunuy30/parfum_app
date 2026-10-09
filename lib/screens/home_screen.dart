import 'package:flutter/material.dart';

import '../models/parfum_model.dart';
import '../services/api_service.dart';
import 'detail_screen.dart';
import 'form_parfum_screen.dart';

class HomeScreen extends StatefulWidget {
  final List<Parfum> wishlist;
  final Function(Parfum) onAddToCart;
  final Function(Parfum) onToggleFavorite;

  const HomeScreen({
    super.key,
    required this.wishlist,
    required this.onAddToCart,
    required this.onToggleFavorite,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Parfum> listParfum;

  @override
  void initState() {
    super.initState();
    _muatData();
  }

  void _muatData() {
    setState(() {
      listParfum = ApiService.fetchParfum();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parfum SH'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: listParfum.length,
        itemBuilder: (context, index) {
          final parfum = listParfum[index];
          final isFavorite = widget.wishlist.any(
            (item) => item.id == parfum.id,
          );

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    parfum: parfum,
                    onAddToCart: widget.onAddToCart,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            parfum.gambar,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                        // Tombol Favorite
                        Positioned(
                          top: 4,
                          right: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 16,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.pinkAccent,
                                size: 18,
                              ),
                              onPressed: () {
                                widget.onToggleFavorite(parfum);
                              },
                            ),
                          ),
                        ),
                        // Tombol Edit & Hapus (Titik Tiga)
                        Positioned(
                          top: 4,
                          left: 4,
                          child: CircleAvatar(
                            backgroundColor: Colors.white70,
                            radius: 16,
                            child: PopupMenuButton<String>(
                              padding: EdgeInsets.zero,
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.black87,
                                size: 18,
                              ),
                              color: Colors.white,
                              onSelected: (value) async {
                                if (value == 'edit') {
                                  bool? updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FormParfumScreen(
                                        parfumToEdit: parfum,
                                      ),
                                    ),
                                  );
                                  if (updated == true) _muatData();
                                } else if (value == 'hapus') {
                                  setState(() {
                                    ApiService.hapusParfum(parfum.id);
                                    _muatData();
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Produk berhasil dihapus!'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Text('Edit'),
                                ),
                                const PopupMenuItem(
                                  value: 'hapus',
                                  child: Text(
                                    'Hapus',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          parfum.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          parfum.kategori,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${parfum.harga.toStringAsFixed(0)}',
                          style: const TextStyle(
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                          width: double.infinity,
                          height: 28,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pinkAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            onPressed: () {
                              widget.onAddToCart(parfum);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${parfum.nama} ditambahkan ke keranjang!',
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Text(
                              '+ Keranjang',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Tombol Tambah Produk (+) di pojok kanan bawah
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () async {
          bool? added = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormParfumScreen()),
          );
          if (added == true) {
            _muatData();
          }
        },
      ),
    );
  }
}
