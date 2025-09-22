import 'movie_remote_datasource.dart';

class MovieCacheDatasourceImpl implements MovieCacheDatasource {
  final NetworkInfo networkInfo;
  final Dio dio;

  ExamRemoteDataSourceImpl(this.networkInfo, this.dio);

  @override
  Future<Exam> create(ExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      String? questioners;
      for (User item in params.questioners ?? []) {
        questioners ??= '';
        if (questioners.isNotEmpty) {
          questioners += ',';
        }
        questioners += item.id.toString();
      }

      Response response = await dio.post(
        'exam/create',
        data: jsonEncode({
          "name": params.name,
          "description": params.description,
          "is_enable": params.isEnable,
          "questioners": questioners,
        }),
      );
      try {
        Exam model = Exam.fromJson(response.data["data"]);
        return Future.value(model);
      } catch (e) {
        throw ParseFailure();
      }
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<Exam> get(GetExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Response response = await dio.get('exam/get/${params.examId}');
      try {
        Exam model = Exam.fromJson(response.data["data"]);
        return Future.value(model);
      } catch (e) {
        throw ParseFailure();
      }
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<List<Exam>> query(QueryExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Response response = await dio.get('exam/query', queryParameters: {
        "page": params.page,
      });
      try {
        try {
          List<Exam> model = getDataListFromJson<Exam>(
              response.data, (jsonItem) => Exam.fromJson(jsonItem));
          return Future.value(model);
        } catch (e) {
          throw ParseFailure();
        }
      } catch (e) {
        throw ParseFailure();
      }
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<Exam> update(ExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      Response response = await dio.patch(
        'exam/update/${params.id}',
        data: jsonEncode({
          "name": params.name,
          "description": params.description,
          "is_enable": params.isEnable,
        }),
      );
      try {
        Exam model = Exam.fromJson(response.data["data"]);
        return Future.value(model);
      } catch (e) {
        throw ParseFailure();
      }
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<bool> addExamQuestioners(AddExamQuestionersParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      String? questioners;
      for(User item in params.questioners) {
        questioners ??= '';
        if(questioners.isNotEmpty) {
          questioners += ',';
        }
        questioners += item.id.toString();
      }

      Map<String, dynamic> query = {
        "questioners": questioners,
      };
      await dio.post(
        'exam/add_exam_questioners/${params.examId}',
        data: jsonEncode(query),
      );
      return Future.value(true);
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<bool> deleteExamQuestioner(DeleteExamQuestionerParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      await dio.delete('exam/delete_exam_questioner/${params.examId}/${params.questionerId}');
      return Future.value(true);
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }

  @override
  Future<bool> deleteExam(DeleteExamParams params) async {
    //if (!await networkInfo.isConnected) throw NetworkFailure();
    try {
      await dio.delete('exam/delete/${params.examId}', data: {
        "security_code": params.securityCode.toString(),
      });
      return Future.value(true);
    } on DioException catch (e) {
      throw e.response?.statusCode?.exception ?? UnknownFailure();
    } catch (e) {
      if (e is Failure) {
        rethrow;
      } else {
        throw UnknownFailure();
      }
    }
  }
}
