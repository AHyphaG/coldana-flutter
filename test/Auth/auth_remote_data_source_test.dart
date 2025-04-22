import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:coldana_flutter/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:coldana_flutter/features/auth/data/models/user_model.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<AuthRemoteDataSource>(), MockSpec<http.Client>()])
import 'auth_remote_data_source_test.mocks.dart';

void main() async {
  var mockAuthRemoteDataSource = MockAuthRemoteDataSource();
  MockClient mockClient = MockClient();
  var mockAuthRemoteDataSourceImpl = AuthRemoteDataSourceImpl(
    client: mockClient,
    baseUrl: 'http://localhost:8080',
  );

  final UserModel fakeUser = UserModel(id: '123', username: 'testuser');
  final Map<String, dynamic> fakeDataJson = {
    "message": "Login successful!",
    "token":
        "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3NDU0MDk1NjksInN1YiI6IjEiLCJpYXQiOjE3NDUzMjMxNjl9.BloZOgKPz8yYM6_fkwLk5wzypNcMHyQHc6Dc80bgAAk",
  };

  group("Auth Remote Data Source Implementation", () {
    group("Login", () {
      test("Berhasil", () async {
        when(
          mockClient.post(
            Uri.parse('http://localhost:8080/api/auth/login'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async {
          return http.Response(
            jsonEncode(fakeDataJson),
            200,
            headers: {'Content-Type': 'application/json'},
          );
        });

        try {
          var response = await mockAuthRemoteDataSourceImpl.login(
            'testuser',
            'testpassword',
          );
          expect(response, fakeDataJson);
        } catch (e) {
          print(e);
          fail("Seharusnya tidak ada error");
        }
      });

      test("Gagal - (401)", () async {
        when(
          mockClient.post(
            Uri.parse('http://localhost:8080/api/auth/login'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async {
          return http.Response(
            jsonEncode({"message": "Invalid credentials"}),
            401,
            headers: {'Content-Type': 'application/json'},
          );
        });

        try {
          await mockAuthRemoteDataSourceImpl.login('testuser', 'testpassword');
          fail("Seharusnya ada error");
        } catch (e) {
          expect(e.toString(), contains("Invalid credentials"));
        }
      });

      test("Gagal - (500)", () async {
        when(
          mockClient.post(
            Uri.parse('http://localhost:8080/api/auth/login'),
            headers: anyNamed('headers'),
            body: anyNamed('body'),
          ),
        ).thenAnswer((_) async {
          return http.Response(
            jsonEncode({"message": "Failed to login"}),
            500,
            headers: {'Content-Type': 'application/json'},
          );
        });

        try {
          await mockAuthRemoteDataSourceImpl.login('testuser', 'testpassword');
          fail("Seharusnya ada error");
        } catch (e) {
          expect(e.toString(), contains("Failed to login"));
        }
      });
    });
  });

  group("Auth Remote Data Source", () {
    group("Login", () {
      test('BERHASIL (200)', () async {
        when(mockAuthRemoteDataSource.login(any, any)).thenAnswer((_) async {
          return {'id': fakeUser.id, 'username': fakeUser.username};
        });

        try {
          // Berhasil login
          var response = await mockAuthRemoteDataSource.login(
            'testuser',
            'testpassword',
          );
          print(response);
        } catch (e) {
          print(e);
        }
      });

      test('Gagal (401)', () async {
        when(mockAuthRemoteDataSource.login(any, any)).thenAnswer((_) async {
          throw Exception('Invalid credentials');
        });

        try {
          var response = await mockAuthRemoteDataSource.login(
            'testuser',
            'wrongpassword',
          );
          print(response);
          fail('Seharusnya melempar Exception');
        } catch (e) {
          // Gagal login karena password salah
          print(e);
          expect(e, isA<Exception>());
          // You can also verify the error message
          expect((e as Exception).toString(), contains('Invalid credentials'));
        }
      });

      test('Gagal (Internet Lambat)', () async {
        when(mockAuthRemoteDataSource.login(any, any)).thenAnswer((_) async {
          await Future.delayed(const Duration(seconds: 2));
          throw TimeoutException('Connection timed out', Duration(seconds: 30));
          // Or use a more specific exception like:
          // throw SocketException('Connection timed out');
        });

        try {
          var response = await mockAuthRemoteDataSource.login(
            'testuser',
            'testpassword',
          );
          print(response);
          fail('Seharusnya melempar TimeoutException');
        } catch (e) {
          print(e);
          expect(e, isA<TimeoutException>());
          expect((e as TimeoutException).message, contains('timed out'));
        }
      });
    });
  });
}
