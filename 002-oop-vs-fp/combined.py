import functools
from dataclasses import dataclass
from typing import Callable, Optional, Self

Logger = Callable[[str], None]


def named_log(message: str, name: str):
    print(f'{name}: {message}')


@dataclass
class Animal:
    name: str
    log: Optional[Logger] = None

    def __post_init__(self):
        if not self.log:
            self.log = functools.partial(named_log, name=self.name)

    def speak(self) -> Self:
        self.log('Speaking')
        return self


@dataclass
class Dog(Animal):
    breed: str = 'Labrador'

    def speak(self) -> Self:
        self.log('Woof!')
        return self

    def run(self) -> Self:
        self.log('Running')
        return self


@dataclass
class Fish(Animal):
    ...


def main():
    fido = Dog('Fido')
    goldie = Fish('Goldie')

    fido.speak().run()

    goldie.speak()


if __name__ == '__main__':
    main()
