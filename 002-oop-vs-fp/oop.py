from abc import ABC, abstractmethod


class Logger(ABC):
    @abstractmethod
    def log(self, message: str):
        ...


class NamedLogger(Logger):
    def __init__(self, name: str):
        self.name = name

    def log(self, message: str):
        print(f'{self.name}: {message}')


class Animal:
    def __init__(self, name: str, logger: Logger):
        self.name = name
        self.logger = logger

    def speak(self):
        self.logger.log('Speaking')
        ...


class Dog(Animal):
    def speak(self):
        self.logger.log('Woof!')
        ...

    def run(self):
        self.logger.log('Running')
        ...


class Fish(Animal):
    ...


class App:
    @staticmethod
    def run():
        fido = Dog(name='Fido', logger=NamedLogger('Fido'))
        goldie = Fish(name='Goldie', logger=NamedLogger('Goldie'))

        fido.speak()
        fido.run()

        goldie.speak()


if __name__ == '__main__':
    App.run()
