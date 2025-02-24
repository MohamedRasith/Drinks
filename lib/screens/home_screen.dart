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
    child:DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap the back button again to exit the app!'),
          ),
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              TextField(
                controller: searchController,
                onSubmitted: (_) {
                  final searchQuery = searchController.text;
                  if (isNullOrBlank(searchQuery)) {
                    return showSnackBar('Please enter a valid search term!');
                  }
                  _updateDrinks(searchQuery);
                },
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      _updateDrinks(null);
                    });

                  }
                  else {
                    setState(() {
                      _updateDrinks(value);
                    });

                  }
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Please search by drinks name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      final q = searchController.text;
                      if (!isNullOrBlank(q)) _updateDrinks(null);
                      searchController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(Icons.clear,color: Colors.black,),
                  ),
                ),
              ),
              const SizedBox(height: 10,width: 40,),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.white),
              //       minimumSize: MaterialStateProperty.all(Size(50, 50)),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(50.0),
              //           ),
              //       ),
              //   ),
              //   onPressed: () async {
              //     final searchQuery = searchController.text;
              //     if (isNullOrBlank(searchQuery)) {
              //       return showSnackBar('Please Enter Any Words');
              //     }
              //     _updateDrinks(searchQuery);
              //   },
              //   child: const Text(
              //     'Search',
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              const SizedBox(height: 25),
              if (_isLoading)
                const CustomLoader()
              else if (_drinks == null)
                const Center(
                  child: Text(
                    '! Not Found',
                    style: TextStyle(fontSize: 22),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _DrinkCard(
                    drink: _drinks![index],
                  ),
                  itemCount: _drinks!.length,
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
          leading: Image.network("${drink.strDrinkThumb}", width: 50, height: 50,),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${drink.strDrink}'),
              Text('Category: ${drink.strCategory}'),
              Text('Updated on: ${DateFormat("dd MMM yyyy").format(date ?? DateTime.now())}'),
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
