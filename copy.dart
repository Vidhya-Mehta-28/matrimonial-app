import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:other_design/pr2/about_us_page.dart';
import 'package:other_design/pr2/tp.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrimonial App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Lobster',
      ),
      home: SplashScreen(), // Start with SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.repeat(reverse: true);

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Color myPeachPuffColor = const Color(0xFFFFDAB9);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cute_couple.jpeg'), // Add a romantic couple image
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3), // Dark overlay for contrast
              BlendMode.dstATop,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink.shade200.withOpacity(0.7),
              Colors.pinkAccent.withOpacity(0.7),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _pulseAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pinkAccent.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/images/heart.jpeg', // Replace with a heart or ring logo
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 30),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Matrimony App',
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'GreatVibes', // Modern cursive font
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 15,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'Finding Love, One Heart at a Time 💞',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 4,
                backgroundColor: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/couple_illustration.jpeg'), // Wedding scene background
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.dstATop,
            ),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink.withOpacity(0.6),
              Colors.pink.shade300.withOpacity(0.6),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/nice.jpeg', // Animated couple illustration
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Find Your Soulmate',
                      style: TextStyle(
                        fontSize: 50,
                        fontFamily: 'GreatVibes',
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 15,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        'Join millions in finding true love today! 💍',
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DashboardScreen()),
                      );
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.pinkAccent.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite, color: Colors.white, size: 28),
                          SizedBox(width: 12),
                          Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Map<String, String>> users = [];
  List<Map<String, String>> favoriteUsers = [];

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  Map<String, String> _toggleFavorite(Map<String, String> user) {
    setState(() {
      if (favoriteUsers.any((favUser) => favUser['email'] == user['email'])) {
        favoriteUsers.removeWhere((favUser) => favUser['email'] == user['email']);
      } else {
        favoriteUsers.add({...user, 'isFavorite': 'true'});
      }
    });
    return {...user, 'isFavorite': user['isFavorite'] == 'true' ? 'false' : 'true'};
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _pages.addAll([
      AddUserScreen(onUserAdded: (user) {
        setState(() {
          users.add(user);
          _animationController.forward(from: 0.0);
        });
      }),
      UserListScreen(users: users, onToggleFavorite: _toggleFavorite),
      FavoriteUserScreen(favoriteUsers: favoriteUsers),
      AboutUsPage(),
    ]);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _animationController.forward(from: 0.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.2),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade300.withOpacity(0.3),
                Colors.teal.shade300.withOpacity(0.3),
              ],
            ),
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
          ),
        ),
        title: Text(
          'Matrimonial Dashboard',
          style: TextStyle(
            fontSize: 26,
            fontFamily: 'GreatVibes',
            color: Colors.pinkAccent,
            shadows: [
              Shadow(color: Colors.black45, blurRadius: 5, offset: Offset(2, 2)),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white.withOpacity(0.3),
              child: Icon(Icons.person, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.tealAccent.withOpacity(0.8),
              Colors.pink.shade100.withOpacity(0.8),
            ],
          ),
        ),
        child: Column(
          children: [
            // Hero Section
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/romantic_banner.jpeg'), // Romantic banner
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.dstATop,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  "Love Journey begins",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'GreatVibes',
                    color: Colors.pinkAccent,
                    shadows: [
                      Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(2, 2)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _pages[_selectedIndex],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_add),
                  label: 'Add User',
                  tooltip: 'Add a new user',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'User List',
                  tooltip: 'View all users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                  tooltip: 'Favorite users',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.info),
                  label: 'About Us',
                  tooltip: 'About the app',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.pinkAccent,
              unselectedItemColor: Colors.grey.shade600,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontFamily: 'Poppins'),
              onTap: _onItemTapped,
              showUnselectedLabels: true,
            ),
          ),
        ),
      ),
    );
  }
}

class AddUserScreen extends StatefulWidget {
  final Function(Map<String, String>) onUserAdded;
  AddUserScreen({required this.onUserAdded});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = 'Male';
  String _age = '';
  String? _selectedCity;
  bool isFav = false;

  final List<String> _cities = [
    'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',
    'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'
  ];

  Map<String, bool> _hobbies = {
    'Reading': false,
    'Sports': false,
    'Music': false,
    'Traveling': false,
    'Cooking': false,
    'Gaming': false,
  };

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      String selectedHobbies = _hobbies.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .join(', ');
      widget.onUserAdded({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _gender,
        'dob': _dobController.text,
        'age': _age,
        'city': _selectedCity ?? '',
        'hobbies': selectedHobbies,
        'isFavorite': isFav.toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User saved successfully!'),
          backgroundColor: Colors.pinkAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _age = '';
        _gender = 'Male';
        _selectedCity = null;
        _hobbies.updateAll((key, value) => false);
        isFav = false;
      });
    }
  }

  void _calculateAge(DateTime dob) {
    final today = DateTime.now();
    int age = today.year - dob.year;
    if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
      age--;
    }
    setState(() => _age = age.toString());
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your email';
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Please enter your phone number';
    final phoneRegex = RegExp(r'^\+?[0-9]{10}$');
    if (!phoneRegex.hasMatch(value)) return 'Enter a valid phone number';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Please enter a password';
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must be at least 8 characters, include letters and numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade50, Colors.teal.shade100],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Create Profile',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink.shade800,
                        fontFamily: 'Lobster',
                        shadows: [Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Let’s find your perfect match! 💞',
                      style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 30),

                    _buildTextField(
                      controller: _nameController,
                      label: 'Name',
                      icon: Icons.person,
                      keyboardType: TextInputType.name,
                      formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _emailController,
                      label: 'Email',
                      icon: Icons.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _phoneController,
                      label: 'Phone',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      formatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: _validatePhone,
                    ),
                    SizedBox(height: 16),
                    _buildDateField(),
                    SizedBox(height: 16),
                    _buildDropdownField('Gender', _gender, ['Male', 'Female', 'Other'], Icons.person_outline,
                            (value) => setState(() => _gender = value!)),
                    SizedBox(height: 16),
                    _buildDropdownField(
                      'City',
                      _selectedCity,
                      _cities,
                      Icons.location_city,
                          (value) => setState(() => _selectedCity = value),
                      validator: (value) => value == null ? 'Please select a city' : null,
                    ),
                    SizedBox(height: 16),
                    _buildHobbiesSection(),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      icon: Icons.lock,
                      keyboardType: TextInputType.text,
                      validator: _validatePassword,
                      isPassword: true,
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      icon: Icons.lock_outline,
                      keyboardType: TextInputType.text,
                      validator: (value) => value != _passwordController.text ? 'Passwords do not match' : null,
                      isPassword: true,
                    ),
                    SizedBox(height: 16),
                    _buildFavoriteCheckbox(),
                    SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: _saveUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 8,
                          shadowColor: Colors.pink.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.save, size: 20),
                            SizedBox(width: 8),
                            Text('Save Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
    List<TextInputFormatter>? formatters,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        obscureText: isPassword,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pinkAccent),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          labelStyle: TextStyle(color: Colors.grey.shade600),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: TextFormField(
        controller: _dobController,
        readOnly: true,
        onTap: () async {
          DateTime now = DateTime.now();
          DateTime maxDate = DateTime(now.year - 18, now.month, now.day);
          DateTime minDate = DateTime(now.year - 80, now.month, now.day);
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: maxDate,
            firstDate: minDate,
            lastDate: maxDate,
            builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: Colors.pinkAccent),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ),
          );
          if (pickedDate != null) {
            _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            _calculateAge(pickedDate);
          }
        },
        decoration: InputDecoration(
          labelText: 'Date of Birth (Age: $_age)',
          prefixIcon: Icon(Icons.calendar_today, color: Colors.pinkAccent),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label,
      String? value,
      List<String> items,
      IconData icon,
      Function(String?) onChanged, {
        String? Function(String?)? validator,
      }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pinkAccent),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        ),
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down, color: Colors.pinkAccent),
      ),
    );
  }

  Widget _buildHobbiesSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.pinkAccent),
              SizedBox(width: 8),
              Text(
                'Hobbies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink.shade800),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: _hobbies.keys.map((hobby) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _hobbies[hobby],
                    onChanged: (value) => setState(() => _hobbies[hobby] = value!),
                    activeColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  Text(hobby, style: TextStyle(fontSize: 16, color: Colors.grey.shade800)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCheckbox() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Checkbox(
            value: isFav,
            onChanged: (value) => setState(() => isFav = value!),
            activeColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          Text('Mark as Favorite', style: TextStyle(fontSize: 16, color: Colors.grey.shade800)),
          SizedBox(width: 8),
          Icon(Icons.favorite, color: Colors.redAccent, size: 20),
        ],
      ),
    );
  }
}

class UserListScreen extends StatefulWidget {
  final List<Map<String, String>> users;
  final Function(Map<String, String>) onToggleFavorite;

  UserListScreen({required this.users, required this.onToggleFavorite});

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> with SingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _deleteUser(int index) {
    setState(() {
      widget.users.removeAt(index);
    });
  }

  void _editUser(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(
          user: widget.users[index],
          onSave: (updatedUser) {
            setState(() {
              widget.users[index] = updatedUser;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredUsers = widget.users.where((user) {
      final name = user['name']?.toLowerCase() ?? '';
      final email = user['email']?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase()) || email.contains(searchQuery.toLowerCase());
    }).toList();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pink.shade50, Colors.teal.shade50],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search by Name or Email',
                  prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    _animationController.forward(from: 0.0);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: filteredUsers.isEmpty
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 80, color: Colors.grey.shade400),
                    SizedBox(height: 16),
                    Text(
                      'No users found',
                      style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              )
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  int originalIndex = widget.users.indexOf(filteredUsers[index]);
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                        child: Icon(Icons.person, color: Colors.pinkAccent, size: 30),
                      ),
                      title: Text(
                        filteredUsers[index]['name'] ?? '',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                      ),
                      subtitle: Text(
                        filteredUsers[index]['email'] ?? 'No Email',
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              filteredUsers[index]['isFavorite'] == 'true'
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.redAccent,
                            ),
                            onPressed: () => widget.onToggleFavorite(widget.users[originalIndex]),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.tealAccent),
                            onPressed: () => _editUser(originalIndex),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _showDeleteDialog(originalIndex),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(user: filteredUsers[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        title: Text('Delete User', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          TextButton(
            onPressed: () {
              _deleteUser(index);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

class EditUserScreen extends StatefulWidget {
  final Map<String, String> user;
  final Function(Map<String, String>) onSave;

  EditUserScreen({required this.user, required this.onSave});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> with SingleTickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  String? selectedGender;
  String? selectedCity;

  final List<String> _cities = [
    'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',
    'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'
  ];

  late Map<String, bool> _hobbies;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    phoneController = TextEditingController(text: widget.user['phone']);
    dobController = TextEditingController(text: widget.user['dob']);
    selectedGender = widget.user['gender'];
    selectedCity = widget.user['city'];

    _hobbies = {
      'Reading': false,
      'Sports': false,
      'Music': false,
      'Traveling': false,
      'Cooking': false,
      'Gaming': false,
    };
    if (widget.user['hobbies'] != null) {
      List<String> savedHobbies = widget.user['hobbies']!.split(', ');
      for (var hobby in savedHobbies) {
        if (_hobbies.containsKey(hobby)) {
          _hobbies[hobby] = true;
        }
      }
    }

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.pink.shade300.withOpacity(0.5),
                Colors.teal.shade300.withOpacity(0.5),
              ],
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: HeartBorderPainter(),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontFamily: 'GreatVibes',
                  color: Colors.white,
                  shadows: [
                    Shadow(color: Colors.black87, blurRadius: 15, offset: Offset(3, 3)),
                  ],
                ),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        color: Colors.pink.shade100, // Solid blush pink background for better contrast
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Update Your Story 💞',
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'GreatVibes',
                          color: Colors.pink.shade900, // Darker pink for visibility
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3)),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildInputCard(
                      child: _buildTextField(
                        controller: nameController,
                        label: 'Name',
                        icon: Icons.person,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildTextField(
                        controller: emailController,
                        label: 'Email',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildTextField(
                        controller: phoneController,
                        label: 'Phone',
                        icon: Icons.phone,
                        keyboardType: TextInputType.phone,
                        formatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildDateField(),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildDropdownField(
                        'Gender',
                        selectedGender,
                        ['Male', 'Female', 'Other'],
                        Icons.transgender,
                            (value) => setState(() => selectedGender = value),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildDropdownField(
                        'City',
                        selectedCity,
                        _cities,
                        Icons.location_city,
                            (value) => setState(() => selectedCity = value),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildHobbiesSection(),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          String selectedHobbies = _hobbies.entries
                              .where((entry) => entry.value)
                              .map((entry) => entry.key)
                              .join(', ');
                          widget.onSave({
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'dob': dobController.text,
                            'gender': selectedGender ?? '',
                            'city': selectedCity ?? '',
                            'hobbies': selectedHobbies,
                          });
                          Navigator.pop(context);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.pinkAccent, Colors.tealAccent],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pinkAccent.withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.save, color: Colors.white, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3), // Increased opacity for better contrast
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: child,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputType keyboardType,
    List<TextInputFormatter>? formatters,
  }) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink.shade900),
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.pink.shade900, // Darker pink for visibility
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 21),
      ),
    );
  }

  Widget _buildDateField() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: dobController,
        readOnly: true,
        onTap: () async {
          DateTime now = DateTime.now();
          DateTime maxDate = DateTime(now.year - 18, now.month, now.day);
          DateTime minDate = DateTime(now.year - 80, now.month, now.day);
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: maxDate,
            firstDate: minDate,
            lastDate: maxDate,
            builder: (context, child) => Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: Colors.pinkAccent),
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ),
          );
          if (pickedDate != null) {
            dobController.text = pickedDate.toLocal().toString().split(' ')[0]; // Simple date format
          }
        },
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          prefixIcon: Icon(Icons.calendar_today, color: Colors.pink.shade900),
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.pink.shade900,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 21, horizontal: 20),
        ),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 21),
      ),
    );
  }

  Widget _buildDropdownField(
      String label,
      String? value,
      List<String> items,
      IconData icon,
      Function(String?) onChanged,
      ) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink.shade900),
          labelStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.pink.shade900,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        dropdownColor: Colors.white.withOpacity(0.2),
        icon: Icon(Icons.arrow_drop_down, color: Colors.pink.shade900),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 21),
      ),
    );
  }

  Widget _buildHobbiesSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.pink.shade900),
              SizedBox(width: 8),
              Text(
                'Hobbies',
                style: TextStyle(
                  fontSize: 21,
                  fontFamily: 'GreatVibes',
                  color: Colors.pink.shade900,
                  shadows: [
                    Shadow(color: Colors.black54, blurRadius: 5, offset: Offset(1, 1)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: _hobbies.keys.map((hobby) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: _hobbies[hobby],
                    onChanged: (value) => setState(() => _hobbies[hobby] = value!),
                    activeColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  Text(
                    hobby,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.pink.shade900,
                      fontSize: 21,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Heart-Shaped Border
class HeartBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path();
    double width = size.width;
    double height = size.height;

    path.moveTo(width * 0.5, height * 0.3); // Start at top center
    path.cubicTo(
      width * 0.2, height * 0.1, // Left control point
      width * 0.0, height * 0.7, // Left bottom point
      width * 0.5, height * 1.0, // Bottom center
    );
    path.cubicTo(
      width * 1.0, height * 0.7, // Right bottom point
      width * 0.8, height * 0.1, // Right control point
      width * 0.5, height * 0.3, // Back to top center
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UserDetailsScreen extends StatefulWidget {
  final Map<String, String> user;

  UserDetailsScreen({required this.user});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Colors.white,
        title: Text(
          'Delete User',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
        ),
        content: Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, widget.user); // Return user to delete
            },
            child: Text('Delete', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.pink.shade300, Colors.teal.shade300],
            ),
          ),
        ),
        title: Text(
          'User Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Lobster',
            shadows: [Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(2, 2))],
          ),
        ),
        elevation: 10,
        shadowColor: Colors.pink.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: _showDeleteDialog,
            tooltip: 'Delete User',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade50, Colors.teal.shade50],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                SizedBox(height: 20),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  widget.user['name'] ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink.shade800,
                    fontFamily: 'Lobster',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.user['email'] ?? 'No Email',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(height: 30),
                _buildInfoCard(
                  title: 'Basic Information',
                  icon: Icons.person,
                  details: [
                    _buildDetailRow('Gender', widget.user['gender']),
                    _buildDetailRow('Date of Birth', widget.user['dob']),
                    _buildDetailRow('Age', widget.user['age']),
                  ],
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Contact Information',
                  icon: Icons.contact_mail,
                  details: [
                    _buildDetailRow('Phone', widget.user['phone']),
                    _buildDetailRow('City', widget.user['city']),
                  ],
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Interests',
                  icon: Icons.favorite_border,
                  details: [
                    _buildDetailRow('Hobbies', widget.user['hobbies']),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required IconData icon, required List<Widget> details}) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: title == 'Basic Information'
              ? [Colors.pink.shade100, Colors.teal.shade100]
              : title == 'Contact Information'
              ? [Colors.teal.shade100, Colors.pink.shade100]
              : [Colors.pink.shade200, Colors.teal.shade200],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Colors.pinkAccent, Colors.tealAccent],
                ).createShader(bounds),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(children: details),
        ],
      ),
    );
  }
// Update text colors in _buildDetailRow for contrast
  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
class FavoriteUserScreen extends StatefulWidget {
  final List<Map<String, String>> favoriteUsers;

  const FavoriteUserScreen({required this.favoriteUsers});

  @override
  _FavoriteUserScreenState createState() => _FavoriteUserScreenState();
}

class _FavoriteUserScreenState extends State<FavoriteUserScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.pink.shade50, Colors.teal.shade50],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: widget.favoriteUsers.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 100, color: Colors.grey.shade400),
                SizedBox(height: 16),
                Text(
                  'No favorite users yet!',
                  style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                ),
              ],
            ),
          )
              : ListView.builder(
            itemCount: widget.favoriteUsers.length,
            itemBuilder: (context, index) {
              final user = widget.favoriteUsers[index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4)),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                    child: Icon(Icons.person, color: Colors.pinkAccent, size: 30),
                  ),
                  title: Text(
                    user['name'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4),
                      Text(user['email'] ?? '', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                      SizedBox(height: 4),
                      Text('City: ${user['city'] ?? 'N/A'}', style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
                    ],
                  ),
                  trailing: Icon(Icons.favorite, color: Colors.redAccent, size: 28),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}