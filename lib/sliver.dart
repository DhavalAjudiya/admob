import 'package:extended_sliver/extended_sliver.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class animation extends StatefulWidget {
  const animation({Key? key}) : super(key: key);

  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> with SingleTickerProviderStateMixin {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          TransitionAppBar(
            extent: 32.5.h,
            text: "LAISSE-TOl GUIDER",
            avatar: Container(
              height: 7.h,
              width: 19.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                image: const DecorationImage(
                  image: NetworkImage(
                    "https://i.pinimg.com/474x/e5/0c/1d/e50c1d3835400d1a1cd4363eae694105.jpg",
                  ),
                ),
              ),
            ),
            subtext: "Marion",
            title: Container(
              height: 4.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.black),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "920/1400",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: searchAndScanner(),
          ),
          SliverPinnedPersistentHeader(
            delegate: MySliverPinnedPersistentHeaderDelegate(
              minExtentProtoType: _calendarAndText(),
              maxExtentProtoType: Container(color: Colors.red, height: 200),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _sliverList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  searchAndScanner() {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.w, left: 3.w, right: 3.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 5.h,
                  width: 76.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Chercher un aliment",
                      hintStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Image.asset("assets/image/search.png", height: 20),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  )),
              Container(
                height: 5.h,
                width: 11.5.w,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Image.asset(
                    "assets/image/scanner.png",
                    fit: BoxFit.cover,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(1, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 2.5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Progressoin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
              Text("Parametres", style: TextStyle(color: Colors.black26, fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }

  _calendarAndText() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black54,
            offset: Offset(1, 2),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 0, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              availableGestures: AvailableGestures.none,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              focusedDay: _focusedDay,
              headerVisible: false,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              // rangeStartDay: _rangeStart,
              // rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black.withOpacity(
                    0.5,
                  ),
                ),
                weekendStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Colors.black.withOpacity(
                    0.5,
                  ),
                ),
              ),
              calendarStyle: CalendarStyle(
                todayTextStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                rangeStartDecoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                rangeEndDecoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                rangeHighlightColor: Colors.black.withOpacity(0.3),
                defaultTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                weekendTextStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                todayDecoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _rangeSelectionMode = RangeSelectionMode.toggledOff;
                  });
                }
              },
              // onRangeSelected: (start, end, focusedDay) {
              //   setState(() {
              //     _selectedDay = null;
              //     _focusedDay = focusedDay;
              //     _rangeStart = start;
              //     _rangeEnd = end;
              //     _rangeSelectionMode = RangeSelectionMode.toggledOn;
              //   });
              // },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(
              height: 1.6.h,
            ),
          ],
        ),
      ),
    );
  }

  // _tableCalendar() {
  //   return TableCalendar(
  //     firstDay: kFirstDay,
  //     lastDay: kLastDay,
  //     focusedDay: _focusedDay,
  //     selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  //     rangeStartDay: _rangeStart,
  //     rangeEndDay: _rangeEnd,
  //     calendarFormat: _calendarFormat,
  //     rangeSelectionMode: _rangeSelectionMode,
  //   );
  // }

  _sliverList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _itemContainer(
            itemImage: "assets/image/pain.png",
            text: "Pain au Chocolat ",
            subText: "250",
            subTextS: "kcal",
            subText1: "250",
            subText1S: "gm",
            markColor: Colors.green,
            icon: Icons.favorite,
          ),
          _itemContainer(
            itemImage: "assets/image/pain1.png",
            text: "Pain baguette",
            subText: "87",
            subTextS: "kcal",
            subText1: "100",
            subText1S: "gm",
            markColor: Colors.green,
            icon: Icons.favorite,
          ),
          SizedBox(height: 2.h),
          Text(
            "Liquides",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 2.h),
          _liquidesContainer(),
          SizedBox(height: 3.h),
          Text(
            "Activites",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 2.h),
          _itemContainer(
            itemImage: "assets/image/pain1.png",
            text: "Course a piad",
            subText: "545",
            subTextS: "kcal",
            subText1: "",
            subText1S: "",
            markColor: Colors.white,
            icon: Icons.arrow_forward_ios_rounded,
          ),
        ],
      ),
    );
  }

  _itemContainer({
    required String itemImage,
    required String text,
    required String subText,
    required String subTextS,
    required String subText1,
    required String subText1S,
    required IconData icon,
    Color? markColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Container(
        height: 9.h,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: SizedBox(
                height: 8.5.h,
                width: 20.w,
                child: Image.asset(itemImage),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5.sp,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 1.w,
                      backgroundColor: Colors.red,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      subText,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      subTextS,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    CircleAvatar(
                      radius: 1.w,
                      backgroundColor: markColor,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      subText1,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      subText1S,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Icon(icon),
            SizedBox(width: 3.w),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(1, 2),
              blurRadius: 8,
            ),
          ],
        ),
      ),
    );
  }

  _liquidesContainer() {
    return Container(
      height: 14.h,
      width: 100.w,
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 5.h,
                  width: 86.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: glassList.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("sdfsfsf${glassList.length}");
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (!glassList[index]["isSelected"]) {
                              glassList[index]["isSelected"] = true;
                            } else {
                              glassList[index]["isSelected"] = false;
                            }
                          });
                        },
                        // child: Stack(
                        //   children: [
                        //     Container(
                        //       height: 40,
                        //       width: 500,
                        //       color: Colors.green,
                        //     )
                        //         ? Positioned(
                        //             top: 0.7.h,
                        //             left: 0.8.w,
                        //             child: const Icon(Icons.add, color: Colors.white),
                        //           )
                        //         : SizedBox(),
                        //   ],
                        // ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 2.7.w,
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "500/",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  "2000ml",
                  style: TextStyle(
                    color: Colors.white60,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
                const Spacer(),
                Text(
                  "25%",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class TransitionAppBar extends StatelessWidget {
  final Widget? avatar;
  final Widget? title;
  final Widget? title1;
  final double? extent;
  final String? text;
  final String? subtext;

  const TransitionAppBar({
    Key? key,
    this.avatar,
    this.title,
    this.title1,
    this.extent = 250,
    this.text,
    this.subtext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          subtext: subtext, text: text, avatar: avatar!, title: title!, title1: title1, extent: extent! > 200 ? extent! : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  ///image
  final _avatarMarginTween = EdgeInsetsTween(begin: EdgeInsets.only(bottom: 14.h, left: 40.w), end: EdgeInsets.only(bottom: 4.5.h, left: 4.w));
  final _avatarAlignTween = AlignmentTween(
    begin: Alignment.bottomLeft,
    end: Alignment.bottomLeft,
  );

  ///text
  final _avatarMarginTextTween = EdgeInsetsTween(
    begin: EdgeInsets.only(bottom: 14.h),
    end: EdgeInsets.only(bottom: 15.h),
  );
  final _avatarAlignTextTween = AlignmentTween(
    begin: Alignment.center,
    end: Alignment.topCenter,
  );

  ///sub text
  final _avatarMarginSubTextTween = EdgeInsetsTween(begin: EdgeInsets.only(top: 10.8.h), end: EdgeInsets.only(left: 25.w, bottom: 2.h));
  final _avatarAlignSubTextTween = AlignmentTween(
    begin: Alignment.center,
    end: Alignment.center,
  );

  /// container
  final _avatarMarginContainerTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 20.5.h, left: 5.w, right: 5.w), end: EdgeInsets.only(top: 8.h, right: 5.w, left: 25.w, bottom: 2.h));
  final _avatarAlignContainerTween = AlignmentTween(
    begin: Alignment.center,
    end: Alignment.center,
  );

  final Widget? avatar;
  final Widget? title;
  final Widget? title1;
  final double? extent;
  final String? text;
  final String? subtext;

  _TransitionAppBarDelegate({
    this.text,
    this.avatar,
    this.title,
    this.title1,
    this.extent = 250,
    this.subtext,
  })  : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 50 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;

    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);
    final avatarTextMargin = _avatarMarginTextTween.lerp(progress);
    final avatarTextAlign = _avatarAlignTextTween.lerp(progress);
    final avatarSubTextMargin = _avatarMarginSubTextTween.lerp(progress);
    final avatarSubTextAlign = _avatarAlignSubTextTween.lerp(progress);
    final avatarContainerMargin = _avatarMarginContainerTween.lerp(progress);
    final avatarContainerAlign = _avatarAlignContainerTween.lerp(progress);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: shrinkOffset * 1,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.white,
        ),
        Padding(
          padding: avatarTextMargin,
          child: Align(
            alignment: avatarTextAlign,
            child: Text(text!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: avatar,
          ),
        ),
        Padding(
          padding: avatarSubTextMargin,
          child: Align(
            alignment: avatarSubTextAlign,
            child: Text(
              subtext!,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        // progress == 1
        //     ? Padding(
        //         padding: avatarContainerMargin,
        //         child: Align(
        //           alignment: avatarContainerAlign,
        //           child: title1,
        //         ),
        //       )
        //     :
        Padding(
          padding: avatarContainerMargin,
          child: Align(
            alignment: avatarContainerAlign,
            child: title,
          ),
        ),
        progress == 1
            ? Positioned(
                top: 85.h,
                right: 4.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 5.5.w,
                      child: Image.asset(
                        "assets/image/scanner.png",
                        color: Colors.white,
                        height: 2.5.h,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 8.w,
                      child: Image.asset(
                        "assets/image/search.png",
                        color: Colors.white,
                        height: 4.h,
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  @override
  double get maxExtent => extent!;

  @override
  double get minExtent => (maxExtent * 58) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}

class MySliverPinnedPersistentHeaderDelegate extends SliverPinnedPersistentHeaderDelegate {
  MySliverPinnedPersistentHeaderDelegate({
    required Widget minExtentProtoType,
    required Widget maxExtentProtoType,
  }) : super(
          minExtentProtoType: minExtentProtoType,
          maxExtentProtoType: maxExtentProtoType,
        );

  @override
  Widget build(BuildContext context, double shrinkOffset, double? minExtent, double maxExtent, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        // Positioned(
        //   child: maxExtentProtoType,
        //   top: -shrinkOffset,
        //   bottom: 0,
        //   left: 0,
        //   right: 0,
        // ),
        Positioned(
          child: minExtentProtoType,
          top: 0,
          left: 0,
          right: 0,
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPinnedPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

List<Map> glassList = [
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
  {
    "img": "assets/image/glass.png",
    "isSelected": false,
  },
];
