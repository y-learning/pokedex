class StatSliderViewModel {
  static double calculateActiveSliderWidth(double stat, double sliderWidth) {
    const maxPokemonStat = 200.0;

    if (stat > maxPokemonStat) return sliderWidth;

    return sliderWidth * stat / maxPokemonStat;
  }
}
