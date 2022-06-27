//

//
abstract class ToDoStates{}

class ToDoInitialState extends ToDoStates{}

class ToDoChangeCurrentIndexState extends ToDoStates{}

class ToDoCreateDatabaseState extends ToDoStates{}
class ToDoInsertToDatabaseState extends ToDoStates{}
class ToDoGetFromDatabaseState extends ToDoStates{}

class ToDoChangeBottomSheetState extends ToDoStates{}