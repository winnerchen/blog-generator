---
title: Spring QuickStart
date: 2017-10-19 18:37:02
tags:
copyright: true
---
# 1. Introduction
## 1.1 What is Spring
The Spring Framework is an open-source application framework that is hierarchical, full-stack and lightweight.

### 1.1.1 JavaEE Hierarchy

Three-layer structural system of JavaEE standard:

- Presentation Layer(display of webpage data, navigation and dispatch of webpage), e.g. Jsp/Servlet.
- Business Logic Layer(business process, function logics and transaction control), e.g. service
- Data Presistence Layer(data access and encapuslation, interaction with database), e.g. dao
<!--more-->

They are illustrated in below image.
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/spring_1.png)

### 1.1.2 Full Stack:
Spring Framework provides solutions for all JavaEE layers

- Presentation Layer: Struts2, SpringMVC
- Business Logic Layer: IOC, AOP, Transaction control
- Data Presistence Layer（JDBCTemplate, HibernateTemplate, ORM framework integration)

### 1.1.3 Lightweight:
The introduction of Spring has replaced its previous framework, EJB, which is inefficient, cumbersome and complex.Not to mention that using Spring to program is non-invasive.

## 1.2 System Architecture of Spring
The Spring framework is a hierarchical architecture that contains a set of functional elements and  is divided into about 20 modules. These modules are Core Container, Data Access/Integration, WEB, AOP(Aspect Oriented Programming), Instrumentation and testing part, as shown in below figure:
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/spring_2.png)

### 1.2.1 Core Container
- It includes 4 modules: <font color=red>Core, Beans, Context and Express Language</font>
- <font color=red>Core and Beans module</font> provide the most fundamental functions of Spring: IoC(Inversion of control) and DI(Dependency Injection). The basic concept here is BeanFactory, which provides a classic implementation of the Factory pattern to eliminate the need for singleton patterns and utimately allows you to separate dependencies and configurations from program logic.
-  The <font color=red>Context module</font> is built on Core and Beans module, which provides the function of accessing to objects in a framework style. The Context wrapper inherits the functionality of beans package, which also includes internationalization(I18N), event propagation, resource loading, and transparent construct contexts, as well as support for a large number of JavaEE features such as EJB and JMX. It’s core interface is ApplicationContext. 
-  The <font color=red>Expression Language module</font> provides the ability to query and manipulate object graphs during runtime. It supports access and modification for attribute values, arrays, containers and indexers. It also provides support for arithmetic and logical operations, list projections, selection and general list aggregation, as well as support for object access from Spring container. 

### 1.2.2 Data Access/Integration
- <font color=red>JDBC module</font> provides an abstraction of JDBC that eliminates the lengthy JDBC encoding and parsing database vendor-specific error code.
- <font color=red>ORM module</font> provides an integrated layer of commonly used "object / relational" mapping APIs, including JPA, JDO, Hibernate and iBatis. With the ORM package, you can mix all the features provided by Spring to support “object/relation”mappings, such as simple declarative transaction management.
- <font color=red>Jms module</font> provides a set of “message producer/consumer” template to simplify the use of Jms. JMS is employed between two applications, or sending message in distributive system to implement asynchronous communication. 
- <font color=red>Transaction module</font> provides support for simple declarative transaction management. Objects that are managed by Spring can all benefit from Spring transaction management, even it is a POJO e.g. Spring can also provide transaction control to POJO.

### 1.2.3 Web
- <font color=red>Web module</font> provides fundamental web functions, such as multi-file upload, integration of IoC container, remote process access, and support for Web Service. It also provides a RestTemplate class to improve the convenience of Restful services access.
- <font color=red>Web-Servlet module</font> provides a Model-View-Controller (MVC) implementation for Web applications. The Spring MVC framework provides annotation-based request resource injection, simpler data binding, data validation, and a set of easy-to-use JSP tags that work seamlessly with other Spring technologies.
- <font color=red>Web-Struts module</font> provides support for Struts integration, this feature is not recommended in the Spring3.0, it is recommended that you should transfer to Struts2.0 or Spring MVC.
- <font color=red>Web-Protlet module</font> provides the implementation under Portlet environment.

### 1.2.4 AOP
- The <font color=red>AOP module</font> provides an aspect-oriented programming implementation that conforms to the AOP alliance specification so that you can define method interceptors and cutting points. Logically, it can reduce the code coupling so that functions be clearly separated. Moreover, the use of source-level metadata function, you can also combine a variety of behavioral information into your code.
- The <font color=red>Aspect module</font> provides integration for AspectJ
- The <font color=red>Instrumentation module</font> provides tool support for class-level and implementation for ClassLoader-level that can be used in some specific application servers.

### 1.2.5 Test
- The <font color=red>Test module</font> provides support for testing Spring components using JUnit and TestNG, which provide consistent ApplicationContexts to cache these contexts. It also provides some mock objects that allow you to test your code independently.

## 1.3 The core of Spring
- IoC(Inversion of control): Handover the management of objects to Spring factory.
- AOP(Aspect Oriented Programming): Functional enhancement based on dynamic proxy

## 1.4 The advantages of Spring

The introduction of Spring aims to solve the practical issues of JavaEE:
- Remove dependency and simplify development
	- Spring is a large factory that can manage the creation and dependency maintenance of any objects
- Support for AOP
	- Spring provides support for AOP, which can easily implement functions such as access control, runtime monitoring, logging and etc.
- Support for declarative transaction control
	- Implement the management of transaction by configuration file, without manual program.
- More convenient program testing
	- Spring provides support for JUnit4, which allows us to test Spring program conveniently by annotation.
- Provide integration for a variety of excellent frameworks
	- Spring does not exclude other well designed open source framework. It provides direct support for other excellent framework such as Struts2, Hibernate, MyBatis, Quartz, etc.
- Reduce the complexity of using JavaEE API
	- Spring provides encapsulation for APIs that are difficult to use during JavaEE development, such as JDBC, JavaMail, remote method invocation, etc. 

# 2. Spring IoC quick start
Basic development procedure of Spring core context
- Download development package, import jar
- Coding
- Write configuration file

## 2.1 Coding
### 2.1.1 Traditional Business logic coding (business layer, data persistence layer)
The example I use here is simulation of user login operation

1.  Create interface IUserDao
```java
public interface IUserDao {

	//query data from database according to username and password

	public void findByUsernameAndPassword();

}

```
2. Create implementation class of interface IUserDao
```java
//Implementation class of dao
public class UserDaoImpl implements IUserDao {
	@Override
	public void findByUsernameAndPassword() {
		System.out.println("function findUserByUsernameAndPassword of UserDaoImpl has been called...");
	}
}

```
3. Create interface IUserService
```java
//business layer
public interface IUserService {
	//login
	public void login();
}

```
4. Create implementation class of interface IUserService
```java
//Business layer implementation
public class UserServiceImpl implements IUserService{

	public void login() {
		System.out.println("UserServiceImpl_login function has been called...");
		//instantiate dao
		IUserDao userDao = new UserDaoImpl();
		userDao.findByUsernameAndPassword();
	}
}

```
5. Test
```java
public class SpringTest {
	@Test
	public void test(){
		//create service instance
		IUserService userService = new UserServiceImpl();
		userService.login();
		
	}
	
}

```

Console:
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/spring_3.png)

In the example above, we are instantiating UserDaoImpl in UserServiceImpl class, which mean this class directly depends on UserDaoImpl class.This would cause many issues, e.g. error would occur if we want to change the implementation class, or rename the implementation class. It means that we will have to modify original code.

Solution: Inversion of Control

## 2.2 Implementation of IoC
Using IoC (Inverse of Control) to solve the problem of code coupling. In one word, we introduce facotry that manage the object relations instead of manually create dependencies.
1. Create a factory that provide userDao instance
UserDaoFactory.java
```java
public class UserDAOFactory {
	//provide function to get object
	public UserDAOImpl getUserDAO(){
		//return this instance
		return new  UserDAOImpl ();
	}
}

```
2. Modify the code in UserServiceImpl
```java
public class UserServiceImpl implements IUserService{
	public void login() {
		 System.out.println("UserServiceImpl_login function has been called...");
		 //Create factory, get dependency from it
		 UserDAOFactory userDAOFactory = new UserDAOFactory();
		 UserDAOImpl userDAO = userDAOFactory.getUserDAO();
		 userDAO.findUserByUsernameAndPassword();
	}
}
```

Above method does solve code coupling between these two class. However, the function in factory class still requires a specific instance. The solution here is reflection.

Solution: Create instance of object by reflection, which pass in a string that specify the dependency class

UserDAOFactory.java:
```java
	public Object getBean(){
		Object bean = null;
		try {
			bean = Class.forName("yiheng.chen.spring.a_quickstart.UserDAOImpl").newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return the instance
		return bean;
	}

```

UserServiceImpl.java:
```java
IUserDAO userDAO = (IUserDAO) userDAOFactory.getBean();
userDAO.findUserByUsernameAndPassword();

```



Let's think,above solution use a fixed string to create instance, so how can we dynamically pass in different string?

The solution is XML  configuration file

It comes to an end that the IoC underlying implementation is a combination of <font color=red>factory(design pattern), reflection(mechanism)</font>,and  <font color=red>configuration file(XML)</font>.

## 2.3 Obtain Bean objects from Spring factory
1. Configure applicationContext.xml
```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
http://www.springframework.org/schema/beans 
http://www.springframework.org/schema/beans/spring-beans.xsd">

<bean id="userDAO" class="yiheng.chen.spring.a_quickstart.UserDAOImpl" />

</beans>
```

2. Modify the code in UserServiceImpl class
```java
	//Create Spring factory, load Spring configuration file
	 ApplicationContext ac = new 		  ClassPathXmlApplicationContext("applicationContext.xml");
	 IUserDAO userDAO = (IUserDAO) ac.getBean("userDAO");
	 userDAO.findUserByUsernameAndPassword();
```


## 2.4 Implementation of DI
DI(Dependency Injection): When Spring framework is creating Bean object, it injects dependencies into bean components. 

1. Configure applicationContext.xml
```java
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="
http://www.springframework.org/schema/beans 
http://www.springframework.org/schema/beans/spring-beans.xsd">

<bean id="userDAO" class="yiheng.chen.spring.a_quickstart.UserDAOImpl" />

<bean id ="userService" class="yiheng.chen.spring.a_quickstart.UserServiceImpl">
	<!-- Inject object -->
	<!-- property inject dependency based on the setter function of the class -->
	<!-- ref: the object that it is refer to, its values is the id/name of that bean -->
	<property name="userDAO" ref="userDAO" />
</bean>

</beans>

```

2. Provide setter function
UserServiceImpl.java
```java
public class UserServiceImpl implements IUserService{
	
	//define attribute
	private IUserDAO userDAO;

	public void setUserDAO(IUserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public void login() {
		 System.out.println("UserServiceImpl-service层方法调用了");
		 
		 userDAO.findUserByUsernameAndPassword();
		
	}

```
3. Run test(the object must be obtained from Spring factory. Object that is mannually instantiated has no dependency injection)

```java
public class SpringTest {
	@Test
	public void test(){
		ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		IUserService userService = (IUserService) ac.getBean("userService");
		
		userService.login();
		
	}
	
}

```
## 2.5 Spring Factory
ApplicationContext is used to load Spring framework configuration file, to create Spring factory object. It is also known as Spring container.

![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/spring_4.png)

Why don't we just use the top interface to operate?

- BeanFactory uses lazy load strategy, it initialize bean after user first call getBean function.
- ApplicationContext is an extension of BeanFactory which provides more functions.
	- Internationalization(I18N)
	- Event propagation
	- Bean autowire
	- Context implementation of different application layer

Since ApplicationContext is much more powerful, it is rare to see BeanFactory used in development.

PS. There is a difference between BeanFactory and FactoryBean. We will discuss it later.

There are two ways of obtaining beans from IoC container

- by its id/name 
- by the its class or the class of its interface

# 3. Assemble bean in IoC container

## 3.1 Four ways of instantiating Bean

- Use default constructor(most common)
- Static factory method
	1. Define bean class
	2. Define factory Class and write static function to return the bean
	3. Configure applicationContext.xml, specify class and factory-method
- Instance factory method
	1. Define bean
	2. Define factory class and write non-static function to return the bean
	3. Configure applicationContext.xml, specify class of the factory, and factory-method and factory-bean of that bean 
- FactoryBean
	1. Define bean
	2. Create MyFactoryBean class and implement FactoryBean interface
	3. Configure applicationContext.xm

What is the difference between FactoryBean and BeanFactory?

- BeanFactory is a factory, it actually create the environment for Spring context. it is used to manage bean instance.
- FactoryBean is a tool which generates beans. It is a bean that we use to obtain a specific type of object. It is one way to instantiate bean instance.

## 3.2 Scope of Bean
![](https://raw.githubusercontent.com/winnerchen/yiheng.github.io/master/images/spring_5.png)

We normally use <font color=red>Singleton</font> and  <font color=red>Prototype</font> in the project development.

## 3.3 The life cycle of bean 
We are able to control the life cycle of bean through Spring factory

### 3.3.1 Configure init and destory function of bean

- Specify the function that will be invoked after instantiation by specifying init-method
- Specify the function that will be invoked after the object is destory by specifying destory-method

Steps:
1. Create LifeCycleBean, specify an init function and a destory function
```java
public class LifeCycleBean {

	//define constructor
	public LifeCycleBean() {
		System.out.println("LifeCycleBean constructor is called");		
	}
	
	
	public void init(){
		System.out.println("LifeCycleBean-init, called after instantiation");
	}
	
	
	public void destroy(){
		System.out.println("LifeCycleBean-destroy called when object is destory");
	}

}

```
2. Configure applicationContext.xml
```java
<bean id="lifeCycleBean" class="yiheng.chen.spring.d_xmllifecycle.LifeCycleBean" init-method="init" destroy-method="destroy" />
```

## 3.4 Dependency injection of bean attribute

What is attribute injection of bean? It means assigning values to the attributes of an object.

There are two ways of doing that:

- by passing the parameters in the constructor
- by using setter function

### 3.4.1 Attribute injection by constructor
1. Define bean and its constructor 
```java
public class Car {
	private Integer id;
	private String name;
	private Double price;
	//Constructor with arguements
	public Car(Integer id, String name, Double price) {
		this.id = id;
		this.name = name;
		this.price = price;
	}
	
	@Override
	public String toString() {
		return "Car [id=" + id + ", name=" + name + ", price=" + price + "]";
	}

}

```
2. Configure applicationContext.xml
```java
<!-- use constructor to inject values into attributes-->
	<bean id="car" class="yiheng.chen.spring.e_xmlpropertydi.Car">
		<!--constructor-arg：indicate that we are using constructor with arguements instead of the default one
		new Car(1,"BMW",99999d)
		1st group of parameters：locate attribute
		    * index:locate attribute by index，0 means the first one
			* name：locate attribute by its name
			* type:locate attribute by its data type 
		2nd group of paramters：values
			* value:simple values, strings
			* ref: bean objects that are created by spring containter
		-->
		<!-- <constructor-arg index="0" value="1"/> -->
		<constructor-arg index="0" name="id" value="1"/>
		<!-- <constructor-arg name="name" value="BMW_X3"/> -->
		<constructor-arg name="name" >
			<value>BMW_X6</value>
		</constructor-arg>
		<constructor-arg type="java.lang.Double" value="99999d"/>
	</bean>

```
### 3.4.2 Attribute injection by setter
It uses the default constructor, however it must be provided by setter function. This method is commonly used in enterprise Java development

1. Create java bean, define attributes
```java
public class Person {
	private Integer id;
	private String name;
	private Car car;
	
	public void setId(Integer id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setCar(Car car) {
		this.car = car;
	}
	
	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + ", car=" + car + "]";
	}

}

```

2. Configure Spring container
```java
<bean id="person" class="yiheng.chen.spring.e_xmlpropertydi.Person">
		<property name="id" value="1001"/>
		<property name="name" value="Tom"/>
		<property name="car" ref="car"/> 
	</bean>
```