import 'package:intl/intl.dart';
import 'package:schedule/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/data/models/task_model.dart';

abstract class TaskFirebaseDataSource {
  Future<void> addTask(TaskEntity taskEntity);
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date);
  Future<void> changeTaskStatus(String taskId);
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate);
}

class TaskFirebaseDataSourceImpl implements TaskFirebaseDataSource {
  final FirebaseFirestore taskFireStore;

  TaskFirebaseDataSourceImpl({required this.taskFireStore});

  @override
  Future<void> addTask(TaskEntity taskEntity) async {
    // TODO: implement addPet
    final collectionRef = taskFireStore.collection('tasks');
    final taskId = collectionRef.doc().id;

    //mengubah menjadi JSON
    collectionRef.doc(taskId).get().then((value) {
      final newTask = TaskModel(
              id: taskId,
              petId: taskEntity.petId,
              activity: taskEntity.activity,
              startTime: taskEntity.startTime,
              endTime: taskEntity.endTime,
              description: taskEntity.description,
              repeat: taskEntity.repeat,
              status: taskEntity.status,
              date: taskEntity.date)
          .toJson();
      if (!value.exists) {
        collectionRef.doc(taskId).set(newTask);
      }
      return;
    });
  }

  @override
  Stream<List<TaskEntity>> getTodayTask(String petId, DateTime date) {
    final taskCollection = taskFireStore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('date', isEqualTo: DateFormat("yyyy-MM-dd").format(date));

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> changeTaskStatus(String taskId) async {
    final collectionRef = taskFireStore.collection('tasks');
    Map<String, dynamic>? doc =
        await collectionRef.doc(taskId).get().then((value) => value.data());
    String status = doc!['status'] == 'complete' ? 'waiting' : 'complete';
    final statusMap = {"status": status};
    await collectionRef.doc(taskId).update(statusMap);
  }

  @override
  Stream<List<TaskEntity>> getMonthlyTask(
      String petId, DateTime startDate, DateTime endDate) {
    final taskCollection = taskFireStore
        .collection('tasks')
        .where('pet_id', isEqualTo: petId)
        .where('start_time',
            isGreaterThanOrEqualTo: startDate, isLessThanOrEqualTo: endDate);

    return taskCollection.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docSnap) => TaskModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}
