/// 평균 속도 계산
double calAvgSpeed(double? distance, int? time) {
  if (time != null && time != 0 && distance != null) {
    return toFixedDigits(distance / time);
  } else {
    return 0;
  }
}

/// 소수점 자리를 지정해서 반환하는 함수
double toFixedDigits(double value, {int digit = 2}) {
  return double.parse(value.toStringAsFixed(digit));
}
