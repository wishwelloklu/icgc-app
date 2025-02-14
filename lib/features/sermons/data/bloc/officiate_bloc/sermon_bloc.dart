import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icgc/app/cache/cache_keys.dart';
import 'package:icgc/app/config/push_notification.dart';
import 'package:icgc/features/sermons/data/bloc/officiate_bloc/sermon_events.dart';
import 'package:icgc/features/sermons/data/models/sermon_model.dart';

import 'sermon_states.dart';

class SermonBloc extends Bloc<SermonEvents, SermonStates> {
  SermonBloc() : super(InitialSermonState()) {
    final box = Hive.box<SermonModel>(CacheKeys.officiate);
    on<LoadSermon>(
      (event, emit) {
        final officiateList = box.values.toList();
        emit(SermonLoaded(officiateList));
      },
    );

    on<SaveSermonEvent>(
      (event, emit) async {
        try {
          await box.add(event.sermon);
          emit(SermonProcessingDoneState('Saved'));
        } on Exception catch (e) {
          emit(ErrorSermonState('Something went wrong'));
        }
        add(LoadSermon());
      },
    );

    on<UpdateSermon>(
      (event, emit) async {
        try {
          final list = box.values.toList();
          final index =
              list.indexWhere((sermon) => sermon.id == event.sermon.id);
          if (index != -1) {
            await box.putAt(index, event.sermon);
            // await setNotification(
            //   date: event.sermon.,
            //   body: '',
            //   id: '',
            // );
            add(LoadSermon());
          } else {
            add(SaveSermonEvent(event.sermon));
          }
          emit(SermonProcessingDoneState('Saved'));
        } on Exception catch (e) {
          emit(ErrorSermonState('Something went wrong'));
        }
      },
    );

    on<DeleteSermon>(
      (event, emit) async {
        try {
          final index = box.values.toList().indexOf(event.sermon);
          if (index != -1) {
            await box.deleteAt(index);

            add(LoadSermon());
          }
          emit(SermonProcessingDoneState('Deleted'));
        } on Exception catch (e) {
          emit(ErrorSermonState('Something went wrong'));
        }
      },
    );
  }

  Future<void> setNotification({
    required DateTime date,
    String? title,
    required String body,
    required String id,
  }) async {
    await PushNotificationService.setReminder(
      id: int.parse(id),
      title: title ?? 'Sermon reminder',
      body: body,
      date: date,
    );
  }
}
