import os
from enum import StrEnum

import typer
from rich import print

from smart_car import users


app = typer.Typer(name="iLectric Car")
app.add_typer(users.app, name="users", help="Manage users")


class Direction(StrEnum):
    NORTH = "north"
    SOUTH = "south"
    EAST = "east"
    WEST = "west"


@app.command()
def drive(
    miles: int,
    direction: Direction = typer.Option(Direction.NORTH, "--direction", "-d"),
):
    print(
        f"[green]Going on a [/green]{miles}[green] mile "
        f"emission-free drive {direction}![/green]"
    )


@app.command()
def stop():
    print("[red]Stopping the car![/red]")


@app.command()
def unlock(
    username: str = typer.Option(..., prompt=True),
    password: str = typer.Option(..., prompt=True, hide_input=True),
):
    if users.USERS.get(username) != password:
        print("[red]Incorrect username or password![/red]")
        raise typer.Exit(code=1)

    print(f"[green]Unlocking the car for {username}![/green]")


@app.callback()
def check_for_key():
    if os.getenv("SMART_CAR_KEY") != "super secure key":
        print("[red]You need a key to access the car![/red]")
        raise typer.Exit(code=1)


if __name__ == "__main__":
    app()
