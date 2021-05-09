---
title: Deep Dive Into Java8 Stream
date: 2019-11-14 10:56:28
copyright: true
tags:
- java
- java 8
- stream
categories:
- Coding
---
## What is stream
* Before we start, let's image a scenario where you have a collection of apples and you want to filter them by their weight, and you only want to keep apples that are more than 100 grams, how would you do it? Before Java8 and Stream was introduced, you might write code like this to iterate over the collection and store the ones that match the condition to another list.

``` java
public List<Apple> filterByWeight(List<apple> apples, int weight){
    List<Apple> filteredApples = new ArrayList<>();
    for (Apple apple : apples){
        if(apple.weight > weight){
            filteredApples.add(apple);
        }
    }
    
    return filteredApples;
}
```

<!--more-->

Client code which invokes this method would be like this:

```java
List<Apple> filteredApples = filterByWeight(apples,100)
```
The above code complies and runs perfectly fine and it might also be effective. 

Now let's take a look at what we can achieve with the help of Stream.

```Java
List<Apple> filteredApples = apples.stream().filter(e-> e.weight>100).collect(toList());
```
Yes, that's right. With the help of stream we are able to reduce the number of lines of code from about 10 to 1.

But let's take a closer look at both implementations, and try to understand the key difference and what's really important.

The first implementation, we tell program how to iterate over our collection and how it should perform in each iteration. We call this Imperative Programming, in which you tell what to do.

The second implementation, we tell the program what we what to achieve, and the underlying implemenation will take care of the iteration logic. This is what we call declarative programming.

So what's so good about writing code in a declarative way? 

* It is more flexible - more adaptive to requirement changes
    - if we want to filter apples by it's price, without stream we will have to implement a new method which iterate over the collection of apples and filter them by price. 
    - with stream we can simply replace the lambda express which define what we want to perform on this collection, e.g.
```Java 
List<Apple> filteredApples = apples.stream().filter(e-> e.price > 2.5).collect(toList());
```
* It is clearer and more consice 
* Is is more readable and hence easier to maintain

Now let's get back to the topic, what is Stream really? For starters, Streams are an update to the Java API that lets you manipulate collections of data in a declarative way (you express a query rather than code an ad hoc implementation for it), so for now you can think of them as fancy iterators over a collection of data.

Stream gives us the ability to write code that's

- **Declarative**— More concise and readable
- **Composable**— Greater flexibility
- **Parallelizable**— Better performance


## Get started with streams

Let's look at a bit more complicated example, get the names of the first three dishes which calories is higher than 300. Take a look at the following code that's implemented using Stream api.

```java
List<String> threeHighCaloricDishNames = menu.stream()
	.filter(e -> e.getCalories > 300)
	.map (Dish::getName)
	.limit(3).
	.collect(toList());
```

Imagine you have to implement this using external iteration (for loops), and compare to above implementation, you can already see the advantages of using streams. The code we've just written is very clear and descriptive, it tells us and the machine exactly what needs to be done, "find the names of the first 3 dishes which has calories higher than 300". Rather than implementing the functionalities, we simply tell the program what needs to be done, and as a result, the program has more flexibility to decide how to optimize the pipeline processing. e.g. all the operation can be merged in to one and stop as soon as 3 matched dishes is found.

### Common Stream API
The Stream interface defines many operations and they can be classified into two categories, namely intermediate operation and terminal operations

- Intermediate operation - any operation that returns a stream is a intermediate operation
- Terminal operation - any operation that closes a stream is a terminal operation


#### Intermediate operation

- filter - expecting a predicate (take one arguement and return a boolean), filter out elements that does not match the predicate
- map - extract 
- distinct
- sorted
- peek
- limit

#### Intermediate operation

- forEach
- reduce
- count
- anyMatch


