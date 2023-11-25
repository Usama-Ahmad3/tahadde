import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/passwordSecurityFields.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../localizations.dart';
import 'emailContactsFields.dart';

class ProfileShimmer {
  static buildShimmer(sizeWidth, sizeHeight, context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.grey,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: sizeHeight * 0.144,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/bg-image.png'),
                            fit: BoxFit.fitWidth)),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.08,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: sizeHeight * 0.025),
                        ),
                        CircleAvatar(
                          radius: sizeHeight * 0.018,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.edit,
                            size: sizeHeight * 0.02,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.04,
                  ),
                  EmailContactDOB(
                    constant: 'Email :',
                    constantValue: 'Email',
                  ),
                  EmailContactDOB(
                      constant: 'DOB :',
                      constantValue: AppLocalizations.of(context)!.dateofBirth),
                  EmailContactDOB(
                    constant: 'Contact :',
                    constantValue: '0000-0000-0000',
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.key,
                    title: 'Change Password',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.support_agent,
                    title: 'Support',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.security,
                    title: 'Security',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                ],
              ),
              Positioned(
                  top: sizeHeight * 0.079,
                  left: 0,
                  right: sizeWidth * 0.67,
                  child: CircleAvatar(
                    radius: sizeHeight * 0.06,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
