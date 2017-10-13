### Todo List
- Could expand day feature to a general "list" feature.
    - Since days can hold lists, why not other arbitrary things?
    - Could work the same way, sorting lists of todos by list name
    - Probably won't be able to nest them; no lists within days
        - In that case, need some way to indicate if list or day is taking precedence
        - Maybe we just generalize the day command to a list command that understands days. i.e. `todo list today` will
          understand how to set the active list to that the current day
- Expand to items beyond todos
    - Thinking notes.
        - Notes could be nested. That would be an interesting UX and code design problem
