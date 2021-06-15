class ResponseDashboard {
  String totalSpent;
  List<ProjectDetails> projects;

  ResponseDashboard({
    required this.totalSpent,
    required this.projects,
  });

  @override
  String toString() =>
      'ResponseDashboard(totalSpent: $totalSpent, projects: $projects)';
}

class ProjectDetails {
  String id;
  String name;
  Duration duration;
  String totalSpend;
  int totalSpendSeconds;
  Set<String> issueIds;
  ProjectDetails({
    required this.id,
    required this.name,
    required this.duration,
    required this.totalSpend,
    required this.totalSpendSeconds,
    required this.issueIds,
  });

  @override
  String toString() {
    return 'ProjectDetails(id: $id, name: $name, duration: $duration, totalSpend: $totalSpend, totalSpendSeconds: $totalSpendSeconds, issueIds: $issueIds)';
  }
}
