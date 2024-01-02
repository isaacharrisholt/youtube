"""
My first application
"""

from typing import Any

import toga
from toga.style.pack import COLUMN, ROW, Pack


class HelloWorld(toga.App):
    todos: toga.Box

    def startup(self):
        """
        Construct and show the Toga application.

        Usually, you would add your application to a main content box.
        We then create a main window (with a name matching the app), and
        show the main window.
        """
        main_box = toga.Box(style=Pack(direction=COLUMN))

        todo_label = toga.Label(
            "Add todo: ",
            style=Pack(padding=(0, 5)),
        )
        self.todo_input = toga.TextInput(style=Pack(flex=1))

        todo_box = toga.Box(style=Pack(direction=ROW, padding=5))
        todo_box.add(todo_label)
        todo_box.add(self.todo_input)

        button = toga.Button(
            "Add todo",
            on_press=lambda widget, **kwargs: self.add_todo_item(self.todo_input.value),
            style=Pack(padding=5),
        )

        self.todos = toga.Box(style=Pack(direction=COLUMN, padding=5))

        main_box.add(todo_box)
        main_box.add(button)
        main_box.add(self.todos)

        self.main_window = toga.MainWindow(title=self.formal_name)
        self.main_window.content = main_box
        self.main_window.show()

    def add_todo_item(self, todo: str):
        if not todo:
            return
        todo_label = toga.Label(todo, style=Pack(padding=(0, 5), flex=1))
        todo_button = toga.Button(
            "Complete",
            on_press=self.delete_todo_item,
            style=Pack(padding=5),
        )
        todo_box = toga.Box(style=Pack(direction=ROW, padding=5))
        todo_box.add(todo_label)
        todo_box.add(todo_button)
        self.todos.add(todo_box)

    def delete_todo_item(self, widget: Any):
        self.todos.remove(widget.parent)

    # def update_todos(self):
    #     self.todos_box.remove(*self.todos_box.children)
    #     for todo in self.todos:
    #         self.todos_box.add(todo)


def greeting(name: str) -> str:
    if name:
        return f"Hello, {name}"

    return "Hello, stranger"


def main():
    return HelloWorld()
