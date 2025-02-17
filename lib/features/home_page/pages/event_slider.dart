import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:icgc/features/home_page/data/events_model.dart';

import '../../../app/utils/screen_size.dart';

class EventSlider extends StatelessWidget {
  const EventSlider({super.key});

  @override
  Widget build(BuildContext context) {
    var isTablet = ScreenSizeHelper(context).isTablet;
    var isPortrait = ScreenSizeHelper(context).isPortrait;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height *
            (isTablet
                ? isPortrait
                    ? .2
                    : .4
                : .2),
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(14, 0, 0, 0),
            blurRadius: 10,
            spreadRadius: 10,
          )
        ]),
        child: CarouselSlider.builder(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.decelerate,
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
            ),
            itemCount: EventsModel.eventMock.length,
            itemBuilder: (context, index, _) {
              final event = EventsModel.eventMock[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      foregroundDecoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(5, 0, 0, 0),
                            Color.fromARGB(104, 0, 0, 0),
                            Color.fromARGB(178, 0, 0, 0),
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Image.asset(
                        event.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // if (_activeIndex ==
                    //     EventsModel.eventMock.indexOf(event))
                  ],
                ),
              );
            }));
  }
}
