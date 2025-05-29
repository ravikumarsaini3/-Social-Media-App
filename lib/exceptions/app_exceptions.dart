class AppExceptions implements Exception {
  final String message;
  final _prefix;

  AppExceptions([this.message = 'Somthing went wrong', this._prefix]);

  String toString() {
    return "$_prefix$message";
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String message = 'Data not found'])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String message = 'invalid request'])
      :super(message, 'Invalid Request: ');
}

class InternetException extends AppExceptions {
  InternetException([String message = 'Check Your Internet Connection'])
      :super(message, 'No Internet Connection: ');
}

class InvalidResponse extends AppExceptions {
  InvalidResponse([String message = 'Response invalid'])
      : super(message, 'Invalid Response: ');
}

class TimeOutException extends AppExceptions{
  TimeOutException([String message='Responce invalid']):
        super(message,'invalid responce');
}
