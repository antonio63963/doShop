import 'package:doshop_app/models/models/subcategories.dart';

import '../exports.dart';

List<Category> categories = [
  Category(
    id: 1,
    title: 'Продукты',
    isShown: true,
    subcategories: true,
    img: 'assets/img/categories/grocery.png',
  ),
  Category(
    id: 2,
    title: 'Алкоголь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/alcohol.png',
  ),
  Category(
    id: 3,
    title: 'Хозтовары',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/hoz.png',
  ),
  Category(
    id: 4,
    title: 'Химия',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/chem.png',
  ),
  Category(
    id: 5,
    title: 'Любимцы',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pets.png',
  ),
  Category(
    id: 6,
    title: 'Одежда, обувь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/clothes.png',
  ),
  Category(
    id: 7,
    title: 'Сад',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/garden.png',
  ),
  Category(
    id: 8,
    title: 'Аптека',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pills.png',
  ),
  Category(
    id: 9,
    title: 'Ребенок',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/baby.png',
  ),
  Category(
    id: 10,
    title: 'Косметика',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/cosmetics.png',
  ),
];

List<Subcategory> subcategories = [
   Subcategory(
    id: 11,
    title: 'Мясо',
    subtitle: 'мясопродукты',
    isShown: true,
    img: 'assets/img/categories/meat.png',
    parentId: 1,
  ),
  Subcategory(
    id: 12,
    title: 'Рыба',
    subtitle: 'рыбопродукты',
    isShown: true,
    img: 'assets/img/categories/fish.png',
    parentId: 1,
  ),
  Subcategory(
    id: 13,
    title: 'Сыр',
    subtitle: 'молоко йогурт',
    isShown: true,
    img: 'assets/img/categories/milk_sheese.png',
    parentId: 1,
  ),
  Subcategory(
    id: 14,
    title: 'Бакалея',
    subtitle: 'крупа, соль, сахар, масло, яйцо',
    isShown: true,
    img: 'assets/img/categories/bakaleya.png',
    parentId: 1,
  ),
  Subcategory(
    id: 15,
    title: 'Специи',
    subtitle: 'перец, розмарин...',
    isShown: true,
    img: 'assets/img/categories/species.png',
    parentId: 1,
  ),
  Subcategory(
    id: 16,
    title: 'Овощи',
    subtitle: 'фрукты, ягоды, орехи',
    isShown: true,
    img: 'assets/img/categories/fruit.png',
    parentId: 1,
  ),
];
