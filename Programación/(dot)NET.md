# Delegates
Delegates are fundamental for functional programming, they are in essence just functions that are saved to variables, either as a **single function**, or **multiple functions**(multicast), which when the variable is called, it will apply all the functions it has stored, in the order they were stored  
To store multiple functions to a variable, you use the `+=` and `-=` to either add or remove functions

There are several ways of declaring **Delegates**:
1. Action<>
2. Func<>
	Func has a similarity with the `Task<T>` type, this is using the type specifier(the types defined inside the <>) to define the **return type of the function to be defined**, but note that:
	1. `Task<T>` is **NOT a Delegate**, but rather an **asynchronous operation that returns a value of type T**
	2. `Func<T, U, R>` can have multiple types parameters, and with this example containing 3 type parameters, that means that the function to be defined must "Have 2 parameters, the first one of type T, the second one of type U, AND it must **return an R value**", and while that is true for `Func`, `Task` can't have multiple type parameters, only one
3. Predicate<>
Predicate is just a `Func<T, bool>`
4. Delegate keyword
> Now the **quirk** of delegates is the **Anonymous Functions use such as lambda functions to be defined**, this special attribute is what makes delegates special

They are used to declare **anonymous functions**, doing the following

```csharp
delegate int MyDelegate(int x);
MyDelegate myDelegate = delegate(int x) { x * x; };u
```

5. Lambda functions
They are too **anonymous functions**, but consist of just using an "arrow", where code before the arrow represent **function parameters** or could represent each element from an array in #LINQ, and the code after the arrow represents the actual code to perform, enclosed with curly braces

#LINQ : An example of the parameter of the lambda function used for LINQ is this
```csharp
Enumerable.Range(1, 5).Select(index => new WeatherForecast 
	{
	...code...
	})
```
The above code represents **index** being used by LINQ to represent **each element from a collection**, where each element will be processed by the lambda function  
==NOTE== : It is important to highlight how, when we work with collections that support LINQ(i. e. IEnumerable) and there is a method that takes in a **Delegate**(in the example above, the method would be "Select()"), and that Delegate is a lambda function, then the **parameter will always be EACH element from the collection**("index" is indeed each element from the collection)  
==NOTE 2== : For **lambda expressions**, the parameter could **also represent a type that is not present in the 『visible context』** but rather **『inside the implementation of the function/method』**, for example
```csharp
protected override void OnModelCreating(ModelBuilder modelBuilder) {
	modelBuilder.Entity<Users>(entity => {
		entity.Property(e => e.Id).HasColumnName("ID");
	});
}
```
Where "Users" represent an entity for a database, the "Id" is an integer
Thus, the documentation of the method says that the method "Entity<Users" takes as parameter an `Action`, which later **converts the "entity" parameter to an "EntityTypeBuilder<Users"** inside the lambda expression  
And here is why the **parameter "entity"** has defined its type to a variable that is not present in the **『visible context』**, the parameter is **defined inside** the implementation of the `Entity<Users`   
.• ° •.  Basically, when a **lambda expression** is passed in a function, the function is able to assign whatever variable type it wants to the lambda parameter AND be used as that type **inside the body of the lambda expression**  
-Also, the reason there is a `User` in diamonds in the `Entity` method is because it is used also in the implementation of that method to **define 『in advance』, the type of another parameter in a lambda expression for another method**, in this case, the **Property method**
```csharp
		entity.Property(e => e.Id).HasColumnName("ID");
```
 To be concrete, Property states...  
        - "I accept as parameter, an `Expression`(a lambda expression), **which** has as a parameter a `User` type"  
And the Property method states that because we applied `User` inside the diamonds of the `Entity` method

# Task
> Tasks are asynchronous operations, taken from a pool of threads that take care of a task when a Task is prompted to start execution

```csharp
CancellationTokenSource cts = new CancellationTokenSource();
CancellationToken token = cts.Token;

Task myTask = Task.Run(() =>
{
    while (!token.IsCancellationRequested)
    {
        // Do work...
    }
}, token);

// Cancel the task
cts.Cancel();
```
In this example, Task know about the value of `CancellationToken token` because **all Tasks CAN ACCESS the value of token if and only if that value was set using a CancellationTokenSource**

# Custom Constructor
In C#, if there is a class, and you want to create an instance of that class, **and also** want to initialize the values in **a lot of different ways**, BUT the class doesn't have any constructors, then you can do this
```csharp
MyClass myclass {
	attr1 = () => {code;};
	attr2 = await getDataFromDatabase();
}
```
And thus you get a **custom constructor**, without any pre made constructor  
Replacing the parenthesis `()` with curly braces and the attributes to modify `{}`

# Expression Bodied Property 
## The "=>" when it defines a variable or method
> Basically, a way to store a function **that always returns something** inside a class, its like a ge of the property with a computed return
```csharp
public class Circle
{
    public double Radius { get; set; }
    public double Area => Math.PI * Radius * Radius;
}
```

In the example I provided, the `Area` property is defined as an expression-bodied property that calculates the area of a circle using the formula `Math.PI * Radius * Radius`. This is equivalent to defining a read-only property with a `get` accessor that returns the calculated value, like this:
```csharp
public class Circle
{
    public double Radius { get; set; }
    public double Area
    {
        get { return Math.PI * Radius * Radius; }
    }
}
```
.• ° •.  You can use that for methods of a class too

# Aspect Oriented Programming
> This kind of programming is meant to fill in what OOP and FP can't deal with easily, that is **cross-cutting concerns** which are activities that **a lot of modules in the system must perform**, regardless of their **core function**, like logging or security

To be more explicit, There are 2 kinds of concerns:
1. Core or Primary Concerns:  
These concerns are the ones we have always dealt with, and that is what we wanted our programs to do and the reason they exist, the **Business Logic**  
2. Cross-cutting or system-wide concerns:  
These are the reason AOP exists, these concerns refer to the **functionalities that must be performed by several parts of the system**

For example, let’s say you have an application with several modules. Each module has its own primary functionality, but they all need to perform logging. Logging is a cross-cutting concern because it affects multiple modules and cannot be cleanly encapsulated in any one module. Instead of duplicating the logging code in each module, you can use aspect-oriented programming to encapsulate the logging code into an aspect and apply it to all the modules that need it. This way, you can avoid code duplication and keep your code modular.

# IEnumerable
> The most important thing to know about this is that it is an **INTERFACE**, this it is not meant for **storing values as a collection, but rather ITERATE through them**, using fancy stuff from functional programming like LINQ

Example, here’s how you could use LINQ to sort a list of integers in descending order:
```csharp
List<int> numbers = new List<int> { 1, 2, 3, 4, 5 };
IEnumerable<int> sortedNumbers = numbers.OrderByDescending(x => x);
```
※ If a variable is declared **as IEnumerable**, it is not going to actually store whatever value was assigned to it, instead it is like a **function**, which whenever the variable is called then it will run the code that was assigned to it to create an **IEnumerable**

# Extension Methods
> **Extension Method** is basically adding a method to an existing class without **defining the method inside the class**, because the CLR is able to do that easily

Requirements:
1. They must be defined in a `static class`
2. The methods must be of type `static`, they can return any type or void
3. The methods must always have a `this [type]` as the first parameter, other parameters will result in then being the parameters of the method to be extend
```csharp
public static class StringExtensions
{
    public static string AppendStrings(this string str, params string[] strings)
    {
        foreach (var s in strings)
        {
            str += s;
        }
        return str;
    }
}
```


```csharp
string s = "Hello";
s = s.AppendStrings(" ", "Extension", " ", "Methods");
// s now contains "Hello Extension Methods"
```

# Params
> They just appear inside the parameters of a function, and they define parameter multiplicity of ONE TYPE of variable, **but** to use it the type must also have a `[]` at the end, because the `params` keyword treats the parameters as a list, and also providing no arguments will result in an empty list

# Typed class error "cannot be used as type parameter" in inheritance
> When you are making a generic class that is typed AND inheriting from another typed class (`public abstract class GenericObj<TId> : Entity<TId>`), and there is an error saying `The type TId cannot be used as a type parameter TId in the generic type or method`, then you must add at the end an `where TId : implementedClass`
> Because the inherited class **has that type defined through a WHERE**, thus enforcing that rule to be followed in child classes




