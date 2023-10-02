import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plataforma_rede_campo/components/close_button.dart';
import 'package:plataforma_rede_campo/models/people_to_display.dart';
import 'package:plataforma_rede_campo/utils/utils.dart';

class AlertDialogUser extends StatelessWidget {
  const AlertDialogUser({Key? key, required this.peopleToDisplay}) : super(key: key);

  final PeopleToDisplay peopleToDisplay;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(33)),
      backgroundColor: const Color.fromRGBO(93, 105, 114, 1),
      contentPadding: const EdgeInsets.all(30),
      content: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              peopleToDisplay.image.url != null
                  ? Padding(
                      padding: EdgeInsets.only(top: screenSize.height * 0.020, bottom: screenSize.height * 0.017),
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(
                            screenSize.height * 0.10,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: peopleToDisplay.image.url,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SvgPicture.asset('assets/images/sem_imagem.svg'),
              Text(
                peopleToDisplay.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF Pro Display',
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.035,
              ),
              SizedBox(
                height: screenSize.height * 0.17,
                width: screenSize.width * 0.25,
                child: SingleChildScrollView(
                  child: Text(
                    peopleToDisplay.description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro Display',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: screenSize.height * 0.070,
                  bottom: screenSize.height * 0.03,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Utils.launchUrlMethod(url: peopleToDisplay.lattes!.trim());
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/lattes.png',
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.1,
                          ),
                          const Text(
                            "Lattes",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: screenSize.width * 0.04,
                    ),
                    InkWell(
                      onTap: () {
                        Utils.launchUrlMethod(url: peopleToDisplay.linkedin!.trim());
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/linkedin.svg',
                            height: screenSize.height * 0.1,
                            width: screenSize.width * 0.1,
                          ),
                          const Text(
                            "Linkedin",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SF Pro Display',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          CloseButtonProj(
            message: 'Fechar',
            width: screenSize.height * 0.050,
            height: screenSize.height * 0.050,
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
