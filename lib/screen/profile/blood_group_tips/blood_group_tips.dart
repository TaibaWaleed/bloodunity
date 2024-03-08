import 'package:bloodunity/contants/contants.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class BloodTipScreen extends StatelessWidget {
  const BloodTipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blood Tips',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Blood Tips:',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.bloodtype,
                size: 40,
                color: Colors.red,
              ),
            ),
            sizedbox(),
            _buildTipCard(context,
                'Maintain a Healthy Diet: Follow a balanced diet rich in fruits, vegetables, lean proteins, and whole grain'),
            _buildTipCard(context,
                ' Hydrate Well: Drink plenty of water to stay hydrated which is essential for overall health'),
            _buildTipCard(context,
                'Exercise Regularly: Engage in physical activity to maintain a healthy weight and promote cardiovascular health'),
            _buildTipCard(context,
                ' Avoid Smoking and Excessive Alcohol: Both smoking and excessive alcohol consumption can negatively impact your health'),
            _buildTipCard(context,
                ' Manage Stress: Practice stress-reducing activities such as meditation, yoga, or deep breathing exercises'),
            _buildTipCard(context,
                ' Regular Health Check-ups: Schedule regular check-ups with your healthcare provider for preventive care'),
            _buildTipCard(context,
                ' Know Your Family History: Understand your familys medical history, as some health conditions may have a genetic component.'),
            _buildTipCard(context,
                ' Manage Stress: Practice stress-reducing activities such as meditation, yoga, or deep breathing exercises'),
            _buildTipCard(context,
                ' Regular Health Check-ups: Schedule regular check-ups with your healthcare provider for preventive care'),
            _buildTipCard(context,
                ' Blood Type and Pregnancy: Understand the implications of blood type during pregnancy, especially in terms of Rh factor compatibility'),
            _buildTipCard(context,
                ' Be Informed for Emergency Situations: Make sure your blood type information is accessible in case of emergencies'),
            _buildTipCard(context,
                ' Sun Safety: People with certain blood types may be more susceptible to certain infections; practice good hygiene and sun safety'),
            _buildTipCard(context,
                ' Immunizations: Stay up-to-date on vaccinations to protect against preventable diseases'),
            _buildTipCard(context,
                ' Be Mindful of Iron Levels: Individuals with certain blood types may need to monitor iron levels; consult with a healthcare professional'),
            _buildTipCard(context,
                'Eye Health: Certain blood types may be associated with a higher risk of certain eye conditions'),
            _buildTipCard(context,
                ' Bone Health: Pay attention to calcium and vitamin D intake for strong bones'),
            _buildTipCard(context,
                ' Heart Health: Adopt heart-healthy habits to reduce the risk of cardiovascular diseases'),
            _buildTipCard(context,
                ' Liver Health: Maintain a liver-friendly lifestyle, including limiting alcohol and avoiding excessive medication use'),
            _buildTipCard(context,
                ' Consult with Healthcare Professionals: When in doubt, consult with healthcare professionals for personalized advice based on your health history and blood type'),
            _buildTipCard(context,
                ' Regular Health Check-ups: Schedule regular check-ups with your healthcare provider for preventive care'),
          ],
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String tip) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text(
              tip,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            trailing: IconButton(
              onPressed: () {
                // Use the 'tip' variable for sharing the content
                Share.share(tip);
              },
              icon: Icon(Icons.share),
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
