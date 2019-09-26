import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokedex/viewmodels/chain_view_model.dart';

import '../profile_theme.dart';
import '../resources.dart';
import 'data_box.dart';
import 'evolution_image.dart';

class PokemonEvolutionWidget extends StatelessWidget {
  final ChainViewModel chainViewModel;
  final ProfileTheme profileTheme;

  const PokemonEvolutionWidget({this.chainViewModel, this.profileTheme});

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        EvolutionImage(pokemonImage('${chainViewModel.id}')),
        SizedBox(height: ScreenUtil.getInstance().setHeight(8)),
        DataBox(
          subtitle: chainViewModel.formattedId,
          widgets: [
            DataBoxTitle(
              chainViewModel.name,
              color: profileTheme.dataBoxTitleColor,
            ),
          ],
        ),
      ],
    );
  }
}
