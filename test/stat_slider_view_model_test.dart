import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/viewmodels/stat_slider_view_model_test.dart';

void main() {
  group("Fixed tests", () {
    test(
      "Testing for 60.0 stat points and width 200.0",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(60.0, 200.0),
        equals(60.0),
      ),
    );
    test(
      "Testing for 60.0 stat points and width 300.0",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(60.0, 300.0),
        equals(90.0),
      ),
    );
    test(
      "Testing for 60.0 stat points and width 699.0",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(60.0, 699.0),
        equals(209.7),
      ),
    );
  });
}
