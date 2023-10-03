import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isLoading;
  final Function() onPressed;
  final Widget child;
  const AppButton({super.key, this.isLoading = false, required this.onPressed, required this.child});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AbsorbPointer(
      absorbing: isLoading,
      child: Stack(children: [
        Align(
          alignment: Alignment.center,
          child: AnimatedContainer(
            height: 44,
            width: isLoading ? 44 : size.width,
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(isLoading ? 30 : 10)),
              color: const Color(0XFF25A163),
            ),
            child: TextButton(
              onPressed: onPressed,
              child: isLoading
                  ? const SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : child,
            ),
          ),
        ),
        isLoading
            ? Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.only(top: 3.5),
                  child: const CircularProgressIndicator(
                    strokeWidth: 1.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              )
      ]),
    );
  }
}
