import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/viewmodels/stat_slider_view_model.dart';

void main() {
  group("Assertions", () {
    test(
      "When zero stat points, active slider width is zero",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(0.0, 300.0),
        equals(0.0),
      ),
    );

    test(
      "When max stat points, Active slider width equals full width",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(200, 300.0),
        equals(300.0),
      ),
    );

    test(
      "When stat points bigger than max, Active slider width equals full width",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(600, 300.0),
        equals(300.0),
      ),
    );

    test(
      "When stat points 100 and full width 300, Active slider width equals 150",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(100, 300.0),
        equals(150.0),
      ),
    );

    test(
      "When stat points 60 and full width 300 Active slider width equals 90",
      () => expect(
        StatSliderViewModel.calculateActiveSliderWidth(60, 300.0),
        equals(90.0),
      ),
    );
  });
}
