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
            
            
            
            
            
            
______


- https://book.cairo-lang.org/
- Spearbit Cairo Security (Peteris Erins) https://youtu.be/9CIhHNrliW4
- Cairo audits: https://github.com/Cairo-Security-Clan/Audit-Portfolio