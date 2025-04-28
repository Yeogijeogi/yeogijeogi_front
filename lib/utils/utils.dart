/// 평균 속도 계산
double calAvgSpeed(double? distance, int? time) {
  if (time != null && time != 0 && distance != null) {
    return distance / time;
  } else {
    return 0;
  }
}
