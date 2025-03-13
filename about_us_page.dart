import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "About ASWDC",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Image.asset(
                            //   'assets/darshan_logo.png', // Replace with your image
                            //   height: 50,
                            // ),
                            Text(
                              "Darshan UNIVERSITY",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Sole purpose of ASWDC is to bridge gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real world application & experiences professional environment @ASWDC under guidance of industry experts & faculty members.",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Contact Us",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [Icon(Icons.mail,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "aswdc@darshan.ac.in",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.call,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "+91-9727747317",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.language_rounded,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "www.darshan.ac.in",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                        ],
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 5),
              Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [Icon(Icons.share,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "Share App",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.apps_rounded,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "More Apps",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.star_rate_sharp,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "Rate Us",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.thumb_up_alt_sharp,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "Like us on Facebook",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [Icon(Icons.autorenew_rounded,color: Colors.purpleAccent,),
                              SizedBox(width: 10),
                              Text(
                                "Check for Update",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),],
                          ),

                        ],
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF3F3F3),

    );
  }
}
