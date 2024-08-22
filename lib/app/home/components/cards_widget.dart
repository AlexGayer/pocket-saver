import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 150,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => SizedBox(
            width: 150,
            child: Card(
              color: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}
