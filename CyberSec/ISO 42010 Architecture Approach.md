Architecture is defined as the “fundamental concepts or properties related to an entity in its environment and governing principles for the realization and evolution of this entity and its related life cycle processes”

The ultimate goal of this approach to develop an architecture is to use an **ordered process** that is able to **classify information in a structured manner** about a complex project(like an application, enterprises or even city planning) to help us **identify and prioritize the goals and objectives that this project needs them to be solved, and thus GUIDE and know which solution to implement to the project**

From that, ensuring a TREE structure of a system is the BEST OUTCOME to achieve, where nodes that are high up **have many abstractions** and contain several other things, while the leaf nodes contain the data **in its rawest form**, where the implementation details reside and there's no abstraction
And regarding relationships between them, its best of those **relationships** between nodes is done at the **same level or lower nodes**, because a node interacting with a higher node would make the tree a graph, and those are harder to think about
### What is a Model?
M is a model of S, if M can be used to be able to answer questions about S

A summarized exemplification of all these concepts brought to the real world in a scenario of a software engineering application would be this:
- **Stakeholder Concerns**: Identify key stakeholder concerns such as usability, performance, and security, which will help in defining the **goals and objectives, as well as knowing which architecture views and viewpoints to define**.
- **Architecture Views**: The views relates to the information that addresses the stakeholders concerns **in different domains**, for instance, a **usability view** might include user interface mockups, while a **security view** could detail encryption methods -- This is the HOW basically, defining a concrete AND imperative way to solve the problem from specific viewpoints
	These are the basis for the architecture descriptions, which is the information to be classified and segmented.
	- **Architecture Viewpoints**: The viewpoints are the set of rules and conventions that state how views are built, interpreted and analyzed, with the purpose of **making easier the process of creating and understanding the views** us(like the *syntactic rules* of languages, which define how a language is built and understood, making this useful to break down very complex topics) -- This is the WHAT, the declarative way of saying what is the problem and how it is understood in a more abstract way
		**ENSURE** to have the minimal and **condensed** amount of viewpoints, because they represent dimensions of the problem, and having a 20th dimension problem is VERY hard -- Its about **defining borders and limits** when everyone understands the problem
- **Aspects and Perspectives**: *Aspects* refer to **objective type information** that takes a particular feature of the entity of interest, letting us decompose a complex entity into smaller and more manageable parts, like ...., while the *Perspective* take an *aspect* of the entity and we **expand the aspect from different angles, in order to get identify more concerns**, like viewing an application feature from the *perspective* of a developer or a stakeholder, where the developer has more technical concerns, while the stakeholder has more cost concerns
	These aspects can be then associated with different modes of perception such as **structural, behavioral, taxonomic, and connectivity**.
- **Viewpoints and Models**: Utilize viewpoints to frame concerns and guide the creation of models that form the architecture views.

This approach helps in organizing the architecture description and ensures that the software application is designed to meet the stakeholders’ needs effectively.


![[ExamplesOfViewPoints.png]]
<center>*Some architecure viewpoints examples*</center>

The architecture is composed out of:
- **Entity of Interest**: This is a concept that covers a broad set of things like the systems in the architecture, and also things outside the boundaries of those systems such as the enterprises, and more.
- **Stakeholder Concerns**: Central to shaping the architecture.
- **Architecture Views**: Created based on stakeholders’ perspectives and concerns
- **Aspects and Perspectives**: New concepts introduced to align with modern practices.
- **Architecture Description**: This concepts is not the same as architecture, because this rather is the **representation or expression** of the architecture, which is a collection of artifacts like diagrams, tables, documents, etc. This architecture description helps communicate the design and characteristics of the entity of interest and the entity's properties(which the architecture is defined upon, which can be a system or enterprise)

![[ArchitectureComponentDiagram.png]]


# Notes

To define viewpoints, 
















