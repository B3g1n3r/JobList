class Job {
  final String jobId;
  final String productName; // from API: product_name
  final String location;
  final String date;        // from API: job_assigned_date
  final String time;        // from API: job_assigned_time
  final String? serviceNotes; 
  final String? username;
  final String? ticketStatus;
  final String? ticket_id;

  Job({
    required this.jobId,
    required this.productName,
    required this.location,
    required this.date,
    required this.time,
    this.serviceNotes,
    this.username,
    this.ticketStatus,
    required this.ticket_id,
    
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['job_id'] ?? '',
      productName: json['product_name'] ?? '',
      location: json['location'] ?? '',
      date: json['job_assigned_date'] ?? '',
      time: json['job_assigned_time'] ?? '',
      ticket_id : json['unique_id']
    );
  }
}
