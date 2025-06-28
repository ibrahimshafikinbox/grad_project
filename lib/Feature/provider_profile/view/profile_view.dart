// import 'package:flutter/material.dart';
// import 'package:grad_project/Core/Helper/naviagation_helper.dart';
// import 'package:grad_project/Core/Localizations/app_localizatios.dart';
// import 'package:grad_project/Feature/Booking/book_customer/booking_view_1.dart';
// import 'package:grad_project/Feature/Login/Widget/app_button.dart';
// import 'package:grad_project/Feature/provider_profile/Model/service_provider_model.dart';
// import 'package:grad_project/Feature/provider_profile/cubit/provider_pprfile_cubit.dart';
// import 'package:grad_project/Feature/provider_profile/cubit/provider_state.dart';
// import 'package:grad_project/Feature/resources/colors/colors.dart';
// import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
// import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ProviderProfileView extends StatefulWidget {
//   const ProviderProfileView({super.key});

//   @override
//   State<ProviderProfileView> createState() => _ProviderProfileViewState();
// }

// class _ProviderProfileViewState extends State<ProviderProfileView> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final serviceProviderCubit = BlocProvider.of<ServiceProviderCubit>(context);
//     serviceProviderCubit.getServiceProvider(2);
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: BlocBuilder<ServiceProviderCubit, ServiceProviderState>(
//         builder: (context, state) {
//           if (state is ServiceProviderLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ServiceProviderLoaded) {
//             final provider = state.serviceProvider;
//             return SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   provider.profilePicture != null
//                       ? Image.network(
//                           provider.profilePicture!,
//                           height: 250,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset("assets/img/Group 1000003542.png"),
//                   AppSizedBox.sizedH20,
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Row(
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(provider.name,
//                                 style: AppTextStyle.textStyleBoldBlack),
//                             Text(provider.category,
//                                 style: AppTextStyle.textStyleMediumBlack),
//                           ],
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           icon: const Icon(Icons.phone_outlined),
//                           onPressed: () async {
//                             final phoneNumber = provider.phone;
//                             final uri = Uri(scheme: 'tel', path: phoneNumber);

//                             if (await canLaunchUrl(uri)) {
//                               await launchUrl(uri,
//                                   mode: LaunchMode.externalApplication);
//                             } else {
//                               print('Could not launch $uri');
//                             }
//                           },
//                         ),
//                         AppSizedBox.sizedW10,
//                         IconButton(
//                           icon: const Icon(Icons.chat_outlined),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Container(
//                       height: 100,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset("assets/img/rate.png"),
//                                 // Text("12"),
//                                 Text("${provider.rating}"),
//                                 Text(AppLocalizations.of(context)
//                                     .translate("rating"))
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset("assets/img/order.png"),
//                                 Text("12"),
//                                 Text(
//                                   AppLocalizations.of(context)
//                                       .translate("completed"),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Image.asset("assets/img/exp.png"),
//                                 Text("${provider.experience}"),
//                                 Text(
//                                   AppLocalizations.of(context)
//                                       .translate("experience"),
//                                 )
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text(
//                         AppLocalizations.of(context).translate("availability"),
//                         style: AppTextStyle.textStylesemiBoldBlue),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColors.grey),
//                           ),
//                           padding: const EdgeInsets.all(12.0),
//                           // child: Text("12"),

//                           child: Text("${provider.startTime}"),
//                         ),
//                         AppSizedBox.sizedW15,
//                         Text(AppLocalizations.of(context).translate("to"),
//                             style: AppTextStyle.textStyleRegularBlack),
//                         AppSizedBox.sizedW20,
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: AppColors.grey),
//                           ),
//                           padding: const EdgeInsets.all(12.0),
//                           // child: Text("12"),
//                           child: Text("${provider.endTime}"),
//                         ),
//                       ],
//                     ),
//                   ),
//                   AppSizedBox.sizedH20,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: AppButton(
//                       function: () {
//                         navigateTo(
//                           context,
//                           BookingAddressForm_1(
//                             userId: '12', // Replace with actual userId
//                             providerId: 1.toString(),
//                             // providerId: provider.id.toString(),
//                           ),
//                         );
//                       },
//                       text: AppLocalizations.of(context).translate("book_now"),
//                       textColor: AppColors.white,
//                     ),
//                   ),
//                   AppSizedBox.sizedH20,
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(AppLocalizations.of(context).translate("about"),
//                         style: AppTextStyle.textStylesemiBoldBlue),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: Text(provider.bio),
//                   ),
//                   //                  "rating": "التقييم",
//                   // "completed": "مكتمل",
//                   // "experience": "الخبرة",
//                   // "availability": "التوفر",
//                   // "to": "إلى",
//                   // "book_now": "احجز الآن",
//                   // "about": "حول",
//                   // "reviews": "المراجعات",
//                   // "rate_this_provider": "قيّم هذا المزود وشارك تجربتك",
//                   // "write_a_review": "اكتب مراجعة",
//                   // "no_reviews_yet": "لا توجد مراجعات بعد.",
//                   // "unexpected_error": "حدث خطأ غير متوقع"
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                     child: Text(
//                         AppLocalizations.of(context).translate("reviews"),
//                         style: AppTextStyle.textStylesemiBoldBlue),
//                   ),
//                   ReviewList(reviews: provider.reviews),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Container(
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black12,
//                             blurRadius: 6,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                               AppLocalizations.of(context)
//                                   .translate("rate_this_provider"),
//                               style: AppTextStyle.textStyleRegularBlack),
//                           Row(
//                             children: [
//                               ...List.generate(
//                                 5,
//                                 (index) => const Icon(
//                                     Icons.star_border_outlined,
//                                     color: Colors.blue,
//                                     size: 18),
//                               ),
//                               const Spacer(),
//                               Text(
//                                   AppLocalizations.of(context)
//                                       .translate("write_a_review"),
//                                   style: AppTextStyle.textStyleRegularBlue),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   AppSizedBox.sizedH40,
//                 ],
//               ),
//             );
//           } else if (state is ServiceProviderError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text("An unexpected error occurred"));
//           }
//         },
//       ),
//     );
//   }
// }

// class ReviewList extends StatelessWidget {
//   final List<Review> reviews;

//   const ReviewList({super.key, required this.reviews});

//   @override
//   Widget build(BuildContext context) {
//     if (reviews.isEmpty) {
//       return const Padding(
//         padding: EdgeInsets.all(12.0),
//         child: Text("No reviews yet."),
//       );
//     }
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: reviews.length,
//       itemBuilder: (context, index) {
//         return ReviewCard(review: reviews[index]);
//       },
//     );
//   }
// }

// class ReviewCard extends StatelessWidget {
//   final Review review;

//   const ReviewCard({super.key, required this.review});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.white,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const CircleAvatar(
//                       backgroundImage:
//                           AssetImage('assets/img/Group 1000003542.png'),
//                       radius: 20,
//                     ),
//                     const SizedBox(width: 10),
//                     Text(review.userName,
//                         style: const TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Text(review.reviewDate,
//                     style: const TextStyle(color: Colors.grey)),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: List.generate(5, (index) {
//                 return Icon(
//                   index < review.rating ? Icons.star : Icons.star_border,
//                   color: Colors.amber,
//                   size: 18,
//                 );
//               }),
//             ),
//             const SizedBox(height: 8),
//             Text(review.reviewText,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87)),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/Core/Helper/naviagation_helper.dart';
import 'package:grad_project/Core/Localizations/app_localizatios.dart';
import 'package:grad_project/Feature/Booking/book_customer/booking_view_1.dart';
import 'package:grad_project/Feature/Login/Widget/app_button.dart';
import 'package:grad_project/Feature/provider_profile/Model/service_provider_model.dart';
import 'package:grad_project/Feature/provider_profile/cubit/provider_pprfile_cubit.dart';
import 'package:grad_project/Feature/provider_profile/cubit/provider_state.dart';
import 'package:grad_project/Feature/resources/colors/colors.dart';
import 'package:grad_project/Feature/resources/styles/app_sized_box.dart';
import 'package:grad_project/Feature/resources/styles/app_text_style.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderProfileView extends StatefulWidget {
  const ProviderProfileView({super.key});

  @override
  State<ProviderProfileView> createState() => _ProviderProfileViewState();
}

class _ProviderProfileViewState extends State<ProviderProfileView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final serviceProviderCubit = BlocProvider.of<ServiceProviderCubit>(context);
    serviceProviderCubit.getServiceProvider(2);
  }

  // Function to show the review dialog, accepting providerId
  void _showReviewDialog(BuildContext context, String providerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Pass the providerId to the ReviewDialog
        return ReviewDialog(providerId: providerId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<ServiceProviderCubit, ServiceProviderState>(
        builder: (context, state) {
          if (state is ServiceProviderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ServiceProviderLoaded) {
            final provider = state.serviceProvider;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  provider.profilePicture != null
                      ? Image.network(
                          provider.profilePicture!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Image.asset("assets/img/Group 1000003542.png"),
                  AppSizedBox.sizedH20,
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(provider.name,
                                style: AppTextStyle.textStyleBoldBlack),
                            Text(provider.category,
                                style: AppTextStyle.textStyleMediumBlack),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(Icons.phone_outlined),
                          onPressed: () async {
                            final phoneNumber = provider.phone;
                            final uri = Uri(scheme: 'tel', path: phoneNumber);

                            if (await canLaunchUrl(uri)) {
                              await launchUrl(uri,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              print('Could not launch $uri');
                            }
                          },
                        ),
                        AppSizedBox.sizedW10,
                        IconButton(
                          icon: const Icon(Icons.chat_outlined),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/img/rate.png"),
                                // Text("12"),
                                Text("${provider.rating}"),
                                Text(AppLocalizations.of(context)
                                    .translate("rating"))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/img/order.png"),
                                const Text("12"),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("completed"),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/img/exp.png"),
                                Text("${provider.experience}"),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("experience"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                        AppLocalizations.of(context).translate("availability"),
                        style: AppTextStyle.textStylesemiBoldBlue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.grey),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          // child: Text("12"),

                          child: Text("${provider.startTime}"),
                        ),
                        AppSizedBox.sizedW15,
                        Text(AppLocalizations.of(context).translate("to"),
                            style: AppTextStyle.textStyleRegularBlack),
                        AppSizedBox.sizedW20,
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.grey),
                          ),
                          padding: const EdgeInsets.all(12.0),
                          // child: Text("12"),
                          child: Text("${provider.endTime}"),
                        ),
                      ],
                    ),
                  ),
                  AppSizedBox.sizedH20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: AppButton(
                      function: () {
                        navigateTo(
                          context,
                          BookingAddressForm_1(
                              userId: '12', // Replace with actual userId
                              providerId: provider.bio // Use provider.id
                              ),
                        );
                      },
                      text: AppLocalizations.of(context).translate("book_now"),
                      textColor: AppColors.white,
                    ),
                  ),
                  AppSizedBox.sizedH20,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(AppLocalizations.of(context).translate("about"),
                        style: AppTextStyle.textStylesemiBoldBlue),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(provider.bio),
                  ),
                  // "rating": "التقييم",
                  // "completed": "مكتمل",
                  // "experience": "الخبرة",
                  // "availability": "التوفر",
                  // "to": "إلى",
                  // "book_now": "احجز الآن",
                  // "about": "حول",
                  // "reviews": "المراجعات",
                  // "rate_this_provider": "قيّم هذا المزود وشارك تجربتك",
                  // "write_a_review": "اكتب مراجعة",
                  // "no_reviews_yet": "لا توجد مراجعات بعد.",
                  // "unexpected_error": "حدث خطأ غير متوقع"
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                        AppLocalizations.of(context).translate("reviews"),
                        style: AppTextStyle.textStylesemiBoldBlue),
                  ),
                  ReviewList(reviews: provider.reviews),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      // Wrap with GestureDetector to make it tappable
                      onTap: () => _showReviewDialog(context, "12"),
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)
                                    .translate("rate_this_provider"),
                                style: AppTextStyle.textStyleRegularBlack),
                            Row(
                              children: [
                                ...List.generate(
                                  5,
                                  (index) => const Icon(
                                      Icons.star_border_outlined,
                                      color: Colors.blue,
                                      size: 18),
                                ),
                                const Spacer(),
                                Text(
                                    AppLocalizations.of(context)
                                        .translate("write_a_review"),
                                    style: AppTextStyle.textStyleRegularBlue),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AppSizedBox.sizedH40,
                ],
              ),
            );
          } else if (state is ServiceProviderError) {
            return Center(child: Text(state.message));
          } else {
            return Center(
                child: Text(AppLocalizations.of(context)
                    .translate("unexpected_error")));
          }
        },
      ),
    );
  }
}

class ReviewList extends StatelessWidget {
  final List<Review> reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(AppLocalizations.of(context).translate("no_reviews_yet")),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return ReviewCard(review: reviews[index]);
      },
    );
  }
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/img/Group 1000003542.png'),
                      radius: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(review.userName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(review.reviewDate,
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(review.reviewText,
                style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}

// THIS IS THE NEW WIDGET FOR THE REVIEW POPUP
class ReviewDialog extends StatefulWidget {
  final String providerId; // To receive the provider ID

  const ReviewDialog({super.key, required this.providerId});

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  int _currentRating = 0; // To store the selected star rating
  final TextEditingController _commentController =
      TextEditingController(); // Controller for the comment text field

  @override
  void dispose() {
    _commentController
        .dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Rounded corners for the dialog
      ),
      title: const Center(
        child: Text(
          'Rate Our Product', // You might want to localize this
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.blueAccent,
          ),
        ),
      ),
      content: SingleChildScrollView(
        // Use SingleChildScrollView to prevent overflow if content is too long
        child: Column(
          mainAxisSize: MainAxisSize.min, // Make column take minimum space
          children: <Widget>[
            const Text(
              'How would you rate your experience?', // You might want to localize this
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 15),
            // Star rating row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _currentRating
                        ? Icons.star
                        : Icons
                            .star_border, // Fill star if index is less than current rating
                    color: Colors.amber, // Star color
                    size: 35,
                  ),
                  onPressed: () {
                    setState(() {
                      _currentRating =
                          index + 1; // Update rating when a star is pressed
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20),
            // Comment text field
            TextField(
              controller: _commentController,
              maxLines: 4, // Allow multiple lines for comments
              decoration: InputDecoration(
                hintText:
                    'Share your detailed feedback...', // You might want to localize this
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.blueAccent, width: 2),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 25),
            // Submit and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    child: const Text(
                      'Cancel', // You might want to localize this
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Process the review data here
                      // You would typically send _currentRating, _commentController.text, and widget.providerId to a backend
                      print('Provider ID: ${widget.providerId}');
                      print('Rating: $_currentRating stars');
                      print('Comment: ${_commentController.text}');
                      Navigator.of(context).pop(); // Close the dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Thank you for your $_currentRating star review for provider ${widget.providerId}!'), // Localize this
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Submit Review', // You might want to localize this
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
