class PokemonStatSliderViewModel {
  static double calculateActiveSliderWidth(
    double pokemonStat,
    double fullStatSliderWidth,
  ) {
    const maxPokemonStat = 200.0;

    if (pokemonStat > maxPokemonStat) return fullStatSliderWidth;

    return fullStatSliderWidth * pokemonStat / maxPokemonStat;
  }
}
