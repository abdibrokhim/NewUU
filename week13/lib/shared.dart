import 'package:flutter/material.dart';

Widget buildButton({required String text, required Function() onPressed}) {
    return TextButton(
                  onPressed: onPressed,
                  child: Text(text),
                );
}

Widget buildTextfield({required String text, required TextEditingController controller, required bool obscureText}) {
    return                     TextField(
                      obscureText: obscureText,
                      controller: controller,
                      decoration: InputDecoration(
                        labelText: text,
                      ),
                    );
}

Widget buildElevatedButton({required String text, required Function() onPressed}) {
    return                     ElevatedButton(

                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          fixedSize: const Size(300, 50)
                      ),
                      child: Text(text),

                    );
}
