class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Welcome to Todo",
    image: "assets/images/image1.png",
    desc: "Simplify your life and stay organized with Todo. Manage your tasks, set goals, and achieve more.",
  ),
  OnboardingContents(
    title: "Organize Your Tasks",
    image: "assets/images/image2.png",
    desc:
    " Keep track of your to-dos, prioritize tasks, and create a structured plan to boost your productivity.",
  ),
  OnboardingContents(
    title: "Stay in Control",
    image: "assets/images/image3.png",
    desc:
"    ake charge of your day with Todo. Get reminders, set deadlines, and never miss an important task again."
  ),
];