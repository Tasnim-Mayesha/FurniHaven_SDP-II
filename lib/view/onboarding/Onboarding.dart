import 'package:flutter/material.dart';
import '../widgets/paginationIndicator.dart';
import 'package:sdp2/view/onboarding/Onboarding2.dart';
class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

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
          Text('NEXT', style: TextStyle(color: Colors.deepOrange,fontSize: 16),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboarding2()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_right_alt, size: 30.0, color: Colors.white),
            ),
            backgroundColor: Colors.deepOrange,
            elevation: 4,
          ),
        ],
      ),


      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PaginationIndicator(
              totalPages: 3,
              currentPage: 0,
              ),
              Container(
                padding: const EdgeInsets.all(25.0),
                child: Image.asset('assets/images/image 78.jpg',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Choose your furniture',
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
                  'Welcome to a World of Limitless Choices \n Your Perfect Furniture Awaits!',
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
