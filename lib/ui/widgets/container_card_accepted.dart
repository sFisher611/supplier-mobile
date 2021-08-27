import 'package:flutter/material.dart';
import 'package:supplier_project/const/const_text.dart';

// ignore: must_be_immutable
class ContainerCardAccepted extends StatelessWidget {
  ContainerCardAccepted({
    Key key,
    this.size,
    this.product,
    this.onPressed,
    this.onLongPress,
    this.onPressedDelivered,
    this.onPressedCancel,
  }) : super(key: key);
  final size;
  final product;
  Function onPressed;
  Function onLongPress;
  Function onPressedDelivered;
  Function onPressedCancel;
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
              onLongPress: onLongPress,
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
                            height: 100,
                            width: 100,
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
                                    style: TextStyle(fontSize: 15),
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
                              height: 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 2,
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
                              height: 2,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.pin_drop,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            'Данғара тумани, Ганжиравон МФЙ Наврўз кўчаси',
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          // ignore: deprecated_member_use
                          child: FlatButton(
                            splashColor: Colors.white38,
                            onPressed: onPressedDelivered,
                            color: Colors.green[400],
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              TEXT_PRODUCT_CARD_BUTTON_DELIVERED,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            // ignore: deprecated_member_use
                            child: FlatButton(
                              splashColor: Colors.white38,
                              onPressed: onPressedCancel,
                              color: Colors.red[200],
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black,
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                TEXT_CARD_BUTTON_CANCEL,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            height: 30,
                          ),
                        )
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
