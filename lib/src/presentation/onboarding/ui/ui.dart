class Unbording {
  String image;
  String discripton;
  String title;

  Unbording({
    required this.image,
    required this.discripton,
    required this.title,
  });
}

List<Unbording> contents = [
  Unbording(
      image: 'assets/images/onboarding1.png',
      title: 'Welcome ',
      discripton:
          '    Take control of your rental finances with\nease. Track income and expenses, all in one\n                                  place'),
  Unbording(
      image: 'assets/images/onboarding2.png',
      title: 'Manage Your Properties ',
      discripton:
          'Add and monitor all of your real estate\n  investments. Track each property’s\n performance and status effortlessly'),
  Unbording(
      image: 'assets/images/onboarding3.png',
      title: 'Track Finances & Repairs ',
      discripton:
          'Stay organized with detailed income and\n expense reports. Schedule and track all\n              repair needs and histories'),
];
