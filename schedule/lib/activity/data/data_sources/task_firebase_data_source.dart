
import 'package:schedule/activity/domain/entities/task_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/activity/data/models/task_model.dart';

abstract class TaskFirebaseDataSource{
  Future<void> addTask(TaskEntity taskEntity);
}

class TaskFirebaseDataSourceImpl implements TaskFirebaseDataSource{
  final FirebaseFirestore taskFireStore;

  TaskFirebaseDataSourceImpl({required this.taskFireStore});

  @override
  Future<void> addTask(TaskEntity taskEntity) async {
    // TODO: implement addPet
    final collectionRef = taskFireStore.collection('task');
    final petId = collectionRef.doc().id;


    //mengubah menjadi JSON
    collectionRef.doc(petId).get().then((value) {
      final newTask = TaskModel(
          petId: petId,
          activity: taskEntity.activity,
          date: taskEntity.date,
          startTime: taskEntity.startTime,
          endTime: taskEntity.endTime,
          description: taskEntity.description,
          repeat: taskEntity.repeat
      ).toJson();
      if (!value.exists) {
        collectionRef.doc(petId).set(newTask);
      }
      return;
    });
  }
}