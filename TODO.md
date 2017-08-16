### Todo List

- Add the ability to group todos by day
    - ~This might have an interface like todo set_day will change the
      current day, and then all the normal todo commands are scoped to
      that day.~
    - Todo day today should set the day to today's date
    - Flag could show todos for the week or month
    - set_day could support relative days, or absolute
        - Maybe will default to current year, so I could do todo set_day 11/7
        - todo set_day monday would be cool too
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
