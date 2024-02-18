
# python wrapper for package distance_go/go_src within overall package distance_go
# This is what you import to use the package.
# File is generated by gopy. Do not edit.
# gopy build -vm=python3 -output=distance_go ./go_src

# the following is required to enable dlopen to open the _go.so file
import os,sys,inspect,collections
try:
	import collections.abc as _collections_abc
except ImportError:
	_collections_abc = collections

cwd = os.getcwd()
currentdir = os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))
os.chdir(currentdir)
from . import _distance_go
from . import go

os.chdir(cwd)

# to use this code in your end-user python file, import it as follows:
# from distance_go import distance_go
# and then refer to everything using distance_go. prefix
# packages imported by this package listed below:




# ---- Types ---


#---- Enums from Go (collections of consts with same type) ---


#---- Constants from Go: Python can only ask that you please don't change these! ---


# ---- Global Variables: can only use functions to access ---


# ---- Interfaces ---


# ---- Structs ---

# Python type for struct distance_go.Coord
class Coord(go.GoClass):
	"""Coord represents a 2D coordinate\n"""
	def __init__(self, *args, **kwargs):
		"""
		handle=A Go-side object is always initialized with an explicit handle=arg
		otherwise parameters can be unnamed in order of field names or named fields
		in which case a new Go object is constructed first
		"""
		if len(kwargs) == 1 and 'handle' in kwargs:
			self.handle = kwargs['handle']
			_distance_go.IncRef(self.handle)
		elif len(args) == 1 and isinstance(args[0], go.GoClass):
			self.handle = args[0].handle
			_distance_go.IncRef(self.handle)
		else:
			self.handle = _distance_go.distance_go_Coord_CTor()
			_distance_go.IncRef(self.handle)
			if  0 < len(args):
				self.X = args[0]
			if "X" in kwargs:
				self.X = kwargs["X"]
			if  1 < len(args):
				self.Y = args[1]
			if "Y" in kwargs:
				self.Y = kwargs["Y"]
	def __del__(self):
		_distance_go.DecRef(self.handle)
	def __str__(self):
		pr = [(p, getattr(self, p)) for p in dir(self) if not p.startswith('__')]
		sv = 'distance_go.Coord{'
		first = True
		for v in pr:
			if callable(v[1]):
				continue
			if first:
				first = False
			else:
				sv += ', '
			sv += v[0] + '=' + str(v[1])
		return sv + '}'
	def __repr__(self):
		pr = [(p, getattr(self, p)) for p in dir(self) if not p.startswith('__')]
		sv = 'distance_go.Coord ( '
		for v in pr:
			if not callable(v[1]):
				sv += v[0] + '=' + str(v[1]) + ', '
		return sv + ')'
	@property
	def X(self):
		return _distance_go.distance_go_Coord_X_Get(self.handle)
	@X.setter
	def X(self, value):
		if isinstance(value, go.GoClass):
			_distance_go.distance_go_Coord_X_Set(self.handle, value.handle)
		else:
			_distance_go.distance_go_Coord_X_Set(self.handle, value)
	@property
	def Y(self):
		return _distance_go.distance_go_Coord_Y_Get(self.handle)
	@Y.setter
	def Y(self, value):
		if isinstance(value, go.GoClass):
			_distance_go.distance_go_Coord_Y_Set(self.handle, value.handle)
		else:
			_distance_go.distance_go_Coord_Y_Set(self.handle, value)


# ---- Slices ---

# Python type for slice distance_go.CoordList
class CoordList(go.GoClass):
	""""""
	def __init__(self, *args, **kwargs):
		"""
		handle=A Go-side object is always initialized with an explicit handle=arg
		otherwise parameter is a python list that we copy from
		"""
		self.index = 0
		if len(kwargs) == 1 and 'handle' in kwargs:
			self.handle = kwargs['handle']
			_distance_go.IncRef(self.handle)
		elif len(args) == 1 and isinstance(args[0], go.GoClass):
			self.handle = args[0].handle
			_distance_go.IncRef(self.handle)
		else:
			self.handle = _distance_go.distance_go_CoordList_CTor()
			_distance_go.IncRef(self.handle)
			if len(args) > 0:
				if not isinstance(args[0], _collections_abc.Iterable):
					raise TypeError('distance_go_CoordList.__init__ takes a sequence as argument')
				for elt in args[0]:
					self.append(elt)
	def __del__(self):
		_distance_go.DecRef(self.handle)
	def __str__(self):
		s = 'distance_go.distance_go_CoordList len: ' + str(len(self)) + ' handle: ' + str(self.handle) + ' ['
		if len(self) < 120:
			s += ', '.join(map(str, self)) + ']'
		return s
	def __repr__(self):
		return 'distance_go.distance_go_CoordList([' + ', '.join(map(str, self)) + '])'
	def __len__(self):
		return _distance_go.distance_go_CoordList_len(self.handle)
	def __getitem__(self, key):
		if isinstance(key, slice):
			if key.step == None or key.step == 1:
				st = key.start
				ed = key.stop
				if st == None:
					st = 0
				if ed == None:
					ed = _distance_go.distance_go_CoordList_len(self.handle)
				return CoordList(handle=_distance_go.distance_go_CoordList_subslice(self.handle, st, ed))
			return [self[ii] for ii in range(*key.indices(len(self)))]
		elif isinstance(key, int):
			if key < 0:
				key += len(self)
			if key < 0 or key >= len(self):
				raise IndexError('slice index out of range')
			return go_Coord(handle=_distance_go.distance_go_CoordList_elem(self.handle, key))
		else:
			raise TypeError('slice index invalid type')
	def __setitem__(self, idx, value):
		if idx < 0:
			idx += len(self)
		if idx < len(self):
			_distance_go.distance_go_CoordList_set(self.handle, idx, value.handle)
			return
		raise IndexError('slice index out of range')
	def __iadd__(self, value):
		if not isinstance(value, _collections_abc.Iterable):
			raise TypeError('distance_go_CoordList.__iadd__ takes a sequence as argument')
		for elt in value:
			self.append(elt)
		return self
	def __iter__(self):
		self.index = 0
		return self
	def __next__(self):
		if self.index < len(self):
			rv = go_Coord(handle=_distance_go.distance_go_CoordList_elem(self.handle, self.index))
			self.index = self.index + 1
			return rv
		raise StopIteration
	def append(self, value):
		_distance_go.distance_go_CoordList_append(self.handle, value.handle)
	def copy(self, src):
		""" copy emulates the go copy function, copying elements into this list from source list, up to min of size of each list """
		mx = min(len(self), len(src))
		for i in range(mx):
			self[i] = src[i]


# ---- Maps ---


# ---- Constructors ---


# ---- Functions ---
def CalculateDistance(coords):
	"""CalculateDistance([]object coords) float
	
	CalculateDistance calculates the total distance traveled for a slice of coordinates
	"""
	return _distance_go.distance_go_CalculateDistance(coords.handle)


