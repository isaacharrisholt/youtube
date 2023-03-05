import subprocess
from pathlib import Path
from typing import Any, Dict, Optional

import typer


def get_variables(
    project_name: str,
    destination: Path,
    variables: Dict[str, Any],
) -> Dict[str, Any]:
    """Get variables for the template."""
    port = typer.prompt("What port should the server run on?", default=8000)
    return {"port": port}


def post_script(
    project_name: str,
    final_directory: Path,
    variables: Dict[str, Any],
) -> Optional[Dict[str, Any]]:
    """Run a script after the template has been created."""
    results = subprocess.run(
        ["pip", "index", "versions", "fastapi"],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
    )
    header = results.stdout.decode().splitlines()[0]
    version = header.split(" ")[-1][1:-1]
    return {"fastapi_version": version}
