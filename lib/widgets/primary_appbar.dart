import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:media_design_assingment_app/utils/constants/app_assets.dart';

class PrimaryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hideDrawer;
  const PrimaryAppBar({super.key, this.hideDrawer = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading:
          hideDrawer
              ? null
              : IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(AppAssets.drawerIcon),
              ),
      centerTitle: true,
      title: Image.asset(AppAssets.logo, width: 123),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
