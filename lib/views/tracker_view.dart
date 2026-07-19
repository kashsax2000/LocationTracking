import 'package:flutter/material.dart';
import 'package:tracker/constants/app_colors.dart';
import 'package:tracker/constants/string_constant.dart';
import 'package:tracker/services/app_router.dart';
import 'package:tracker/services/navigation_service.dart';
import 'package:tracker/viewmodels/tracker_viewmodel.dart';
import 'package:tracker/views/base_view.dart';

class TrackerView extends StatelessWidget {
  const TrackerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<TrackerViewmodel>(
      create: (_) => TrackerViewmodel(),
      builder: (context, viewmodel, child) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          centerTitle: true,
          title: Text(StringConstant.gpsTracking),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          viewmodel.isTracking
                              ? StringConstant.trackingStarted
                              : StringConstant.notTracking,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${StringConstant.batteryLevel}: ${viewmodel.battery}%',
                          style: TextStyle(color: AppColors.grey),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () async =>
                                await viewmodel.startTracking(),
                            icon: Icon(
                              viewmodel.isTracking
                                  ? Icons.stop
                                  : Icons.play_arrow,
                            ),
                            label: Text(
                              viewmodel.isTracking
                                  ? StringConstant.stopTracking
                                  : StringConstant.startTracking,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: viewmodel.isTracking
                                  ? AppColors.red
                                  : AppColors.deepPurple,
                              foregroundColor: AppColors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: GestureDetector(
              onTap: () => NavigationService.instance.navigateTo(
                AppRouter.locationHistory,
              ),

              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstant.showTrackingHistory,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.white,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
