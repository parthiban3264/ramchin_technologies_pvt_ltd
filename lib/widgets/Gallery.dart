// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:photo_view/photo_view_gallery.dart';
// import '../services/Gallery_service.dart';
//
// class GalleryItem {
//   final String imagePath; // Asset path or Base64 string
//   final String caption;
//   final bool isAsset;
//
//   GalleryItem(this.imagePath, this.caption, {this.isAsset = true});
// }
//
// class RamchinTechPhotoGallery extends StatefulWidget {
//   const RamchinTechPhotoGallery({super.key});
//
//   @override
//   State<RamchinTechPhotoGallery> createState() =>
//       _RamchinTechPhotoGalleryState();
// }
//
// class _RamchinTechPhotoGalleryState extends State<RamchinTechPhotoGallery> {
//   final GalleryService _galleryService = GalleryService();
//   List<GalleryItem> photos = [];
//   bool _isLoadingBackend = true;
//
//   // Local asset images
//   final List<GalleryItem> _localPhotos = [
//     GalleryItem('assets/compress/DSC_2507-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2513-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2521-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2535-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2538-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2543-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2547-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2561-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2566-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2578-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2584-min.jpeg', 'Internship Training'),
//     GalleryItem('assets/compress/DSC_2593.jpeg', 'Internship Training'),
//     GalleryItem(
//       'assets/compress/2-min.jpeg',
//       'Chief Guest being welcomed at the opening ceremony',
//     ),
//     GalleryItem(
//       'assets/compress/5-min.jpeg',
//       'Reception of Guests at the Opening Ceremony',
//     ),
//     GalleryItem(
//       'assets/compress/9-min.jpeg',
//       'The Chief Guest Opening the Ramchin Technologies (P) Ltd.',
//     ),
//     GalleryItem(
//       'assets/compress/14-min.jpeg',
//       'Honouring Mr.V.Vairavaraj, Director, Farmer\'s Insurance, USA',
//     ),
//     GalleryItem('assets/compress/16-min.jpeg', 'Honouring the Guest'),
//     GalleryItem('assets/compress/18-min.jpeg', 'Honouring the Guest'),
//     GalleryItem(
//       'assets/compress/37-min.jpeg',
//       'Briefing the objecives of the Company',
//     ),
//     GalleryItem(
//       'assets/compress/69-min_11zon.jpeg',
//       'Internship batch from B.Sc (Computer Science)',
//     ),
//     GalleryItem(
//       'assets/compress/70-min_11zon.jpeg',
//       'Internship batch from B.E (Computer Science & Engg)',
//     ),
//     GalleryItem(
//       'assets/compress/75-min.jpeg',
//       'Students actively engaged in their Internship Program',
//     ),
//     GalleryItem(
//       'assets/compress/77-min.jpeg',
//       'Students actively engaged in their Internship Program',
//     ),
//     GalleryItem(
//       'assets/compress/79-min.jpeg',
//       'Students actively engaged in their Internship Program',
//     ),
//     GalleryItem(
//       'assets/compress/g01.jpeg',
//       'The Principal of GAC addressing their Students during Campus Interview',
//     ),
//     GalleryItem(
//       'assets/compress/g02.jpeg',
//       'Screening the Students by conducting a written test',
//     ),
//     GalleryItem(
//       'assets/compress/g03.jpeg',
//       'The Students are being screened through Personal Interviw',
//     ),
//     GalleryItem(
//       'assets/compress/g04.jpeg',
//       'The Director of Ramchin Technologies addressing to the candidates during Campus Interview',
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     photos = List.from(_localPhotos); // Show local assets first
//     _fetchBackendImages(); // Then fetch backend images
//   }
//
//   Future<void> _fetchBackendImages() async {
//     try {
//       final backendImages = await _galleryService.getAllImages();
//
//       final backendPhotos = backendImages.map<GalleryItem>((item) {
//         return GalleryItem(
//           item['image'] ?? '', // Base64 string
//           item['description'] ?? '',
//           isAsset: false,
//         );
//       }).toList();
//
//       if (mounted) {
//         setState(() {
//           photos.addAll(backendPhotos);
//           _isLoadingBackend = false;
//         });
//       }
//     } catch (e) {
//       print("❌ Error fetching backend images: $e");
//       setState(() => _isLoadingBackend = false);
//     }
//   }
//
//   void _openFullScreen(BuildContext context, int index) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (_) => Scaffold(
//           backgroundColor: Colors.black,
//           body: Stack(
//             children: [
//               PhotoViewGallery.builder(
//                 itemCount: photos.length,
//                 builder: (context, idx) {
//                   return PhotoViewGalleryPageOptions(
//                     imageProvider: photos[idx].isAsset
//                         ? AssetImage(photos[idx].imagePath)
//                         : MemoryImage(base64Decode(photos[idx].imagePath)),
//                     minScale: PhotoViewComputedScale.contained,
//                     maxScale: PhotoViewComputedScale.covered * 2,
//                   );
//                 },
//                 pageController: PageController(initialPage: index),
//                 backgroundDecoration: const BoxDecoration(color: Colors.black),
//               ),
//               Positioned(
//                 top: 40,
//                 right: 20,
//                 child: IconButton(
//                   icon: const Icon(Icons.close, color: Colors.white, size: 32),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white70,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Text(
//               "Welcome to Ramchin Tech Photo Gallery",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 35,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w400,
//                 letterSpacing: 1.1,
//               ),
//             ),
//             const SizedBox(height: 15),
//             const Text(
//               "A collection of beautiful moments captured in photos.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 20,
//                 color: Colors.black38,
//                 fontWeight: FontWeight.w400,
//                 letterSpacing: 1.1,
//               ),
//             ),
//             const SizedBox(height: 40),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: photos.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: MediaQuery.of(context).size.width > 1100
//                       ? 4
//                       : MediaQuery.of(context).size.width > 700
//                       ? 3
//                       : 2,
//                   crossAxisSpacing: 22,
//                   mainAxisSpacing: 22,
//                   childAspectRatio: 1.2,
//                 ),
//                 itemBuilder: (context, index) {
//                   return _HoverCard(
//                     photo: photos[index],
//                     onTap: () => _openFullScreen(context, index),
//                   );
//                 },
//               ),
//             ),
//             if (_isLoadingBackend)
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20),
//                 child: CircularProgressIndicator(),
//               ),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _HoverCard extends StatefulWidget {
//   final GalleryItem photo;
//   final VoidCallback onTap;
//
//   const _HoverCard({Key? key, required this.photo, required this.onTap})
//     : super(key: key);
//
//   @override
//   State<_HoverCard> createState() => _HoverCardState();
// }
//
// class _HoverCardState extends State<_HoverCard> {
//   bool _isHovered = false;
//
//   void _triggerMobileHover() {
//     if (mounted &&
//         (Theme.of(context).platform == TargetPlatform.android ||
//             Theme.of(context).platform == TargetPlatform.iOS)) {
//       setState(() => _isHovered = true);
//       Future.delayed(const Duration(seconds: 2), () {
//         if (mounted) setState(() => _isHovered = false);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onTap();
//         _triggerMobileHover(); // 👈 mobileல் hover auto trigger
//       },
//       onLongPress: _triggerMobileHover, // long press alternate hover
//       child: MouseRegion(
//         cursor: SystemMouseCursors.click,
//         onEnter: (_) => setState(() => _isHovered = true),
//         onExit: (_) => setState(() => _isHovered = false),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           elevation: 8,
//           clipBehavior: Clip.antiAlias,
//           child: Stack(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: double.infinity,
//                 child: widget.photo.isAsset
//                     ? Image.asset(widget.photo.imagePath, fit: BoxFit.cover)
//                     : Image.memory(
//                         base64Decode(widget.photo.imagePath),
//                         fit: BoxFit.cover,
//                         errorBuilder: (_, __, ___) =>
//                             const Center(child: Icon(Icons.broken_image)),
//                       ),
//               ),
//               AnimatedOpacity(
//                 opacity: _isHovered ? 1.0 : 0.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                   alignment: Alignment.center,
//                   child: Text(
//                     widget.photo.caption,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: MediaQuery.of(context).size.width > 700
//                           ? 22
//                           : 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../services/Gallery_service.dart';

class GalleryItem {
  final String imagePath; // Asset path or Base64 string
  final String caption;
  final bool isAsset;
  Uint8List? decodedBytes; // cache for base64

  GalleryItem(this.imagePath, this.caption, {this.isAsset = true}) {
    if (!isAsset) {
      try {
        decodedBytes = base64Decode(imagePath);
      } catch (e) {
        debugPrint("❌ Base64 decode failed for: $caption, error: $e");
      }
    }
  }
}

class RamchinTechPhotoGallery extends StatefulWidget {
  const RamchinTechPhotoGallery({super.key});

  @override
  State<RamchinTechPhotoGallery> createState() =>
      _RamchinTechPhotoGalleryState();
}

class _RamchinTechPhotoGalleryState extends State<RamchinTechPhotoGallery> {
  final GalleryService _galleryService = GalleryService();
  List<GalleryItem> photos = [];
  bool _isLoadingBackend = true;

  // Local asset images
  final List<GalleryItem> _localPhotos = [
    GalleryItem('assets/compress/DSC_2507-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2513-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2521-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2535-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2538-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2543-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2547-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2561-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2566-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2578-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2584-min.jpeg', 'Internship Training'),
    GalleryItem('assets/compress/DSC_2593.jpeg', 'Internship Training'),
    GalleryItem(
      'assets/compress/2-min.jpeg',
      'Chief Guest being welcomed at the opening ceremony',
    ),
    GalleryItem(
      'assets/compress/5-min.jpeg',
      'Reception of Guests at the Opening Ceremony',
    ),
    GalleryItem(
      'assets/compress/9-min.jpeg',
      'The Chief Guest Opening the Ramchin Technologies (P) Ltd.',
    ),
    GalleryItem(
      'assets/compress/14-min.jpeg',
      'Honouring Mr.V.Vairavaraj, Director, Farmer\'s Insurance, USA',
    ),
    GalleryItem('assets/compress/16-min.jpeg', 'Honouring the Guest'),
    GalleryItem('assets/compress/18-min.jpeg', 'Honouring the Guest'),
    GalleryItem(
      'assets/compress/37-min.jpeg',
      'Briefing the objectives of the Company',
    ),
    GalleryItem(
      'assets/compress/69-min_11zon.png',
      'Internship batch from B.Sc (Computer Science)',
    ),
    GalleryItem(
      'assets/compress/70-min_11zon.png',
      'Internship batch from B.E (Computer Science & Engg)',
    ),
    GalleryItem(
      'assets/compress/75-min.jpeg',
      'Students actively engaged in their Internship Program',
    ),
    GalleryItem(
      'assets/compress/77-min.jpeg',
      'Students actively engaged in their Internship Program',
    ),
    GalleryItem(
      'assets/compress/79-min.jpeg',
      'Students actively engaged in their Internship Program',
    ),
    GalleryItem(
      'assets/compress/g01.jpeg',
      'The Principal of GAC addressing Students during Campus Interview',
    ),
    GalleryItem(
      'assets/compress/g02.jpeg',
      'Screening the Students by conducting a written test',
    ),
    GalleryItem(
      'assets/compress/g03.jpeg',
      'The Students are being screened through Personal Interview',
    ),
    GalleryItem(
      'assets/compress/g04.jpeg',
      'The Director of Ramchin Tech addressing candidates during Interview',
    ),
  ];

  @override
  void initState() {
    super.initState();
    photos = List.from(_localPhotos); // show local assets first
    _fetchBackendImages(); // then fetch backend images
  }

  Future<void> _fetchBackendImages() async {
    try {
      debugPrint("📡 Fetching images from backend...");
      final backendImages = await _galleryService.getAllImages();

      final backendPhotos = backendImages.map<GalleryItem>((item) {
        return GalleryItem(
          item['image'] ?? '',
          item['description'] ?? '',
          isAsset: false,
        );
      }).toList();

      if (mounted) {
        setState(() {
          photos.addAll(backendPhotos);
          _isLoadingBackend = false;
        });
        debugPrint("✅ Loaded ${backendPhotos.length} images from backend");
      }
    } catch (e) {
      debugPrint("❌ Error fetching backend images: $e");
      if (mounted) setState(() => _isLoadingBackend = false);
    }
  }

  void _openFullScreen(BuildContext context, int index) {
    debugPrint("🔍 Opening full screen for: ${photos[index].caption}");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: photos.length,
                builder: (context, idx) {
                  final img = photos[idx];
                  return PhotoViewGalleryPageOptions(
                    imageProvider: img.isAsset
                        ? AssetImage(img.imagePath)
                        : (img.decodedBytes != null
                              ? MemoryImage(img.decodedBytes!)
                              : const AssetImage(
                                      "assets/compress/DSC_2507-min.jpeg",
                                    )
                                    as ImageProvider),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                pageController: PageController(initialPage: index),
                backgroundDecoration: const BoxDecoration(color: Colors.black),
              ),
              Positioned(
                top: 40,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome to Ramchin Tech Photo Gallery",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "A collection of beautiful moments captured in photos.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: photos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 1100
                      ? 4
                      : MediaQuery.of(context).size.width > 700
                      ? 3
                      : 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 22,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return _HoverCard(
                    photo: photos[index],
                    onTap: () => _openFullScreen(context, index),
                  );
                },
              ),
            ),
            if (_isLoadingBackend)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircularProgressIndicator(),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final GalleryItem photo;
  final VoidCallback onTap;

  const _HoverCard({Key? key, required this.photo, required this.onTap})
    : super(key: key);

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard>
    with AutomaticKeepAliveClientMixin {
  bool _isHovered = false;

  @override
  bool get wantKeepAlive => true;

  void _triggerMobileHover() {
    if (mounted &&
        (Theme.of(context).platform == TargetPlatform.android ||
            Theme.of(context).platform == TargetPlatform.iOS)) {
      debugPrint("📱 Mobile hover triggered for: ${widget.photo.caption}");
      setState(() => _isHovered = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _isHovered = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _triggerMobileHover();
      },
      onLongPress: _triggerMobileHover,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          setState(() => _isHovered = true);
        },
        onExit: (_) {
          setState(() => _isHovered = false);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 6,
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: widget.photo.isAsset
                    ? Image.asset(
                        widget.photo.imagePath,
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                        cacheWidth: 400, // lower res for smoother grid
                      )
                    : (widget.photo.decodedBytes != null
                          ? Image.memory(
                              widget.photo.decodedBytes!,
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                              cacheWidth: 400,
                              errorBuilder: (_, __, ___) =>
                                  const Center(child: Icon(Icons.broken_image)),
                            )
                          : const Center(child: Icon(Icons.broken_image))),
              ),
              AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Text(
                    widget.photo.caption,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > 700
                          ? 22
                          : 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
