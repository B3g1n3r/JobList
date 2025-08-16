import 'package:flutter/material.dart';
import 'package:job_management_app/screens/job_detail.dart';
import 'package:job_management_app/service/api_service.dart';
import '../models/job_model.dart';
import '../viewmodels/auth_viewmodel.dart'; 
import 'package:provider/provider.dart';
class JobList extends StatefulWidget {
  final String userId;
  final String token;

  const JobList({Key? key, required this.userId, required this.token}) : super(key: key);

  @override
  State<JobList> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> allJobs = [];
  List<Job> filteredJobs = [];
  bool loading = true;
  String? error;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;


  @override
  void initState() {
    super.initState();
    fetchJobs();
  }

  void filterJobs() {
    setState(() {
      filteredJobs = allJobs.where((job) {
        DateTime jobDate = DateTime.parse(job.date);
        return jobDate.month == selectedMonth && jobDate.day == selectedDay;
      }).toList();
    });
  }

  Future<void> fetchJobs() async {
    try {
      final data = await ApiService().getJobs(widget.userId, widget.token);
      allJobs = data.map<Job>((j) => Job.fromJson(j)).toList();
      filterJobs();
      setState(() { loading = false; });
    } catch (e) {
      setState(() { error = "Error: $e"; loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final monthNames = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    int daysInMonth = DateUtils.getDaysInMonth(DateTime.now().year, selectedMonth);
    
  Provider.of<AuthViewModel>(context);
  

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : error != null
                  ? Center(child: Text(error!))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(child: Text("Job List", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black))),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            DropdownButton<int>(
                              value: selectedMonth,
                              items: List.generate(
                                12,
                                (i) => DropdownMenuItem(
                                  value: i + 1,
                                  child: Text(monthNames[i]),
                                ),
                              ),
                              onChanged: (val) {
                                setState(() {
                                  selectedMonth = val!;
                                  selectedDay = 1;
                                  filterJobs();
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: SizedBox(
                                height: 38,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: daysInMonth,
                                  separatorBuilder: (_, __) => const SizedBox(width: 4),
                                  itemBuilder: (_, idx) {
                                    int day = idx + 1;
                                    bool isSelected = day == selectedDay;
                                    return OutlinedButton(
                                      onPressed: () {
                                        setState(() {
                                          selectedDay = day;
                                          filterJobs();
                                        });
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: isSelected ? const Color(0xFFE7E4FB) : Colors.white,
                                        side: BorderSide(
                                          color: isSelected ? const Color(0xFFD1CAF5) : Colors.transparent
                                        ),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                      ),
                                      child: Text(
                                        day.toString(),
                                        style: TextStyle(
                                          color: isSelected ? Colors.deepPurpleAccent : Colors.black
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Expanded(
                          child: filteredJobs.isEmpty
                            ? const Center(child: Text("No jobs for the selected date"))
                            : ListView.separated(
                                itemCount: filteredJobs.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 10),
                                itemBuilder: (_, idx) {
                                  final job = filteredJobs[idx];
                                  return Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                      side: const BorderSide(color: Color(0xFFF2EFFB)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(job.productName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                                const SizedBox(height: 4),
                                                Text(job.location, style: const TextStyle(fontSize: 13, color: Colors.black45)),
                                                const SizedBox(height: 4),
                                                Row(
                                                  children: [
                                                    const Icon(Icons.access_time, color: Color(0xFFA9A7B6), size: 15),
                                                    const SizedBox(width: 4),
                                                    Text(
                                                      job.time,
                                                      style: const TextStyle(fontSize: 12, color: Color(0xFFA9A7B6)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(job.jobId, style: const TextStyle(fontSize: 12, color: Color(0xFFA9A7B6))),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFFF2EFFB),
                                                  foregroundColor: Colors.deepPurpleAccent,
                                                  minimumSize: const Size(85, 30),
                                                  elevation: 0,
                                                  padding: EdgeInsets.zero,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> JobDetail(ticketId: job.ticket_id!,token: widget.token,)));
                                                },
                                                child: const Text("View details", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
