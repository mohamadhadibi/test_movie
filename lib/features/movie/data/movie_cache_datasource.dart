import '../../core/domain/exam/entity/exam.dart';
import '../../core/domain/exam/repository/params_model.dart';

abstract class ExamRemoteDataSource {
  Future<Exam> create(ExamParams params);

  Future<Exam> update(ExamParams params);

  Future<bool> deleteExam(DeleteExamParams params);

  Future<Exam> get(GetExamParams params);

  Future<List<Exam>> query(QueryExamParams params);

  Future<bool> addExamQuestioners(AddExamQuestionersParams params);

  Future<bool> deleteExamQuestioner(DeleteExamQuestionerParams params);
}