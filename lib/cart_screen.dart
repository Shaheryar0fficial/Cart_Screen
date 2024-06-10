import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItem {
  final String imagePath;
  final String title;
  final String description;
  double price;
  int quantity;

  CartItem({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.price,
    this.quantity = 1,
  });
}

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> _cartItems = [
    CartItem(
      imagePath: 'assets/aripip.jpg',
      title: 'Aripip 10mg',
      description: 'strip 10 tablets',
      price: 120.67,
    ),
    CartItem(
      imagePath: 'assets/acefyl.jpg',
      title: 'Acefyl Cough',
      description: 'Syrup bottle',
      price: 89.63,
    ),
  ];

  double _couponDiscount = 20.15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          '${_cartItems.length} Items in your cart',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              '+ Add more',
              style: TextStyle(color: Colors.blueAccent, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _cartItems.length,
                itemBuilder: (context, index) {
                  final item = _cartItems[index];
                  return _buildCartItem(context, item, index);
                },
              ),
            ),
            _buildCouponSection(context),
            _buildPaymentSummary(),
            _buildPlaceOrderButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item, int index) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              item.imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    item.description,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Rs${item.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (item.quantity > 1) item.quantity--;
                        });
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.quantity++;
                        });
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _cartItems.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget _buildCouponSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/coupon_icon.svg',
              width: 20,
              height: 20,
            ),
            SizedBox(width: 5),
            Text(
              '1 Coupon applied',
              style: TextStyle(color: Colors.green, fontSize: 16),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _couponDiscount = 0;
            });
          },
          icon: Icon(Icons.close),
        ),
      ],
    );
  }

  Widget _buildPaymentSummary() {
    double orderTotal = _cartItems.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
    double itemsDiscount = 5.15;
    double total = orderTotal - itemsDiscount - _couponDiscount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Summary',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 10),
        _buildSummaryRow('Order Total', 'Rs ${orderTotal.toStringAsFixed(2)}'),
        _buildSummaryRow(
            'Items Discount', '-Rs ${itemsDiscount.toStringAsFixed(2)}'),
        _buildSummaryRow(
            'Coupon Discount', '-Rs ${_couponDiscount.toStringAsFixed(2)}'),
        _buildSummaryRow('Shipping', 'Free'),
        Divider(),
        _buildSummaryRow('Total', 'Rs ${total.toStringAsFixed(2)}',
            isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String title, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOrderButton() {
    double orderTotal = _cartItems.fold(
      0,
      (total, item) => total + (item.price * item.quantity),
    );
    double itemsDiscount = 5.15;
    double total = orderTotal - itemsDiscount - _couponDiscount;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle place order functionality here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          'Place Order Rs ${total.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
