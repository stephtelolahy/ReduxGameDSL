# A Domain Specific Language For Trading Card Games

[![iOS starter workflow](https://github.com/stephtelolahy/ReduxGameDSL/actions/workflows/ios.yml/badge.svg)](https://github.com/stephtelolahy/ReduxGameDSL/actions/workflows/ios.yml)

**Game**: a form of competitive activity played according to rules.

**Trading card games**: it is turn based, cards have actions, cards have properties and cards have rules.
Currently, there is no good way to prototype trading card games and then be able to test the workings and the implications of rules in these games. 

**DSL**: Domain Specific Languages are computer languages designed for a specific domain. 
Since DSLs result in programs that are smaller and easier to understand, they allow even non-programmers to read, write and understand the language.


### Key Features
- [x] Game DSL
- [x] Serializable game object
- [x] Equatable game object
- [ ] Composable rules
- [ ] Replay
- [ ] Hot reload with JSON file 

### MetaModel

![](Docs/architecture.png)

- **Game**: Global metaclass which contains all elements in a game.
- **Player**: Players who are participating in a game.
- **Rule**: Rules define the constraints of a game. Rules are either game-wide, or specific to one card.
- **Card**: Cards that are used in a game. Cards can have a cost, can have multiple properties, define additional rules, have actions that can be played and have side effects that happen when they are being played.
- **Action**: Cards can have actions on them. For example an ability of a card that can be activated.

### Architecture

Redux architecture is meant to protect changes in an application’s state. It forces you to define clearly what state should be set when a specific action is dispatched.

![](Docs/redux.png)

- There is a single global state kept in store.
- State is immutable.
- New state can be set only by dispatching an action to store.
- New state can be calculated only by reducer which is a pure function.
- Store notifies subscribers by broadcasting new state.
- It is best to separate each responsibility into different middleware. You can then easily enable or disable some features.


### Code duplication
Detect code duplication with [Periphery](https://github.com/kucherenko/jscpd/tree/master/packages/jscpd#html)

Run the following command on terminal from the project root

```
npx jscpd --reporters html ./Game/Sources/Game/

open ./report/html/index.html
```
