class NoDefault:
    pass


class Field:
    def __init__(self, name: str, type_: type, default=NoDefault()):
        self.name = name
        self.type_ = type_
        self.default = default


def parse_fields(cls: type) -> dict[str, Field]:
    annotations = cls.__annotations__
    class_dict = cls.__dict__
    fields = {}
    for name, value in annotations.items():
        if name in class_dict:
            default = class_dict[name]
        else:
            default = None
        fields[name] = Field(name, value, default)

    return fields


def create_parameters(fields: dict[str, Field], class_name: str) -> str:
    params = []
    for field in fields.values():
        if not isinstance(field.default, NoDefault):
            default = f" = None"
            defaults_started = True
        else:
            default = ""
            if defaults_started:
                raise TypeError(
                    "Non-default argument follows default argument"
                    f"for {class_name}.{field.name}"
                )
        params.append(f"{field.name}: {field.type_.__name__}{default}")

    return ", ".join(params)


def create_assignments(cls: type) -> str:
    annotations = cls.__annotations__
    assignments = []
    for name in annotations:
        assignments.append(
            f"""
    if not isinstance(self._FIELDS["{name}"].default, NoDefault):
        self.{name} = {name} or copy.deepcopy(self._FIELDS["{name}"].default)
    else:
        self.{name} = {name}
        """.strip(
                "\n"
            )
        )

    return "\n".join(assignments)


def my_dataclass(cls: type):
    fields = parse_fields(cls)
    setattr(cls, "_FIELDS", fields)
    parameters = create_parameters(fields, class_name=cls.__name__)

    new_init = f"""
def __init__(self{', ' if parameters else ''}{parameters}):
    import copy
{create_assignments(cls)}
    if hasattr(self, '__post_init__'):
        self.__post_init__()

""".strip()

    exec(new_init, globals(), locals())

    new_init_func = locals()["__init__"]
    new_init_func.__name__ = "__init__"
    new_init_func.__qualname__ = f"{cls.__name__}.__init__"

    cls.__init__ = new_init_func

    return cls


@my_dataclass
class Person:
    name: str
    age: int = 25
    friends: list[str] = ["John", "Jane"]

    def __post_init__(self):
        print("Hello from post init")

    def greet(self):
        print(f"Hello {self.name}")


def main():
    john = Person("John")
    john.greet()
    john.friends.append("Hugo")
    print(john.friends)

    mary = Person("Mary", 30)
    print(mary.friends)


if __name__ == "__main__":
    main()
