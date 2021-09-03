import 'package:flutter/material.dart';
import 'package:supplier_project/const/const_text.dart';

// ignore: must_be_immutable
class ContainerCardReturn extends StatelessWidget {
  ContainerCardReturn({
    Key key,
    this.size,
    this.product,
    this.onPressedButton,
    this.onLongPressed,
    this.onPressed,
  }) : super(key: key);
  final size;
  final product;
  Function onPressedButton;
  Function onPressed;
  Function onLongPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Center(
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: onPressed,
              onLongPress: onLongPressed,
              borderRadius: BorderRadius.circular(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Card(
                          child: Container(
                            child: Image.network(
                                'https://lh3.googleusercontent.com/p/AF1QipMIPNOYmmUQgfPFS23-j4Yj0Vn5ESwIxcWNW4AS=w600-h0'),
                            height: size.width * 0.21,
                            width: size.width * 0.21,
                          ),
                          elevation: 5,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    'Кондиционер LG invertor',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    'Очилов Сардор ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Text(
                                    '+998 91 123 45 67',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationStyle:
                                            TextDecorationStyle.dashed),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            'Данғара тумани, Ганжиравон МФЙ Наврўз кўчаси',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          child: FlatButton(
                            splashColor: Colors.white38,
                            onPressed: onPressedButton,
                            color: Colors.green[400],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              TEXT_RETURN_CARD_BUTTON,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          height: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
