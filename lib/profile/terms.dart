

import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';

import '../common/textconstants.dart';
import '../view/widgets/termclass.dart';


class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:white,
      appBar: AppBar(
        backgroundColor: white,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back )),
        title: Text('Terms and Conditions', style: NeededTextstyles.style36),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          TermsAndConditions.terms,
          style: NeededTextstyles.style121,
        ),

      ),
    );
  }
}