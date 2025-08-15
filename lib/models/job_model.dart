class Job {
  final String jobId;
  final String productName; // using product_name from API
  final String location;
  final String date;
  final String time;

  Job({
    required this.jobId,
    required this.productName,
    required this.location,
    required this.date,
    required this.time,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['job_id'] ?? '',
      productName: json['product_name'] ?? '',
      location: json['location'] ?? '',
      date: json['job_assigned_date'] ?? '',
      time: json['job_assigned_time'] ?? '',
    );
  }
}
