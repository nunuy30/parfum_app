import 'package:flutter/material.dart';

import 'models/parfum_model.dart';
import 'screens/home_screen.dart';
import 'screens/wishlist_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/pesanan_saya_screen.dart';

void main() {
  runApp(const ParfumApp());
}

class ParfumApp extends StatelessWidget {
  const ParfumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parfum Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final List<Parfum> _wishlist = [];
  final List<Parfum> _cartItems = [];

  // Fungsi Tambah/Hapus Wishlist (Favorit)
  void _toggleFavorite(Parfum parfum) {
    setState(() {
      final index = _wishlist.indexWhere((item) => item.id == parfum.id);
      if (index >= 0) {
        _wishlist.removeAt(index);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Dihapus dari Wishlist'),
            duration: Duration(milliseconds: 800),
          ),
        );
      } else {
        _wishlist.add(parfum);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ditambahkan ke Wishlist'),
            duration: Duration(milliseconds: 800),
          ),
        );
      }
    });
  }

  // Fungsi Tambah ke Keranjang
  void _addToCart(Parfum parfum) {
    setState(() {
      _cartItems.add(parfum);
    });
  }

  // Fungsi Hapus item dari Keranjang
  void _removeFromCart(Parfum parfum) {
    setState(() {
      _cartItems.remove(parfum);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Daftar Halaman Utama (Bottom Navigation)
    final List<Widget> pages = [
      HomeScreen(
        wishlist: _wishlist,
        onAddToCart: _addToCart,
        onToggleFavorite: _toggleFavorite,
      ),
      WishlistScreen(
        wishlist: _wishlist,
        onAddToCart: _addToCart,
        onToggleFavorite: _toggleFavorite,
      ),
      CartScreen(cartItems: _cartItems, onRemoveFromCart: _removeFromCart),
      const PesananSayaScreen(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart),
                if (_cartItems.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        '${_cartItems.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Keranjang',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Pesanan',
          ),
        ],
      ),
    );
  }
}
