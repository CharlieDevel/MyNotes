

The key to being able to solve problems of an entire project with lots and lots of things to do and matters like non functional and functional requirements and stuff, is to actually view everything and reality **as is** by outlining each component of the whole system, **this is viewing reality**(the **Resources**) and **its value to us but as a whole**(the sum of the parts), and of course this is immense, and the way to be able to manage them is by making **our own rules of perception** and define **which part of reality is *valuable* to us in that sense**(the **Viewpoints**, like we do with our **eyes** which perceives a part of the real world, and so do the **ears** catching another part of the real world, and both making up the entire reality)
1. Identify the **Resources** that you are working with
Things such as 
* Data
* Components of a system that process the data
* Whole systems that interact with one another on a set of criteria and circumstances
All of that are **Resources you want to visualize** and make sure to be known by **everyone**
> At this point it all seems like just making code with classes that addresses a problem or we make an existing class solve a new problem
> BUT the thing is that we need to **understand it INTEGRALLY**, this brings a new definition to **defining the Resource**, this is not just a google definition or something, we need to define it **with our *VIEWPOINTS* that fits our own needs and context in which we are working with, what it *means* to us from the different perspectives of the stakeholders**
> Thus, a Resource can be defined as:
	`User Data: Database Viewpoint, Security Viewpoint, User Viewpoint, etc`
> This example is a definition of a **Resource**, defined only with **Viewpoints**, and the reason it is like this is because the viewpoints will contain the instructions on how to view the real world things, but from different aspects INSTEAD of a GENERALISTIC Viewpoint, which tends to work but not fully
- DON'T forget that the way to understand a Resource is a high level description of it, you should also be able to describe the Resource as what it actually is(like the **implementation** of the abstraction, because we can treat the implementation as the abstracion, but we can handle the implementation ***differently*** than the abstraction)>   
> Normally this results in writing a LOT of information for each thing
> Including even making a **WHOLE Parts-Tree** for each Resource if it is convenient to do
 
### Ports of Resources
Another important component to add to the Resources are ***ports and influencers***, which is the input of the Resource that is able to *influence* the Resource's behaviour, and NOTE that you are not the ONLY one able to influence a Resource, **other resources or even forces are able to influence it(i. e. time)**
> It is specially important to take into account that this is done because what we are trying to model is **COMPLEX**, and thus things like expert opinions or best practices **are BAD**, because we need to **study the system or problem to be understood**

### Viewpoint 
**Viewpoints** are defined as: A list of statements of things that perceive a part from **reality and the Resources**, where we are able to define a Resource in a unique way rather than a general definition like just having a security viewpoint, and then a list of things like: `Sensitive Data should be encrypted` or `When Server receives data, encrypt the data`, it is beneficial to follow a pretty simple and conscice way and mention the **explicit resources in action** like `Data`, and a **predicate of what happens to the Resource**, like `Transaction Data can only be viewed by Emisor and Receptor`, because viewpoints are supposed to DEFINE the Resources in their unique perspective, you can also add in parentheses which resource the statement is interested in
   - When defining requirements of the entity, you can create a new Viewpoint and put the requirements in there, and stop putting requirements when there are statements that belong to another Viewpoint(which can be created or assigned to an existing one), and if these requirements are from the client or something similar, then it is better to create a brand new Viewpoint named as the original Viewpoint of the client but with an `advanced` appended to it or something that expresses that this is viewed differently than the original Viewpoint

*ADDITIONAL NOTE*: **Objectives/Problems to solve** can be created from **Viewpoints**, which can be mapped to (Stakeholders/Interested parts) that care about the system in different views, allowing us to see the problem with **multiple dimensions**(Although the problem comes when a stakeholder, like a Developer, isn't just **one viewpoint**(the Developer Viewpoint) but actually a **SET of Viewpoints** that each can be separated and also divided **Orthogonally**, like the Security Viewpoint, Database Viewpoint, etc)

ARCHIVED:
* Requirements and problems(which are the things that you start **(the system/add new functionality)**)
	This will either mean the **creation of a new Resource** or ***propagating* the (objective/problem to solve) to an already existing Resource**
	WHICH if we propagate the objective(which is another Resource), then the existing Resource now **inherits** all the characteristics of the things it will be responsible of(like authenticating someone, which can easily be delegated to a component, **but now the data to be authenticated is as vulnerable as the component itself**)


2. Link the Resources with other Resources
This means to make **relationship diagrams** between these resources where we express how does a resource interact with others to achieve **objectives/solve problems** in a **granular level**(this means a **functionality** of the system, like processing a Post in a social media app) which make up our entire **complex** system


3. Visualize the Resources **multi-dimensionally**
This means to basically create multiple orthogonal viewpoints
This lets us see the resources **not only in one dimension, which is the GENERALIST viewpoint**, but to visualize the resources **in the multiple dimensions that they have(only if there is a certain characteristic of something that you need)**,e.g. having a social web app, where you naturally view things as just **satisfying the user needs**, which is a **viewpoint BUT** it is hidden AND **replaced** by the GENERALIST VIEW that we all humans have, which lets us understand everything more easily and in a more **integral manner**, but since there is just **too much to take into account for complex systems**, there are things that our brains will cut-off from that GENERALIST viewpoint, and we must fix this by seeing things **from different views, and thus separating what a Resource means to us in multiple dimension(preferably orthogonally, where each viewpoint doesn't take into account what other viewpoints take into account)**

ADDITIONAL NOTE: When reading the description of something which explains a problem to be solved but not yet fully abstracted, like having only the raw information, it is useful to look at that information as a Resource that currently you are creating, and extract from the information the **Viewpoints** that **are** being addressed in this information