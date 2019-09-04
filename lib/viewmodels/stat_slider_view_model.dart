class StatSliderViewModel {
  static double calculateActiveSliderWidth(double stat, double sliderWidth) {
    const maxPokemonStat = 200;

    return sliderWidth * stat / maxPokemonStat;
  }
}
