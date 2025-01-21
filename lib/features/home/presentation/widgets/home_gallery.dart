import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '/config/routes/app_routes.dart';
import '/core/widgets/diff_img.dart';
import '/core/widgets/gaps.dart';

class HomeGallery extends StatefulWidget {
  const HomeGallery({super.key});

  @override
  State<HomeGallery> createState() => _HomeGalleryState();
}

class _HomeGalleryState extends State<HomeGallery> {
  final CarouselSliderController controller = CarouselSliderController();
  final ValueNotifier<int> _pageIndexNotifier =
      ValueNotifier<int>(0); // Track page index

  // Sample images for testing
  List<String> items = [
    'https://img.freepik.com/premium-photo/supra-mk4-car-bridge-image-background_911078-4755.jpg?w=1060',
    'https://img.freepik.com/free-photo/old-car-cobblestone-street_1203-2228.jpg?t=st=1736261539~exp=1736265139~hmac=2e87be11511809f91f2be07f2179fa98652a5af12f87244a2dd69cc619a960c7&w=996',
    'https://img.freepik.com/premium-photo/futuristic-supercar-concept_849715-16438.jpg?w=826',
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CarouselSlider(
                carouselController: controller,
                items: items.map((image) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.fullPhotoRoute,
                              arguments: image);
                        },
                        child: DiffImage(
                          image: image,
                          height: screenHeight * 0.2721,
                          width: double.infinity,
                          fitType: BoxFit.fill,
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  padEnds: true,
                  enableInfiniteScroll: true,
                  autoPlay: items.length > 1 ? true : false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (val, _) {
                    _pageIndexNotifier.value = val;
                  },
                ),
              ),
              Positioned(
                bottom: 10, // Adjust this to control vertical positioning
                child: ValueListenableBuilder<int>(
                  valueListenable: _pageIndexNotifier,
                  builder: (context, value, child) {
                    return Container(
                      padding: EdgeInsets.all(3.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(41.r),
                        color: Colors.transparent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          items.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 9.0,
                            width: value == index ? 16.0 : 9.0,
                            decoration: BoxDecoration(
                              color: value == index
                                  ? const Color(0xFF4F008C)
                                  : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                color: const Color(0xFF4F008C),
                                width: 1.0, // Border width
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Gaps.vGap10,
      ],
    );
  }
}

class GalleryShimmer extends StatelessWidget {
  const GalleryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0.r),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }
}
