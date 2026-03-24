import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key, this.size = 50});
  final double size;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: TargetPlatform.iOS == Theme.of(context).platform
          ? CupertinoActivityIndicator(color: Colors.white)
          : CircularProgressIndicator(color: Colors.white),
    );
  }
}
