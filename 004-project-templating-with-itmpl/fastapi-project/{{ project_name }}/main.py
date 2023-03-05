from fastapi import FastAPI
from fastapi.responses import PlainTextResponse

app = FastAPI()


@app.get("/", response_class=PlainTextResponse)
def read_root():
    return "{{ root_path_response }}"


if __name__ == '__main__':
    app()
