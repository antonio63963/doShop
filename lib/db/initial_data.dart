import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/models/models/subcategory.dart';
import 'package:doshop_app/utils/constants.dart';

List<CategoryProd> categories = [
  CategoryProd(
    id: 1,
    title: 'Продукты',
    isShown: true,
    subcategories: true,
    img: 'assets/img/categories/grocery.png',
    colorBg: 0xFF7F83B7,
  ),
  CategoryProd(
    id: 2,
    title: 'Алкоголь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/alcohol.png',
    colorBg: 0xFFB06565,
  ),
  CategoryProd(
    id: 3,
    title: 'Хозтовары',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/hoz.png',
    colorBg: 0xFF5B89B4,
  ),
  CategoryProd(
    id: 4,
    title: 'Химия',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/chem.png',
    colorBg: 0xFF6D5BB4,
  ),
  CategoryProd(
    id: 5,
    title: 'Любимцы',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pets.png',
    colorBg: 0xFF7FB7AD,
  ),
  CategoryProd(
    id: 6,
    title: 'Одежда, обувь',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/clothes.png',
    colorBg: 0xFFB7977F,
  ),
  CategoryProd(
    id: 7,
    title: 'Сад',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/garden.png',
    colorBg: 0xFF80B77F,
  ),
  CategoryProd(
    id: 8,
    title: 'Аптека',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/pills.png',
    colorBg: 0xFF7F95B7,
  ),
  CategoryProd(
    id: 9,
    title: 'Ребенок',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/baby.png',
    colorBg: 0xFFB77F7F,
  ),
  CategoryProd(
    id: 10,
    title: 'Косметика',
    isShown: true,
    subcategories: false,
    img: 'assets/img/categories/cosmetics.png',
    colorBg: 0xFFB77FA1,
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
    img: 'assets/img/categories/milk_cheese.png',
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
    subtitle: 'фрукты, ягоды, зелень',
    isShown: true,
    img: 'assets/img/categories/fruit1.png',
    parentId: 1,
  ),
];

List<Product> products = [
  Product(
    catId: 11,
    title: "Курица",
    units: Units.thing,
  ),
  Product(
    catId: 11,
    title: "Курица четверть",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Курица крылья",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Курица филе",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Индейка филе",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Индейка бедро",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Говядина филе",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Говядина ребро",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Свинина ребро",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Свинина филе",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Свинина шея",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Свинина подчеревок",
    subtitle: 'Копченный',
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Свинина подчеревок",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "колбаса сыровяленая",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "колбаса вареная",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Сосиски",
    units: Units.kg,
  ),
  Product(
    catId: 11,
    title: "Сардельки",
    units: Units.kg,
  ),
  // Milk
  Product(
    catId: 13,
    title: "Молоко 2,5%",
    subtitle: 'Веселый фермер',
    units: Units.lt,
  ),
  Product(
    catId: 13,
    title: "Сыр гауда",
    subtitle: 'Веселый фермер',
    units: Units.lt,
  ),
  Product(
    catId: 13,
    title: "Сыр плавленый",
    subtitle: 'Веселый фермер',
    units: Units.lt,
  ),
  Product(
    catId: 13,
    title: "Йогурт",
    subtitle: 'Веселый фермер',
    units: Units.lt,
  ),
  // Fish
  Product(
    catId: 12,
    title: "Хек",
    subtitle: 'Заморозка',
    units: Units.kg,
  ),
  Product(
    catId: 12,
    title: "Минтай",
    subtitle: 'Заморозка',
    units: Units.kg,
  ),
  Product(
    catId: 12,
    title: "Семга",
    subtitle: 'Заморозка',
    units: Units.kg,
  ),
  Product(
    catId: 12,
    title: "Скумбрия",
    subtitle: 'Заморозка',
    units: Units.kg,
  ),
  Product(
    catId: 12,
    title: "Селедка",
    subtitle: 'Соленая',
    units: Units.kg,
  ),
  Product(
    catId: 12,
    title: "Морская капуста",
    subtitle: 'Готовая',
    units: Units.kg,
  ),
// bakaleya
  Product(
    catId: 14,
    title: "Хлопья Овсяные",
    subtitle: 'Хуторок',
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Хлопья 7 злаков",
    subtitle: 'Хуторок',
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Крупа гречневая",
    subtitle: 'Хуторок',
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Крупа кукурузная",
    subtitle: 'Хуторок',
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Лапша",
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Соль",
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Сахар песок",
    units: Units.kg,
  ),
  Product(
    catId: 14,
    title: "Масло подсолнечное",
    units: Units.lt,
  ),
  Product(
    catId: 14,
    title: "Яйца",
    units: Units.thing,
  ),
// species
  Product(
    catId: 15,
    title: "Хмели-сунели",
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Куркума",
    subtitle: 'Пластиковая упаковка',
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Розмарин",
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Перец черный",
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Перец красный",
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Приправа для плова",
    subtitle: 'На развес у Алика',
    units: Units.pack,
  ),
  Product(
    catId: 15,
    title: "Приправа для рыбы",
    units: Units.pack,
  ),

// vegitables
  Product(
    catId: 16,
    title: "Картофель",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Капуста",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Морковь",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Свекла",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Лук репчатый",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Чеснок",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Помидор",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Огурец",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Перец",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Яблоки",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Апельсины",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Бананы",
    units: Units.kg,
  ),
  Product(
    catId: 16,
    title: "Укроп",
    units: Units.pack,
  ),
  Product(
    catId: 16,
    title: "Петрушка",
    units: Units.pack,
  ),
  Product(
    catId: 16,
    title: "Сельдирей",
    units: Units.pack,
  ),

];


