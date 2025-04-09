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

class __MyEventsPageContentState extends State<_MyEventsPageContent> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();
  String _currentMonthYear = "";

  @override
  void initState() {
    super.initState();
    _currentMonthYear = widget.events.isNotEmpty
        ? DateFormat('MMMM yyyy').format(widget.events.first.dateTime)
        : DateFormat('MMMM yyyy').format(DateTime.now());

    _itemPositionsListener.itemPositions.addListener(_updateMonthOnScroll);
  }

  void _updateMonthOnScroll() {
    final visibleItems = _itemPositionsListener.itemPositions.value;
    if (visibleItems.isNotEmpty) {
      final firstVisible = visibleItems.where((item) => item.itemLeadingEdge >= 0).reduce(
            (min, current) => current.index < min.index ? current : min,
          );
      final newMonthYear = DateFormat('MMMM yyyy')
          .format(widget.events[firstVisible.index].dateTime);
      if (newMonthYear != _currentMonthYear) {
        setState(() {
          _currentMonthYear = newMonthYear;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
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
      body: RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: ScrollablePositionedList.builder(
          itemScrollController: _itemScrollController,
          itemPositionsListener: _itemPositionsListener,
          itemCount: widget.events.length,
          itemBuilder: (context, index) {
            final event = widget.events[index];
            final eventDate = event.dateTime;
            final isToday = DateUtils.isSameDay(DateTime.now(), eventDate);
            final isFirstOfDay = index == 0 ||
                !DateUtils.isSameDay(eventDate, widget.events[index - 1].dateTime);
            final isLastOfDay = index == widget.events.length - 1 ||
                !DateUtils.isSameDay(eventDate, widget.events[index + 1].dateTime);
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
                        IntrinsicHeight( // NEW: makes the column match the card’s height
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
    );
  }
}
