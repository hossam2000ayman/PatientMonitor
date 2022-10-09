
import 'dart:math' as math;

import 'package:complex/complex.dart';
import 'package:complex/fastmath.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/band_pass_transform.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/band_stop_transform.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/cascade.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/direct_form.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/high_pass_transform.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/layout_base.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/low_pass_transform.dart';
import 'package:patient_monitor_nullsafety/iirjdart/src/math_supplement.dart';

class _AnalogLowPass extends LayoutBase {
  int nPoles;

  _AnalogLowPass(int _nPoles):
        nPoles = _nPoles,
        super(_nPoles);

  void design(double stopBandDb) {
    reset();

    double eps = math.sqrt(1.0 / (math.exp(stopBandDb * 0.1 * MathSupplement.doubleLn10) - 1));
    double v0 = MathSupplement.asinh(1 / eps) / nPoles;
    double sinhV0 = -sinh(v0);
    double coshV0 = cosh(v0);
    double fn = math.pi / (2 * nPoles);

    int k = 1;
    for (int i = nPoles ~/ 2; --i >= 0; k += 2) {
      double a = sinhV0 * math.cos((k - nPoles) * fn);
      double b = coshV0 * math.sin((k - nPoles) * fn);
      double d2 = a * a + b * b;
      double im = 1 / math.cos(k * fn);
      Complex pole = Complex(a / d2, b / d2);
      Complex zero = Complex(0.0, im);
      addPoleZeroConjugatePairs(pole, zero);
    }

    if ((nPoles & 1) == 1) {
      add( Complex(1 / sinhV0),  Complex(double.infinity));
    }
    setNormal(0, 1);
  }
}

/// Create a ChebyshevII filter.
///
/// Example:
/// ```dart
///   ChebyshevII chebyshev = new ChebyshevII();
///   chebyshev.bandPass(2,250,50,5);
/// ```
class ChebyshevII extends Cascade {
  /// ChebyshevI Lowpass filter with custom topology
  ///
  /// Param:
  /// * order - The order of the filter
  /// * sampleRate - The sampling rate of the system
  /// * cutoffFrequency - The cutoff frequency
  /// * rippleDb - pass-band ripple in decibel sensible value: 1dB
  /// * directFormType -The filter topology. Default direct_form_II
  void lowPass(
      int order,
      double sampleRate,
      double cutoffFrequency,
      double rippleDb,
      [int directFormType = DirectFormAbstract.direct_form_II]
      ) {
    _AnalogLowPass analogProto = _AnalogLowPass(order);
    analogProto.design(rippleDb);
    LayoutBase digitalProto = LayoutBase(order);
    LowPassTransform(cutoffFrequency / sampleRate, digitalProto, analogProto);
    setLayout(digitalProto, directFormType);
  }

  /// ChebyshevI Lowpass filter and custom filter topology
  ///
  /// Param:
  /// * order - The order of the filter
  /// * sampleRate - The sampling rate of the system
  /// * cutoffFrequency - The cutoff frequency
  /// * rippleDb - pass-band ripple in decibel sensible value: 1dB
  /// * directFormType - The filter topology. Default direct_form_II
  void highPass(
      int order,
      double sampleRate,
      double cutoffFrequency,
      double rippleDb,
      [int directFormType = DirectFormAbstract.direct_form_II]
      ) {
    _AnalogLowPass analogProto =  _AnalogLowPass(order);
    analogProto.design(rippleDb);
    LayoutBase digitalProto =  LayoutBase(order);
    HighPassTransform(cutoffFrequency / sampleRate, digitalProto, analogProto);
    setLayout(digitalProto, directFormType);
  }

  /// Bandstop filter with custom topology
  ///
  /// Param:
  /// * order - Filter order (actual order is twice)
  /// * sampleRate - Sampling rate of the system
  /// * centerFrequency - Center frequency
  /// * widthFrequency - Width of the notch
  /// * rippleDb - pass-band ripple in decibel sensible value: 1dB
  /// * directFormType - The filter topology. Default direct_form_II
  void bandStop(
      int order,
      double sampleRate,
      double centerFrequency,
      double widthFrequency,
      double rippleDb,
      [int directFormType = DirectFormAbstract.direct_form_II]
      ) {
    _AnalogLowPass analogProto =  _AnalogLowPass(order);
    analogProto.design(rippleDb);
    LayoutBase digitalProto =  LayoutBase(order * 2);
    BandStopTransform(centerFrequency / sampleRate, widthFrequency / sampleRate, digitalProto, analogProto);
    setLayout(digitalProto, directFormType);
  }

  /// Bandpass filter with custom topology
  ///
  /// Param:
  /// * order - Filter order
  /// * sampleRate -  Sampling rate
  /// * centerFrequency - Center frequency
  /// * widthFrequency - Width of the notch
  /// * rippleDb - pass-band ripple in decibel sensible value: 1dB
  /// * directFormType - The filter topology. Default direct_form_II
  void bandPass(
      int order,
      double sampleRate,
      double centerFrequency,
      double widthFrequency,
      double rippleDb,
      [int directFormType = DirectFormAbstract.direct_form_II]
      ) {
    _AnalogLowPass analogProto =  _AnalogLowPass(order);
    analogProto.design(rippleDb);
    LayoutBase digitalProto =  LayoutBase(order * 2);
    BandPassTransform(centerFrequency / sampleRate, widthFrequency / sampleRate, digitalProto, analogProto);
    setLayout(digitalProto, directFormType);
  }
}