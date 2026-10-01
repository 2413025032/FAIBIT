class LearningMaterial {
  const LearningMaterial(this.title, this.description, this.example);
  final String title, description, example;
}

class Question {
  const Question(this.question, this.options, this.correct, this.explanation);
  final String question, explanation;
  final List<String> options;
  final int correct;
}

class ActivityItem {
  const ActivityItem(this.type, this.title, this.detail, this.time);
  final String type, title, detail, time;
}
