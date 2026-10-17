import 'package:flutter/material.dart';

class PlayerDiscImage extends StatelessWidget {
  final String? imageUrl;
  final String imagePath;

  const PlayerDiscImage({
    super.key,
    this.imageUrl,
    this.imagePath = 'assets/image/player_screen/sai_baba.png',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Main disc with image
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFFFFF),
                  width: 8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ClipOval(
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        width: 240,
                        height: 240,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildAssetImage();
                        },
                      )
                    : _buildAssetImage(),
              ),
            ),

            // Center disc (white)
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                shape: BoxShape.circle,
              ),
              child: Center(
                // Inner circle (brown)
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9A4100),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      imagePath,
      width: 240,
      height: 240,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 240,
      height: 240,
      decoration: const BoxDecoration(
        color: Color(0xFFFFDDB8),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.music_note,
        color: Color(0xFF9A4100),
        size: 80,
      ),
    );
  }
}
