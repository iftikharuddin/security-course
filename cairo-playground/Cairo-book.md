## Let's explore Cairo lang

_____
**Data Types Overview**
- Cairo is statically typed, requiring all variable types to be known at compile time.
- Conversion methods can specify desired output types when multiple types are possible.

**Scalar Types**
1. **Felt Type**
   - Default type if not specified.
   - Represents an integer in the range \(0 \leq x < P\), where \(P\) is a large prime number.
   - Arithmetic operations are performed modulo \(P\).
   - Division ensures \(x / y \cdot y = x\).

2. **Integer Types**
   - Built-in unsigned integer types: `u8`, `u16`, `u32`, `u64`, `u128`, `u256`, `usize`.
   - Signed integer types: `i8`, `i16`, `i32`, `i64`, `i128`.
   - Integer types come with overflow and underflow checks for security.
   - Numeric literals can be decimal, hexadecimal, octal, or binary.

3. **Boolean Type**
   - Values: `true` and `false`.
   - Boolean variables must be initialized with `true` or `false`, not integer literals.
   - Used in conditional expressions.

**Compound Types**
1. **String Types**
   - **Short Strings**: ASCII strings up to 31 characters, stored in `felt252`.
   - **ByteArray Strings**: No length limit, introduced in Cairo 2.4.0, stored as `ByteArray`.

**Numeric Operations**
- Supports addition, subtraction, multiplication, division, and remainder.
- Integer division truncates towards zero.
- Mathematical operations follow the standard patterns and result in a single value bound to a variable.

### Important Concepts
- **Static Typing**: Ensures type safety at compile time.
- **Field Elements (felt252)**: Default and fundamental type, crucial for arithmetic operations in Cairo.
- **Unsigned and Signed Integers**: Provide various bit lengths for different use cases, with security features to prevent overflow/underflow.
- **Boolean and Conditional Expressions**: Essential for control flow.
- **String Handling**: Differentiates between short and long strings, providing flexibility in string manipulation.

Understanding these data types and their characteristics is fundamental for effectively programming in Cairo, ensuring type safety, security, and efficient data handling.
______

1. **Function Definitions and Conventions:** Functions use the `fn` keyword and snake case for names.
   ```cairo
   fn another_function() {
       println!("Another function.");
   }
   ```

2. **Creating and Running Functions:** Define with `fn`, name, parentheses, and body in curly brackets.
   ```cairo
   fn main() {
       println!("Hello, world!");
       another_function();
   }
   ```

3. **Function Parameters:** Parameters must have declared types.
   ```cairo
   fn another_function(x: felt252) {
       println!("The value of x is: {}", x);
   }
   ```

4. **Function Calls with Parameters:** Call functions by passing matching arguments.
   ```cairo
   fn main() {
       another_function(5);
   }
   ```

5. **Multiple Parameters:** Use commas to separate multiple parameters.
   ```cairo
   fn print_labeled_measurement(value: u128, unit_label: ByteArray) {
       println!("The measurement is: {value}{unit_label}");
   }
   ```

6. **Named Parameters:** Use named parameters for readability.
   ```cairo
   fn foo(x: u8, y: u8) {}

   fn main() {
       let first_arg = 3;
       let second_arg = 4;
       foo(x: first_arg, y: second_arg);
   }
   ```

7. **Statements and Expressions:** Statements perform actions, expressions evaluate to values.
   ```cairo
   let y = 6;
   ```

8. **Function Return Values:** Declare return values with `->` followed by the type.
   ```cairo
   fn five() -> u32 {
       5
   }

   fn main() {
       let x = five();
       println!("The value of x is: {}", x);
   }
   ```

9. **Returning Values from Functions:** Avoid semicolons at the end of return expressions.
   ```cairo
   fn plus_one(x: u32) -> u32 {
       x + 1
   }
   ```

10. **Error Handling in Function Returns:** Statements do not return values, causing errors if expected.
    ```cairo
    fn plus_one(x: u32) -> u32 {
        x + 1; // Error due to semicolon
    }
    ```
______

### Dictionaries in Cairo

1. **Definition and Purpose:**
   - `Felt252Dict<T>` is a collection of unique key-value pairs.
   - Keys are `felt252` and values are of type `T`.
   - Useful for organizing data where arrays are not sufficient.

2. **Basic Operations:**
   - **Insert:** Adds or updates a key-value pair.
     ```cairo
     balances.insert('Alex', 100);
     ```
   - **Get:** Retrieves the value associated with a key.
     ```cairo
     let alex_balance = balances.get('Alex');
     ```

3. **Creating a Dictionary:**
   - Use the `Default::default()` method to create a new dictionary.
     ```cairo
     let mut balances: Felt252Dict<u64> = Default::default();
     ```

4. **Immutability and Modification:**
   - Memory is immutable; you can't change an existing value, but you can "rewrite" it by inserting a new value for the same key.

5. **Automatic Zero Initialization:**
   - All keys in a dictionary are initialized to zero.
   - Accessing a non-existent key returns 0.

6. **No Deletion:**
   - You cannot delete a key-value pair from a dictionary.

7. **Handling Values:**
   - Using `insert()` to add or update values.
   - Using `get()` to read values, which returns 0 for non-existent keys.

8. **Example Usage:**
   - Insert and retrieve balances for individuals.
   - Update an individual's balance by reinserting the key with a new value.
     ```cairo
     // Insert balance
     balances.insert('Alex', 100);
     let alex_balance = balances.get('Alex');
     // Update balance
     balances.insert('Alex', 200);
     let alex_balance_2 = balances.get('Alex');
     ```

9. **Default Initialization:**
   - Dictionary keys are initialized to zero, avoiding undefined values or errors when accessing non-existent keys.

10. **Non-deterministic Nature:**
    - Cairo is a non-deterministic Turing-complete language, influencing how dictionaries are implemented differently from other languages.

[Footnote]: A Turing-complete language is a programming language that can simulate any computation or algorithm given enough time and resources.
            
    
____        

## More about dictionaries

### Very Important Points from the Documentation

1. **Felt252Dict<T> Overview:**
   - Represents a collection of unique key-value pairs.
   - Useful for organizing data where arrays are insufficient.
   - Key type is restricted to `felt252`, and value type is specified by `T`.

2. **Basic Operations:**
   - **Insert:** Adds or updates a key-value pair.
     ```cairo
     balances.insert('Alex', 100);
     ```
   - **Get:** Retrieves the value associated with a key.
     ```cairo
     let alex_balance = balances.get('Alex');
     ```

3. **Memory Immutability:**
   - Cairo's memory is immutable; dictionaries simulate mutability using a list of entries.
   - Each entry records the key, previous value, and new value.

4. **Automatic Zero Initialization:**
   - All keys are initialized to zero by default.
   - Accessing a non-existent key returns 0 instead of an error.

5. **No Deletion:**
   - There is no way to delete data from a dictionary; it can only be updated.

6. **Entry and Finalize Methods:**
   - **Entry:** Creates a new entry for a given key and returns the entry and previous value.
     ```cairo
     fn entry(self: Felt252Dict<T>, key: felt252) -> (Felt252DictEntry<T>, T) nopanic
     ```
   - **Finalize:** Updates the entry with a new value and returns the updated dictionary.
     ```cairo
     fn finalize(self: Felt252DictEntry<T>, new_value: T) -> Felt252Dict<T>
     ```

7. **Dictionary Squashing:**
   - Ensures dictionary integrity by verifying that the last entry's `new_value` matches the next entry's `previous_value` for the same key.
   - Reduces the entry list to the most recent entry for each key.

8. **Destruct<T> Trait:**
   - Automatically calls `squash_dict` before the dictionary goes out of scope.
   - Differentiates from `Drop<T>` as it can generate new Cairo Assembly (CASM) code.

9. **Using Complex Types:**
   - `Nullable<T>` and `Box<T>` are used to store complex types in dictionaries.
   - Example for storing and retrieving a span of `felt252`:
     ```cairo
     d.insert(0, NullableTrait::new(a.span()));
     ```

10. **Example Implementations:**
    - Custom `get` method:
      ```cairo
      fn custom_get<T, +Felt252DictValue<T>, +Drop<T>, +Copy<T>>(ref dict: Felt252Dict<T>, key: felt252) -> T {
          let (entry, prev_value) = dict.entry(key);
          let return_value = prev_value;
          dict = entry.finalize(prev_value);
          return_value
      }
      ```
    - Custom `insert` method:
      ```cairo
      fn custom_insert<T, +Felt252DictValue<T>, +Destruct<T>, +Drop<T>>(ref dict: Felt252Dict<T>, key: felt252, value: T) {
          let (entry, _prev_value) = dict.entry(key);
          dict = entry.finalize(value);
      }
      ```

______
## Ownership in Cairo

1. **Linear Type System:**
   - Values must be used once, either destroyed or moved.
   - Destruction can happen when:
     - A variable goes out of scope.
     - A struct is destructured.
     - Explicit destruction using `destruct()`.

2. **Ownership in Cairo:**
   - Ownership applies to variables, not values.
   - Variables have a single owner at a time.
   - When the owner goes out of scope, the variable is destroyed.

3. **Variable Scope:**
   - Variables are valid from their declaration until the end of their scope.
   - Example:
     ```cairo
     { 
         let s = 'hello'; // s is valid
     } // s is no longer valid
     ```

4. **Moving Values:**
   - Passing a value to another function moves it, making the original variable unusable.
   - Example:
     ```cairo
     fn foo(mut arr: Array<u128>) {
         arr.pop_front();
     }

     fn main() {
         let mut arr: Array<u128> = array![];
         foo(arr);
         foo(arr); // Error: arr is already moved
     }
     ```

5. **The Copy Trait:**
   - Types that implement the `Copy` trait can be copied instead of moved.
   - All basic types implement the `Copy` trait by default.
   - Example:
     ```cairo
     #[derive(Copy, Drop)]
     struct Point {
         x: u128,
         y: u128,
     }

     fn main() {
         let p1 = Point { x: 5, y: 10 };
         foo(p1);
         foo(p1); // No error: Point implements Copy
     }
     ```

6. **Destruction with Drop and Destruct Traits:**
   - **Drop Trait:** No-op destruction, simply a hint for the compiler.
   - **Destruct Trait:** Ensures dictionaries are squashed when going out of scope.
   - Example with `Destruct`:
     ```cairo
     #[derive(Destruct)]
     struct A {
         dict: Felt252Dict<u128>
     }

     fn main() {
         A { dict: Default::default() }; // No error: dict is squashed
     }
     ```

7. **Clone Method:**
   - Deep copies data, creating new memory cells.
   - Example:
     ```cairo
     fn main() {
         let arr1: Array<u128> = array![];
         let arr2 = arr1.clone();
     }
     ```

8. **Returning Values:**
   - Returning a value moves it to the caller.
   - Example:
     ```cairo
     #[derive(Drop)]
     struct A {}

     fn gives_ownership() -> A {
         let some_a = A {};
         some_a // Moves ownership to the caller
     }

     fn takes_and_gives_back(some_a: A) -> A {
         some_a // Moves ownership to the caller
     }
     ```

9. **Returning Multiple Values:**
   - Use tuples to return multiple values.
   - Example:
     ```cairo
     fn calculate_length(arr: Array<u128>) -> (Array<u128>, usize) {
         let length = arr.len();
         (arr, length)
     }
     ```
____
### Important Points from References and Snapshots

1. **Snapshots:**
   - Snapshots provide an immutable view of a value at a specific point in time.
   - They allow retaining ownership in the calling function while still passing the value to other functions.
   - Example:
     ```cairo
     let first_snapshot = @arr1;
     ```

2. **Function Parameters with Snapshots:**
   - Use the `@` symbol to indicate that a function parameter is a snapshot.
   - Example:
     ```cairo
     fn calculate_length(arr: @Array<u128>) -> usize {
         arr.len()
     }
     ```

3. **Desnap Operator (`*`):**
   - Converts a snapshot back into a regular variable.
   - Only Copy types can be desnapped.
   - Example:
     ```cairo
     *rec.height * *rec.width
     ```

4. **Immutability of Snapshots:**
   - Snapshots cannot be modified.
   - Attempting to modify a snapshot results in a compilation error.
   - Example of invalid code:
     ```cairo
     rec.height = rec.width;
     rec.width = temp;
     ```

5. **Mutable References:**
   - Allow passing a mutable value to a function, implicitly returning ownership after the function call.
   - Use the `ref` modifier for parameters and `mut` for variable declaration.
   - Example:
     ```cairo
     let mut rec = Rectangle { height: 3, width: 10 };
     flip(ref rec);
     ```

6. **Example with Mutable References:**
   - Swapping the height and width fields of a `Rectangle` instance.
   - Example:
     ```cairo
     #[derive(Drop)]
     struct Rectangle {
         height: u64,
         width: u64,
     }

     fn main() {
         let mut rec = Rectangle { height: 3, width: 10 };
         flip(ref rec);
         println!("height: {}, width: {}", rec.height, rec.width);
     }

     fn flip(ref rec: Rectangle) {
         let temp = rec.height;
         rec.height = rec.width;
         rec.width = temp;
     }
     ```

These points summarize the core concepts and usage of snapshots and mutable references in Cairo, highlighting how they help manage ownership and mutability in the linear type system.
____

* **No Null Pointers in Cairo:** Cairo does not have null pointers or a null keyword; use the `Option` type to represent the possibility of an object being null.
* A package is the top-level organizational unit, containing crates. A crate contains modules.


_____
Let’s recap what we’ve discussed about the linear type system, ownership, snapshots, and references:

At any given time, a variable can only have one owner.
You can pass a variable by-value, by-snapshot, or by-reference to a function.
If you pass-by-value, ownership of the variable is transferred to the function.
If you want to keep ownership of the variable and know that your function won’t mutate it, you can pass it as a snapshot with @.
If you want to keep ownership of the variable and know that your function will mutate it, you can pass it as a mutable reference with ref.

______
- https://book.cairo-lang.org/
- Spearbit Cairo Security (Peteris Erins) https://youtu.be/9CIhHNrliW4
- Cairo audits: https://github.com/Cairo-Security-Clan/Audit-Portfolio