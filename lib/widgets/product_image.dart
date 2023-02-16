import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String? url;
  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _boxDecoration(),
        width: double.infinity,
        height: 450,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          child: url == null
          ?
          const Image(image: AssetImage('assets/no-image.png'))
          : 
          FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            image: NetworkImage(url!),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() => BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        color: Colors.red,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      );
}
