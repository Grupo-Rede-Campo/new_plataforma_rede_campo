import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/stores/home_store.dart';

import '../../../theme/app_colors.dart';

class NewsLetterField extends StatelessWidget {
  const NewsLetterField({Key? key, required this.homeStore}) : super(key: key);

  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 76, bottom: 15),
          child: Text(
            'Assine nossa newsletter',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        SizedBox(
          width: 510,
          child: Observer(
            builder: (context) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: homeStore.setEmail,
                    keyboardType: TextInputType.emailAddress,
                    enabled: !homeStore.loading,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      errorText: homeStore.emailError,
                      isDense: true,
                      filled: true,
                      fillColor: AppColors.brightGray,
                      hintText: 'Digite seu email :)',
                      hintStyle: const TextStyle(
                        fontSize: 15,
                        color: AppColors.primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: homeStore.invalidSendPressed,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondaryColor,
                      disabledBackgroundColor: AppColors.secondaryColor.withAlpha(120),
                      fixedSize: const Size(86, 40),
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onPressed: homeStore.subscribeNewsletterPressed,
                    child: homeStore.loading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text('Inscreva-se'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
