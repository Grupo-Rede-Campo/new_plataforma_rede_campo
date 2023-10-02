import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:plataforma_rede_campo/stores/home_store.dart';
import 'package:plataforma_rede_campo/views/home/components/project_container.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_row_column.dart';

import '../../../components/custom_rounded_left_button.dart';
import '../../../components/custom_rounded_right_button.dart';
import '../../../theme/app_colors.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key, required this.homeStore}) : super(key: key);

  final HomeStore homeStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => ResponsiveRowColumn(
        layout: ResponsiveRowColumnType.ROW,
        rowMainAxisAlignment: MainAxisAlignment.center,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        rowPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        rowSpacing: 20,
        children: [
          if (!homeStore.loadingProjects)
            ResponsiveRowColumnItem(
              rowFlex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoundedLeftButton(
                    onTap: homeStore.setPreviousIndex,
                  ),
                ],
              ),
            ),
          !homeStore.loadingProjects
              ? ResponsiveRowColumnItem(
                  rowFlex: 4,
                  //rowFit: FlexFit.tight,
                  child: Observer(
                    builder: (context) => ProjectContainer(
                      project: homeStore.projectList[homeStore.index],
                    ),
                  ),
                )
              : ResponsiveRowColumnItem(
                  rowFlex: 4,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 600,
                      maxHeight: 450,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
          if (!homeStore.loadingProjects)
            ResponsiveRowColumnItem(
              rowFlex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoundedRightButton(
                    onTap: homeStore.setNextIndex,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
