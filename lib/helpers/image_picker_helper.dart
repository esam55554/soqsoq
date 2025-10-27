import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> pickImage(BuildContext context) async {
  final ImagePicker picker = ImagePicker();

  final source = await showDialog<ImageSource>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Center(child: Text("Choose where to select your image ^_^")),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: Colors.blue),
            title: const Text("Take a Picture"),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.green),
            title: const Text("From Gallery"),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    ),
  );

  if (source == null) return null;

  final XFile? picked = await picker.pickImage(source: source);
  return picked?.path;
}
