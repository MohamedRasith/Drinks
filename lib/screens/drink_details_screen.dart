import 'package:drinks/models/drink.dart';
import 'package:flutter/material.dart';

class DrinkDetailsScreen extends StatelessWidget {
  static const id = 'DrinkDetailsScreen';

  final Drink drink;

  const DrinkDetailsScreen({
    Key? key,
    required this.drink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(drink.strDrink),
          centerTitle: true,
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
    child:Card(
      color: Colors.white,
      child: ListView(
        children: [
          Image.network('${drink.strDrinkThumb}',width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
          _InfoTile(
            title: 'Tags',
            subtitle: drink.strTags,
          ),
          _InfoTile(
            title: 'Category',
            subtitle: drink.strCategory,
          ),
          _InfoTile(
            title: 'Glass',
            subtitle: drink.strGlass,
          ),
          _InfoTile(
            title: 'Instructions',
            subtitle: drink.strInstructions,
          ),
          _InfoTile(
            title: 'Ingredient 1',
            subtitle: drink.strIngredient1 == null
                ? null
                : '${drink.strIngredient1} (${drink.strMeasure1})',
          ),
          _InfoTile(
            title: 'Ingredient 2',
            subtitle: drink.strIngredient2 == null
                ? null
                : '${drink.strIngredient2} (${drink.strMeasure2})',
          ),
          _InfoTile(
            title: 'Ingredient 3',
            subtitle: drink.strIngredient3 == null
                ? null
                : '${drink.strIngredient3} (${drink.strMeasure3})',
          ),
          _InfoTile(
            title: 'Ingredient 4',
            subtitle: drink.strIngredient4 == null
                ? null
                : '${drink.strIngredient4} (${drink.strMeasure4})',
          ),
          _InfoTile(
            title: 'Ingredient 5',
            subtitle: drink.strIngredient5 == null
                ? null
                : '${drink.strIngredient5} (${drink.strMeasure5})',
          ),
          _InfoTile(
            title: 'Ingredient 6',
            subtitle: drink.strIngredient6 == null
                ? null
                : '${drink.strIngredient6} (${drink.strMeasure6})',
          ),
          _InfoTile(
            title: 'Ingredient 7',
            subtitle: drink.strIngredient7 == null
                ? null
                : '${drink.strIngredient7} (${drink.strMeasure7})',
          ),
          _InfoTile(
            title: 'Ingredient 8',
            subtitle: drink.strIngredient8 == null
                ? null
                : '${drink.strIngredient8} (${drink.strMeasure8})',
          ),
          _InfoTile(
            title: 'Ingredient 9',
            subtitle: drink.strIngredient9 == null
                ? null
                : '${drink.strIngredient9} (${drink.strMeasure9})',
          ),
          _InfoTile(
            title: 'Ingredient 10',
            subtitle: drink.strIngredient10 == null
                ? null
                : '${drink.strIngredient10} (${drink.strMeasure10})',
          ),
          _InfoTile(
            title: 'Ingredient 11',
            subtitle: drink.strIngredient11 == null
                ? null
                : '${drink.strIngredient11} (${drink.strMeasure11})',
          ),
          _InfoTile(
            title: 'Ingredient 12',
            subtitle: drink.strIngredient12 == null
                ? null
                : '${drink.strIngredient12} (${drink.strMeasure12})',
          ),
          _InfoTile(
            title: 'Ingredient 13',
            subtitle: drink.strIngredient13 == null
                ? null
                : '${drink.strIngredient13} (${drink.strMeasure13})',
          ),
          _InfoTile(
            title: 'Ingredient 14',
            subtitle: drink.strIngredient14 == null
                ? null
                : '${drink.strIngredient14} (${drink.strMeasure14})',
          ),
          _InfoTile(
            title: 'Ingredient 15',
            subtitle: drink.strIngredient15 == null
                ? null
                : '${drink.strIngredient15} (${drink.strMeasure15})',
          ),
        ],
      ),
    ),
      ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    if (subtitle == null) {
      return const SizedBox.shrink();
    } else {
      return ListTile(
        title: Text(title),
        subtitle: Text(subtitle!),
      );
    }
  }
}
