import 'package:flutter/material.dart';
import 'dart:math';

class ItemScrollPhysics extends ScrollPhysics {
  /// Creates physics for snapping to item.
  /// Based on PageScrollPhysics
  final double? itemHeight;
  final double targetPixelsLimit;

  const ItemScrollPhysics({
    ScrollPhysics? parent,
    this.itemHeight,
    this.targetPixelsLimit = 3.0,
  })  : assert(itemHeight != null && itemHeight > 0),
        super(parent: parent);

  @override
  ItemScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return ItemScrollPhysics(
        parent: buildParent(ancestor), itemHeight: itemHeight);
  }

  double _getItem(ScrollPosition position) {
    double maxScrollItem =
        (position.maxScrollExtent / itemHeight!).floorToDouble();
    return min(max(0, position.pixels / itemHeight!), maxScrollItem);
  }

  double _getPixels(ScrollPosition position, double item) {
    return item * itemHeight!;
  }

  double _getTargetPixels(
      ScrollPosition position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity) {
      item -= targetPixelsLimit;
    } else if (velocity > tolerance.velocity) {
      item += targetPixelsLimit;
    }
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a item boundary.
//    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
//        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
//      return super.createBallisticSimulation(position, velocity);
    Tolerance tolerance = this.tolerance;
    final double target =
        _getTargetPixels(position as ScrollPosition, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

typedef SelectedIndexCallback = void Function(int);
typedef YearPickerCallback = void Function(int);
typedef TextStyleSelector = TextStyle Function(
    int index, int selectedIndex, int length);

class TimePickerSpinner extends StatefulWidget {
  final DateTime? time;
  final TextStyleSelector? textStyleSelector;
  final double? itemHeight;
  final double? itemWidth;
  final YearPickerCallback? onYearChange;
  final int minYear;
  final int maxYear;
  final int? initialYear;

  const TimePickerSpinner({
    Key? key,
    this.time,
    this.itemHeight,
    this.itemWidth,
    required this.textStyleSelector,
    this.onYearChange,
    required this.minYear,
    required this.maxYear,
    this.initialYear,
  }) : super(key: key);

  @override
  State<TimePickerSpinner> createState() => _TimePickerSpinnerState();
}

class _TimePickerSpinnerState extends State<TimePickerSpinner> {
  ScrollController yearController = ScrollController();
  int currentSelectedYearIndex = -1;
  DateTime? currentTime;
  bool isYearScrolling = false;

  final int _shift = 2;

  /// default settings
  double defaultItemHeight = 60;
  double defaultItemWidth = 75;

  int _getYearCount() {
    return widget.maxYear - widget.minYear + 1;
  }

  double? _getItemHeight() {
    return widget.itemHeight ?? defaultItemHeight;
  }

  double? _getItemWidth() {
    return widget.itemWidth ?? defaultItemWidth;
  }

  int getYear() {
    return widget.maxYear - currentSelectedYearIndex + _shift;
  }

  @override
  void initState() {
    currentSelectedYearIndex = _shift;

    if (widget.onYearChange != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => widget.onYearChange!(getYear()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> contents = [
      SizedBox(
        width: _getItemWidth(),
        height: _getItemHeight()! * 5,
        child: yearSpinner(
          yearController,
          _getYearCount(),
          currentSelectedYearIndex,
          isYearScrolling,
          (index) {
            currentSelectedYearIndex = index;
            isYearScrolling = true;
          },
          () => isYearScrolling = false,
        ),
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: contents,
    );
  }

  Widget yearSpinner(
      ScrollController controller,
      int max,
      int selectedIndex,
      bool isScrolling,
      SelectedIndexCallback onUpdateSelectedIndex,
      VoidCallback onScrollEnd) {
    /// wrapping the spinner with stack and add container above it when it's scrolling
    /// this thing is to prevent an error causing by some weird stuff like this
    /// flutter: Another exception was thrown: 'package:flutter/src/widgets/scrollable.dart': Failed assertion: line 469 pos 12: '_hold == null || _drag == null': is not true.
    /// maybe later we can find out why this error is happening
    Widget spinner = NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowIndicator();
        return true;
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is UserScrollNotification) {
            if (scrollNotification.direction.toString() ==
                'ScrollDirection.idle') {
              setState(() {
                onScrollEnd();
                if (widget.onYearChange != null) {
                  widget.onYearChange!(getYear());
                }
              });
            }
          } else if (scrollNotification is ScrollUpdateNotification) {
            setState(() {
              onUpdateSelectedIndex(
                  (controller.offset / _getItemHeight()!).round() + 2);
            });
          }
          return true;
        },
        child: ListView.builder(
          itemBuilder: (context, index) {
            String text = '';
            if (index > 1 && (index < (max + _shift))) {
              text = (widget.maxYear - ((index - _shift) % max)).toString();
            }
            return SizedBox(
              height: _getItemHeight(),
              child: Text(
                text,
                style: widget.textStyleSelector != null
                    ? widget.textStyleSelector!(index, selectedIndex, max)
                    : null,
              ),
            );
          },
          controller: controller,
          itemCount: max + _shift * 2,
          physics: ItemScrollPhysics(itemHeight: _getItemHeight()),
          padding: EdgeInsets.zero,
        ),
      ),
    );

    return Stack(
      children: <Widget>[
        Positioned.fill(child: spinner),
        isScrolling
            ? Positioned.fill(
                child: Container(
                color: Colors.black.withOpacity(0),
              ))
            : Container()
      ],
    );
  }
}
