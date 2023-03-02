# Start A New Project In Seconds With iTmpl

[iTmpl](https://itmpl.ihh.dev) is an extensible project templating tool written
in Python. It's great for creating new projects from scratch, or for
generating new files for existing projects.

It comes with a few built-in templates, which we'll use in this video. You can
also create your own templates. The video shows you how to do that, and how to
run arbitrary Python code in your templates.

For more information, watch the [video](https://youtu.be/8-i3U_3Gxko).

## Following along

First, install iTmpl in the recommended way - via `pipx`:

```bash
pip install pipx
pipx install itmpl
```

To find your iTmpl templates directory, run:

```bash
itmpl config get extra_templates_dir
```

This will print the path to the directory. You can use this directory to store
your own templates.

To use the `fastapi-project` template in this video, copy the `fastapi-project`
folder from this repository into your iTmpl templates directory.
