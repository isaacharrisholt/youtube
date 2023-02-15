import functools
from typing import Callable

Logger = Callable[[str], None]


def named_log(message: str, name: str):
    print(f'{name}: {message}')


def bark(
    name: str,
    log_fn: Logger,
) -> (str, Logger):
    log_fn('Woof!')
    return name, log_fn


def run(
    name: str,
    log_fn: Logger,
) -> (str, Logger):
    log_fn('Running')
    return name, log_fn


def speak(
    name: str,
    log_fn: Logger,
) -> (str, Logger):
    log_fn('Speaking')
    return name, log_fn


def main():
    run(
        *bark(
            'Fido',
            functools.partial(named_log, name='Fido'),
        ),
    )

    speak(
        'Goldie',
        functools.partial(named_log, name='Goldie'),
    )


if __name__ == '__main__':
    main()
