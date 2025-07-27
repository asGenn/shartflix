import 'package:flutter/material.dart';
import 'package:shartflix/config/theme/theme.dart';
import 'package:shartflix/features/auth/presentation/widgets/button/custom_button.dart';

class PremiumOfferModal extends StatelessWidget {
  const PremiumOfferModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PremiumOfferModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height * 0.8,
      width: mediaQuery.size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.bottomCenter,
          radius: 1.5,
          colors: [
            AppTheme.darkRed,
            AppTheme.darkSurfaceColor,
            AppTheme.darkRed,
          ],
        ),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          SizedBox(height: mediaQuery.size.height * 0.02),
          Text('Sınırlı Teklif', style: Theme.of(context).textTheme.titleLarge),
          Text(
            'Jeton paketin\'ni seçerek bonus\n kazanın ve yeni bölümlerin kilidini açın!',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppTheme.textColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),
          Container(
            width: mediaQuery.size.width * 0.9,
            height: mediaQuery.size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.greyColor.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: mediaQuery.size.height * 0.01),
                Text(
                  "Alacağınız Bonuslar",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: mediaQuery.size.height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        _BuildCirclerItem(image: "assets/images/elmas.png"),
                        SizedBox(height: mediaQuery.size.height * 0.01),
                        Text(
                          "Premium\nHesap",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppTheme.textColor,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),

                    Column(
                      children: [
                        _BuildCirclerItem(image: "assets/images/kalp.png"),
                        SizedBox(height: mediaQuery.size.height * 0.01),
                        Text(
                          "Premium\nHesap",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppTheme.textColor,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _BuildCirclerItem(image: "assets/images/ok.png"),
                        SizedBox(height: mediaQuery.size.height * 0.01),
                        Text(
                          "Premium\nHesap",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppTheme.textColor,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        _BuildCirclerItem(image: "assets/images/tek_kalp.png"),
                        SizedBox(height: mediaQuery.size.height * 0.01),
                        Text(
                          "Premium\nHesap",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: AppTheme.textColor,
                                fontSize: 12,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),
          Text(
            "Kilidi açmak için bir jeton paketi seçin",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _JetonPackageWidget(
                positionTop: -15,
                positionLeft: 25,
                price: "99,99",
                jeton: "330",
                discount: "200",
                badge: "+10%",
                badgeColor: AppTheme.darkRed,
                containerColor: [AppTheme.darkRed, AppTheme.lightRed],
              ),
              _JetonPackageWidget(
                positionTop: -15,
                positionLeft: 25,
                price: "799,99",
                jeton: "3.375",
                discount: "2000",
                badge: "+70%",
                badgeColor: AppTheme.lightBlue,
                containerColor: [AppTheme.lightBlue, AppTheme.lightRed],
              ),
              _JetonPackageWidget(
                positionTop: -15,
                positionLeft: 25,
                price: "399,99",
                jeton: "1350",
                discount: "1000",
                badge: "+10%",
                badgeColor: AppTheme.darkRed,
                containerColor: [AppTheme.darkRed, AppTheme.lightRed],
              ),
            ],
          ),
          SizedBox(height: mediaQuery.size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CustomButton(text: "Tüm Jetonları Gör", onPressed: () {}),
          ),
        ],
      ),
    );
    // Header Section
  }
}

class _BuildCirclerItem extends StatelessWidget {
  final String image;
  const _BuildCirclerItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.greyColor.withValues(alpha: 0.5),
          width: 1,
        ),
        color: AppTheme.darkRed,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.inner,
            color: Colors.white,
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Image.asset(image),
    );
  }
}

class _JetonPackageWidget extends StatelessWidget {
  const _JetonPackageWidget({
    super.key,
    required this.positionTop,
    required this.positionLeft,
    required this.price,
    required this.jeton,
    required this.discount,
    required this.badge,
    required this.badgeColor,
    required this.containerColor,
  });
  final double positionTop;
  final double positionLeft;
  final String price;
  final String jeton;
  final String discount;
  final String badge;
  final Color badgeColor;
  final List<Color> containerColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // +10% badge - container'ın üstünde

        // Ana container
        Container(
          width: mediaQuery.size.width * 0.3,
          height: mediaQuery.size.height * 0.3,
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.greyColor, width: 1),
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 2,

              colors: containerColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20), // Badge için boşluk
              // 200 üstü çizili
              const SizedBox(height: 8),
              // 200 üstü çizili
              Text(
                discount,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppTheme.textColor,
                  decoration: TextDecoration.lineThrough,
                  fontSize: 16,
                ),
              ),
              // 330 büyük
              Text(
                jeton,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              // Jeton
              Text(
                "Jeton",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              // Ayırıcı çizgi
              Container(
                width: mediaQuery.size.width * 0.25,
                height: 1,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 8),
              // Fiyat
              Text(
                price,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              // Başına haftalık
              Text(
                "Başına haftalık",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: positionTop,
          left: positionLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppTheme.greyColor, width: 1),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.greyColor,
                  blurRadius: 8,
                  blurStyle: BlurStyle.inner,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Text(
              badge,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppTheme.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
