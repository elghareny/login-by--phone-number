
import 'package:flutter/material.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class BuildSearch extends StatelessWidget {
  const BuildSearch({super.key});

  static FloatingSearchBarController searchBarController = FloatingSearchBarController();

  @override
  Widget build(BuildContext context) {

    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: searchBarController,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 16.sp),
      queryStyle: TextStyle(fontSize: 16.sp),
      hint: 'Find a place',
      border: BorderSide(
        style: BorderStyle.none
      ),
      margins: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      height: 45.h,
      iconColor: MyColors.blue,
      scrollPadding: EdgeInsets.only(top: 15.h, bottom: 50.h),
      transitionDuration: Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600.w : 500.w,
      debounceDelay: Duration(milliseconds: 500),
      onQueryChanged: (query)
      {

      },
      onFocusChanged: (_)
      {

      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(Icons.place,color: Colors.black.withOpacity(0.6),),
            onPressed: ()
            {

            },
          ),
        )
      ],
      builder:(context, transition) 
      {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

            ],
          ),
        );
      },
      );
  }
}