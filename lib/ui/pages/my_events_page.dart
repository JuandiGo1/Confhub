import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confhub/ui/widgets/timeline/event_timeline_widget.dart';
import 'package:confhub/ui/widgets/timeline/day_header.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';
import 'package:confhub/domain/entities/event.dart';

class MyEventsPage extends StatefulWidget {
  const MyEventsPage({super.key});

  @override
  State<MyEventsPage> createState() => _MyEventsPageState();
}

class _MyEventsPageState extends State<MyEventsPage> {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = _fetchEvents();
  }

  Future<List<Event>> _fetchEvents() async {
    return _mockEvents(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return _MyEventsPageContent(events: snapshot.data!);
      },
    );
  }
}
class _MyEventsPageContent extends StatefulWidget {
  final List<Event> events;

  const _MyEventsPageContent({required this.events});

  @override
  State<_MyEventsPageContent> createState() => __MyEventsPageContentState();
}

class __MyEventsPageContentState extends State<_MyEventsPageContent> {
  late ScrollController _scrollController;
  String _currentMonthYear = "";

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _currentMonthYear = widget.events.isNotEmpty
        ? DateFormat('MMMM yyyy').format(widget.events.first.dateTime)
        : DateFormat('MMMM yyyy').format(DateTime.now());

    // Listen to scroll changes
    _scrollController.addListener(_updateMonthOnScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateMonthOnScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateMonthOnScroll() {
    // Find the first visible item's month
    final firstVisibleIndex = (_scrollController.position.pixels / 200).floor();
    if (firstVisibleIndex >= 0 && firstVisibleIndex < widget.events.length) {
      final newMonthYear = DateFormat('MMMM yyyy')
          .format(widget.events[firstVisibleIndex].dateTime);
      if (newMonthYear != _currentMonthYear) {
        setState(() {
          _currentMonthYear = newMonthYear;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentMonthYear,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          controller: _scrollController,  // Attach the scroll controller
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            final event = widget.events[index];
            final eventDate = event.dateTime;
            final isToday = DateUtils.isSameDay(DateTime.now(), eventDate);
            final isFirstOfDay = index == 0 ||
                !DateUtils.isSameDay(eventDate, widget.events[index - 1].dateTime);
            final isLastOfDay = index == widget.events.length - 1 ||
                !DateUtils.isSameDay(eventDate, widget.events[index + 1].dateTime);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isFirstOfDay)
                  DayHeader(eventDate: eventDate, isToday: isToday),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTimelineWidget(
                      isFirst: isFirstOfDay,
                      isLast: isLastOfDay,
                      isToday: isToday,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: EventCard(event: event, isToday: isToday),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

 /// A simple mock of events with different dates.
  List<Event> _mockEvents() {
    return [
      Event(
        title: "Test",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 10,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Data",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 10,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Mock",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 20,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ), Event(
        title: "Test",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: -5)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 10,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Data",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: 1)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 10,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Mock",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: -1)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 20,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Mock",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: -5)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 20,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Mock",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: -10)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 20,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      Event(
        title: "Mock",
        category: "Frontend",
        date: DateTime.now().subtract(const Duration(days: -17)).toString().split(' ')[0],
        time: "10:00",
        attendees: 50,
        availableSpots: 20,
        description: "Aprende los fundamentos de Flutter",
        location: "Bogotá, Colombia",
        eventid: 1,
        speakerName: "Juan Perez",
        speakerAvatar: "https://avatar.iran.liara.run/username?username=Juan+Perez",
        sessionOrder: [],
        tags: ["flutter", "mobile"],
      ),
      // Add more mock events as needed
    ];
  }
