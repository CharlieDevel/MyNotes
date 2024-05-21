

# Constructor Injection
> Used when you need to **initialize** member variables of a class at its startup, **ONLY IF** the class needs those variables to start running

## Circular dependency
Occurs when there are 2 classes that in their constructors injectors, they have as parameters each other, and since those parameters are treated as Beans, they will cause a circular dependency
> Solution: Use `@Lady` in the parameters of one of the variables of a constructor, that will make Spring **not look for the Bean**, and only look for it when it is **actually needed**, like a method in that variable that is called
> Alternative: Use **Setter Injection** rather than constructor injection for the variables that are not necessary for the startup of the class

# Multiple Beans of same type
Spring Boot has a **Registry** of the `@Beans, @Components, @Services` etc that are requested by other class that are `@Autowired`

==Criteria to connect Beans to Autowired member variables of classes==: Spring Boot connects the member variables of a class that have the @Autowired, or appear as parameters in the constructor of a class, with the constructor having an @Autowired annotation, are requesting to Spring Boot a **@Bean with the same type as the @Autowired** thus Spring Boot will look **all over it's registry with Beans with the same type of the requested component**, and execute the code that Bean requires
### Problem
When there are **multiple Beans of the same type**, Spring Boot encounters an error and dies, to fix this we can use
1. `@Primary` annotation
This annotation must be placed at a Bean
The effect of this annotation is to make the selected Bean as the one with the top priority to be chosen when this problem occurs
1. `@Qualifier("identifier")` annotation
The qualifier annotation at both the Bean declaration, and Autowired declaration
The effect of this annotation is to make the `@Autowired` request the Bean **If and only if it has the provided qualifier identifier**


# Concurrent Programming

## ExecutorService
This class allows us to use the **Producer/Consumer pattern**, where we use the `submit(Callable<T> task)` #_1_ to input a **task** to be executed by a **Consumer**, this being a Virtual Thread, this consumer thread will return something if the passed function or lambda function has a `return`  
        But to achieve this we need to use the constructor `newVirtualThreadPerTaskExecutor()`

#_1_: `Callable` is a function or a lambda function, the `<T>` represents the **output type** of the function when it ends and returns a variable

## Spliterator
The `Spliterator` class allows to **take a connection or array, and**
1. Traverse the collection as an Iterator
2. SPLIT the collection into 2, through a function that returns another `Spliterator` with the other half of the collection

#### Command (? super T) action
This is just a **function that returns nothing**, and the parentheses(that are supposed to be `diamonds`) say that the function will only operate over variables of type **T or superclasses of T**, when it's **accept(T t)** method is called


#Requirements-to-run-Java
> - In the `PATH` environment variable the path to the **JDK version** you will be using
> - Set the jdk version to use in the `Files > Project Structure`
> - Set to gradle the version it will use to build the programs in `Gradle setting, at Build, Execution, Deployment > Build tools > Gradle > Gradle JVM`
> - Set the jdk to build and run in the `Run/Debug Configurations`

#Whe-IntelliJ-cant-find-preview-classes-like-incubator
When this happens, this is because it seems that the JVM does NOT include the arguments `--enable-preview --add-modules jdk.incubator.concurrent` when using the experimental features certain java versions have, so you need to insert to the **JVM options**, or arguments, the arguments provided above, with the enable preview and add modules


