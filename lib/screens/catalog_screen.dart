import 'package:flutter/material.dart';

// Model Produk Lokal
class Product {
  final String name;
  final String description;
  final double price;
  final String imagePath;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}

class CatalogScreen extends StatelessWidget {
  CatalogScreen({super.key});

  // Daftar produk parfum langsung dari foto yang kamu punya
  final List<Product> productList = [
    Product(
      name: 'SH Premium - Nagita',
      description: 'Parfum eksklusif edisi Nagita dengan keharuman lembut.',
      price: 150000,
      imagePath: 'assets/images/parfum2.jpeg',
    ),
    Product(
      name: 'SH Premium - Scandalous',
      description: 'Aroma terinspirasi dari Scandalous yang memikat.',
      price: 165000,
      imagePath: 'assets/images/parfum1.jpeg',
    ),
    Product(
      name: 'SH Premium - Coco Mademoiselle',
      description: 'Aroma oriental segar dan elegan.',
      price: 180000,
      imagePath: 'assets/images/parfum13.jpeg',
    ),
    Product(
      name: 'SH Premium - Black Opium',
      description: 'Wangi manis khas kopi dan vanilla.',
      price: 175000,
      imagePath: 'assets/images/parfum14.jpeg',
    ),
    Product(
      name: 'SH Premium - Versace Bright Crystal',
      description: 'Kesegaran buah delima dan yuzu.',
      price: 160000,
      imagePath: 'assets/images/parfum15.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SH Premium Parfume'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.amber,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: productList.length,
        itemBuilder: (context, index) {
          var product = productList[index];
          return Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Menampilkan Gambar dari Asset Lokal
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.asset(
                      product.imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Rp ${product.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
