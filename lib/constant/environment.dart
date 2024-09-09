enum Environment {
  development,
  production,
}

String getBaseURL() {
  String baseURL;
  Environment env = Environment.production;

  switch (env) {
    case Environment.production:
      baseURL = 'http://localhost:3000';
      break;

    default:
      baseURL = 'http://localhost:3000';
  }

  return baseURL;
}