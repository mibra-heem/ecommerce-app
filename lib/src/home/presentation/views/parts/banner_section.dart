// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:ecommerce_app/core/app/views/loading_view.dart';
// import 'package:ecommerce_app/core/config/api.dart';
// import 'package:ecommerce_app/core/resources/media.dart';
// import 'package:ecommerce_app/core/services/dependency_injection.dart';
// import 'package:ecommerce_app/core/utils/dimensions.dart';
// import 'package:ecommerce_app/core/widgets/not_found_text.dart';
// import 'package:ecommerce_app/src/home/presentation/bloc/home_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class BannerSection extends StatefulWidget {
//   const BannerSection({super.key});

//   @override
//   State<BannerSection> createState() => _BannerSectionState();
// }

// class _BannerSectionState extends State<BannerSection> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<HomeBloc>(),
//       child: BlocConsumer<HomeBloc, HomeState>(
//         listener: (context, state) {},
//         builder: (_, state) {
//           debugPrint('$state');
//           if (state is LoadingBanners) {
//             return const LoadingView();
//           } else if (state is BannersLoaded) {
//             if (state.banners.isEmpty) {
//               return const NotFoundText('No Banners');
//             }
//             return CarouselSlider(
//               options: CarouselOptions(
//                 height: Dimensions.height(120),
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 8),
//                 enlargeCenterPage: true,
//                 viewportFraction: 1,
//               ),
//               items: state.banners.map((banner) {
//                 return ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: CachedNetworkImage(
//                     width: double.infinity,
//                     imageUrl: ApiConfig.baseUrl + banner.image,
//                     fit: BoxFit.fill,
//                     placeholder: (context, url) => const Center(
//                       child: CircularProgressIndicator(strokeWidth: 2),
//                     ),
//                     errorWidget: (context, url, error) {
//                       return const Image(
//                         image: AssetImage(Media.defaultShoeImage),
//                       );
//                     },
//                   ),
//                 );
//               }).toList(),
//             );
//           } else if (state is BannerError) {
//             return NotFoundText(state.message);
//           }
//           return const SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
