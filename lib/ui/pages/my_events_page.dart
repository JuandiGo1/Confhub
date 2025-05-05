import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:confhub/ui/widgets/timeline/day_header.dart';
import 'package:confhub/ui/widgets/timeline/event_card.dart';
import 'package:confhub/domain/entities/event.dart';
import 'package:confhub/domain/use_cases/get_suscribed_events.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:confhub/ui/widgets/timeline/event_timeline.dart';

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
    final getEventsUseCase = Get.find<GetSuscribedEventsUseCase>();
    return await getEventsUseCase.call();
  }

  Future<void> _refreshEvents() async {
    final events = await _fetchEvents();
    setState(() {
      _eventsFuture = Future.value(events);
    });
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
          return const Center(child: Text('Ocurrió un error al cargar los eventos.'));
        }
        if (snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay eventos suscritos'));
        }
        return _MyEventsPageContent(events: snapshot.data!, onRefresh: _refreshEvents);
      },
    );
  }
}
class _MyEventsPageContent extends StatefulWidget {
  final List<Event> events;
  final Future<void> Function() onRefresh;

  const _MyEventsPageContent({
    required this.events,
    required this.onRefresh,
  });

  @override
  State<_MyEventsPageContent> createState() => __MyEventsPageContentState();
}

enum EventFilter { all, past, upcoming }

class __MyEventsPageContentState extends State<_MyEventsPageContent> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  String _currentMonthYear = "";
  EventFilter _filter = EventFilter.upcoming;
  List<Event> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _applyFilter(); // Initial filtering
    _itemPositionsListener.itemPositions.addListener(_updateMonthOnScroll);
  }

  void _applyFilter() {
    final now = DateTime.now();

    setState(() {
      if (_filter == EventFilter.past) {
        _filteredEvents = widget.events.where((e) => e.dateTime.isBefore(now)).toList();
      } else if (_filter == EventFilter.upcoming) {
        _filteredEvents = widget.events.where((e) => !e.dateTime.isBefore(now)).toList();
      } else {
        _filteredEvents = widget.events;
      }

      _currentMonthYear = _filteredEvents.isNotEmpty
          ? DateFormat('MMMM yyyy').format(_filteredEvents.first.dateTime)
          : DateFormat('MMMM yyyy').format(DateTime.now());
    });
  }

  void _updateMonthOnScroll() {
    final visibleItems = _itemPositionsListener.itemPositions.value;
    if (visibleItems.isNotEmpty && _filteredEvents.isNotEmpty) {
      final firstVisible = visibleItems
          .where((item) => item.itemLeadingEdge >= 0)
          .reduce((min, current) => current.index < min.index ? current : min);
      final newMonthYear = DateFormat('MMMM yyyy')
          .format(_filteredEvents[firstVisible.index].dateTime);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterChip(
                  label: const Text("Todos"),
                  selected: _filter == EventFilter.all,
                  onSelected: (_) {
                    _filter = EventFilter.all;
                    _applyFilter();
                  },
                ),
                FilterChip(
                  label: const Text("Pasados"),
                  selected: _filter == EventFilter.past,
                  onSelected: (_) {
                    _filter = EventFilter.past;
                    _applyFilter();
                  },
                ),
                FilterChip(
                  label: const Text("Futuros"),
                  selected: _filter == EventFilter.upcoming,
                  onSelected: (_) {
                    _filter = EventFilter.upcoming;
                    _applyFilter();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await widget.onRefresh();
                _applyFilter();
              },
              child: _filteredEvents.isEmpty
                  ? const Center(child: Text("No hay eventos en esta categoría"))
                  : ScrollablePositionedList.builder(
                      itemScrollController: _itemScrollController,
                      itemPositionsListener: _itemPositionsListener,
                      itemCount: _filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = _filteredEvents[index];
                        final eventDate = event.dateTime;
                        final isToday = DateUtils.isSameDay(DateTime.now(), eventDate);
                        final isFirstOfDay = index == 0 ||
                            !DateUtils.isSameDay(eventDate, _filteredEvents[index - 1].dateTime);
                        final isLastOfDay = index == _filteredEvents.length - 1 ||
                            !DateUtils.isSameDay(eventDate, _filteredEvents[index + 1].dateTime);
                        final isSoloEvent = isFirstOfDay && isLastOfDay;

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (isFirstOfDay)
                                DayHeader(eventDate: eventDate, isToday: isToday),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    IntrinsicHeight(
                                      child: EventTimelineWidget(
                                        isFirst: isFirstOfDay,
                                        isLast: isLastOfDay,
                                        isToday: isToday,
                                        isSolo: isSoloEvent,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: EventCard(event: event, isToday: isToday),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
