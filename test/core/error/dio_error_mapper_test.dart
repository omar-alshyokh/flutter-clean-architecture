import 'package:dio/dio.dart';

import 'package:flutter_clean_architecture/core/error/dio_error_mapper.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const mapper = DioErrorMapper();

  final req = RequestOptions(path: '/test');

  group('DioErrorMapper', () {
    test('maps connectionTimeout to TimeoutError', () {
      final ex = DioException(
        requestOptions: req,
        type: DioExceptionType.connectionTimeout,
        response: Response(requestOptions: req, statusCode: 408),
      );

      final error = mapper.map(ex);

      expect(error, isA<TimeoutError>());
      expect(error.code, '408');
    });

    test('maps receiveTimeout to TimeoutError', () {
      final ex = DioException(
        requestOptions: req,
        type: DioExceptionType.receiveTimeout,
      );

      final error = mapper.map(ex);

      expect(error, isA<TimeoutError>());
    });

    test('maps connectionError to NetworkConnectionError', () {
      final ex = DioException(
        requestOptions: req,
        type: DioExceptionType.connectionError,
      );

      final error = mapper.map(ex);

      expect(error, isA<NetworkConnectionError>());
    });

    test('maps cancel to CustomError', () {
      final ex = DioException(
        requestOptions: req,
        type: DioExceptionType.cancel,
      );

      final error = mapper.map(ex);

      expect(error, isA<CustomError>());
      expect(error.message, isNotEmpty);
    });

    test('maps badCertificate to CustomError', () {
      final ex = DioException(
        requestOptions: req,
        type: DioExceptionType.badCertificate,
      );

      final error = mapper.map(ex);

      expect(error, isA<CustomError>());
    });

    group('badResponse HTTP status mapping', () {
      DioException badResponse(int status, {Object? data}) {
        return DioException(
          requestOptions: req,
          type: DioExceptionType.badResponse,
          response: Response(
            requestOptions: req,
            statusCode: status,
            data: data,
          ),
        );
      }

      test('maps 401 to UnauthorizedError', () {
        final error = mapper.map(badResponse(401));
        expect(error, isA<UnauthorizedError>());
        expect(error.code, '401');
      });

      test('maps 403 to ForbiddenError', () {
        final error = mapper.map(badResponse(403));
        expect(error, isA<ForbiddenError>());
      });

      test('maps 404 to NotFoundError', () {
        final error = mapper.map(badResponse(404));
        expect(error, isA<NotFoundError>());
      });

      test('maps 422 to UnProcessableError', () {
        final error = mapper.map(badResponse(422));
        expect(error, isA<UnProcessableError>());
      });

      test('maps 500+ to InternalServerError', () {
        final error = mapper.map(badResponse(500));
        expect(error, isA<InternalServerError>());
      });

      test('extracts server message from Map when present', () {
        final error = mapper.map(
          badResponse(400, data: {'message': 'Bad input'}),
        );
        expect(error, isA<UnknownError>());
        expect(error.message, 'Bad input');
      });

      test('extracts server message from String body when present', () {
        final error = mapper.map(badResponse(400, data: 'Something failed'));
        expect(error, isA<UnknownError>());
        expect(error.message, 'Something failed');
      });
    });

    test(
      'maps unknown DioException to UnknownError using exception.message',
      () {
        final ex = DioException(
          requestOptions: req,
          type: DioExceptionType.unknown,
          message: 'Low-level socket error',
        );

        final error = mapper.map(ex);

        expect(error, isA<UnknownError>());
        expect(error.message, 'Low-level socket error');
      },
    );

    test('maps non-Dio errors to UnknownError', () {
      final error = mapper.map(StateError('boom'));
      expect(error, isA<UnknownError>());
    });
  });
}
