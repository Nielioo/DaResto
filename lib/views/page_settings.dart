part of 'pages.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap.h20,
              Text(
                'Settings',
                style: Style.headline1,
              ),
              Gap.h20,
              ListTile(
                title: Text(
                  'Daily Restaurant Reminder',
                  style: Style.text1,
                ),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, provider, _) {
                    return Switch.adaptive(
                      value: provider.isScheduled,
                      onChanged: (value) async {
                        await provider.scheduledRestaurant(value);
                      },
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
