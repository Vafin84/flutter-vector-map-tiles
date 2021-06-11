import 'package:flutter/widgets.dart';
import 'package:vector_tile_renderer/vector_tile_renderer.dart';

import '../tile_identity.dart';
import '../cache/caches.dart';
import '../vector_tile_provider.dart';
import 'grid_vector_tile.dart';
import 'tile_model.dart';

class TileWidgets {
  Map<TileIdentity, Widget> _idToWidget = {};
  final ZoomScaleFunction _zoomScaleFunction;
  final ZoomFunction _zoomFunction;
  final Theme _theme;
  final Caches _caches;

  TileWidgets(VectorTileProvider tileProvider, this._zoomScaleFunction,
      this._zoomFunction, this._theme, this._caches);

  void update(List<TileIdentity> tiles) {
    if (tiles.isEmpty) {
      return;
    }
    Map<TileIdentity, Widget> idToWidget = {};
    tiles.forEach((tile) {
      idToWidget[tile] = _idToWidget[tile] ?? _createWidget(tile);
    });
    _idToWidget = idToWidget;
  }

  Map<TileIdentity, Widget> get all => _idToWidget;

  Widget _createWidget(TileIdentity tile) {
    return AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(seconds: 2),
        child: GridVectorTile(
            key: Key('GridTile_${tile.z}_${tile.x}_${tile.y}'),
            tileIdentity: tile,
            caches: _caches,
            zoomScaleFunction: _zoomScaleFunction,
            zoomFunction: _zoomFunction,
            theme: _theme));
  }
}