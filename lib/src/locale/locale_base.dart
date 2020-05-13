import 'package:international_system_of_units/src/unit_system.dart';
import 'package:intl/intl.dart';

abstract class LocaleBase<Unit> {
  final NumberFormat _numberFormat;

  LocaleBase(this._numberFormat);

  Unit unit(
    UnitSystem unitSystem, {
    Unit toInternationalUnit,
    Unit toImperialUnit,
    Unit toUsUnit,
  }) {
    switch (unitSystem) {
      case UnitSystem.imperial:
        return toImperialUnit;
      case UnitSystem.us:
        return toUsUnit;
      default:
        return toInternationalUnit;
    }
  }

  String localeUnit(
    final num value,
    UnitSystem unitSystem,
    Unit unit, {
    bool shortUnit = true,
  });

  num localeNumber(
    num value,
    UnitSystem unitSystem, {
    Unit toInternationalUnit,
    Unit toImperialUnit,
    Unit toUsUnit,
  }) {
    switch (unitSystem) {
      case UnitSystem.imperial:
        return localeNumberBase(value, toImperialUnit);
      case UnitSystem.us:
        return localeNumberBase(value, toUsUnit);
      default:
        return localeNumberBase(value, toInternationalUnit);
    }
  }

  num localeNumberBase(num value, Unit unit);

  String locale(
    num value,
    UnitSystem unitSystem, {
    bool withUnit = true,
    bool shortUnit = true,
    NumberFormat customNumberFormat,
    Unit toInternationalUnit,
    Unit toImperialUnit,
    Unit toUsUnit,
  }) {
    final _number = localeNumber(
      value,
      unitSystem,
      toInternationalUnit: toInternationalUnit,
      toImperialUnit: toImperialUnit,
      toUsUnit: toUsUnit,
    );
    final _unit = unit(
      unitSystem,
      toInternationalUnit: toInternationalUnit,
      toImperialUnit: toImperialUnit,
      toUsUnit: toUsUnit,
    );
    final sb =
        StringBuffer((customNumberFormat ?? _numberFormat).format(_number));
    if (withUnit) {
      sb.write(
          ' ${localeUnit(_number, unitSystem, _unit, shortUnit: shortUnit)}');
    }
    return sb.toString();
  }
}