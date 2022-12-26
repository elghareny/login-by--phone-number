import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic/cubit/phone_auth/phone_cubit.dart';
import 'package:flutter_maps/constnats/colors.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});


  PhoneCubit phoneCubit = PhoneCubit();


   Widget buildDrawerHeader(context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsetsDirectional.fromSTEB(5.w, 5.h, 5.w, 5.h),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.blue[100],
          ),
          child: Image.asset(
            'assets/mohamed.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Text(
          'Mohamed Said',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
         SizedBox(
          height: 5.h,
        ),
        BlocProvider<PhoneCubit>(
            create: (context) => phoneCubit,
            child: Text(
              '${phoneCubit.getLoggedInUser().phoneNumber}',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            )),
      ],
    );
  }


  Widget buildDrawerListItem(
      {required IconData leadingIcon,
      required String title,
      Widget? trailing,
      Function()? onTap,
      Color? color}) {
    return ListTile(
      leading: Icon(
        leadingIcon,
        color: color ?? MyColors.blue,
      ),
      title: Text(title),
      trailing: trailing ??= Icon(
        Icons.arrow_right,
        color: MyColors.blue,
      ),
      onTap: onTap,
    );
  }

  Widget buildDrawerListItemsDivider() {
    return Divider(
      height: 0,
      thickness: 1.h,
      indent: 18.w,
      endIndent: 24.w,
    );
  }


   Widget buildLogoutBlocProvider(context) {
    return Container(
      child: BlocProvider<PhoneCubit>(
        create: (context) => phoneCubit,
        child: buildDrawerListItem(
          leadingIcon: Icons.logout,
          title: 'Logout',
          onTap: () async {
            await phoneCubit.signOut();
            Navigator.of(context).pushReplacementNamed(loginScreen);
          },
          color: Colors.red,
          trailing: SizedBox(),
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 270.h,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[100]),
              child: buildDrawerHeader(context),
            ),
          ),
          buildDrawerListItem(leadingIcon: Icons.person, title: 'My Profile'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(
            leadingIcon: Icons.history,
            title: 'Places History',
            onTap: () {},
          ),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.settings, title: 'Settings'),
          buildDrawerListItemsDivider(),
          buildDrawerListItem(leadingIcon: Icons.help, title: 'Help'),
          buildDrawerListItemsDivider(),
          buildLogoutBlocProvider(context),
        ],
      ),
    );
  }
}