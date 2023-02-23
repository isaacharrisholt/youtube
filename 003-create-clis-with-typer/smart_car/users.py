import typer
from rich import print

USERS: dict[str, str] = {
    "isaac": "password",
    "bill": "totally-safe",
}

app = typer.Typer()


@app.command("list")
def list_():
    print("[yellow]Users:[/yellow]")
    print("\n".join(USERS.keys()))


@app.command()
def add(username: str, password: str):
    USERS[username] = password
    print(f"Added user {username}\n")
    list_()
