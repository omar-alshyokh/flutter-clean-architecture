enum Environment { dev, staging, prod }

extension EnvironmentX on Environment {
  String get name {
    return switch (this) {
      Environment.dev => 'dev',
      Environment.staging => 'staging',
      Environment.prod => 'prod',
    };
  }

  static Environment from(String value) {
    return switch (value) {
      'dev' => Environment.dev,
      'staging' => Environment.staging,
      'prod' => Environment.prod,
      _ => Environment.dev,
    };
  }
}
