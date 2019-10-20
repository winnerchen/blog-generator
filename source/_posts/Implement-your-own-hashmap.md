---
title: Implement your own HashMap
date: 2017-09-05 14:37:44
tags:
copyright: true
---
# 1. Introduction
As one of the important members of data structure in Java, HashMap has high performance in both insertion and query. Recently, I have learnt to know its power when I was working on the project. HashMap provides both high flexibility and scalability for font and back end data interactions that cannot be replaced by other data structures. Its key-value pair structure naturally provides good support for Json transformation. This article mainly analysis the theory of HashMap and how to implement your own HashMap.
<!--more-->

# 2. Theory of HashMap
## 2.1 What is HashMap？
In computing, a hash table (hash map) is a data structure which implements an associative array abstract data type, a structure that can map keys to values. A hash table uses a hash function to compute an index into an array of buckets or slots, from which the desired value can be found. -- From Wikipedia, the free encyclopedia
## 2.2 What is hash
Hash is an algorithm, which can map a binary value with random length to a binary value with fixed length. In a HashMap, hash algorithm is mainly used to calculate the index that its value needs to be stored in. In one word, the storage process of a value is based on the hash value of its key.

The performance of a hash algorithm depends on whether it can store data into an array with good distribution so that collisions can be avoided. 

There are many hash functions existed, and I will take division method as an example. First, define the length of an array, 16 for example (16 is also the default length of HashMap in JDK). Therefore, the index should be key mod m, and the value of m should be the maximum prime number that is less than the length of the array.m is therefore is 13 in this case. Such algorithm would lead to situation like this: we might get same index for different given keys. If that’s the case, we need to handle collisions. 

Ps. The hash algorithm in JDK is much more complicated. The example above is just an example for readers to understand more easily. 

## 2.3 Handling collisions
There are many solutions to handle collisions, and in this article I will introduce two methods and I will demonstrate how to solve this issue with one of them.
-	Linear Probing
When collision happens, find whether next index has been occupied or not, if not then store data into that index. If it is already occupied, repeat previous process until it finds a slot.
-	Linked list
Since data is stored in the form of entry object in HashMap, and an entry contains key, value and next pointer. Therefore we can handle collisions using LinkedList form, that is taking out the original data in this slot and place new data into it and then set the next pointer to the original data, which means the head of the this linkedlist is always the latest data. 

# 3. Implement your HashMap

## 3.1 Map Interface
The top interface of HashMap is Map, which means we need our own interface if we want to implement our own map. The map interface of our HashMap is defined as MyMap<K,V> and it should have these three functions:
- put(K k,V v)
- get(K k)
- size()

and an internal interface
- Entry<K,V>

It should contains two functions
- getKey()
- getValue()

Java code:
```Java
public interface MyMap<K,V> {
    /**
     * put function
     * @param k
     * @param v
     * @return
     */
    V put(K k, V v);
    /**
     * get function
     * @param k
     * @return
     */
    V get(K k);

    int size();
    /**
     * Entry interface
     * @param <K>
     * @param <V>
     */
    interface Entry<K, V>{
        /**
         * get the key in an entry object
         * @return
         */
        K getKey();
        /**
         * get the value in an entry object
         * @return
         */
        V getValue();

    }
}
```
## 3.2 Implementation of internal class Entry
Once the interface is designed, we need to create a class to implement all its functions. The class MyHashMap is created to implement MyMap interface.

An internal class is also necessary for the implementation of internal interface of MyMap. The instance of this internal class is entry, which will be stored into the array. This class should have three global variables, which are K, V and Next pointer. The type of next is entry itself because it points to the next entry object.

Java code:
```Java
class Entry<K, V> implements  MyMap.Entry<K, V> {

        K k;
        
        V v;
        
        Entry<K, V> next;
        
        public Entry(K k, V v, Entry next) {
            this.k = k;
            this.v = v;
            this.next = next;
        }

        @Override
        public K getKey() {
            return k;
        }

        @Override
        public V getValue() {
            return v;
        }
    }
```
## 3.3 Define global variables
A hashmap contains the following global variables:
- default length of the array
- default loading factor
- an entry array
- the size of this hashmap

```Java
//Default length of the array, initial value is 16
private static int defaultLength = 16;
//Loading factor, 0.75 by default
private static double defaultLoader = 0.75;
//Entry array
private Entry<K, V>[] table = null;
//The size of this hashmap
private int size = 0;
```
## 3.4 Define constructor 
Since the default length and default loading factor can be customized in HashMap, we can define a constructor with array length and loading factor as parameters.
```Java
     /**
     * customize default array length and loading factor
     * @param length
     * @param loader
     */
    public MyHashMap(int length, double loader) {
        defaultLength = length;
        defaultLoader = loader;
        //initialize entry array
        table = new Entry[defaultLength];
    }
```
If parameters are not specified, we use default value
```Java
    /**
     * use default values
     */
    public MyHashMap() {
        this(defaultLength, defaultLoader);
    }
```
## 3.5 Define hash function
It is mentioned above that we are using mod method for our hash function. First define an int m, the value of m should be the maximum prime number that is less than the length of its array. I set the value of m to be the length of the array to simplify the algorithm.
```Java
     /**
     * customize hash algorithm
     * get the value of index from the hash value of its key, it is the index in which data needs to be stored
     * @param k
     * @return
     */
    private int getKey(K k) {
        int m = defaultLength;
        int index = k.hashCode() % m;
        return index >= 0 ? index : -index;
    }
```

## 3.6 Implement put function 
First, we need calculate the index of the array using hash algorithm, and then store the entry object that contains key, value and next pointer to that slot.

Before we do that we need to determine if that slot is occupied. It should be handled differently according to the situation. Detailed explanations are given in the comments.
```Java
public V put(K k, V v) {
        //calculate the index of a given key
        int index = getKey(k);
        Entry<K, V> entry = table[index];
        //determine if entry is null
        if (entry == null) {
            /*
            * if entry is null, it means there is no data in this slot
            * create an entry object
            * next pointer has no value at this moment because there is only
            * one entry object in this slot
            * */
            table[index] = new Entry(k, v, null);
            //size of map + 1
            size++;
        } else {
            /*
            * if entry is not null, it means there is at least one entry in
            * this slot
            * create an entry object
            * set the next pointer to be previous entry and replace the data
            * in the array
            * */
            table[index] = new Entry<K, V>(k, v, entry);
        }
        return table[index].getValue();
    }
```
## 3.7 Implement resize mechanism of HashMap
The principle of resize in hashmap is that when the size of map is greater than default length * loading factor, the length of the array will be doubled and data in the array will be rehashed and restored. Therefore, in previous put function, we need to first determine if the size of hashmap has reach the boundary of resize, and then execute rest of the code. 

```Java
    //resize of the array
    private void expand() {
        //create an entry array that its length is two times as previous
        Entry<K, V>[] newTable = new Entry[2 * defaultLength];
        //call rehash function
        rehash(newTable);
    }
    //the process of rehash
    private void rehash(Entry<K,V>[] newTable) {
        //create a list to store all the entry objects in the hashmap
        List<Entry<K, V>> list = new ArrayList<Entry<K, V>>();

        //traverse the array
        for(int i=0; i<table.length;i++) {
            //continue if the given slot has no data
            if (table[i] == null) {
                continue;
            }
            //store all entries into the list using recursive method
            findEntryByNext(table[i],list);
            if (list.size() > 0) {
                //reset size
                size = 0;
                //double the default size
                defaultLength = 2 * defaultLength;

                table = newTable;
                for (Entry<K, V> entry : list) {
                    if (entry.next != null) {
                        //set next pointer of all entries to null
                        entry.next = null;
                    }
                    //rehash new table
                    put(entry.getKey(), entry.getValue());
                }
            }
        }
    }

    private void findEntryByNext(Entry<K, V> entry,List<Entry<K, V>> list ) {
        if (entry != null && entry.next != null) {
            list.add(entry);
            //call recursive function
            findEntryByNext(entry.next,list);
        }else {
            list.add(entry);
        }
    }
```
## 3.8 Implement get function 
As it is mentioned above, the nature of hash algorithm might lead to the scenario that multiple entries stored in the same index. Therefore, we need to find the real entry object by comparing the key value.
```Java
    public V get(K k) {
        //get the index that the entry is stored
        int index = getKey(k);
        //non-empty check
        if (table[index] == null) {
            return null;
        }
        //call function to find the real value and then return
        return findValueByEqualKey(k,table[index]);
    }

     /**
     * find real value by recursive comparison
     * @param k
     * @param entry
     * @return
     */
    public V findValueByEqualKey(K k , Entry<K,V> entry) {

        /*
        * if key of this parameter equals to the key of this entry, that means
        * this is the target entry
        * */
        if (k == entry.getKey() || k.equals(entry.getKey())) {
            return entry.getValue();
        } else {
            /*
            * if they are not equal, use recursive method to compare the key of its next pointer to find the real value
            * */
            if (entry.next != null) {
                return findValueByEqualKey(k, entry.next);
            }

        }
        return entry.getValue();
    }
```
Since the size function is rather easy, all we need to do is return the variable size, I just paste the code here.
```Java
    //return the size of the map
    public int size() {
        return size;
    }
```
At this point, the basic function of a HashMap is completed. That includes put function, get function and its resize mechanism. In the next section, I will write a test class to test the code see if they are implemented correctly. In the meantime, its performacne needs to be tested as well.
# 4. Test MyHashMap
## 4.1 Output test

Write a test class to check if the output of our HashMap and the output of HashMap in JDK are the same.

```Java
/**
 * @Author: Yiheng Chen
 * @Description: Map test class
 * @Date: Created in 4:33 2017/9/1
 * @Modified by:
 */
public class MyMapTest {
    public static void main(String[] args) {

        MyHashMap<String,String > map = new MyHashMap();

        Long t1 = System.currentTimeMillis();
        for (int i=0; i<1000;i++) {
            map.put("key" + i, "value" + i);
        }

        for (int i = 0; i < 1000; i++) {
            System.out.println("key: " + "key" + i +"---"+ "value: " + map.get("key" + i));
        }
        Long t2 = System.currentTimeMillis();

        System.out.println("time consumed by MyHashMap："+(t2-t1));
        System.out.println("-------------------HashMap-------------------------" );

        Map<String,String > hashMap = new HashMap();

        Long t3 = System.currentTimeMillis();
        for (int i=0; i<1000;i++) {
            hashMap.put("key" + i, "value" + i);
        }

        for (int i = 0; i < 1000; i++) {
            System.out.println("key: " + "key" + i + "---"+ "value: " + hashMap.get("key" + i));
        }
        Long t4 = System.currentTimeMillis();
        System.out.println("time consumed by HashMap in JDK: "+(t4-t3));

    }
}
```
Part of the output:
```
key: key980---value: value980
key: key981---value: value981
key: key982---value: value982
key: key983---value: value983
key: key984---value: value984
key: key985---value: value985
key: key986---value: value986
key: key987---value: value987
key: key988---value: value988
key: key989---value: value989
key: key990---value: value990
key: key991---value: value991
key: key992---value: value992
key: key993---value: value993
key: key994---value: value994
key: key995---value: value995
key: key996---value: value996
key: key997---value: value997
key: key998---value: value998
key: key999---value: value999
```
It can be seen that the result of our HashMap is excatly the same as the output of HashMap in JDK. It indicates that our HashMap is successfully implemented.
## 4.2 Performance test

Result of the performance test:
```
time consumed by MyHashMap：30
-----------------------
time consumed by HashMap in JDK：19
```
Without doubt, the HashMap in JDK is obviously more powerful than the one I implemented. The HashMap in JDK may be the most optimized implementation of map. However, the performance of our own HashMap can be considered acceptable, given the simplicity of the code.

Thanks for reading.

