from pathlib import Path
from urllib.parse import parse_qs

from markdown_renderer import render_markdown
from models import Base, Note, SessionLocal, engine
from robyn import Request, Response, Robyn
from robyn.logger import Logger
from robyn.robyn import Headers
from robyn.templating import JinjaTemplate

app = Robyn(__file__)
log = Logger()
templates = JinjaTemplate(Path(__file__).parent / "templates")


@app.get("/", const=True)
def index():
    return templates.render_template("index.html")


@app.get("/notes")
def get_notes():
    with SessionLocal() as session:
        notes = session.query(Note).all()

    return templates.render_template("note-list.html", notes=notes)


@app.post("/note")
def create_note():
    with SessionLocal() as session:
        note = Note(title="Default title", content="")
        session.add(note)
        session.commit()

        return templates.render_template("editor.html", note=note)


@app.get("/note/:note_id")
def get_note_by_id(request: Request):
    with SessionLocal() as session:
        note_id = request.path_params.get("note_id")
        if note_id is None:
            return Response(
                status_code=400,
                headers=Headers({}),
                description="Bad request",
            )
        note = session.get(Note, int(note_id))

        return templates.render_template("editor.html", note=note)


@app.patch("/note/:note_id")
def update_note_by_id(request: Request):
    data = parse_qs(str(request.body))
    content_list = data.get("content")
    title_list = data.get("title")
    note_id = request.path_params.get("note_id")

    if not title_list or not note_id:
        return Response(
            status_code=400,
            headers=Headers({}),
            description="Bad request",
        )

    title = title_list[0]

    with SessionLocal() as session:
        note = session.get(Note, int(note_id))
        if note is None:
            return Response(
                status_code=404,
                headers=Headers({}),
                description="Note not found",
            )
        content = ""
        if content_list:
            content = content_list[0]
        note.content = content
        note.title = title
        session.commit()


@app.delete("/note/:note_id")
def delete_note_by_id(request: Request):
    note_id = request.path_params.get("note_id")
    if note_id is None:
        return Response(
            status_code=400,
            headers=Headers({}),
            description="Bad request",
        )

    with SessionLocal() as session:
        note = session.get(Note, note_id)
        if note is None:
            return Response(
                status_code=404,
                headers=Headers({}),
                description="Note not found",
            )
        session.delete(note)
        session.commit()

    return Response(
        status_code=200,
        headers=Headers({}),
        description="Note deleted",
    )


@app.post("/markdown")
def parse_markdown(request: Request):
    data = parse_qs(str(request.body))
    content_list = data.get("content")
    if not content_list:
        return Response(
            status_code=200,
            headers=Headers({}),
            description="",
        )
    content = content_list[0]
    return Response(
        status_code=200,
        headers=Headers({}),
        description=render_markdown(content),
    )


if __name__ == "__main__":
    # create a configured "Session" class
    print("Creating tables")
    Base.metadata.create_all(bind=engine)
    app.start(host="0.0.0.0", port=8080)
