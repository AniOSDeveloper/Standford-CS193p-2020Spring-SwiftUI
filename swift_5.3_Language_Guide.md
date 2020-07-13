# swift 5.3 Language Guide
[TOC]
# 基础介绍
## 常量let & 变量var
```swift
let maximumNumberOfLoginAttempts = 10  // 常量的值设定后不能更改
var currentLoginAttempt = 0
var x = 0.0, y = 0.0, z = 0.0
var red, green, blue: Double // 理论上可以但是实际很少这么写
```
常量和变量名称几乎可以包含任何字符，包括一些Unicode字符。**常量和变量名称不能包含空格，数学符号，箭头，专用的Unicode标量值或线条和框形图字符，不能以数字开头**。不能将常量更改为变量或将变量更改为常量。如果需要命名为保留的Swift关键字名称，在关键字两端加上反引号`，不建议使用保留的keyword。

string interpolation打印法，**使用 `\()` 打印**
```swift
print("The current value of friendlyWelcome is \(friendlyWelcome)") 
```
## 注释
```swift
// 单行注释
/* 多行注释
可以嵌套 */
```
## 分号
可以写也可以不写，一般不写分号。如果要在一行上编写多个单独的语句，则需要分号。
## 整数
Swift提供8位，16位，32位和64位形式的有符号和无符号整数。其中8位无符号整数的类型为UInt8，而32位有符号整数的类型为Int32。一般使用Int就可以了。
```swift
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8
```
在大多数情况下，无需选择特定大小的整数即可在代码中使用。Swift提供了额外的整数类型，Int其大小与当前平台的本机字大小相同：在32位平台上，Int与大小相同Int32；在64位平台上，Int与大小相同Int64。Swift还提供了一个无符号整数类型，UInt其大小与当前平台的本机字大小相同。
## 浮点值
- Double 表示一个64位浮点数，精度至少为15个十进制数字
- Float 表示一个32位浮点数，精度可以低至6个十进制数字
## 类型推断 & Type Safety
当声明具有初始值的常量或变量时，swift根据类型推断来确定常量或者变量的类型，但如果没有初始值就需要明确给定改常量或变量的类型：`var welcomeMessage: String`
在浮点值里面默认都是Double
## 数字
```swift
let decimalInteger = 17			  // 十进制数，无前缀
let binaryInteger = 0b10001       // 二进制数，前缀0b
let octalInteger = 0o21           // 八进制数，前缀0o
let hexadecimalInteger = 0x11     // 十六进制数，前缀0x
```
浮点文字可以是十进制（不带前缀）或十六进制（带0x前缀）。它们的小数点两侧必须始终有一个数字（或十六进制数字）。小数浮点数也可以有一个可选的指数，用大写或小写表示e; 十六进制浮点数必须具有指数，以大写或小写表示p。
对于指数为的十进制数字exp，基数乘以10^exp：
- 1.25e2表示1.25 x 10^2，或125.0。
- 1.25e-2表示1.25 x 10^-2，或0.0125。

对于指数为的十六进制数exp，将基数乘以2^exp：
- 0xFp2表示15 x 2^2，或60.0。
- 0xFp-2表示15 x 2^-2，或3.75。

```swift
let decimalDouble = 12.1875			// 十进制
let exponentDouble = 1.21875e1		// 指数形式
let hexadecimalDouble = 0xC.3p0		// 十六进制
```
## 数值类型转换
```swift
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
```
## 类型别名typealias
类型别名为现有类型定义备用名称，可以使用typealias关键字定义类型别名。  
想通过上下文更合适的名称来引用现有类型时，例如使用外部源中特定大小的数据时，类型别名非常有用：

```swift
typealias AudioSample = UInt16
```

定义类型别名后，可以在任何可能使用原始名称的地方使用别名：

```swift
var maxAmplitudeFound = AudioSample.min
// maxAmplitudeFound is now 0
```

在这里，AudioSample被定义为的别名UInt16。因为它是一个别名，调用AudioSample.min实际调用UInt16.min，它提供的初始值0的maxAmplitudeFound变量。
## 布尔值 Bool
有两个布尔常量值，true以及false
## 元组 Tuples
元组将多个值分组为一个复合值。元组中的值可以是任何类型，而不必彼此相同。下例描述HTTP状态代码的元组。如果请求的网页不存在，则返回状态404 Not Found

```swift
let http404Error = (404, "Not Found")
// http404Error is of type (Int, String), and equals (404, "Not Found")
```
可以将元组的内容分解为单独的常量或变量，然后像往常一样访问它们：

```swift
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
// Prints "The status code is 404"
print("The status message is \(statusMessage)")
// Prints "The status message is Not Found"
```

如果只需要一些元组的值，则在分解元组时，请用下划线_忽略该元组的某些部分：

```swift
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
// Prints "The status code is 404"
```

或者，使用从零开始的索引号访问元组中的各个元素值：

```swift
print("The status code is \(http404Error.0)")
// Prints "The status code is 404"
print("The status message is \(http404Error.1)")
// Prints "The status message is Not Found"
```

定义元组时，可以命名元组中的各个元素：

```swift
let http200Status = (statusCode: 200, description: "OK")
```

如果在元组中命名元素，则可以使用元素名称来访问这些元素的值：

```swift
print("The status code is \(http200Status.statusCode)")
// Prints "The status code is 200"
print("The status message is \(http200Status.description)")
// Prints "The status message is OK"
```

**具有多个返回值的函数使用元组特别合适。**
元组对于简单的一组相关值很有用。它们不适合创建复杂的数据结构。如果您的数据结构可能更复杂，则将其建模为类或结构，而不是元组。
## Optionals
Optionls表示要么有一个值并且可访问该值，或者为nil。
以下示例使用初始化程序尝试将 String转换为Int，由于初始化程序可能失败，因此它返回一个optional Int而不是一个Int。

```swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// convertedNumber is inferred to be of type "Int?", or "optional Int"
```

如果定义一个可选变量而不提供默认值，则该变量将自动nil为您设置为：

```swift
var surveyAnswer: String?
// surveyAnswer is automatically set to nil
surveyAnswer = nil		// 也可以给optional赋值为nil
```
**1. 可选值的强制展开**
一旦确定可选选项确实包含一个值，就可以**在可选名称的末尾添加一个感叹号!来访问其基础值**。

```swift
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."
```
**2. Optional Binding**
Optional Binding一般与if 和 while语句一起使用，以检查可选内部的值，并将该值提取到常量或变量中，作为单个操作的一部分。

```swift
if let constantName = someOptional {
    statements
}

if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" could not be converted to an integer")
}
// Prints "The string "123" has an integer value of 123"
```
如果Int返回的可选Int(possibleNumber)内容包含一个值，请为该可选内容中包含的值设置一个新的常量actualNumber。如果转换成功，则该actualNumber常量可在if语句的第一分支中使用。它已经被初始化与包含在值内可选的，因此没有必要使用!后缀来访问它的价值。

您可以根据需要在单个if语句中包含尽可能多的可选绑定和布尔条件，以逗号分隔。如果可选绑定中的nil任何值是或任何布尔条件求和false，则整个if语句的条件视为false。

```swift
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"
```
**3. 隐式展开的Optionals**
隐式解包的可选对象视为允许在需要时强制打开可选对象的权限
```swift
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // no need for an exclamation point

let optionalString = assumedString
// The type of optionalString is "String?" and assumedString isn't force-unwrapped.
```
当变量可能nil在以后出现时，请不要使用隐式展开的可选。
## 错误处理
当函数遇到错误条件时，它将引发错误。该函数的调用方可以捕获错误并做出适当响应。

```swift
func canThrowAnError() throws {
    // this function may or may not throw an error
}
```

函数通过throws在其声明中包含关键字来表明它可以引发错误。当调用可能引发错误的函数时，会将try关键字放在表达式的前面。  
Swift会自动将错误传播到当前范围之外，直到由catch子句处理为止。

```swift
do {
    try canThrowAnError()
    // no error was thrown
} catch {
    // an error was thrown
}
```

一条do语句创建一个新的包含范围，该范围允许将错误传播到一个或多个catch子句。  
这是一个示例，说明如何使用错误处理来响应不同的错误情况：

```swift
func makeASandwich() throws {
    // ...
}

do {
    try makeASandwich()
    eatASandwich()
} catch SandwichError.outOfCleanDishes {
    washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    buyGroceries(ingredients)
}
```

在此示例中，makeASandwich()如果没有干净的盘子或缺少任何配料，该函数将引发错误。因为makeASandwich()会抛出错误，所以函数调用被包装在一个try表达式中。通过将函数调用包装在一条do语句中，抛出的任何错误都将传播到提供的catch子句中。

如果未引发任何错误，eatASandwich()则调用该函数。如果抛出错误并且匹配SandwichError.outOfCleanDishes大小写，则将washDishes()调用该函数。如果引发了一个错误并且与SandwichError.missingIngredients大小写匹配，则buyGroceries(_:)使用模式[String]捕获的关联值调用该函数catch。
## Assertions & Preconditions（待研究）
断言和前提条件是在运行时进行的检查。可以使用它们来确保在执行任何其他代码之前满足基本条件。如果断言或前提条件中的布尔条件求值为true，则代码将照常继续执行。如果条件的计算结果为false，则程序的当前状态无效；否则，结果为0。代码执行结束，您的应用程序终止。  
可以使用断言和前提条件来表达您在进行编码时所做的假设和期望，因此可以将其包含在代码中。断言可帮助在开发过程中发现错误和不正确的假设，前提条件可帮助检测生产中的问题。
### Assertions 
通过调用Swift标准库中的函数`assert(_:_:file:line:)`来编写断言

```swift
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
// This assertion fails because -3 is not >= 0.
```

在此示例中，如果值为负，则age >= 0就是false，断言失败，从而终止应用程序。

您可以省略断言消息`assert(age >= 0)`  
如果代码已经检查了条件，则可以使用该assertionFailure(_:file:line:)函数指示断言失败。例如：

```swift
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}
```

### Enforcing Preconditions
当可能的情况为false时使用Preconditions，但必须肯定是真的对你的代码继续执行。例如，使用Preconditions检查下标是否未超出范围，或检查是否已向函数传递了有效值。

可以通过调用precondition(_:_:file:line:)函数来编写Preconditions。

```swift
// In the implementation of a subscript...
precondition(index > 0, "Index must be greater than zero.")
```

也可以调用该preconditionFailure(_:file:line:)函数以指示发生了故障。

# 基本运算符
## 元组之间的比较
两个元组具有相同的类型和相同数量的值，则可以比较它们。元组从左到右进行比较，一次比较一个值，直到比较发现两个不相等的值。将这两个值进行比较，然后比较的结果确定元组比较的整体结果。如果所有元素相等，则元组本身相等。

```swift
(1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" are not compared
(3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
(4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
("blue", false) < ("purple", true)  // Error because < can't compare Boolean values
```
Swift标准库包含用于少于七个元素的元组的元组比较运算符。要比较具有七个或更多元素的元组，必须自己实现比较运算符。
## Nil-Coalescing Operator
```swift
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil

var colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is nil, so colorNameToUse is set to the default of "red"

userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
// userDefinedColorName is not nil, so colorNameToUse is set to "green"
```
## Range运算符
`a...b`       表示 [a,b]  
`a..<b`       表示 [a,b)  
`names[2...]`     names数组索引2到末尾  
`names[...2]`     names数组索引0到2  
`names[..<2]`     names数组索引0到1  

## 逻辑判断

```swift
let enteredDoorCode = true
let passedRetinaScan = false
let hasDoorKey = false
let knowsOverridePassword = true
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
// If we’ve entered the correct door code and passed the retina scan, or if we have a valid door key, or if we know the emergency override password, then allow access.
```
**Swift逻辑运算符&&和||是左关联的，这意味着具有多个逻辑运算符的复合表达式首先评估最左边的子表达式。**
当然，添加括号后逻辑会更加清楚
```swift
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// Prints "Welcome!"
```
# 字符串Strings和字符Characters
## 多行字符串文字用三引号 """
两个"""之间的字符串都作为多行字符串的值，如果仅想在代码里换行是代码易读，可以在换行符前添加反斜杠转义
```swift
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
```
swift可以自动推断多行字符串里的缩进，如下面的例子，缩进被忽略，只有第二行的四个空格包括在了多行字符串内
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200711165302962.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1h1bkNpeQ==,size_16,color_FFFFFF,t_70)
## 转义字符串
\0（空字符）
\\（反斜杠）
\t（水平制表符）
\n（换行符）
\r（回车）
\"（双引号）
\'（单引号）
任意的Unicode标值，写为\u{n}，其中n是一个1-8位十六进制数

```swift
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
// "Imagination is more important than knowledge" - Einstein
let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496

//因为多行字符串文字使用三个双引号而不是一个双引号，可以在多行字符串文字中包含一个双引号而不进行转义。
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
```
## Extended String Delimiters（待研究）
 `#"Line 1\nLine 2"#` 用 (\n) 打印转行的String
 使用 `#"Line 1\#nLine 2"#` 代替`#"Line 1\nLine 2"#` ，`###"Line1\###nLine2"###` 也是两行

```swift
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
```
## 初始化字符串
```swift
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other
```
## 字符character

```swift
for character in "Dog!" {
    print(character)
}
// D
// o
// g
// !

let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)
// Prints "Cat!🐱"

let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
// welcome now equals "hello there"

var instruction = "look over"
instruction += string2
// instruction now equals "look over there"

let exclamationMark: Character = "!"
welcome.append(exclamationMark)
// welcome now equals "hello there!"

let badStart = """
one
two
"""
let end = """
three
"""
print(badStart + end)
// Prints two lines:
// one
// twothree

let goodStart = """
one
two

"""
print(goodStart + end)
// Prints three lines:
// one
// two
// three
```
## String Interpolation: \\()
```swift
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"
```
## .count
```swift
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
// Prints "unusualMenagerie has 40 characters"
```
## 访问和修改String
```swift
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.index(before: greeting.endIndex)]
// !
greeting[greeting.index(after: greeting.startIndex)]
// u
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
// a


greeting[greeting.endIndex] // Error
greeting.index(after: greeting.endIndex) // Error


for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}
// Prints "G u t e n   T a g ! "
```

```swift
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
// welcome now equals "hello!"
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there!"

welcome.remove(at: welcome.index(before: welcome.endIndex))
// welcome now equals "hello there"

let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
// welcome now equals "hello"
```
## 子串

```swift
let greeting = "Hello, world!"
let index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
// beginning is "Hello"

// Convert the result to a String for long-term storage.
let newString = String(beginning)
```
greeting是一个字符串，这意味着它具有一个存储区域，用于存储组成该字符串的字符。因为beginning是的子字符串greeting，所以它重复使用了所greeting使用的内存。相反，newString是一个字符串-从子字符串创建它时，它具有自己的存储空间。
准备长时间存储结果时，可以将子字符串转换为字符串
![在这里插入图片描述](https://img-blog.csdnimg.cn/20200711182839781.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1h1bkNpeQ==,size_16,color_FFFFFF,t_70)
## 比较字符串
可以用 == 或者 !=
```swift
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"
```
**使用前缀 `hasPrefix(_:)` 后缀比较 `hasSuffix(_:)`**

```swift
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")
// Prints "There are 5 scenes in Act 1"

var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
// Prints "6 mansion scenes; 2 cell scenes"
```
## Unicode编码 & UTF-16（待研究）

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in cafe is 4"

word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301

print("the number of characters in \(word) is \(word.count)")
// Prints "the number of characters in café is 4"
```

# Collection
三种collection： array有序集合, set唯一值的无序集合, dictionarie键-值关联的无序集合。
## Array

```swift
var arr = Array<Int>    // 空数组，两种方式，一般采用[]
var someInts = [Int]()  // 简写
someInts.append(3)      // someInts now contains 1 value of type Int
someInts = []           // someInts is now an empty array, but is still of type [Int]

var threeDoubles = Array(repeating: 0.0, count: 3)
// threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
// anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
var sixDoubles = threeDoubles + anotherThreeDoubles
// sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
```
增删改查
```swift
var shoppingList: [String] = ["Eggs", "Milk"]
// shoppingList has been initialized with two initial items
var shoppingList = ["Eggs", "Milk"]  // 类型推断

print("The shopping list contains \(shoppingList.count) items.")
// Prints "The shopping list contains 2 items."

if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list is not empty.")
}
// Prints "The shopping list is not empty."

shoppingList.append("Flour")
// shoppingList now contains 3 items, and someone is making pancakes

shoppingList += ["Baking Powder"]
// shoppingList now contains 4 items
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
// shoppingList now contains 7 items

var firstItem = shoppingList[0]
shoppingList[0] = "Six eggs"

shoppingList[4...6] = ["Bananas", "Apples"]
// shoppingList now contains 6 items，将索引[4,6]的元素换成["Bananas", "Apples"] 

// insert和remove操作后，其他元素顺移
shoppingList.insert("Maple Syrup", at: 0)
// shoppingList now contains 7 items，索引0位置插入为"Maple Syrup"

let mapleSyrup = shoppingList.remove(at: 0)
// shoppingList now contains 6 items, 删除索引0位置的元素，并且返回该位置元素的值
let apples = shoppingList.removeLast()  //避免查询.count检查是否越界

for item in shoppingList {
    print(item)
}
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}
```
## Set
类型必须是可哈希的才能存储在Set中

```swift
var letters = Set<Character>()  // Set没有简写
letters.insert("a") // letters now contains 1 value of type Character
letters = []        // letters is now an empty set, but is still of type Set<Character>
```
增删改查

```swift
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]  //类型推断

print("I have \(favoriteGenres.count) favorite music genres.")
// Prints "I have 3 favorite music genres."

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// Prints "I have particular music preferences."

favoriteGenres.insert("Jazz")
// favoriteGenres now contains 4 items

// .removeAll()删除全部元素
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."

for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop

for genre in favoriteGenres.sorted() {  // 按<的顺序返回
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz
```
![在这里插入图片描述](https://img-blog.csdnimg.cn/2020071211394394.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1h1bkNpeQ==,size_16,color_FFFFFF,t_70)
- `intersection(_:)`方法创建仅具有两个集合共有的值的新集合。
- `symmetricDifference(_:)`方法创建一个新集合，其中两个集合中都有一个值，但不能同时包含两个集合中的值。
- `union(_:)`方法创建一个包含两个集合中所有值的新集合。
- `subtracting(_:)`方法创建一个新集合，其值不在指定集合中。

![在这里插入图片描述](https://img-blog.csdnimg.cn/20200712114230758.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L1h1bkNpeQ==,size_16,color_FFFFFF,t_70)
- `==`确定两组是否包含所有相同的值。
- `isSubset(of:)`方法确定集合中的所有值是否都包含在指定集合中。
- `isSuperset(of:)`方法确定集合是否包含指定集合中的所有值。
- `isStrictSubset(of:)`或`isStrictSuperset(of:)`方法确定集合是子集还是超集，但不等于指定的集合。
- `isDisjoint(with:)`方法确定两个集合是否没有共同的值。

## Dictionary
字典Key类型必须符合Hashable协议

```swift
var dic = Dictionary<Key, Value>
var namesOfIntegers = [Int: String]()   // 简写
// namesOfIntegers is an empty [Int: String] dictionary
namesOfIntegers[16] = "sixteen"
// namesOfIntegers now contains 1 key-value pair
namesOfIntegers = [:]
// namesOfIntegers is once again an empty dictionary of type [Int: String]
```
增删改查
```swift
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
// 当key和value是同一类型的时候，swift可以进行类型推断

print("The airports dictionary contains \(airports.count) items.")
// Prints "The airports dictionary contains 2 items."

if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary is not empty.")
}
// Prints "The airports dictionary is not empty."

airports["LHR"] = "London"
// the airports dictionary now contains 3 items
airports["LHR"] = "London Heathrow"
// the value for "LHR" has been changed to "London Heathrow"

if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).")
}
// Prints "The old value for DUB was Dublin."
// updateValue(_:forKey:)方法返回字典值类型的可选值。

if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName).")
} else {
    print("That airport is not in the airports dictionary.")
}
// Prints "The name of the airport is Dublin Airport."

airports["APL"] = "Apple International"
// "Apple International" is not the real airport for APL, so delete it
airports["APL"] = nil
// APL has now been removed from the dictionary

if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary does not contain a value for DUB.")
}
// Prints "The removed airport's name is Dublin Airport."

for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
// LHR: London Heathrow
// YYZ: Toronto Pearson

for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
// Airport code: LHR
// Airport code: YYZ
for airportName in airports.values {
    print("Airport name: \(airportName)")
}
// Airport name: London Heathrow
// Airport name: Toronto Pearson

let airportCodes = [String](airports.keys)
// airportCodes is ["LHR", "YYZ"]
let airportNames = [String](airports.values)
// airportNames is ["London Heathrow", "Toronto Pearson"]
```
Swift的Dictionary类型没有定义的顺序。要以特定顺序遍历字典的键或值，可以在keys或values属性上使用sorted()。

# Control Flow
## for in 循环
```swift
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// index是一个常数无需声明
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
// 如果不需要索引值，怎可以使用 下划线_ 代替
```

```swift
let minutes = 60
for tickMark in 0..<minutes {
    // render the tick mark each minute (60 times)
}

let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    // render the tick mark every 3 hours (3, 6, 9, 12)
}
```
## While 循环
- while 每次循环执行时都会评估其条件。
- repeat- while在每次循环结束时评估其条件。在考虑循环条件之前，会先执行一次循环循环。然后，它将继续重复循环，直到条件为false。类似于 do - while

```swift
while condition {
    statements
}

repeat {
    statements
} while condition
```

## 条件语句
### if
多个判断条件可以用逗号连接
### switch
break在Swift中不是必需的，但是可以使用break语句来匹配和忽略特定的情况，或者在该情况完成执行之前中断匹配的情况。
每个case都必须包含一个可执行语句，一个case两种value用逗号隔开
```swift
switch some value to consider {
case value 1:
    respond to value 1
case value 2,
     value 3:
    respond to value 2 or 3
default:
    otherwise, do something else
}

//间隔匹配
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Prints "There are dozens of moons orbiting Saturn."
```
```swift
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}
// Prints "(1, 1) is inside the box"
```
(0，0）可以匹配所有四种情况。但是，如果可能有多个匹配项，则始终使用第一个匹配情况，所有其他匹配情况都将被忽略。
### Value Bindings
```swift
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case let (x, y):
    print("somewhere else at (\(x), \(y))")
}
// Prints "on the x-axis with an x value of 2"

// 复核case
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}
// Prints "On an axis, 9 from the origin"
```
该switch陈述没有任何default理由。但最后一个case，声明了两个可以匹配任何值的占位符常量的元组。因为始终是两个值的元组，所以此情况与所有可能的剩余值匹配，并且不需要使情况穷举的情况。
### where
```swift
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}
// Prints "(1, -1) is on the line x == -y"
```
## Control Transfer Statements
- continue
- break
- fallthrough
- return
- throw
## Labeled Statements（待研究）

```swift
label name: while condition {
    statements
}

gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
    case finalSquare:
        // diceRoll will move us to the final square, so the game is over
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        // diceRoll will move us beyond the final square, so roll again
        continue gameLoop
    default:
        // this is a valid move, so find out its effect
        square += diceRoll
        square += board[square]
    }
}
print("Game over!")
```
如果break上面的语句不使用gameLoop标签，它将脱离该switch语句，而不是该while语句。使用gameLoop标签可以清楚地表明哪个控制语句应该终止。
## Early Exit：guard（待研究）

```swift
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }

    print("Hello \(name)!")

    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }

    print("I hope the weather is nice in \(location).")
}

greet(person: ["name": "John"])
// Prints "Hello John!"
// Prints "I hope the weather is nice near you."
greet(person: ["name": "Jane", "location": "Cupertino"])
// Prints "Hello Jane!"
// Prints "I hope the weather is nice in Cupertino."
```
如果满足guard语句的条件，则执行在该guard语句的右括号后的代码。在guard语句出现的条件绑定，在其余代码部分依然有效。

如果不满足该条件，则执行else分支内的代码。该分支必须转移控制权以退出该guard语句所在的代码块。它可以控制转移语句做到这一点，如return，break，continue，throw，也可以调用一个函数或方法不返回，如`fatalError(_:file:line:)`。
## 检查API可用性（待研究）

```swift
if #available(platform name version, ..., *) {
    statements to execute if the APIs are available
} else {
    fallback statements to execute if the APIs are unavailable
}

if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
```
上面的可用性条件指定在iOS中，if语句主体仅在iOS 10及更高版本中执行；在macOS中，仅在macOS 10.12及更高版本中。最后一个参数*是必需的，它指定在任何其他平台上，if执行程序的主体均在目标所指定的最小部署目标上执行。

# Function
## Function
只用return一行编写的任何函数都可以省略return。
```swift
// 没有参数
func sayHelloWorld() -> String {
    return "hello, world"
}

// 多个参数
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}

// 没有返回值
func greet(person: String) {
    print("Hello, \(person)!")
}
```

```swift
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but does not return a value
```
第一个函数printAndCount(string:)打印一个字符串，然后将其字符计数返回为Int。第二个函数printWithoutCounting(string:)调用第一个函数，但忽略其返回值。当调用第二个函数时，第一个函数仍会打印该消息，但是不使用返回的值。

### 具有多个返回值的函数
可以使用元组类型作为函数的返回类型，以将多个值作为一个复合返回值的一部分返回。

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
```
在从函数返回元组时不必命名元组的成员，因为它们的名称已作为函数返回类型的一部分指定。
### 返回Optional

```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

if let bounds = minMax(array: [8, -6, 2, 109, 3, 71]) {
    print("min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "min is -6 and max is 109"
```
## 内部外部名称： Argument Labels and Parameter Names

```swift
// 指定参数标签
func someFunction(argumentLabel parameterName: Int) {
    // In the function body, parameterName refers to the argument value
    // for that parameter.
}

func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."

// 内外部名称一致，省略参数标签
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
```
### 默认参数值
可以通过在参数的类型之后为该参数分配值来为函数中的任何参数定义默认值。如果定义了默认值，则可以在调用函数时忽略该参数。
```swift
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
```
### 可变参数
一个函数最多可以具有一个可变参数。
通过...在参数的类型名称后插入三个句点字符（...）来编写可变参数。

下面的示例为任意长度的数字列表计算算术平均值（也称为average）：

```swift
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
arithmeticMean(3, 8.25, 18.75)
// returns 10.0, which is the arithmetic mean of these three numbers
```
### In-Out 参数
函数参数默认为常量，如果希望函数修改参数的值，并且希望这些更改在函数调用结束后仍然存在，请将该参数定义为In-Out Parameters。

只能将变量作为输入输出参数的参数传递。您不能将常量或文字值作为参数传递，因为无法修改常量和文字。当您将一个与号（&）作为变量传入in-out参数时，将它放在变量名的前面，以指示该变量可以被函数修改。

输入输出参数不能具有默认值，并且可变参数不能标记为inout。

```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"
```
## Function Types
由函数的参数类型和返回类型组成，如(Int, Int) -> Int

```swift
// () -> Void
func printHelloWorld() {
    print("hello, world")
}
```
### 使用Function Types
可以将常量或变量定义为函数类型，然后为该变量分配适当的函数：
```swift
var mathFunction: (Int, Int) -> Int = addTwoInts
```
“定义一个名为mathFunction的变量，其类型为一个具有两个Int值并返回Int值的函数。” 设置这个变量来表示函数addTwoInts。”

```swift
print("Result: \(mathFunction(2, 3))")  // Prints "Result: 5"

let anotherMathFunction = addTwoInts  // 类型推断
// anotherMathFunction is inferred to be of type (Int, Int) -> Int
```
### Function Types作为另一个函数的参数类型
```swift
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Prints "Result: 8"
```
本示例定义了一个名为printMathResult(_:_:_:)的函数，该函数具有三个参数。第一个参数名为mathFunction，类型为(Int, Int) -> Int。第二个和第三个参数分别名为a和b，并且均为type Int。
### Function Types作为返回类型
```swift
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function

print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!
```
## 嵌套函数
嵌套函数默认情况下对外界隐藏，但仍可以由其封闭函数调用和使用。封闭函数还可以返回其嵌套函数之一，以允许该嵌套函数在另一个作用域中使用。
可以重写chooseStepFunction(backward:)并返回嵌套函数：

```swift
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!
```
# Closure
- 全局函数是具有名称且不捕获任何值的闭包。
- 嵌套函数是具有名称的闭包，可以从其闭包函数捕获值。
- 闭包表达式是用轻量级语法编写的未命名的闭包，可以从其周围的上下文中捕获值。

Swift的闭包表达式特点：
- 从上下文推断参数和返回值类型
- 单表达式闭包的隐式返回
- 速记参数名称
- 尾随闭包语法

## 闭包表达式（各种省略方式）
闭包表达式语法具有以下一般形式：
```swift
{ (parameters) -> return type in
    statements
}
```

```swift
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
// reversedNames is equal to ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

// 闭包写法
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// 从上下文推断类型
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )

// 单表达式可以省略return
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )

// Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 } )

// Operator Methods
reversedNames = names.sorted(by: >)
```
## 尾随闭包

```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

// 闭包表达式作为函数或方法的唯一参数
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
reversedNames = names.sorted { $0 > $1 }
```

```swift
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]

// number的类型可以从要映射的数组中的值推断出来
let strings = numbers.map { (number) -> String in
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output  //字典下标返回的是一个可选值
        number /= 10
    } while number > 0
    return output
}
// strings is inferred to be of type [String]
// its value is ["OneSix", "FiveEight", "FiveOneZero"]
```
如果一个函数使用多个闭包，则可以省略第一个尾随闭包的参数标签，并标记其余的尾随闭包。
```swift
func loadPicture(from server: Server, completion: (Picture) -> Void, onFailure: () -> Void) {
    if let picture = download("photo.jpg", from: server) {
        completion(picture)
    } else {
        onFailure()
    }
}

loadPicture(from: someServer) { picture in
    someView.currentPicture = picture
} onFailure: {
    print("Couldn't download the next picture.")
}
```
在此示例中，该loadPicture(from:completion:onFailure:)函数将其网络任务分派到后台，并在网络任务完成时调用两个完成处理程序之一。通过这种方式编写函数，可以使您将负责处理网络故障的代码与成功下载后更新用户界面的代码完全区分开，而不必使用只处理两种情况的闭包。
## 捕获上下文的value
最简单的可以Capturing Values的闭包形式是嵌套函数，它写在另一个函数的主体内。嵌套函数可以捕获其外部函数的任何自变量，还可以捕获在外部函数内定义的任何常量和变量。

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```
## 函数和闭包是引用类型
将函数或闭包分配给常量或变量时，实际上就是在将该常量或变量设置为对该函数或闭包的引用。

```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
// returns a value of 10
incrementByTen()
// returns a value of 20
incrementByTen()
// returns a value of 30

let incrementBySeven = makeIncrementer(forIncrement: 7)
incrementBySeven()
// returns a value of 7

incrementByTen()
// returns a value of 40
```
如果将闭包分配给两个不同的常量或变量，则这两个常量或变量都引用同一个闭包。下例调用alsoIncrementByTen与相同incrementByTen，它们都引用相同的闭包，所以它们都递增并返回相同的运行总计。

```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 50

incrementByTen()
// returns a value of 60
```
## Escaping Closures(关于self的问题待研究)
当闭包作为函数的参数传递给闭包时，闭包被认为是对函数的转义，但是在函数返回后会被调用。声明将闭包作为其参数之一的函数时，可以@escaping在参数的类型之前编写，以指示允许对闭包进行转义。
闭包可以escaping的一种方法是将这个闭包存储在函数外部定义的变量中。
```swift
var completionHandlers = [() -> Void]()
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```
该someFunctionWithEscapingClosure(_:)函数将闭包作为其参数，并将其添加到在函数外部声明的数组中。如果未使用标记该函数的参数@escaping，则会出现编译时错误。

**如果self引用一个class的实例，则引用self的转义闭包需要特别考虑，可能会形成cycle。**
 例如，在下面的代码中，传递给`someFunctionWithEscapingClosure（_ :)`的闭包显式地引用了`self`。 相比之下，传递给`someFunctionWithNonescapingClosure（_ :)`的闭包是nonescaping closure，这意味着它可以隐式引用self。

```swift
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"
```

```swift
// 通过将self包含在闭包的捕获列表中来捕获self，然后隐式地引用self：
class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
```
## Autoclosures（待研究）
Autoclosures可以延迟evaluation，因为在调用闭包之前，内部代码不会运行。延迟评估对于具有副作用或计算量大的代码很有用，因为它使您可以控制何时评估该代码。
```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"
```
如果从不调用闭包，则闭包内部的表达式不会被求值，这意味着数组元素不会被删除。

```swift
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"


// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"
```
serve(customer:)上面清单中的函数采用显式闭包，该闭包返回客户的姓名。下面的版本serve(customer:)执行相同的操作，但不是采用显式的关闭，而是通过使用@autoclosure属性标记其参数类型来进行自动关闭。现在，您可以像调用带String参数而不是使用闭包一样调用函数。参数将自动转换为闭包，因为customerProvider参数的类型已用@autoclosure属性标记。

如果要允许自动关闭功能可以转义，请同时使用@autoclosure和@escaping属性。

```swift
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"
```

# Enumerations
## enum语法

```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}
var directionToHead = CompassPoint.west
directionToHead = .east     // 类型推断

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```
## 遍历enum

```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
// Prints "3 beverages available"

for beverage in Beverage.allCases {
    print(beverage)
}
// coffee
// tea
// juice
```
## Associated Values 

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."

// 如果都是let或者var可以放到前面去
switch productBarcode {
case let .upc(numberSystem, manufacturer, product, check):
    print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
case let .qrCode(productCode):
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```
## Raw Values
```swift
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
```
### Implicitly Assigned Raw Values

```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
// 当整数用于原始值时，每种情况的隐式值都比前一种情况大一。如果第一种情况未设置值，则其值为0。

enum CompassPoint: String {
    case north, south, east, west
}
// CompassPoint.south其隐式原始值为"south"，依此类推。

let earthsOrder = Planet.earth.rawValue
// earthsOrder is 3

let sunsetDirection = CompassPoint.west.rawValue
// sunsetDirection is "west"

let possiblePlanet = Planet(rawValue: 7)
// possiblePlanet is of type Planet? and equals Planet.uranus

let positionToFind = 11
if let somePlanet = Planet(rawValue: positionToFind) {
    switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
    }
} else {
    print("There isn't a planet at position \(positionToFind)")
}
// Prints "There isn't a planet at position 11"
```
## Recursive Enumerations
加前缀 `indirect`

```swift
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))
// (5 + 4) * 2

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}
print(evaluate(product))
// Prints "18"
```
# Structures and Classes
Swift不需要为自定义结构和类创建单独的接口和实现文件，**可以在单个文件中定义结构或类，并且该类或结构的外部接口会自动提供给其他代码使用。**
## struct和class的共同点和区别
- Define properties to store values
- Define methods to provide functionality
- Define subscripts to provide access to their values using subscript syntax
- Define initializers to set up their initial state
- 可以用extension扩展其功能
- 符合protocols以提供standard functionality 

class具有struct没有的其他功能：
- 继承使一个类可以继承另一个类的特征。
- 通过类型转换，可以在运行时检查和解释类实例的类型。
- 反初始化程序使类的实例可以释放其已分配的所有资源。
- 引用计数允许对一个类实例进行多个引用。

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

// 创建实例（对象）
let someResolution = Resolution()
let someVideoMode = VideoMode()

// 访问属性
print("The width of someResolution is \(someResolution.width)")
// Prints "The width of someResolution is 0"
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is 0"
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")
// Prints "The width of someVideoMode is now 1280"

// struct具有Initializers，class需要init
let vga = Resolution(width: 640, height: 480)
```
## struct和enum是value type值类型的
Swift中的所有基本类型（整数，浮点数，布尔值，字符串，数组和字典）都是值类型，所有结struct和enum都是值类型。这意味着创建的任何struct和enum实例以及它们具有的任何值类型作为属性，都将在它们在代码中传递时始终被**复制**。
由标准库定义的集合（例如数组，字典和字符串）使用优化来降低复制的性能成本。这些集合不共享立即复制的功能，而是共享存储在原始实例和任何副本之间的元素的内存。如果修改了集合的副本之一，则在修改之前就将元素复制。您在代码中看到的行为始终就像是立即进行了复制一样。

## class是引用类型
与值类型不同，将引用类型分配给var或let或将其传递给函数时，不会复制引用类型，而是都是同一个实例的引用。

可以通过 `===` 或者 `!==` 比较两个是否引用相同的实例
 `===` 表示var或者let都引用同一个实例，而`==`表示两个实例的值相等
```swift
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}
// Prints "tenEighty and alsoTenEighty refer to the same VideoMode instance."
```
## 指针
引用某种引用类型的实例的var或let类似于C中的指针，但不是指向内存中地址的直接指针，并且不需要写星号（*）来表示 您正在创建参考。 相反，这些引用的定义与Swift中的其他任何var或let一样。 

# Properties
## Stored Properties

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int  //创建后无法修改
}
var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4) //创建后无法修改
// this range represents integer values 0, 1, 2, and 3
rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property
```
## Lazy Stored Properties
Lazy Stored Properties在首次使用之前不会计算其初始值。

```swift
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
}

// 仅在首次访问该属性时才创建该属性的DataImporter实例
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
// the DataImporter instance for the importer property has not yet been created

print(manager.importer.filename)
// the DataImporter instance for the importer property has now been created
// Prints "data.txt"
```
## Computed Properties: get, set

```swift
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

// newValue
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {  // 省略return
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 只读的property可以省略get{}
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"
```
## Property Observers
可以在以下位置添加Property Observers：
- 定义的Stored properties
- 继承的Stored properties
- 继承的Computed properties
对于继承的属性，可以通过在子类中重写该属性来添加属性观察器。对于定义的计算属性，请使用属性的setter观察并响应值更改，而不是尝试创建观察者。

可以选择在属性上定义这些观察者之一或全部：
- willSet 在值存储之前被调用。则它将新的属性值作为常量参数传递。可以在实现中为此参数指定名称willSet。如果您未在实现中编写参数名称和括号，则该参数的默认参数名称为newValue。
- didSet 新值存储后立即调用。则会传递一个包含旧属性值的常量参数。您可以命名参数或使用默认参数名称oldValue。如果您在其自己的didSet观察器中为属性分配值，则分配的新值将替换刚刚设置的值。

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
```
## Property Wrappers
使用属性包装器时，定义包装器时，只需编写一次管理代码，然后通过将其应用于多个属性来重用该管理代码。

```swift
// 该TwelveOrLess struct确保包装的值始终 <= 12的数字
@propertyWrapper
struct TwelveOrLess {
    private var number: Int
    init() { self.number = 0 }
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"

// 将其属性包装在TwelveOrLess结构中，而不是将@TwelveOrLess编写为属性
struct SmallRectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
```
### 几种init方法
使用此属性包装器的代码不能为被包装的属性指定其他初始值，如SmallRectangle不能给出height或width初始值的定义。所以属性包装器需要添加一个初始化程序。

```swift
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

//通过init()初始化
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}
var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)
// Prints "0 0"


// 通过init(wrappedValue:)初始化
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}
var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width)
// Prints "1 1"


// 通过init(wrappedValue:maximum:)初始化
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"
```

```swift
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height)
// Prints "1"

mixedRectangle.height = 20
print(mixedRectangle.height)
// Prints "12"
```
height通过SmallNumber(wrappedValue: 1)初始化，default的最大值是12
weight通过SmallNumber(wrappedValue: 2, maximum: 9)初始化，最大值是9
## Projecting a Value From a Property Wrapper：$

```swift
@propertyWrapper
struct SmallNumber {
    private var number: Int
    var projectedValue: Bool
    init() {
        self.number = 0
        self.projectedValue = false
    }
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}
struct SomeStructure {
    @SmallNumber var someNumber: Int
}
var someStructure = SomeStructure()

someStructure.someNumber = 4
print(someStructure.$someNumber)
// Prints "false"

someStructure.someNumber = 55
print(someStructure.$someNumber)
// Prints "true"
```
当从属于类型一部分的代码中访问projected value时（如属性获取器或实例方法），可以self.像访问其他属性一样在属性名称之前省略。下面例子height 和width的projected value是$height 和 $width

```swift
enum Size {
    case small, large
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}
```
## 全局和局部变量
全局常量和变量总是 computed lazily。与 Lazy Stored Properties不同，全局常量和变量不需要用lazy修饰符标记。
局部常量和变量绝不会延迟计算。
## Type Properties（待研究）
Instance properties实例属性是属于特定类型的实例的属性。每次创建该类型的新实例时，它都有自己的属性值集，与其他任何实例分开。可以定义属于类型本身的属性，而不是属于该类型的任何一个实例的属性。

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"
```
