import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade200, Colors.teal.shade200],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, size: 100, color: Colors.white),
                SizedBox(height: 20),
                Text(
                  'Matrimonial App',
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'GreatVibes',
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Find Your Soulmate',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.pink.shade100, Colors.teal.shade100],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 120, color: Colors.pink.shade600),
              SizedBox(height: 30),
              Text(
                'Welcome to Love Haven',
                style: TextStyle(
                  fontSize: 36,
                  fontFamily: 'GreatVibes',
                  color: Colors.pink.shade900,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Discover your perfect match with us!',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800, fontFamily: 'Poppins'),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
            ],
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
  List<Map<String, String>> users = [];
  List<Map<String, String>> favoriteUsers = [];
  bool isLoading = true;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _bounceAnimation;
  final ApiService _apiService = ApiService();

  Map<String, String> _toggleFavorite(Map<String, String> user) {
    Map<String, String> updatedUser = {...user};
    setState(() {
      if (favoriteUsers.any((favUser) => favUser['id'] == user['id'])) {
        favoriteUsers.removeWhere((favUser) => favUser['id'] == user['id']);
        updatedUser['isFavorite'] = 'false';
      } else {
        favoriteUsers.add({...user, 'isFavorite': 'true'});
        updatedUser['isFavorite'] = 'true';
      }
      _apiService.updateUser(user['id']!, updatedUser);
      users[users.indexWhere((u) => u['id'] == user['id'])] = updatedUser;
    });
    return updatedUser;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _bounceAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceOut),
    );
    _fetchUsers();
    _animationController.forward();
  }

  Future<void> _fetchUsers() async {
    try {
      final fetchedUsers = await _apiService.fetchUsers();
      print('Fetched Users: $fetchedUsers');
      setState(() {
        users = fetchedUsers;
        favoriteUsers = fetchedUsers.where((user) => user['isFavorite'] == 'true').toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching users: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error fetching users: $e')));
    }
  }

  void _addUser(Map<String, String> user) async {
    try {
      await _apiService.addUser(user);
      await _fetchUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding user: $e')));
    }
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
    final pages = [
      AddUserScreen(onUserAdded: _addUser),
      UserListScreen(users: users, onToggleFavorite: _toggleFavorite),
      FavoriteUserScreen(favoriteUsers: favoriteUsers),
      AboutUsPage(),
    ];

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
              colors: [Colors.pink.shade400.withOpacity(0.7), Colors.teal.shade400.withOpacity(0.7)],
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _bounceAnimation,
              child: Icon(Icons.favorite, color: Colors.white, size: 32),
            ),
            SizedBox(width: 12),
            Text(
              'Love Haven',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'GreatVibes',
                color: Colors.white,
                letterSpacing: 1.5,
                shadows: [Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(2, 2))],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: ScaleTransition(
              scale: _bounceAnimation,
              child: CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white.withOpacity(0.4),
                child: Icon(Icons.person, color: Colors.pink.shade700, size: 28),
              ),
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
              Colors.pink.shade50.withOpacity(0.8),
              Colors.teal.shade50.withOpacity(0.8),
              Colors.purple.shade50.withOpacity(0.8),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.pinkAccent,
                  backgroundColor: Colors.white.withOpacity(0.3),
                ),
              )
            : Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/romantic_banner.jpeg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                      ),
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Text(
                          "Find Your Soulmate Today",
                          style: TextStyle(
                            fontSize: 34,
                            fontFamily: 'GreatVibes',
                            color: Colors.white,
                            letterSpacing: 2,
                            shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: pages[_selectedIndex],
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: ScaleTransition(scale: _bounceAnimation, child: Icon(Icons.person_add)),
                  label: 'Add',
                  tooltip: 'Add a new user',
                ),
                BottomNavigationBarItem(
                  icon: ScaleTransition(scale: _bounceAnimation, child: Icon(Icons.list)),
                  label: 'Users',
                  tooltip: 'View all users',
                ),
                BottomNavigationBarItem(
                  icon: ScaleTransition(scale: _bounceAnimation, child: Icon(Icons.favorite)),
                  label: 'Favorites',
                  tooltip: 'Favorite users',
                ),
                BottomNavigationBarItem(
                  icon: ScaleTransition(scale: _bounceAnimation, child: Icon(Icons.info)),
                  label: 'About',
                  tooltip: 'About the app',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.pink.shade700,
              unselectedItemColor: Colors.grey.shade600,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins', fontSize: 14),
              unselectedLabelStyle: TextStyle(fontFamily: 'Poppins', fontSize: 12),
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
  final _formKey = GlobalKey<FormState>;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;
  late TextEditingController _linkController;
  String? _gender;
  String? _selectedCity;
  String _age = '';
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
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _linkController = TextEditingController();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _linkController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      String selectedHobbies = _hobbies.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .join(', ');
      final newUser = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _gender ?? '',
        'dob': _dobController.text,
        'age': _age,
        'city': _selectedCity ?? '',
        'hobbies': selectedHobbies,
        'isFavorite': isFav.toString(),
        'link': _linkController.text.isEmpty ? '' : _linkController.text,
      };
      widget.onUserAdded(newUser);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Add a New Soulmate',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'GreatVibes',
                    color: Colors.pink.shade900,
                    shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a name';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter an email';
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) return 'Please enter a valid email';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a phone number';
                  if (value.length < 10) return 'Phone number must be at least 10 digits';
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
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
                  );
                  if (pickedDate != null) {
                    _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                    setState(() {
                      _age = (now.year - pickedDate.year).toString();
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please select a date of birth';
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.transgender),
                ),
                items: ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Please select a gender';
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: InputDecoration(
                  labelText: 'City',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: _cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                },
                validator: (value) {
                  if (value == null) return 'Please select a city';
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text('Hobbies', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 10,
                children: _hobbies.keys.map((hobby) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _hobbies[hobby],
                        onChanged: (value) {
                          setState(() {
                            _hobbies[hobby] = value!;
                          });
                        },
                      ),
                      Text(hobby),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'Profile Link (optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.link),
                ),
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: isFav,
                    onChanged: (value) {
                      setState(() {
                        isFav = value!;
                      });
                    },
                  ),
                  Text('Add to Favorites'),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text(
                    'Add User',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
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
  late Animation<double> _scaleAnimation;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _scaleAnimation = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _deleteUser(int index) async {
    try {
      await _apiService.deleteUser(widget.users[index]['id']!);
      setState(() {
        widget.users.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error deleting user: $e')));
    }
  }

  void _editUser(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUserScreen(
          user: widget.users[index],
          onSave: (updatedUser) async {
            try {
              await _apiService.updateUser(widget.users[index]['id']!, updatedUser);
              setState(() {
                widget.users[index] = updatedUser;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating user: $e')));
            }
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
          colors: [
            Colors.pink.shade50.withOpacity(0.8),
            Colors.teal.shade50.withOpacity(0.8),
            Colors.purple.shade50.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white.withOpacity(0.3), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.2),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for Love...',
                  hintStyle: TextStyle(color: Colors.grey.shade500, fontFamily: 'Poppins'),
                  prefixIcon: Icon(Icons.search, color: Colors.pink.shade700, size: 28),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
                style: TextStyle(color: Colors.grey.shade800, fontFamily: 'Poppins'),
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
                          Icon(Icons.favorite_border, size: 120, color: Colors.pink.shade300),
                          SizedBox(height: 20),
                          Text(
                            'No Soulmates Found',
                            style: TextStyle(
                              fontSize: 28,
                              color: Colors.pink.shade600,
                              fontFamily: 'GreatVibes',
                              shadows: [Shadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2))],
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Add someone special to your list!',
                            style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
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
                          duration: Duration(milliseconds: 600),
                          margin: EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.pink.shade50.withOpacity(0.4)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.pinkAccent.withOpacity(0.2), width: 1),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.pinkAccent.withOpacity(0.2),
                                blurRadius: 15,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            leading: ScaleTransition(
                              scale: _scaleAnimation,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: AssetImage('assets/images/heart.jpeg'),
                                child: Icon(Icons.person, color: Colors.pink.shade700, size: 35),
                              ),
                            ),
                            title: Text(
                              filteredUsers[index]['name'] ?? 'Unnamed',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.pink.shade800,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            subtitle: Text(
                              filteredUsers[index]['email'] ?? 'No Email',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Icon(
                                      filteredUsers[index]['isFavorite'] == 'true' ? Icons.favorite : Icons.favorite_border,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                  ),
                                  onPressed: () => widget.onToggleFavorite(widget.users[originalIndex]),
                                ),
                                IconButton(
                                  icon: ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Icon(Icons.edit, color: Colors.teal.shade600, size: 30),
                                  ),
                                  onPressed: () => _editUser(originalIndex),
                                ),
                                IconButton(
                                  icon: ScaleTransition(
                                    scale: _scaleAnimation,
                                    child: Icon(Icons.delete, color: Colors.redAccent, size: 30),
                                  ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.white.withOpacity(0.95),
        title: Row(
          children: [
            Icon(Icons.delete, color: Colors.redAccent),
            SizedBox(width: 10),
            Text(
              'Delete Soulmate',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontFamily: 'Poppins'),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove this person from your list?',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade800),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade700, fontFamily: 'Poppins')),
          ),
          TextButton(
            onPressed: () {
              _deleteUser(index);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.redAccent, fontFamily: 'Poppins')),
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
  late TextEditingController linkController;
  String? selectedGender;
  String? selectedCity;

  final List<String> _cities = [
    'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix',
    'Philadelphia', 'San Antonio', 'San Diego', 'Dallas', 'San Jose'
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];

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
    linkController = TextEditingController(text: widget.user['link']);

    String? genderFromUser = widget.user['gender'];
    if (genderFromUser != null && _genders.contains(genderFromUser)) {
      selectedGender = genderFromUser;
    } else {
      selectedGender = null;
    }

    String? cityFromUser = widget.user['city'];
    if (cityFromUser != null && _cities.contains(cityFromUser)) {
      selectedCity = cityFromUser;
    } else {
      selectedCity = null;
    }

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
    linkController.dispose();
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
              colors: [Colors.pink.shade300.withOpacity(0.5), Colors.teal.shade300.withOpacity(0.5)],
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
                  shadows: [Shadow(color: Colors.black87, blurRadius: 15, offset: Offset(3, 3))],
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
        color: Colors.pink.shade100,
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
                          color: Colors.pink.shade900,
                          shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
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
                    _buildInputCard(child: _buildDateField()),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildDropdownField(
                        'Gender',
                        selectedGender,
                        _genders,
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
                    _buildInputCard(child: _buildHobbiesSection()),
                    SizedBox(height: 16),
                    _buildInputCard(
                      child: _buildTextField(
                        controller: linkController,
                        label: 'Profile Link (optional)',
                        icon: Icons.link,
                        keyboardType: TextInputType.url,
                      ),
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
                            'isFavorite': widget.user['isFavorite'] ?? 'false',
                            'link': linkController.text,
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
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 8))],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(20), child: child),
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
          labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.pink.shade900, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 16),
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
            dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
          }
        },
        decoration: InputDecoration(
          labelText: 'Date of Birth',
          prefixIcon: Icon(Icons.calendar_today, color: Colors.pink.shade900),
          labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.pink.shade900, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 16),
      ),
    );
  }

  Widget _buildDropdownField(String label, String? value, List<String> items, IconData icon, Function(String?) onChanged) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink.shade900),
          labelStyle: TextStyle(fontFamily: 'Poppins', color: Colors.pink.shade900, fontWeight: FontWeight.w500),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
        dropdownColor: Colors.white.withOpacity(0.9),
        icon: Icon(Icons.arrow_drop_down, color: Colors.pink.shade900),
        style: TextStyle(color: Colors.pink.shade900, fontFamily: 'Poppins', fontSize: 16),
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
                  fontSize: 18,
                  fontFamily: 'GreatVibes',
                  color: Colors.pink.shade900,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 5, offset: Offset(1, 1))],
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
                  Text(hobby, style: TextStyle(fontFamily: 'Poppins', color: Colors.pink.shade900, fontSize: 16)),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

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

    path.moveTo(width * 0.5, height * 0.3);
    path.cubicTo(width * 0.2, height * 0.1, width * 0.0, height * 0.7, width * 0.5, height * 1.0);
    path.cubicTo(width * 1.0, height * 0.7, width * 0.8, height * 0.1, width * 0.5, height * 0.3);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
  late Animation<double> _heartBeatAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _heartBeatAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
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
          colors: [
            Colors.pink.shade50.withOpacity(0.8),
            Colors.teal.shade50.withOpacity(0.8),
            Colors.purple.shade100.withOpacity(0.8),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: widget.favoriteUsers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ScaleTransition(
                        scale: _heartBeatAnimation,
                        child: Icon(Icons.favorite_border, size: 140, color: Colors.pink.shade400),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Your Heart is Empty 💔',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.pink.shade600,
                          fontFamily: 'GreatVibes',
                          shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Add someone to your favorites!',
                        style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: widget.favoriteUsers.length,
                  itemBuilder: (context, index) {
                    final user = widget.favoriteUsers[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.teal.shade50.withOpacity(0.4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.tealAccent.withOpacity(0.2), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.tealAccent.withOpacity(0.2),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        leading: ScaleTransition(
                          scale: _heartBeatAnimation,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage('assets/images/heart.jpeg'),
                            child: Icon(Icons.person, color: Colors.teal.shade600, size: 35),
                          ),
                        ),
                        title: Text(
                          user['name'] ?? '',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal.shade800,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4),
                            Text(
                              user['email'] ?? '',
                              style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'City: ${user['city'] ?? 'N/A'}',
                              style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                        trailing: ScaleTransition(
                          scale: _heartBeatAnimation,
                          child: Icon(Icons.favorite, color: Colors.redAccent, size: 32),
                        ),
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
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.white.withOpacity(0.95),
        title: Row(
          children: [
            Icon(Icons.delete, color: Colors.redAccent),
            SizedBox(width: 10),
            Text(
              'Delete Soulmate',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontFamily: 'Poppins'),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove this person from your journey?',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.grey.shade800),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: Colors.grey.shade700, fontFamily: 'Poppins')),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, widget.user);
            },
            child: Text('Delete', style: TextStyle(color: Colors.redAccent, fontFamily: 'Poppins')),
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
              colors: [Colors.pink.shade400, Colors.teal.shade400],
            ),
          ),
        ),
        title: Text(
          'Soulmate Profile',
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'GreatVibes',
            color: Colors.white,
            letterSpacing: 1.5,
            shadows: [Shadow(color: Colors.black45, blurRadius: 10, offset: Offset(2, 2))],
          ),
        ),
        elevation: 10,
        shadowColor: Colors.pinkAccent.withOpacity(0.5),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white, size: 28),
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
            colors: [
              Colors.pink.shade50.withOpacity(0.8),
              Colors.teal.shade50.withOpacity(0.8),
              Colors.purple.shade100.withOpacity(0.8),
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
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
                      border: Border.all(color: Colors.pinkAccent, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: ScaleTransition(
                      scale: _pulseAnimation,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                        child: Icon(Icons.person, size: 100, color: Colors.pinkAccent),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  widget.user['name'] ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'GreatVibes',
                    color: Colors.pink.shade900,
                    letterSpacing: 1.5,
                    shadows: [Shadow(color: Colors.black26, blurRadius: 10, offset: Offset(2, 2))],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text(
                  widget.user['email'] ?? 'No Email',
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade800, fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                _buildInfoCard(
                  title: 'Personal Details',
                  icon: Icons.person,
                  details: [
                    _buildDetailRow('Gender', widget.user['gender']),
                    _buildDetailRow('Date of Birth', widget.user['dob']),
                    _buildDetailRow('Age', widget.user['age']),
                  ],
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Contact Details',
                  icon: Icons.contact_mail,
                  details: [
                    _buildDetailRow('Phone', widget.user['phone']),
                    _buildDetailRow('City', widget.user['city']),
                  ],
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Passions',
                  icon: Icons.favorite_border,
                  details: [_buildDetailRow('Hobbies', widget.user['hobbies'])],
                ),
                SizedBox(height: 20),
                _buildInfoCard(
                  title: 'Profile Link',
                  icon: Icons.link,
                  details: [
                    GestureDetector(
                      onTap: () async {
                        final url = widget.user['link'];
                        if (url != null && url.isNotEmpty) {
                          if (await canLaunchUrl(Uri.parse(url))) {
                            await launchUrl(Uri.parse(url));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cannot launch URL')));
                          }
                        }
                      },
                      child: _buildDetailRow('Link', widget.user['link'] ?? 'Not provided'),
                    ),
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
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: title == 'Personal Details'
              ? [Colors.pink.shade100, Colors.teal.shade100]
              : title == 'Contact Details'
                  ? [Colors.teal.shade100, Colors.pink.shade100]
                  : [Colors.pink.shade200, Colors.teal.shade200],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.pinkAccent.withOpacity(0.2),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ScaleTransition(
                scale: _pulseAnimation,
                child: Icon(icon, color: Colors.pink.shade700, size: 32),
              ),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 26,
                  fontFamily: 'GreatVibes',
                  color: Colors.grey.shade800,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 5, offset: Offset(1, 1))],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Column(children: details),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700, fontFamily: 'Poppins'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
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
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Icon(Icons.favorite, size: 100, color: Colors.pink.shade600),
            SizedBox(height: 20),
            Text(
              'About Love Haven',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'GreatVibes',
                color: Colors.pink.shade900,
                shadows: [Shadow(color: Colors.black54, blurRadius: 15, offset: Offset(3, 3))],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, offset: Offset(0, 8))],
              ),
              child: Column(
                children: [
                  Text(
                    'Our Mission',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade800, fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'At Love Haven, we are dedicated to helping you find your perfect match. Our platform connects hearts with a seamless and romantic experience.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Our Vision',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey.shade800, fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'To create a world where love knows no boundaries, and every heart finds its true companion.',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700, fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Join us on this beautiful journey of love! 💕',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'GreatVibes',
                color: Colors.pink.shade900,
                shadows: [Shadow(color: Colors.black54, blurRadius: 10, offset: Offset(2, 2))],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ApiService {
  final String baseUrl = 'https://67ce92bc125cd5af757b0a97.mockapi.io/users';

  Future<List<Map<String, String>>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) {
        var userMap = Map<String, String>.from(user);
        userMap['gender'] = userMap['gender'] ?? '';
        userMap['city'] = userMap['city'] ?? '';
        return userMap;
      }).toList();
    } else {
      throw Exception('Failed to load users: ${response.statusCode}');
    }
  }

  Future<void> addUser(Map<String, String> user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add user: ${response.statusCode}');
    }
  }

  Future<void> updateUser(String id, Map<String, String> user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update user: ${response.statusCode}');
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete user: ${response.statusCode}');
    }
  }
}