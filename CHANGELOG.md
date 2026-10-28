## 0.2.0

* Replaced all progress indicator with CustomPainter
* Renamed all old progress indicator to `<OldName>V1` under the custom import `colorful_progress_spinner_v1.dart`
* Progress indicator start at the top left and no longer at the top center

## 0.1.1

* Add `enabled` flag to enable/disable progress indicators
* Add `background` color to all progress indicators
* Add AnimatedListColor widget to animate between changing `List<Color>`s

## 0.1.0

### Added

* FixedGradientProgressIndicator (A gradient that stays in place and gets visible during animation)
* FixedLinearGradientProgressIndicator
* FixedCircularGradientProgressIndicator
* MovingGradientProgressIndicator (A gradient that moves around its child during animation)
* MovingLinearGradientProgressIndicator
* MovingCircularGradientProgressIndicator
* GradientColors (Some color presets)
