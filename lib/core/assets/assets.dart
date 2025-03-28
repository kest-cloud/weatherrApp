// file directory
const pngDir = "assets/pngs";

//Dashboard
//png
final kWeatherImage = 'weatherImage'.png;

extension AssetExt on String {
  String get png {
    return "$pngDir/$this.png";
  }
}
