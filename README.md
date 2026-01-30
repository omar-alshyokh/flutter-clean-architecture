# Flutter Clean Architecture Template

A production-ready Flutter starter template that demonstrates Clean Architecture principles, modern state management, and best practices for scalable mobile applications.

## 🏗️ Architecture Overview

This project follows **Clean Architecture** with strict separation of concerns:

```
lib/
├── app/                    # Application-level configuration
│   ├── config/            # Environment configuration (dev/staging/prod)
│   ├── di/                # Dependency injection setup
│   ├── routes/            # Navigation and routing
│   └── theme/             # App theming and styling
├── core/                  # Shared core functionality
│   ├── constants/         # App constants and environment keys
│   ├── datasource/        # Base data sources
│   ├── entity/           # Base entities
│   ├── error/            # Error handling
│   ├── model/            # Data models
│   ├── network/          # HTTP client and interceptors
│   ├── repository/       # Base repositories
│   ├── storage/          # Local storage utilities
│   ├── usecase/          # Base use cases
│   └── utils/            # Utilities (validators, extensions, etc.)
└── features/             # Feature modules
    ├── auth/             # Authentication feature
    ├── home/             # Home feature
    └── posts/            # Posts feature
        ├── data/         # Data layer (repositories, data sources, models)
        ├── domain/       # Domain layer (entities, use cases, repositories)
        └── presentation/  # UI layer (pages, widgets, state)
```

## 🚀 Features & Technologies

### State Management
- **BLoC/Cubit** for predictable state management
- **Provider** for simple dependency injection where needed

### Networking
- **Dio HTTP client** with interceptors for:
  - Authentication tokens
  - Request/response logging
  - Retry logic
  - Network error handling
- **Connectivity monitoring** for offline/online status
- **Internet reachability checks**

### Data Persistence
- **SharedPreferences** for non-sensitive local storage
- **Flutter Secure Storage** for encrypted data (tokens, secrets)

### Dependency Injection
- **GetIt** as service locator
- **Injectable** for automatic DI code generation
- **Composition root** pattern for testable architecture

### Navigation
- **GoRouter** for declarative routing
- Deep linking support
- Type-safe navigation

### UI/UX
- **Material Design 3** components
- **Cached network images** with placeholders
- **Staggered animations** for list/grid items
- **Animate_do** for pre-built animations
- **Responsive design** patterns

### Code Quality & Testing
- **Very Good Analysis** linting rules
- **Equatable** for value equality
- **JSON Serialization** code generation
- **Mocktail** for testing mocks
- **Bloc Test** for BLoC testing

## 📱 Environment Configuration

The app supports multiple environments:

- **Development** (`main_dev.dart`)
- **Staging** (`main_staging.dart`) 
- **Production** (`main_prod.dart`)

Each environment has its own:
- API endpoints
- Logging levels
- Feature flags
- Security settings

## 🛠️ Getting Started

### Prerequisites
- Flutter SDK (>= 3.10.7)
- Dart SDK
- Code editor (VS Code/Android Studio)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flutter-clean-architecture
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   # Development environment
   flutter run -t lib/main_dev.dart

   # Staging environment
   flutter run -t lib/main_staging.dart

   # Production environment
   flutter run -t lib/main_prod.dart
   ```

## 🧪 Testing

### Run all tests
```bash
flutter test
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Test structure follows feature organization:
```
test/
├── features/
│   ├── auth/
│   └── posts/
└── helpers/         # Test utilities and helpers
```

## 📁 Project Structure Deep Dive

### Core Layer (`lib/core/`)
Contains reusable components shared across features:

- **Base Classes**: Abstract classes for repositories, data sources, use cases
- **Network Layer**: Dio client with interceptors for auth, logging, retries
- **Error Handling**: Centralized error models and handling
- **Utilities**: Validators, extensions, logging, debounce utilities
- **Constants**: App-wide constants and environment-specific keys

### Feature Module Pattern
Each feature follows Clean Architecture:

```
feature/
├── data/              # Implementation details
│   ├── datasources/   # Remote and local data sources
│   ├── models/        # Data transfer objects
│   └── repositories/  # Repository implementations
├── domain/            # Business logic
│   ├── entities/      # Business objects
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business use cases
└── presentation/      # UI layer
    ├── pages/         # Screen widgets
    ├── widgets/       # Reusable UI components
    └── state/         # BLoC/Cubit state management
```

### Dependency Injection Setup
```dart
// lib/app/di/di.dart
@InjectableInit()
Future<void> configureDependencies({required AppConfig appConfig}) async {
  getIt.init();
}
```

### Example Use Case Implementation
```dart
@injectable
class GetPostDetailsUseCase implements UseCase<Post, PostIdParams> {
  final PostsRepository _repository;
  
  GetPostDetailsUseCase(this._repository);
  
  @override
  Future<Result<Post>> call(PostIdParams params) async {
    return await _repository.getPostDetails(params.id);
  }
}
```

### BLoC Pattern Example
```dart
@injectable
class PostDetailsCubit extends Cubit<PostDetailsState> {
  final GetPostDetailsUseCase _useCase;
  
  PostDetailsCubit(this._useCase) : super(const PostDetailsInitial());
  
  Future<void> load(int id) async {
    emit(const PostDetailsLoading());
    
    final result = await _useCase(PostIdParams(id));
    
    switch (result) {
      case Success(:final data):
        emit(PostDetailsLoaded(data));
      case Failure(:final error):
        emit(PostDetailsError(error.message));
    }
  }
}
```

## 🔧 Development Workflow

### Adding New Features

1. **Create feature structure**
   ```bash
   mkdir lib/features/your_feature
   mkdir lib/features/your_feature/{data,domain,presentation}
   ```

2. **Define domain layer**
   - Create entities in `domain/entities/`
   - Define repository interfaces in `domain/repositories/`
   - Implement use cases in `domain/usecases/`

3. **Implement data layer**
   - Create models in `data/models/`
   - Implement data sources in `data/datasources/`
   - Create repository implementations in `data/repositories/`

4. **Build presentation layer**
   - Create state classes in `presentation/state/`
   - Implement BLoC/Cubit for state management
   - Build UI components in `presentation/pages/` and `presentation/widgets/`

5. **Add routing**
   ```dart
   GoRoute(
     path: RoutePaths.yourFeature,
     name: 'yourFeature',
     builder: (context, state) {
       return BlocProvider(
         create: (_) => getIt<YourFeatureCubit>(),
         child: const YourFeaturePage(),
       );
     },
   ),
   ```

6. **Register dependencies**
   ```dart
   @module
   abstract class YourFeatureModule {
     @lazySingleton
     YourFeatureRepository get repository => YourFeatureRepositoryImpl();
     
     @injectable
     GetYourFeatureUseCase getUseCase(YourFeatureRepository repository) =>
         GetYourFeatureUseCase(repository);
   }
   ```

### Code Generation
After modifying models or adding dependencies:
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Linting
```bash
# Run static analysis (enforces strict code quality)
flutter analyze

# Fix formatting issues automatically
dart format .

# Format specific directory
dart format lib/
```

**Code Quality Features:**
- ✅ **Strict type checking** (`strict-casts`, `strict-inference`, `strict-raw-types`)
- ✅ **Critical error detection** (`unused_import`, `dead_code`, `invalid_assignment`)
- ✅ **Performance optimization** (`prefer_const_constructors`, `prefer_const_literals`)
- ✅ **Null safety enforcement** (`avoid_null_checks`, `prefer_null_aware_operators`)
- ✅ **Clean imports** (automatic sorting and organization)
- ✅ **Zero analysis issues** - completely clean codebase

## 🎯 Best Practices Implemented

1. **Separation of Concerns**: Each layer has clear responsibilities
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Single Responsibility**: Each class has one reason to change
4. **Testability**: Architecture enables easy unit and integration testing
5. **Error Handling**: Centralized error management with Result types
6. **Type Safety**: Strong typing throughout the application
7. **Immutability**: State objects are immutable using Equatable
8. **Async/Await**: Proper handling of asynchronous operations

## 📦 Package Dependencies

### Core Architecture
- `flutter_bloc`: State management
- `get_it`: Service location
- `injectable`: Dependency injection
- `dio`: HTTP client
- `go_router`: Navigation

### UI/UX
- `cached_network_image`: Image caching
- `flutter_staggered_animations`: List animations
- `animate_do`: Pre-built animations

### Utilities
- `equatable`: Value equality
- `shared_preferences`: Local storage
- `flutter_secure_storage`: Secure storage
- `connectivity_plus`: Network monitoring
- `json_annotation`: JSON serialization

### Development
- `build_runner`: Code generation
- `very_good_analysis`: Linting rules
- `mocktail`: Testing mocks

## 🚀 Deployment

### Build for Production
```bash
# Android
flutter build apk --release --flavor prod -t lib/main_prod.dart

# iOS
flutter build ios --release --flavor prod -t lib/main_prod.dart
```

### Environment-Specific Builds
The app supports different build flavors:
- **dev**: Development environment with verbose logging
- **staging**: Pre-production environment for testing
- **prod**: Production environment with minimal logging

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Follow the existing code patterns
4. Add tests for new functionality
5. Run `flutter analyze` and `flutter test`
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Clean Architecture** by Robert C. Martin
- **BLoC Pattern** by Felix Angelov
- **Flutter Team** for the amazing framework

---

**Written by Omar Alshyokh**

Built with ❤️ using Flutter and Clean Architecture principles.