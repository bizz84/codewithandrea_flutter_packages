part of alert_dialogs;

Future<bool> showAlertDialog({
  @required BuildContext context,
  @required String title,
  @required String content,
  String cancelActionText,
  @required String defaultActionText,
  VoidCallback onConfirmTxtPress,
}) async {
  if (PlatformWeb.isWeb || !Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            FlatButton(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          FlatButton(
            child: Text(defaultActionText),
            onPressed:onConfirmTxtPress == null ? () => Navigator.of(context).pop(true) : onConfirmTxtPress,
          ),
        ],
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        if (cancelActionText != null)
          CupertinoDialogAction(
            child: Text(cancelActionText),
            onPressed: () => Navigator.of(context).pop(false),
          ),
        CupertinoDialogAction(
          child: Text(defaultActionText),
          onPressed:onConfirmTxtPress == null ? () => Navigator.of(context).pop(true) : onConfirmTxtPress,
        ),
      ],
    ),
  );
}
