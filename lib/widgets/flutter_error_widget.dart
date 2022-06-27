import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:drinks/utils/logger.dart';

class FlutterErrorWidget extends StatefulWidget {
  static const id = 'FlutterErrorWidget';

  final FlutterErrorDetails errorDetails;

  const FlutterErrorWidget({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  State<FlutterErrorWidget> createState() => _FlutterErrorWidgetState();
}

class _FlutterErrorWidgetState extends State<FlutterErrorWidget>
    with Logger<FlutterErrorWidget> {
  void _sendError() {
    logErr(
      widget.errorDetails.exception,
      stackTrace: widget.errorDetails.stack,
    );

    // add API call to send error to server...
  }

  @override
  void initState() {
    _sendError();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const Center(
          child: SizedBox(
            width: double.infinity,
            child: FittedBox(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text("Something just broke!\nIt's not you, it's us..."),
              ),
            ),
          ),
        ),
        floatingActionButton: kDebugMode
            ? FloatingActionButton.extended(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(5),
                      child: Text(widget.errorDetails.toString()),
                    ),
                  ),
                ),
                icon: const Icon(Icons.error),
                label: const Text('See Error'),
              )
            : null,
      ),
    );
  }
}
