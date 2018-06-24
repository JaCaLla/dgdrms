# dgdrms

## IDE

* XCode 9.4 

## Libraries used (Podfile)

* **Alamofire**. This pod is being used for encapsuling network requests.
* **SwiftLint**. This pod performs an static code analysis, depending on the issue found injects a warning or even a compilation failure. This is very usefull to reduce dramatically SONAR isses [link](https://github.com/realm/SwiftLint)
* **R.Swift**. This pod pregenerates codes that generate structure with your resources (texts, images, reuse identifiers...) . So next time that you compile a project with a missing resource (or reuse identifier identifier) it will be detected at compilation time, not running the app in the device (or simulator, ...or even worst in front of final user).[link](https://github.com/mac-cain13/R.swift)


## SW. Layers

### Application
Application layer is the responsible of controling different build configurations (Debug, Staging, Relese), some app resources such as endpoints depends on build confituration. This very thin layer depends on that.

### Data Layer
The **first** layer built has been data one.  In **data layer** we have the following components:

* **DataManager**. This is the interface compnent with uppper layers of the architecture and is the respnsible of serving data requested by Domain layer. In this layer resides the data storage policy, I mean, which data is fetched from REST services, or from local persistence.

*In the case of this demo is the responsible of checking ddbb before calling a REST service for fetching data. Also is responsible, for fetching a point full description in case there were missing such information.*

* **PersistentManager**. This component handles the local persistence in ddbb, in this demo was requested CoreData. But using the same interface could be easily implemented with another ddbb technology such as Realm or SQLite. This has been achieved because the models from the entities, are handled internally, never externally from component. DomainManager interacts with DataManager by exchanging generic struct models that does not depend on any ddbb technology.

* **ServiceManager**. This is the component responsible of making rest api Calls. The unique arquitecture improvement to mention in this component is that url is set automatically depening on the environment (.debug, .staging, .procution)

* **Models**. This compoment holds the models that Domain layer will deal with and finally View layer will present. Those structs are generic they are  entities of no-ddbb, this approach has the overwork of translating ddbb-entities in such models, but component is more issolated and in case of replacing ddbb only this component is affected. The rest of components, and event the unit tests are still the same.

Every component has been developed using TDD.
![alt text](https://raw.githubusercontent.com/JaCaLla/tempos21test/master/img/Coverage.jpg)

Once that data layer is functionallity is guaranteed by tests, it is time to build Domain and View layer. In the case of this app, Domain Layer is a very thin layer, and almost always will bypass between data and view layer, so View and Domain layer will be implemented in parallel. But regular case would be continue with Domain, the architecture is build bottom-top, as the construction of a building.


### Domain Layer

Domain layer has the following components:

* **Sequencer**. This is the responsible of starting up the application. [More information](http://celeri.es/designing-app-start-up-sequence-with-operations/)
* **Coordinator**. A coordinator is the responble of presenting (and dismissing) presenters. All the presenters flow is concentrated in a unique coordinator and no longer a presenter, will present, push, pop or dismiss another presenter. With this approach presenter can be reused in other flows.
* **UseCase**.  When a presenter needs to request any functionally from Bussines layer (domain+data) will be performed via use case. With that we get two benefits, first presenter size is being reduced, and second a functionallity can be reused by other different presenter.
*In the case of this app the usecase just bypass to datalayer, but this not the real case with commercial apps*

If you want to know more about [domain layer](http://celeri.es/the-domain-layer-an-ios-architecture-part-iv/)

### View Layer

The pattern used in view layer is MVP. This patterns allows to reduce dramatically the size of the presenters. Presenters just coordinate events and data from views, and view is the responsible of data representation.

## The app

* REMEMBER!!. This project is using pods, do not forget *$pod update* for download pod libraries.

* The demo app is using the new iOS 11 brand new feature of large titles, the search control is hidden in the navigation item, just drag down the list for presenting it.

* Regarding the cache policy, turn on the log console for observing that rest service calls are performed just once per retrieving the point list, and for each point detail. Later on if data is on ddbb, then is fetched from ddbb.

