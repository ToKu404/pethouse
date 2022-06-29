import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:task/data/models/task_model.dart';
import 'package:task/domain/entities/habbit_entity.dart';
import 'package:task/domain/entities/task_entity.dart';

abstract class TaskFirebaseDataSource {
  Future<List<TaskEntity>> getOneReadTask(DateTime date, String petId);
  Future<void> transferTask(List<HabbitEntity> habbits, List<TaskEntity> tasks);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
  Future<void> changeTaskStatus(String taskId);
}

class TaskFirebaseDataSourceImpl implements TaskFirebaseDataSource {
  final FirebaseFirestore taskFirestore;

  TaskFirebaseDataSourceImpl({required this.taskFirestore});

  @override
  Future<void> changeTaskStatus(String taskId) async {
    final collectionRef = taskFirestore.collection('tasks');
    Map<String, dynamic>? doc =
        await collectionRef.doc(taskId).get().then((value) => value.data());
    bool status = doc!['complete_status'] == true ? false : true;
    final statusMap = {"complete_status": status};
    await collectionRef.doc(taskId).update(statusMap);
  }

  @override
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate) {
    final taskCollection = taskFirestore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('time',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date) {
    final taskCollection = taskFirestore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: DateFormat.yMMMEd().format(date));

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<List<TaskEntity>> getOneReadTask(DateTime date, String petId) {
    print("CALLER TASK");
    String dt = DateFormat.yMMMEd().format(date);
    final collectionRef = taskFirestore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: dt);
    return collectionRef.get().then((value) {
      return value.docs.map((e) => TaskModel.fromSnapshot(e)).toList();
    });
  }

  @override
  Future<void> transferTask(
      List<HabbitEntity> newHabbits, List<TaskEntity> deleteTask) async {
    print("TRANSFER");
    final taskRef = taskFirestore.collection('tasks');
    final date = DateTime.now();
    // menambahkan semua habbit dalam list habbit baru ke daftar task
    for (var habbit in newHabbits) {
      final habbitTime = habbit.time!.toDate();
      final taskId = taskRef.doc().id;
      final newTask = TaskModel(
          id: taskId,
          completeStatus: false,
          title: habbit.title,
          habbitId: habbit.id,
          petId: habbit.petId,
          date: DateFormat.yMMMEd().format(date),
          time: Timestamp.fromDate(DateTime(date.year, date.month, date.day,
              habbitTime.hour, habbitTime.minute)),
          activityType: habbit.activityType);
      taskRef.doc(taskId).get().then((value) {
        if (!value.exists) {
          taskRef.doc(taskId).set(newTask.toJson());
        }
      });
    }

    // Menghapus semua task dalam yang ada pada list delete task
    for (var task in deleteTask) {
      taskRef.doc(task.id).delete();
    }
  }
}
