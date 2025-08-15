import 'package:flutter/material.dart';

class JobDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for the demo; replace with your dynamic data as needed.
    final job = {
      'title': 'Installation and Maintenance',
      'id': '#jobid221334',
      'datetime': '22Aug 21, 12:00 PM',
      'name': 'Aaron Williams',
      'address': '121, Random street, Random area, Random city',
      'serviceNotes': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat.',
      'remarks': '',
      'attachments': '',
    };

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black54),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(job['id']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                SizedBox(width: 8),
                Icon(Icons.calendar_today_outlined, color: Color(0xFFA9A7B6), size: 15),
                SizedBox(width: 3),
                Text(job['datetime']!, style: TextStyle(fontSize: 13, color: Color(0xFFA9A7B6))),
              ],
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFF3EFFA), borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  // Profile pic placeholder (round color avatar). Omit face details.
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.purple.shade200,
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(job['name']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.deepPurple, size: 15),
                          SizedBox(width: 4),
                          Text(job['address']!, style: TextStyle(fontSize: 12, color: Color(0xFFA9A7B6))),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Color(0xFFF6F5FA), borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Installation", style: TextStyle(color: Color(0xFFA9A7B6), fontSize: 13)),
                      SizedBox(height: 2),
                      Text(job['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  Spacer(),
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 6)],
                    ),
                    child: Center(
                      child: Icon(Icons.play_circle_fill, color: Colors.black54, size: 34),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Color(0xFFF6F5FA), borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Service Notes", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  SizedBox(height: 8),
                  Text(job['serviceNotes']!, style: TextStyle(fontSize: 13, color: Color(0xFFA9A7B6))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: Color(0xFFF6F5FA), borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.edit, color: Colors.deepPurple),
                title: Text("Technician Remarks", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFFA9A7B6)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(color: Color(0xFFF6F5FA), borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: ListTile(
                leading: Icon(Icons.attach_file, color: Colors.deepPurple),
                title: Text("Attachments", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xFFA9A7B6)),
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: "Scheduled",
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(9), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Color(0xFFE7E4FB),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                    items: ["Scheduled"].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFD0C6F8),
                      foregroundColor: Colors.deepPurpleAccent,
                      padding: EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: Text("Close Ticket", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
