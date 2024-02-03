#include <Python.h>
#include <math.h>

static PyObject* calculate_distance(PyObject* self, PyObject* args) {
    PyObject* coord_list;
    if (!PyArg_ParseTuple(args, "O", &coord_list)) {
        return NULL;
    }

    if (!PyList_Check(coord_list)) {
        PyErr_SetString(PyExc_TypeError, "Argument must be a list");
        return NULL;
    }

    Py_ssize_t num_coords = PyList_Size(coord_list);
    if (num_coords < 2) {
        PyErr_SetString(PyExc_ValueError, "List must contain at least two points");
        return NULL;
    }

    double total_distance = 0;
    PyObject* item;
    PyObject* prev_item = PyList_GetItem(coord_list, 0);
    double x1, y1, x2, y2;

    for (Py_ssize_t i = 1; i < num_coords; i++) {
        item = PyList_GetItem(coord_list, i);
        if (!PyTuple_Check(item) || PyTuple_Size(item) != 2) {
            PyErr_SetString(PyExc_ValueError, "List items must be tuples of size 2");
            return NULL;
        }

        if (!PyArg_ParseTuple(prev_item, "dd", &x1, &y1) || !PyArg_ParseTuple(item, "dd", &x2, &y2)) {
            return NULL;
        }

        total_distance += sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
        prev_item = item;
    }

    return Py_BuildValue("d", total_distance);
}

static PyMethodDef DistanceMethods[] = {
    {"calculate_distance", calculate_distance, METH_VARARGS, "Calculate distance between 2D points"},
    {NULL, NULL, 0, NULL}
};

static struct PyModuleDef distancecmodule = {
    PyModuleDef_HEAD_INIT,
    "distance_c",
    NULL,
    -1,
    DistanceMethods
};

PyMODINIT_FUNC PyInit_distance_c(void) {
    return PyModule_Create(&distancecmodule);
}

