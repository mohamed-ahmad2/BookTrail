import 'package:book_trail/book_operation.dart';
import 'package:book_trail/kconstant.dart';
import 'package:book_trail/models/book.dart';
import 'package:book_trail/providers/theme_provider.dart';
import 'package:book_trail/providers/user_provider.dart';
import 'package:book_trail/views/widgets/stats_search/qr_scanner_screen.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class CustomSearchBarSearch extends StatelessWidget {
  final Function(String) onSearch;
  const CustomSearchBarSearch({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: (value) {
          onSearch(value);
        },
        onSubmitted: (value) {
          onSearch(value);
        },
        decoration: InputDecoration(
          filled: true,
          fillColor:
              themeProvider.isDarkMode
                  ? const Color(0xFF2E2E2E)
                  : const Color(0xFFECE6F0),
          hintText: "search text",
          prefixIcon: Icon(Icons.search),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 17),
            child: IconButton(
              icon: Icon(Icons.qr_code_scanner),
              onPressed: () async {
                var cameraStatus = await Permission.camera.request();
                var storageStatus = await Permission.storage.request();

                if (cameraStatus.isGranted && storageStatus.isGranted) {
                  final scannedCode = await Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QrScannerScreen(),
                    ),
                  );

                  if (scannedCode != null) {
                    final bookOperation = BookOperation();
                    await bookOperation.initialize(
                      kBookBox(userProvider.userId),
                    );

                    final existingBook = bookOperation.getBook(scannedCode);

                    if (existingBook != null) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('This book is already added!'),
                          ),
                        );
                      }
                      return;
                    }

                    final newBook = Book(
                      bookId: scannedCode,
                      title: 'Unknown Title',
                      readingStatus: 'None',
                    );

                    await bookOperation.addBook(newBook);

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Book added successfully!'),
                        ),
                      );
                    }
                  }
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Camera and Storage permissions are required.',
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
