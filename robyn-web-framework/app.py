from robyn import Robyn

app = Robyn(__file__)


@app.get("/")
def index():
    say_hello()
    return "Hello World!"


if __name__ == "__main__":
    # create a configured "Session" class
    app.start(host="0.0.0.0", port=8080)
