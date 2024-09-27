import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SensorDataScreen extends StatelessWidget {
  const SensorDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IoT Sensor Data'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSensorDataSection(),
          ],
        ),
      ),
    );
  }

  // Sensor Data Section
  Widget _buildSensorDataSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Real-Time IoT Sensor Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                // Soil Moisture Gauge
                Expanded(
                  child: Column(
                    children: [
                      const Text('Soil Moisture', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Animate(
                        child: SfRadialGauge(axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 100, ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 50, color: Colors.red),
                            GaugeRange(startValue: 50, endValue: 80, color: Colors.orange),
                            GaugeRange(startValue: 80, endValue: 100, color: Colors.green),
                          ], pointers: <GaugePointer>[
                            NeedlePointer(value: 70)
                          ], annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: const Text('70%',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                                angle: 90,
                                positionFactor: 0.5)
                          ])
                        ]),
                      ).scale(),
                    ],
                  ),
                ),
                // pH Level Chart
                Expanded(
                  child: Column(
                    children: [
                      const Text('pH Level', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Animate(
                        child: SfRadialGauge(axes: <RadialAxis>[
                          RadialAxis(minimum: 0, maximum: 14, ranges: <GaugeRange>[
                            GaugeRange(startValue: 0, endValue: 6.5, color: Colors.red),
                            GaugeRange(startValue: 6.5, endValue: 7.5, color: Colors.green),
                            GaugeRange(startValue: 7.5, endValue: 14, color: Colors.red),
                          ], pointers: <GaugePointer>[
                            NeedlePointer(value: 6.8)
                          ], annotations: <GaugeAnnotation>[
                            GaugeAnnotation(
                                widget: const Text('6.8',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold)),
                                angle: 90,
                                positionFactor: 0.5)
                          ])
                        ]),
                      ).scale(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // NPK Level Chart
            const Text('NPK Levels', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Animate(
              child: SizedBox(
                height: 150,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 20),
                          FlSpot(1, 40),
                          FlSpot(2, 60),
                          FlSpot(3, 80),
                          FlSpot(4, 50),
                        ],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 4,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ).fadeIn(),
          ],
        ),
      ),
    );
  }
}
