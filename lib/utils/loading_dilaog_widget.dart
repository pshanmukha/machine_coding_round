import 'package:flutter/material.dart';

mixin LoadingDialogMixin {
  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}