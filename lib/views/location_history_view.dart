import 'package:flutter/material.dart';
import 'package:tracker/constants/app_colors.dart';
import 'package:tracker/constants/string_constant.dart';
import 'package:tracker/viewmodels/location_history_viewmodel.dart';
import 'package:tracker/views/base_view.dart';

class LocationHistoryView extends StatelessWidget {
  const LocationHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LocationHistoryViewmodel>(
      create: (_) => LocationHistoryViewmodel(),
      model: (viewmodel) async => await viewmodel.init(),
      builder: (context, viewmodel, child) {
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(StringConstant.trackingHistory),
          ),
          body: viewmodel.locationData.isEmpty
              ? Center(
                  child: Text(
                    StringConstant.noTrackingData,
                    style: TextStyle(fontSize: 16, color: AppColors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewmodel.locationData.length,
                  itemBuilder: (context, index) {
                    final data = viewmodel.locationData[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow(
                              StringConstant.longitude,
                              data.longitute.toString(),
                            ),
                            _infoRow(
                              StringConstant.latitude,
                              data.latitude.toString(),
                            ),
                            _infoRow(
                              StringConstant.timestamp,
                              data.timestamp.toString(),
                            ),
                            _infoRow(
                              StringConstant.accuracy,
                              data.accuracy.toString(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value.toString())),
        ],
      ),
    );
  }
}
