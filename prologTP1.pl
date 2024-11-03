:- dynamic task/4.

create_task(TaskID, Description, Assignee) :-
    \+ task(TaskID, _, _, _),
    assertz(task(TaskID, Description, Assignee, false)),
    format('Task created: ~w.~n', [TaskID]).

assign_task(TaskID, User) :-
    task(TaskID, Description, _, Completed),
    retract(task(TaskID, Description, _, Completed)),
    assertz(task(TaskID, Description, User, Completed)),
    format('Task ~w assigned to user: ~w.~n', [TaskID, User]).

mark_completed(TaskID) :-
    task(TaskID, Description, Assignee, false),
    retract(task(TaskID, Description, Assignee, false)),
    assertz(task(TaskID, Description, Assignee, true)),
    format('Task ~w marked as completed.~n', [TaskID]).

display_tasks :-
    forall(task(TaskID, Description, Assignee, Completed),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Assignee: ~w~n', [Assignee]),
            format('- Completion status: ~w~n', [Completed]))).

display_tasks_assigned_to(User) :-
    format('Tasks assigned to ~w:~n', [User]),
    forall(task(TaskID, Description, User, Completed),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Completion status: ~w~n', [Completed]))).

display_completed_tasks :-
    format('Completed tasks:~n'),
    forall(task(TaskID, Description, Assignee, true),
           (format('Task ~w:~n', [TaskID]),
            format('- Description: ~w~n', [Description]),
            format('- Assignee: ~w~n', [Assignee]))).
