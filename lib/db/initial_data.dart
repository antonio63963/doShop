import '../exports.dart';

List<Category> categories = [
  Category(
    title: 'Продукты',
    isShown: true,
    subcategories: true,
    img: 'assets/img/categories/grocery.png'
  ),
  Category(
    title: 'Алкоголь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/alcohol.png'
  ),
  Category(
    title: 'Хозтовары',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/hoz.png'
  ),
  Category(
    title: 'Химия',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/chem.png'
  ),
  Category(
    title: 'Любимцы',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pets.png'
  ),
  Category(
    title: 'Одежда, обувь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/clothes.png'
  ),
  // Category(
  //   title: 'Разное',
  //   isShown: true,
  //   subcategories: false,
  //   img: 'assets/img/cat/hobby.png'
  // ),
  Category(
    title: 'Сад',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/garden.png'
  ),
  Category(
    title: 'Аптека',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pills.png'
  ),
  Category(
    title: 'Ребенок',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/baby.png'
  ),
  Category(
    title: 'Косметика',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/cosmetics.png'
  ),
];

List<Category> grocerySub = [
  Category(
    title: 'Мясо',
    subtitle: 'мясопродукты',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/cosmetics.png'
  ),
  Category(
    title: 'Рыба',
    subtitle: 'рыбопродукты',
    isShown: true,
    subcategories: false,
  ),
  Category(
    title: 'Сыр',
    subtitle: 'молоко йогурт',
    isShown: true,
    subcategories: false,
  ),
  Category(
    title: 'Бакалея',
    subtitle: 'крупа, соль, сахар, масло, яйцо',
    isShown: true,
    subcategories: false,
  ),
  Category(
    title: 'Специи',
    subtitle: 'перец, розмарин...',
    isShown: true,
    subcategories: false,
  ),
  Category(
    title: 'Овощи',
    subtitle: 'фрукты, ягоды, орехи',
    isShown: true,
    subcategories: false,
  ),
];
