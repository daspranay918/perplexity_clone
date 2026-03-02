import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:perplexity_clone/widgets/side_bar_button.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: isCollapsed ? 64 : 128,
      color: AppColors.sideNav,
      duration: const Duration(milliseconds: 100),
      child: Column(
        crossAxisAlignment: isCollapsed
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Icon(
            Icons.auto_awesome_mosaic,
            color: AppColors.whiteColor,
            size: 30,
          ),
          const SizedBox(height: 24),
          SideBarButton(isCollapsed: isCollapsed, icon: Icons.add, text: "Home"),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Icon(Icons.search, color: AppColors.iconGrey, size: 22),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Icon(Icons.language, color: AppColors.iconGrey, size: 22),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Icon(
              Icons.auto_awesome,
              color: AppColors.iconGrey,
              size: 22,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Icon(
              Icons.cloud_outlined,
              color: AppColors.iconGrey,
              size: 22,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                isCollapsed = !isCollapsed;
              });
            },
            child: AnimatedContainer(
              margin: EdgeInsets.symmetric(vertical: 16),
              duration: const Duration(milliseconds: 100),
              child: Icon(
                isCollapsed
                    ? Icons.keyboard_arrow_right
                    : Icons.keyboard_arrow_left,
                color: AppColors.iconGrey,
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
