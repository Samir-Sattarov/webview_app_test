import 'package:sim_data/sim_data.dart';

class SimService {
static Future<String> getCountryCode() async {
    SimData simData = await SimDataPlugin.getSimData();

    final sim = simData.cards.first;

    print('Country ISO: ${sim.countryCode}');

    return sim.countryCode;
  }
}
