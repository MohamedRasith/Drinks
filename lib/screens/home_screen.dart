import 'package:drinks/models/drink.dart';
import 'package:drinks/repositories/drinks_repository.dart';
import 'package:drinks/screens/drink_details_screen.dart';
import 'package:drinks/utils/helpers.dart';
import 'package:drinks/widgets/custom_loader.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Drink>? _drinks;
  bool _isLoading = false;

  final TextEditingController searchController = TextEditingController();

  void _updateDrinks(String? q) async {
    setState(() => _isLoading = true);
    try {
      _drinks = await DrinksRepository.getDrinks(searchQuery: q);
    } catch (_) {

    }
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    _updateDrinks(null);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('Drinks',style: TextStyle(color: Colors.black),))
            ],

          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/images/bg.png'),
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(Colors.white70, BlendMode.lighten),
    )
    ),
          child: DoubleBackToCloseApp(
            snackBar: const SnackBar(
              content: Text('Tap the back button again to exit the app!'),
            ),
            child: Column( // Use Column instead of ListView
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              _updateDrinks(value.isEmpty ? null : value);
                            });
                          },
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Please search by drinks name',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          final q = searchController.text;
                          if (q.isNotEmpty) _updateDrinks(null);
                          searchController.clear();
                          FocusScope.of(context).unfocus();
                        },
                        icon: Icon(Icons.clear, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  const CustomLoader()
                else if (_drinks == null || searchController.text.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'Please search any drinks!',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  )
                else
                  Expanded( // Ensures ListView.builder is scrollable
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(), // Allows smooth scrolling
                      itemBuilder: (context, index) => _DrinkCard(
                        drink: _drinks![index],
                      ),
                      itemCount: _drinks!.length,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrinkCard extends StatelessWidget {
  final Drink drink;

  const _DrinkCard({
    Key? key,
    required this.drink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.tryParse(drink.dateModified.toString());
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 10),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage("${drink.strDrinkThumb}"), // Set image directly
            backgroundColor: Colors.grey, // Fallback color if image is not available
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Name: ', // Bold and blue part
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                    ),
                    TextSpan(
                      text: drink.strDrink, // Normal part
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Category: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                    ),
                    TextSpan(
                      text: drink.strCategory,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Updated on: ',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800),
                    ),
                    TextSpan(
                      text: DateFormat("dd MMM yyyy").format(date ?? DateTime.now()),
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          onTap: () => Navigator.pushNamed(
            context,
            DrinkDetailsScreen.id,
            arguments: drink,
          ),
        ),
      ),
    );
  }
}
