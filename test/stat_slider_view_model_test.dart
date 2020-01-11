import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/viewmodels/pokemon_stat_slider_viewmodel.dart';

void main() {
  group("Assertions", () {
    test(
      "When zero stat points, active slider width is zero",
      () => expect(
        PokemonStatSliderViewModel.calculateActiveSliderWidth(0.0, 300.0),
        equals(0.0),
      ),
    );

    test(
      "When max stat points, Active slider width equals full width",
      () => expect(
        PokemonStatSliderViewModel.calculateActiveSliderWidth(200, 300.0),
        equals(300.0),
      ),
    );

    test(
      "When stat points bigger than max, Active slider width equals full width",
      () => expect(
        PokemonStatSliderViewModel.calculateActiveSliderWidth(600, 300.0),
        equals(300.0),
      ),
    );

    test(
      "When stat points 100 and full width 300, Active slider width equals 150",
      () => expect(
        PokemonStatSliderViewModel.calculateActiveSliderWidth(100, 300.0),
        equals(150.0),
      ),
    );

    test(
      "When stat points 60 and full width 300 Active slider width equals 90",
      () => expect(
        PokemonStatSliderViewModel.calculateActiveSliderWidth(60, 300.0),
        equals(90.0),
      ),
    );
  });
}
