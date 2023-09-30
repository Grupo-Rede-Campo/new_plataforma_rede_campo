import 'package:flutter/material.dart';
import 'package:plataforma_rede_campo/models/project.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../theme/app_colors.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    return ResponsiveConstraints(
      constraint: const BoxConstraints(
        maxWidth: 600,
        maxHeight: 450,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.9,
            child: Container(
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/projectimg.png'),
                  fit: BoxFit.contain,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
              bottom: 4,
            ),
            child: Text(
              '${project.title!}\n\n',
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Text(
            '${project.content!}\n\n',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.darkPuceColor,
            ),
          ),
        ],
      ),
    );
  }
}
