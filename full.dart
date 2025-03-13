import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:other_design/pr2/tp.dart';
import 'dart:async';
import 'about_us_page.dart';

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
      home: WelcomeScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()), // Replace WelcomeScreen with your next screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade800, Colors.pink.shade300],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ring.jpeg',
                height: 120,
              ),
              SizedBox(height: 20),
              Text(
                'Matrimony App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Lobster',
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Find Your Perfect Match 💞',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller,curve: Curves.linear);
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  Color lightSkin = Color(0xFFFAD8C3);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightSkin,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent,Colors.pinkAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: Image.asset(
                      'assets/images/ring.jpeg',
                      height: 120,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Find Your Soulmate 💞',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Lobster',
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Join millions in finding true love today! 💍',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white70,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 18),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                shadowColor: Colors.black45,
                elevation: 12,
              ),
              onPressed: () {
                // Replace DashboardScreen with your next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardScreen()),
                );
              },
              child: Text(
                "💖 Get Started",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.purple.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final List<Map<String, String>> users = [];
  List<Map<String, String>> favoriteUsers = [];

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
    _pages.addAll([
      AddUserScreen(onUserAdded: (user) {
        setState(() {
          users.add(user);
        });
      }),
      UserListScreen(
        users: users,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoriteUserScreen(favoriteUsers: favoriteUsers),
      AboutUsPage(),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matrimonial Dashboard'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Add User'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'User List'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About Us'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.deepPurple,
        onTap: _onItemTapped,
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

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _hobbiesController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = 'Male'; // Default value
  String _age = '';
  bool isFav = false;

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      widget.onUserAdded({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'gender': _gender,
        'dob': _dobController.text,
        'age': _age,
        'city': _cityController.text,
        'hobbies': _hobbiesController.text,
        'isFavorite': isFav.toString(),
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User saved successfully!'),
      ));
      _formKey.currentState!.reset();
      setState(() {
        _age = '';
        _gender = 'Male';
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
    setState(() {
      _age = age.toString();
    });
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _cityController.dispose();
    _hobbiesController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')), // Allows only letters and spaces
                ],
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // Allows only numeric input
                ],
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime now = DateTime.now();
                  DateTime maxDate = DateTime(now.year - 18, now.month, now.day); // 18 years ago
                  DateTime minDate = DateTime(now.year - 80, now.month, now.day);
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: maxDate,
                    firstDate: minDate,
                    lastDate: maxDate,
                  );
                  if (pickedDate != null) {
                    _dobController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
                    _calculateAge(pickedDate);
                  }
                },
              ),
              SizedBox(height: 10),
              Text('Age: $_age', style: TextStyle(fontSize: 16)),

              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.person_outline, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                items: ['Male', 'Female', 'Other'].map((gender) {
                  return DropdownMenuItem(value: gender, child: Text(gender));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _hobbiesController,
                decoration: InputDecoration(
                  labelText: 'Hobbies',
                  prefixIcon: Icon(Icons.settings_accessibility, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: _validatePassword,
              ),
              SizedBox(height: 10),

              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.pinkAccent),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return 'Please confirm your password';
                  if (value != _passwordController.text) return 'Passwords do not match';
                  return null;
                },
              ),
              SizedBox(height: 10),

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
                  Text('Mark as Favorite User'),
                ],
              ),
              SizedBox(height: 10),

              ElevatedButton(
                onPressed: _saveUser,
                child: Text('Save User'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shadowColor: Colors.black45,
                  elevation: 5,
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
  UserListScreen({Key? key, required this.users, required this.onToggleFavorite}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";

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
    // Filter users by name or email
    List<Map<String, String>> filteredUsers = widget.users.where((user) {
      final name = user['name']?.toLowerCase() ?? '';
      final email = user['email']?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase()) || email.contains(searchQuery.toLowerCase());
    }).toList();

    Color lightSkin = Color(0xFFFAD8C3);

    return Scaffold(
      backgroundColor: lightSkin,
      body: Column(
        children: [
          // Search Field Styling
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name or Email',
                prefixIcon: Icon(Icons.search, color: Colors.pinkAccent),
                filled: true,
                fillColor: Colors.pink[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
              child: Text(
                "No users found",
                style: TextStyle(fontSize: 18, color: Colors.pinkAccent),
              ),
            )
                : ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                // Get actual index from the original list
                int originalIndex = widget.users.indexOf(filteredUsers[index]);

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 4,
                  shadowColor: Colors.pinkAccent.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(
                      filteredUsers[index]['name']!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      filteredUsers[index]['email'] ?? 'No Email',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            filteredUsers[index]['isFavorite'] == 'true'
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.onToggleFavorite(widget.users[originalIndex]);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editUser(originalIndex),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Delete User',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text('Are you sure you want to delete this user?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _deleteUser(originalIndex);
                                    },
                                    child: Text('Delete', style: TextStyle(color: Colors.red)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.pinkAccent),
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

class _EditUserScreenState extends State<EditUserScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController cityController;
  late TextEditingController phoneController;
  late TextEditingController dobController;
  late TextEditingController hobbiesController;

  String? selectedGender;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    emailController = TextEditingController(text: widget.user['email']);
    cityController = TextEditingController(text: widget.user['city']);
    phoneController = TextEditingController(text: widget.user['phone']);
    dobController = TextEditingController(text: widget.user['dob']);
    hobbiesController = TextEditingController(text: widget.user['hobbies']);
    selectedGender = widget.user['gender']; // Initialize gender
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name Field
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Email Field
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // City Field
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Phone Field
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  prefixIcon: Icon(Icons.phone, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 12),
              // DOB Field
              TextField(
                controller: dobController,
                decoration: InputDecoration(
                  labelText: 'DOB',
                  prefixIcon: Icon(Icons.cake, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Gender Field
              DropdownButtonFormField<String>(
                value: selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map(
                      (gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  ),
                )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Gender',
                  prefixIcon: Icon(Icons.transgender, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Hobbies Field
              TextField(
                controller: hobbiesController,
                decoration: InputDecoration(
                  labelText: 'Hobbies',
                  prefixIcon: Icon(Icons.sports_esports, color: Colors.pinkAccent),
                  filled: true,
                  fillColor: Colors.pink[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Save Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    widget.onSave({
                      'name': nameController.text,
                      'email': emailController.text,
                      'city': cityController.text,
                      'phone': phoneController.text,
                      'dob': dobController.text,
                      'hobbies': hobbiesController.text,
                      'gender': selectedGender ?? '', // Save gender
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.pinkAccent,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

class UserDetailsScreen extends StatelessWidget {
  final Map<String, String> user;

  UserDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Delete User',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  content: Text('Are you sure you want to delete this user?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context, user); // Return user to delete
                      },
                      child: Text('Delete', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent.shade100, Colors.teal.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.pinkAccent,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              SizedBox(height: 20),
              buildInfoCard(
                context,
                'Basic Information',
                Icons.person,
                [
                  buildDetailRow('Name', user['name']),
                  buildDetailRow('Gender', user['gender']),
                  buildDetailRow('DOB', user['dob']),
                  buildDetailRow('Age', user['age']),
                ],
              ),
              SizedBox(height: 20),
              buildInfoCard(
                context,
                'Contact Information',
                Icons.contact_mail,
                [
                  buildDetailRow('Email', user['email']),
                  buildDetailRow('Phone', user['phone']),
                  buildDetailRow('City', user['city']),
                ],
              ),
              SizedBox(height: 20),
              buildInfoCard(
                context,
                'Other Details',
                Icons.info,
                [
                  buildDetailRow('Hobbies', user['hobbies']),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(
      BuildContext context,
      String title,
      IconData icon,
      List<Widget> children,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 3,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Gradient Accent Bar
            Container(
              height: 5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                gradient: LinearGradient(
                  colors: [Colors.teal.shade300, Colors.teal.shade600],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title with Icon
                  Row(
                    children: [
                      Icon(icon, color: Colors.teal.shade700, size: 26),
                      SizedBox(width: 10),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(children: children),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          Expanded(
            child: Text(
              value ?? 'N/A',
              style: TextStyle(
                fontSize: 27,
                color: Colors.pink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class FavoriteUserScreen extends StatelessWidget {
  final List<Map<String, String>> favoriteUsers;

  const FavoriteUserScreen({Key? key, required this.favoriteUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: favoriteUsers.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 100, color: Colors.grey),
            SizedBox(height: 10),
            Text(
              'No favorite users yet!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: favoriteUsers.length,
        itemBuilder: (context, index) {
          final user = favoriteUsers[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetailsScreen(user: user)));
            },
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.pinkAccent.withOpacity(0.1),
                  child: Icon(Icons.person, color: Colors.pinkAccent, size: 30),
                ),
                title: Text(
                  user['name'] ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 4),
                    Text(
                      user['email'] ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'City: ${user['city'] ?? 'N/A'}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),

                  ],
                ),
                trailing: Icon(
                  Icons.favorite,
                  color: Colors.red,
                  size: 28,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}