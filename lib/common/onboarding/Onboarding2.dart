import 'package:flutter/material.dart';
import 'package:sdp2/common/onboarding/Onboarding3.dart';
import '../widgets/PaginationIndicator/paginationIndicator.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(padding: EdgeInsets.only(top:30.0,right: 14.0),
                child:Text('Skip',
                  style: TextStyle(color:Colors.deepOrange),) ,)
            ],
          )
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(right:130.0),
            child: PaginationIndicator(
              totalPages: 3,
              currentPage: 1,
            ),
          ),
          Text(
            'NEXT',
            style: TextStyle(color: Colors.deepOrange,fontSize: 16),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding3()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_right_alt, size: 30.0,color: Colors.white),
            ),
            backgroundColor: Colors.deepOrange,
            elevation: 10,
          ),
        ],
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset('assets/images/image 76.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Select Payment Method',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'For Seamless Transactions, Choose Your Payment Path \n Your Convenience,Our Priority!',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
