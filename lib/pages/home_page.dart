import 'package:flutter/material.dart';
import 'package:perplexity_clone/theme/colors.dart';
import 'package:perplexity_clone/widgets/search_section.dart';
import 'package:perplexity_clone/widgets/side_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //side navbar
          SideBar(),
          Expanded(
            child: Column(
              children: [
                //searchbar section
                Expanded(child: SearchSection()),
                //footer
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Wrap(
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
                        child: Text(
                          "Pro",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.footerGrey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
