## 0.2.2

// * Added circular progress indicator for 'fixed' and 'moving' gradients
* Fixed a function that was accidentally left in testing

## 0.2.1

* Added circular progress indicator for 'fixed' and 'moving' gradients
* Fixed a value that was accidentally left in testing

## 0.2.0

* Update ReadMe and link to example showcase

** BREAKING CHANGES**
* Replaced all progress indicator with CustomPainter
* Renamed all old progress indicator to `<OldName>V1` under the custom import `colorful_progress_spinner_v1.dart`
* Rectangular progress indicator start at the top left, while circular ones at the top center

## 0.1.1

* Added `enabled` flag to enable/disable progress indicators
* Added `background` color to all progress indicators
* Added AnimatedListColor widget to animate between changing `List<Color>`s

## 0.1.0

### Added

* FixedGradientProgressIndicator (A gradient that stays in place and gets visible during animation)
* FixedLinearGradientProgressIndicator
* FixedCircularGradientProgressIndicator
* MovingGradientProgressIndicator (A gradient that moves around its child during animation)
* MovingLinearGradientProgressIndicator
* MovingCircularGradientProgressIndicator
* GradientColors (Some color presets)
