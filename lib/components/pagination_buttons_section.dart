import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PaginationButtonSection extends StatelessWidget {
  const PaginationButtonSection({
    Key? key,
    required this.page,
    required this.numberItens,
    required this.itemsPerPage,
    required this.visiblePages,
    required this.setPage,
  }) : super(key: key);

  final int page;
  final int numberItens;
  final int itemsPerPage;
  final int visiblePages;
  final Function setPage;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final int totalPages = ((numberItens) / itemsPerPage).ceil();
        final int startPage = max(0, page - (visiblePages ~/ 2));
        final int endPage = min(totalPages - 1, startPage + visiblePages - 1);
        if (kDebugMode) {
          print('TotalPages$totalPages');
          print('StartPage$startPage');
          print('EndPage$endPage');
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (page > 0)
              ElevatedButton(
                onPressed: () => setPage(page - 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(37, 66, 43, 0.8),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('<<'),
              ),
            if (startPage > 0)
              const Text(
                '...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 66, 43, 0.8),
                ),
              ),
            for (int i = startPage; i <= endPage; i++)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: i == page ? const Color.fromRGBO(107, 128, 68, 1) : const Color.fromRGBO(118, 138, 79, 0.55),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                onPressed: () => setPage(i),
                child: Text('${i + 1}'),
              ),
            if (endPage < totalPages - 1)
              const Text(
                '...',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(37, 66, 43, 0.8),
                ),
              ),
            if (page < totalPages - 1)
              ElevatedButton(
                onPressed: () => setPage(page + 1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(37, 66, 43, 0.8),
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                ),
                child: const Text('>>'),
              ),
          ],
        );
      },
    );
  }
}
