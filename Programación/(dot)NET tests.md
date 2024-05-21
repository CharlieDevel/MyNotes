//ーーーーーーーーーーーーーーーーー  
//=====  Constructor of a Test
The code placed in the constructor of a `Test class` will always run because each test that exists in the class makes an instance of the current class, but that means that for each test in your class, translates to a deletion and a new instantiation of the same class, cleaning up the code that was set in the constructor, making each test **isolated and not share data from that constructor**
//ーーーーーーーーーーーーーーーーー  

# Constructor
> The Constructor of a Test Class will ALWAYS RUN FOR EACH TEST  

Meaning that for every test inside the test class, the code in the connector **will be run too**, making the tests isolated and don't get dirty from already used variables from other tests that came from the constructor  
.• ° •.  To use **shared variables** instead of isolated ones, use the **IClassFixture and IDisposable** for Xunit to create an **instance of a class** that will be used by all the tests inside the test class

# IClassFixture [FixtureClass]
> Shared instance of a class among tests of a Test class, which can run a `~Destructor`(IDisposable) when all the tests in the test class are executed

This is basically `dependency injection`, where, for each implementation you make of this interface to the test class, you are telling to Xunit to **make an instance of that type and pass that instance to the parameter of the Test class Constructor**
This, for each instance its constructor will be run, and do whatever configuration you want that all your tests might need
```csharp
public class DatabaseFixture : IDisposable
{
    public DbContext Context { get; private set; }

    public DatabaseFixture()
    {
        // ... initialize data in the test database ...
        Context = new DbContext();
    }

    public void Dispose()
    {
        // ... clean up test data from the database ...
    }
}

public class MyDatabaseTests : IClassFixture<DatabaseFixture>
{
    DatabaseFixture fixture;

    public MyDatabaseTests(DatabaseFixture fixture)
    {
        this.fixture = fixture;
    }

    // ... write tests, using fixture.Context to get access to the shared database context ...
}
```
==.• ° •.  NOTE==: If you want more classes to be instantiated, you can...
1. Put another `IClassFixture` and put the other class you want with its `IDisposable` interface
2. Create a single Fixture Class, and that fixture class contain all the classes you want(Recommended when you **need a fixture to depend on the other**)

# IDisposable
> Basically the `~Destructor` of the shared instantiated class among all tests, called after each test in the test class has been run, used to clean up variables that the fixture created

# Collection Fixtures
> Basically, they are the same as shared instances for multiple tests, but instead of being for each test of a single test class, they are shared across **multiple test classes**

xUnit.net treats collection fixtures in much the same way as class fixtures, except that the lifetime of a collection fixture object is longer: it is created before any tests are run in any of the test classes in the collection, and will not be cleaned up until all test classes in the collection have finished running.

Test collections can also be decorated with `IClassFixture<>`. xUnit.net treats this as though each individual test class in the test collection were decorated with the class fixture.

To use collection fixtures, you need to take the following steps:

- Create the fixture class, and put the startup code in the fixture class constructor.
- If the fixture class needs to perform cleanup, implement `IDisposable` on the fixture class, and put the cleanup code in the `Dispose()` method.
- Create the collection definition class, decorating it with the `[CollectionDefinition]` attribute, giving it a unique name that will identify the test collection.
- Add `ICollectionFixture<>` to the collection definition class.
- Add the `[Collection]` attribute to all the test classes that will be part of the collection, using the unique name you provided to the test collection definition class's `[CollectionDefinition]` attribute.
- If the test classes need access to the fixture instance, add it as a constructor argument, and it will be provided automatically

```csharp
public class DatabaseFixture : IDisposable
{
    public DatabaseFixture()
    {
        Db = new SqlConnection("MyConnectionString");

        // ... initialize data in the test database ...
    }

    public void Dispose()
    {
        // ... clean up test data from the database ...
    }

    public SqlConnection Db { get; private set; }
}

[CollectionDefinition("Database collection")]
public class DatabaseCollection : ICollectionFixture<DatabaseFixture>
{
    // This class has no code, and is never created. Its purpose is simply
    // to be the place to apply [CollectionDefinition] and all the
    // ICollectionFixture<> interfaces.
}

[Collection("Database collection")]
public class DatabaseTestClass1
{
    DatabaseFixture fixture;

    public DatabaseTestClass1(DatabaseFixture fixture)
    {
        this.fixture = fixture;
    }
}

[Collection("Database collection")]
public class DatabaseTestClass2
{
    // ...
}
```

# Integration Tests
Focus: Given the **modules** are **well known**, meaning they work fine and we have a mental map of the layout in which the modules function, we check that the **parts of the skeleton of the system connect fine** AND also meet the requirements and expectations we set on them
Being concrete, integration tests aim to:
* **Check the connections of the modules work**: This is the **PRIMARY OBJECTIVE** of integration tests, because they ensure the **Communication and Data Flow works** in parts of the system
* **Fulfill requirements and expectations of the app**: This is a **SECONDARY OBJECTIVE**, meaning that an integration test may be used like a **Unit Test**, in the sense that this integration test is ensuring a "use case of the application" to ensure acceptance criteria and requirements, AND we use an integration test instead of a unit test because the integration test tests **easily what we want to check without stubs and mocking overhead**, while we get a truer system execution in real life

It is important to note how the unit tests are important in order to ensure that each module correctly works, thus we don't find errors in the integration tests that this test does NOT cover, and may mislead because of that, and also from the point of view of white box testing, unit tests may be done to test other factors aside the requirements checks, like ensuring good use of data structures, code coverage, memory leaks, performance and such



