from pathlib import Path

import typer
from rich import print
from rich.table import Table

from csv_sum import _csv_sum

app = typer.Typer()


@app.command()
def main(
    pattern: str,
    header: str = typer.Option(None, "--header", "-h"),
    index: int = typer.Option(None, "--index", "-i", min=0),
    show_largest: int = typer.Option(None, "--show-largest", "-l"),
):
    if header is None and index is None:
        raise typer.BadParameter("Must specify either --header or --index")

    if header is not None and index is not None:
        raise typer.BadParameter("Must specify either --header or --index, not both")

    paths = [str(p.resolve()) for p in Path.cwd().rglob(pattern)]

    if header is not None:
        csv_sum_obj = _csv_sum.sum_by_header(paths, header)
    else:
        csv_sum_obj = _csv_sum.sum_by_index(paths, index)

    print(csv_sum_obj.total)

    if show_largest is not None:
        table = Table(title="Largest Files")
        table.add_column("File")
        table.add_column("Sum")

        for file_total in csv_sum_obj.get_largest(show_largest):
            table.add_row(file_total.path, str(file_total.total))

        print(table)
