// build/dev/javascript/prelude.mjs
var CustomType = class {
  withFields(fields) {
    let properties = Object.keys(this).map(
      (label2) => label2 in fields ? fields[label2] : this[label2]
    );
    return new this.constructor(...properties);
  }
};
var List = class {
  static fromArray(array3, tail) {
    let t = tail || new Empty();
    for (let i = array3.length - 1; i >= 0; --i) {
      t = new NonEmpty(array3[i], t);
    }
    return t;
  }
  [Symbol.iterator]() {
    return new ListIterator(this);
  }
  toArray() {
    return [...this];
  }
  // @internal
  atLeastLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return true;
      desired--;
    }
    return desired <= 0;
  }
  // @internal
  hasLength(desired) {
    for (let _ of this) {
      if (desired <= 0)
        return false;
      desired--;
    }
    return desired === 0;
  }
  countLength() {
    let length4 = 0;
    for (let _ of this)
      length4++;
    return length4;
  }
};
function prepend(element2, tail) {
  return new NonEmpty(element2, tail);
}
function toList(elements2, tail) {
  return List.fromArray(elements2, tail);
}
var ListIterator = class {
  #current;
  constructor(current) {
    this.#current = current;
  }
  next() {
    if (this.#current instanceof Empty) {
      return { done: true };
    } else {
      let { head, tail } = this.#current;
      this.#current = tail;
      return { value: head, done: false };
    }
  }
};
var Empty = class extends List {
};
var NonEmpty = class extends List {
  constructor(head, tail) {
    super();
    this.head = head;
    this.tail = tail;
  }
};
var BitArray = class _BitArray {
  constructor(buffer) {
    if (!(buffer instanceof Uint8Array)) {
      throw "BitArray can only be constructed from a Uint8Array";
    }
    this.buffer = buffer;
  }
  // @internal
  get length() {
    return this.buffer.length;
  }
  // @internal
  byteAt(index3) {
    return this.buffer[index3];
  }
  // @internal
  floatAt(index3) {
    return byteArrayToFloat(this.buffer.slice(index3, index3 + 8));
  }
  // @internal
  intFromSlice(start4, end) {
    return byteArrayToInt(this.buffer.slice(start4, end));
  }
  // @internal
  binaryFromSlice(start4, end) {
    return new _BitArray(this.buffer.slice(start4, end));
  }
  // @internal
  sliceAfter(index3) {
    return new _BitArray(this.buffer.slice(index3));
  }
};
var UtfCodepoint = class {
  constructor(value2) {
    this.value = value2;
  }
};
function byteArrayToInt(byteArray) {
  byteArray = byteArray.reverse();
  let value2 = 0;
  for (let i = byteArray.length - 1; i >= 0; i--) {
    value2 = value2 * 256 + byteArray[i];
  }
  return value2;
}
function byteArrayToFloat(byteArray) {
  return new Float64Array(byteArray.reverse().buffer)[0];
}
var Result = class _Result extends CustomType {
  // @internal
  static isResult(data) {
    return data instanceof _Result;
  }
};
var Ok = class extends Result {
  constructor(value2) {
    super();
    this[0] = value2;
  }
  // @internal
  isOk() {
    return true;
  }
};
var Error = class extends Result {
  constructor(detail) {
    super();
    this[0] = detail;
  }
  // @internal
  isOk() {
    return false;
  }
};
function isEqual(x, y) {
  let values = [x, y];
  while (values.length) {
    let a = values.pop();
    let b = values.pop();
    if (a === b)
      continue;
    if (!isObject(a) || !isObject(b))
      return false;
    let unequal = !structurallyCompatibleObjects(a, b) || unequalDates(a, b) || unequalBuffers(a, b) || unequalArrays(a, b) || unequalMaps(a, b) || unequalSets(a, b) || unequalRegExps(a, b);
    if (unequal)
      return false;
    const proto = Object.getPrototypeOf(a);
    if (proto !== null && typeof proto.equals === "function") {
      try {
        if (a.equals(b))
          continue;
        else
          return false;
      } catch {
      }
    }
    let [keys2, get3] = getters(a);
    for (let k of keys2(a)) {
      values.push(get3(a, k), get3(b, k));
    }
  }
  return true;
}
function getters(object3) {
  if (object3 instanceof Map) {
    return [(x) => x.keys(), (x, y) => x.get(y)];
  } else {
    let extra = object3 instanceof globalThis.Error ? ["message"] : [];
    return [(x) => [...extra, ...Object.keys(x)], (x, y) => x[y]];
  }
}
function unequalDates(a, b) {
  return a instanceof Date && (a > b || a < b);
}
function unequalBuffers(a, b) {
  return a.buffer instanceof ArrayBuffer && a.BYTES_PER_ELEMENT && !(a.byteLength === b.byteLength && a.every((n, i) => n === b[i]));
}
function unequalArrays(a, b) {
  return Array.isArray(a) && a.length !== b.length;
}
function unequalMaps(a, b) {
  return a instanceof Map && a.size !== b.size;
}
function unequalSets(a, b) {
  return a instanceof Set && (a.size != b.size || [...a].some((e) => !b.has(e)));
}
function unequalRegExps(a, b) {
  return a instanceof RegExp && (a.source !== b.source || a.flags !== b.flags);
}
function isObject(a) {
  return typeof a === "object" && a !== null;
}
function structurallyCompatibleObjects(a, b) {
  if (typeof a !== "object" && typeof b !== "object" && (!a || !b))
    return false;
  let nonstructural = [Promise, WeakSet, WeakMap, Function];
  if (nonstructural.some((c) => a instanceof c))
    return false;
  return a.constructor === b.constructor;
}
function divideInt(a, b) {
  return Math.trunc(divideFloat(a, b));
}
function divideFloat(a, b) {
  if (b === 0) {
    return 0;
  } else {
    return a / b;
  }
}
function makeError(variant, module, line, fn, message, extra) {
  let error = new globalThis.Error(message);
  error.gleam_error = variant;
  error.module = module;
  error.line = line;
  error.fn = fn;
  for (let k in extra)
    error[k] = extra[k];
  return error;
}

// build/dev/javascript/gleam_stdlib/gleam/option.mjs
var Some = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var None = class extends CustomType {
};
function to_result(option, e) {
  if (option instanceof Some) {
    let a = option[0];
    return new Ok(a);
  } else {
    return new Error(e);
  }
}
function from_result(result) {
  if (result.isOk()) {
    let a = result[0];
    return new Some(a);
  } else {
    return new None();
  }
}
function unwrap(option, default$) {
  if (option instanceof Some) {
    let x = option[0];
    return x;
  } else {
    return default$;
  }
}
function map(option, fun) {
  if (option instanceof Some) {
    let x = option[0];
    return new Some(fun(x));
  } else {
    return new None();
  }
}

// build/dev/javascript/gleam_stdlib/gleam/regex.mjs
var Match = class extends CustomType {
  constructor(content, submatches) {
    super();
    this.content = content;
    this.submatches = submatches;
  }
};
var CompileError = class extends CustomType {
  constructor(error, byte_index) {
    super();
    this.error = error;
    this.byte_index = byte_index;
  }
};
var Options = class extends CustomType {
  constructor(case_insensitive, multi_line) {
    super();
    this.case_insensitive = case_insensitive;
    this.multi_line = multi_line;
  }
};
function compile(pattern, options) {
  return compile_regex(pattern, options);
}
function scan(regex, string3) {
  return regex_scan(regex, string3);
}

// build/dev/javascript/gleam_stdlib/gleam/order.mjs
var Lt = class extends CustomType {
};
var Eq = class extends CustomType {
};
var Gt = class extends CustomType {
};

// build/dev/javascript/gleam_stdlib/gleam/int.mjs
function parse(string3) {
  return parse_int(string3);
}
function to_string2(x) {
  return to_string(x);
}

// build/dev/javascript/gleam_stdlib/gleam/result.mjs
function map2(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return new Ok(fun(x));
  } else {
    let e = result[0];
    return new Error(e);
  }
}
function map_error(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return new Ok(x);
  } else {
    let error = result[0];
    return new Error(fun(error));
  }
}
function try$(result, fun) {
  if (result.isOk()) {
    let x = result[0];
    return fun(x);
  } else {
    let e = result[0];
    return new Error(e);
  }
}
function then$(result, fun) {
  return try$(result, fun);
}
function unwrap2(result, default$) {
  if (result.isOk()) {
    let v = result[0];
    return v;
  } else {
    return default$;
  }
}
function nil_error(result) {
  return map_error(result, (_) => {
    return void 0;
  });
}

// build/dev/javascript/gleam_stdlib/gleam/string_builder.mjs
function from_strings(strings) {
  return concat(strings);
}
function to_string3(builder) {
  return identity(builder);
}

// build/dev/javascript/gleam_stdlib/gleam/dynamic.mjs
var DecodeError = class extends CustomType {
  constructor(expected, found, path) {
    super();
    this.expected = expected;
    this.found = found;
    this.path = path;
  }
};
function from(a) {
  return identity(a);
}
function string(data) {
  return decode_string(data);
}
function classify(data) {
  return classify_dynamic(data);
}
function int(data) {
  return decode_int(data);
}
function shallow_list(value2) {
  return decode_list(value2);
}
function any(decoders) {
  return (data) => {
    if (decoders.hasLength(0)) {
      return new Error(
        toList([new DecodeError("another type", classify(data), toList([]))])
      );
    } else {
      let decoder2 = decoders.head;
      let decoders$1 = decoders.tail;
      let $ = decoder2(data);
      if ($.isOk()) {
        let decoded = $[0];
        return new Ok(decoded);
      } else {
        return any(decoders$1)(data);
      }
    }
  };
}
function all_errors(result) {
  if (result.isOk()) {
    return toList([]);
  } else {
    let errors = result[0];
    return errors;
  }
}
function push_path(error, name) {
  let name$1 = from(name);
  let decoder2 = any(
    toList([string, (x) => {
      return map2(int(x), to_string2);
    }])
  );
  let name$2 = (() => {
    let $ = decoder2(name$1);
    if ($.isOk()) {
      let name$22 = $[0];
      return name$22;
    } else {
      let _pipe = toList(["<", classify(name$1), ">"]);
      let _pipe$1 = from_strings(_pipe);
      return to_string3(_pipe$1);
    }
  })();
  return error.withFields({ path: prepend(name$2, error.path) });
}
function list(decoder_type) {
  return (dynamic) => {
    return try$(
      shallow_list(dynamic),
      (list2) => {
        let _pipe = list2;
        let _pipe$1 = try_map(_pipe, decoder_type);
        return map_errors(
          _pipe$1,
          (_capture) => {
            return push_path(_capture, "*");
          }
        );
      }
    );
  };
}
function map_errors(result, f) {
  return map_error(
    result,
    (_capture) => {
      return map3(_capture, f);
    }
  );
}
function field(name, inner_type) {
  return (value2) => {
    let missing_field_error = new DecodeError("field", "nothing", toList([]));
    return try$(
      decode_field(value2, name),
      (maybe_inner) => {
        let _pipe = maybe_inner;
        let _pipe$1 = to_result(_pipe, toList([missing_field_error]));
        let _pipe$2 = try$(_pipe$1, inner_type);
        return map_errors(
          _pipe$2,
          (_capture) => {
            return push_path(_capture, name);
          }
        );
      }
    );
  };
}
function decode4(constructor, t1, t2, t3, t4) {
  return (x) => {
    let $ = t1(x);
    let $1 = t2(x);
    let $2 = t3(x);
    let $3 = t4(x);
    if ($.isOk() && $1.isOk() && $2.isOk() && $3.isOk()) {
      let a = $[0];
      let b = $1[0];
      let c = $2[0];
      let d = $3[0];
      return new Ok(constructor(a, b, c, d));
    } else {
      let a = $;
      let b = $1;
      let c = $2;
      let d = $3;
      return new Error(
        concat2(
          toList([all_errors(a), all_errors(b), all_errors(c), all_errors(d)])
        )
      );
    }
  };
}
function decode6(constructor, t1, t2, t3, t4, t5, t6) {
  return (x) => {
    let $ = t1(x);
    let $1 = t2(x);
    let $2 = t3(x);
    let $3 = t4(x);
    let $4 = t5(x);
    let $5 = t6(x);
    if ($.isOk() && $1.isOk() && $2.isOk() && $3.isOk() && $4.isOk() && $5.isOk()) {
      let a = $[0];
      let b = $1[0];
      let c = $2[0];
      let d = $3[0];
      let e = $4[0];
      let f = $5[0];
      return new Ok(constructor(a, b, c, d, e, f));
    } else {
      let a = $;
      let b = $1;
      let c = $2;
      let d = $3;
      let e = $4;
      let f = $5;
      return new Error(
        concat2(
          toList([
            all_errors(a),
            all_errors(b),
            all_errors(c),
            all_errors(d),
            all_errors(e),
            all_errors(f)
          ])
        )
      );
    }
  };
}

// build/dev/javascript/gleam_stdlib/dict.mjs
var referenceMap = /* @__PURE__ */ new WeakMap();
var tempDataView = new DataView(new ArrayBuffer(8));
var referenceUID = 0;
function hashByReference(o) {
  const known = referenceMap.get(o);
  if (known !== void 0) {
    return known;
  }
  const hash = referenceUID++;
  if (referenceUID === 2147483647) {
    referenceUID = 0;
  }
  referenceMap.set(o, hash);
  return hash;
}
function hashMerge(a, b) {
  return a ^ b + 2654435769 + (a << 6) + (a >> 2) | 0;
}
function hashString(s) {
  let hash = 0;
  const len = s.length;
  for (let i = 0; i < len; i++) {
    hash = Math.imul(31, hash) + s.charCodeAt(i) | 0;
  }
  return hash;
}
function hashNumber(n) {
  tempDataView.setFloat64(0, n);
  const i = tempDataView.getInt32(0);
  const j = tempDataView.getInt32(4);
  return Math.imul(73244475, i >> 16 ^ i) ^ j;
}
function hashBigInt(n) {
  return hashString(n.toString());
}
function hashObject(o) {
  const proto = Object.getPrototypeOf(o);
  if (proto !== null && typeof proto.hashCode === "function") {
    try {
      const code = o.hashCode(o);
      if (typeof code === "number") {
        return code;
      }
    } catch {
    }
  }
  if (o instanceof Promise || o instanceof WeakSet || o instanceof WeakMap) {
    return hashByReference(o);
  }
  if (o instanceof Date) {
    return hashNumber(o.getTime());
  }
  let h = 0;
  if (o instanceof ArrayBuffer) {
    o = new Uint8Array(o);
  }
  if (Array.isArray(o) || o instanceof Uint8Array) {
    for (let i = 0; i < o.length; i++) {
      h = Math.imul(31, h) + getHash(o[i]) | 0;
    }
  } else if (o instanceof Set) {
    o.forEach((v) => {
      h = h + getHash(v) | 0;
    });
  } else if (o instanceof Map) {
    o.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
  } else {
    const keys2 = Object.keys(o);
    for (let i = 0; i < keys2.length; i++) {
      const k = keys2[i];
      const v = o[k];
      h = h + hashMerge(getHash(v), hashString(k)) | 0;
    }
  }
  return h;
}
function getHash(u) {
  if (u === null)
    return 1108378658;
  if (u === void 0)
    return 1108378659;
  if (u === true)
    return 1108378657;
  if (u === false)
    return 1108378656;
  switch (typeof u) {
    case "number":
      return hashNumber(u);
    case "string":
      return hashString(u);
    case "bigint":
      return hashBigInt(u);
    case "object":
      return hashObject(u);
    case "symbol":
      return hashByReference(u);
    case "function":
      return hashByReference(u);
    default:
      return 0;
  }
}
var SHIFT = 5;
var BUCKET_SIZE = Math.pow(2, SHIFT);
var MASK = BUCKET_SIZE - 1;
var MAX_INDEX_NODE = BUCKET_SIZE / 2;
var MIN_ARRAY_NODE = BUCKET_SIZE / 4;
var ENTRY = 0;
var ARRAY_NODE = 1;
var INDEX_NODE = 2;
var COLLISION_NODE = 3;
var EMPTY = {
  type: INDEX_NODE,
  bitmap: 0,
  array: []
};
function mask(hash, shift) {
  return hash >>> shift & MASK;
}
function bitpos(hash, shift) {
  return 1 << mask(hash, shift);
}
function bitcount(x) {
  x -= x >> 1 & 1431655765;
  x = (x & 858993459) + (x >> 2 & 858993459);
  x = x + (x >> 4) & 252645135;
  x += x >> 8;
  x += x >> 16;
  return x & 127;
}
function index(bitmap, bit) {
  return bitcount(bitmap & bit - 1);
}
function cloneAndSet(arr, at, val) {
  const len = arr.length;
  const out = new Array(len);
  for (let i = 0; i < len; ++i) {
    out[i] = arr[i];
  }
  out[at] = val;
  return out;
}
function spliceIn(arr, at, val) {
  const len = arr.length;
  const out = new Array(len + 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  out[g++] = val;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function spliceOut(arr, at) {
  const len = arr.length;
  const out = new Array(len - 1);
  let i = 0;
  let g = 0;
  while (i < at) {
    out[g++] = arr[i++];
  }
  ++i;
  while (i < len) {
    out[g++] = arr[i++];
  }
  return out;
}
function createNode(shift, key1, val1, key2hash, key2, val2) {
  const key1hash = getHash(key1);
  if (key1hash === key2hash) {
    return {
      type: COLLISION_NODE,
      hash: key1hash,
      array: [
        { type: ENTRY, k: key1, v: val1 },
        { type: ENTRY, k: key2, v: val2 }
      ]
    };
  }
  const addedLeaf = { val: false };
  return assoc(
    assocIndex(EMPTY, shift, key1hash, key1, val1, addedLeaf),
    shift,
    key2hash,
    key2,
    val2,
    addedLeaf
  );
}
function assoc(root2, shift, hash, key, val, addedLeaf) {
  switch (root2.type) {
    case ARRAY_NODE:
      return assocArray(root2, shift, hash, key, val, addedLeaf);
    case INDEX_NODE:
      return assocIndex(root2, shift, hash, key, val, addedLeaf);
    case COLLISION_NODE:
      return assocCollision(root2, shift, hash, key, val, addedLeaf);
  }
}
function assocArray(root2, shift, hash, key, val, addedLeaf) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === void 0) {
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root2.size + 1,
      array: cloneAndSet(root2.array, idx, { type: ENTRY, k: key, v: val })
    };
  }
  if (node.type === ENTRY) {
    if (isEqual(key, node.k)) {
      if (val === node.v) {
        return root2;
      }
      return {
        type: ARRAY_NODE,
        size: root2.size,
        array: cloneAndSet(root2.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: ARRAY_NODE,
      size: root2.size,
      array: cloneAndSet(
        root2.array,
        idx,
        createNode(shift + SHIFT, node.k, node.v, hash, key, val)
      )
    };
  }
  const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
  if (n === node) {
    return root2;
  }
  return {
    type: ARRAY_NODE,
    size: root2.size,
    array: cloneAndSet(root2.array, idx, n)
  };
}
function assocIndex(root2, shift, hash, key, val, addedLeaf) {
  const bit = bitpos(hash, shift);
  const idx = index(root2.bitmap, bit);
  if ((root2.bitmap & bit) !== 0) {
    const node = root2.array[idx];
    if (node.type !== ENTRY) {
      const n = assoc(node, shift + SHIFT, hash, key, val, addedLeaf);
      if (n === node) {
        return root2;
      }
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, n)
      };
    }
    const nodeKey = node.k;
    if (isEqual(key, nodeKey)) {
      if (val === node.v) {
        return root2;
      }
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, {
          type: ENTRY,
          k: key,
          v: val
        })
      };
    }
    addedLeaf.val = true;
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap,
      array: cloneAndSet(
        root2.array,
        idx,
        createNode(shift + SHIFT, nodeKey, node.v, hash, key, val)
      )
    };
  } else {
    const n = root2.array.length;
    if (n >= MAX_INDEX_NODE) {
      const nodes = new Array(32);
      const jdx = mask(hash, shift);
      nodes[jdx] = assocIndex(EMPTY, shift + SHIFT, hash, key, val, addedLeaf);
      let j = 0;
      let bitmap = root2.bitmap;
      for (let i = 0; i < 32; i++) {
        if ((bitmap & 1) !== 0) {
          const node = root2.array[j++];
          nodes[i] = node;
        }
        bitmap = bitmap >>> 1;
      }
      return {
        type: ARRAY_NODE,
        size: n + 1,
        array: nodes
      };
    } else {
      const newArray = spliceIn(root2.array, idx, {
        type: ENTRY,
        k: key,
        v: val
      });
      addedLeaf.val = true;
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap | bit,
        array: newArray
      };
    }
  }
}
function assocCollision(root2, shift, hash, key, val, addedLeaf) {
  if (hash === root2.hash) {
    const idx = collisionIndexOf(root2, key);
    if (idx !== -1) {
      const entry = root2.array[idx];
      if (entry.v === val) {
        return root2;
      }
      return {
        type: COLLISION_NODE,
        hash,
        array: cloneAndSet(root2.array, idx, { type: ENTRY, k: key, v: val })
      };
    }
    const size = root2.array.length;
    addedLeaf.val = true;
    return {
      type: COLLISION_NODE,
      hash,
      array: cloneAndSet(root2.array, size, { type: ENTRY, k: key, v: val })
    };
  }
  return assoc(
    {
      type: INDEX_NODE,
      bitmap: bitpos(root2.hash, shift),
      array: [root2]
    },
    shift,
    hash,
    key,
    val,
    addedLeaf
  );
}
function collisionIndexOf(root2, key) {
  const size = root2.array.length;
  for (let i = 0; i < size; i++) {
    if (isEqual(key, root2.array[i].k)) {
      return i;
    }
  }
  return -1;
}
function find(root2, shift, hash, key) {
  switch (root2.type) {
    case ARRAY_NODE:
      return findArray(root2, shift, hash, key);
    case INDEX_NODE:
      return findIndex(root2, shift, hash, key);
    case COLLISION_NODE:
      return findCollision(root2, key);
  }
}
function findArray(root2, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === void 0) {
    return void 0;
  }
  if (node.type !== ENTRY) {
    return find(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return void 0;
}
function findIndex(root2, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root2.bitmap & bit) === 0) {
    return void 0;
  }
  const idx = index(root2.bitmap, bit);
  const node = root2.array[idx];
  if (node.type !== ENTRY) {
    return find(node, shift + SHIFT, hash, key);
  }
  if (isEqual(key, node.k)) {
    return node;
  }
  return void 0;
}
function findCollision(root2, key) {
  const idx = collisionIndexOf(root2, key);
  if (idx < 0) {
    return void 0;
  }
  return root2.array[idx];
}
function without(root2, shift, hash, key) {
  switch (root2.type) {
    case ARRAY_NODE:
      return withoutArray(root2, shift, hash, key);
    case INDEX_NODE:
      return withoutIndex(root2, shift, hash, key);
    case COLLISION_NODE:
      return withoutCollision(root2, key);
  }
}
function withoutArray(root2, shift, hash, key) {
  const idx = mask(hash, shift);
  const node = root2.array[idx];
  if (node === void 0) {
    return root2;
  }
  let n = void 0;
  if (node.type === ENTRY) {
    if (!isEqual(node.k, key)) {
      return root2;
    }
  } else {
    n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root2;
    }
  }
  if (n === void 0) {
    if (root2.size <= MIN_ARRAY_NODE) {
      const arr = root2.array;
      const out = new Array(root2.size - 1);
      let i = 0;
      let j = 0;
      let bitmap = 0;
      while (i < idx) {
        const nv = arr[i];
        if (nv !== void 0) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      ++i;
      while (i < arr.length) {
        const nv = arr[i];
        if (nv !== void 0) {
          out[j] = nv;
          bitmap |= 1 << i;
          ++j;
        }
        ++i;
      }
      return {
        type: INDEX_NODE,
        bitmap,
        array: out
      };
    }
    return {
      type: ARRAY_NODE,
      size: root2.size - 1,
      array: cloneAndSet(root2.array, idx, n)
    };
  }
  return {
    type: ARRAY_NODE,
    size: root2.size,
    array: cloneAndSet(root2.array, idx, n)
  };
}
function withoutIndex(root2, shift, hash, key) {
  const bit = bitpos(hash, shift);
  if ((root2.bitmap & bit) === 0) {
    return root2;
  }
  const idx = index(root2.bitmap, bit);
  const node = root2.array[idx];
  if (node.type !== ENTRY) {
    const n = without(node, shift + SHIFT, hash, key);
    if (n === node) {
      return root2;
    }
    if (n !== void 0) {
      return {
        type: INDEX_NODE,
        bitmap: root2.bitmap,
        array: cloneAndSet(root2.array, idx, n)
      };
    }
    if (root2.bitmap === bit) {
      return void 0;
    }
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap ^ bit,
      array: spliceOut(root2.array, idx)
    };
  }
  if (isEqual(key, node.k)) {
    if (root2.bitmap === bit) {
      return void 0;
    }
    return {
      type: INDEX_NODE,
      bitmap: root2.bitmap ^ bit,
      array: spliceOut(root2.array, idx)
    };
  }
  return root2;
}
function withoutCollision(root2, key) {
  const idx = collisionIndexOf(root2, key);
  if (idx < 0) {
    return root2;
  }
  if (root2.array.length === 1) {
    return void 0;
  }
  return {
    type: COLLISION_NODE,
    hash: root2.hash,
    array: spliceOut(root2.array, idx)
  };
}
function forEach(root2, fn) {
  if (root2 === void 0) {
    return;
  }
  const items = root2.array;
  const size = items.length;
  for (let i = 0; i < size; i++) {
    const item = items[i];
    if (item === void 0) {
      continue;
    }
    if (item.type === ENTRY) {
      fn(item.v, item.k);
      continue;
    }
    forEach(item, fn);
  }
}
var Dict = class _Dict {
  /**
   * @template V
   * @param {Record<string,V>} o
   * @returns {Dict<string,V>}
   */
  static fromObject(o) {
    const keys2 = Object.keys(o);
    let m = _Dict.new();
    for (let i = 0; i < keys2.length; i++) {
      const k = keys2[i];
      m = m.set(k, o[k]);
    }
    return m;
  }
  /**
   * @template K,V
   * @param {Map<K,V>} o
   * @returns {Dict<K,V>}
   */
  static fromMap(o) {
    let m = _Dict.new();
    o.forEach((v, k) => {
      m = m.set(k, v);
    });
    return m;
  }
  static new() {
    return new _Dict(void 0, 0);
  }
  /**
   * @param {undefined | Node<K,V>} root
   * @param {number} size
   */
  constructor(root2, size) {
    this.root = root2;
    this.size = size;
  }
  /**
   * @template NotFound
   * @param {K} key
   * @param {NotFound} notFound
   * @returns {NotFound | V}
   */
  get(key, notFound) {
    if (this.root === void 0) {
      return notFound;
    }
    const found = find(this.root, 0, getHash(key), key);
    if (found === void 0) {
      return notFound;
    }
    return found.v;
  }
  /**
   * @param {K} key
   * @param {V} val
   * @returns {Dict<K,V>}
   */
  set(key, val) {
    const addedLeaf = { val: false };
    const root2 = this.root === void 0 ? EMPTY : this.root;
    const newRoot = assoc(root2, 0, getHash(key), key, val, addedLeaf);
    if (newRoot === this.root) {
      return this;
    }
    return new _Dict(newRoot, addedLeaf.val ? this.size + 1 : this.size);
  }
  /**
   * @param {K} key
   * @returns {Dict<K,V>}
   */
  delete(key) {
    if (this.root === void 0) {
      return this;
    }
    const newRoot = without(this.root, 0, getHash(key), key);
    if (newRoot === this.root) {
      return this;
    }
    if (newRoot === void 0) {
      return _Dict.new();
    }
    return new _Dict(newRoot, this.size - 1);
  }
  /**
   * @param {K} key
   * @returns {boolean}
   */
  has(key) {
    if (this.root === void 0) {
      return false;
    }
    return find(this.root, 0, getHash(key), key) !== void 0;
  }
  /**
   * @returns {[K,V][]}
   */
  entries() {
    if (this.root === void 0) {
      return [];
    }
    const result = [];
    this.forEach((v, k) => result.push([k, v]));
    return result;
  }
  /**
   *
   * @param {(val:V,key:K)=>void} fn
   */
  forEach(fn) {
    forEach(this.root, fn);
  }
  hashCode() {
    let h = 0;
    this.forEach((v, k) => {
      h = h + hashMerge(getHash(v), getHash(k)) | 0;
    });
    return h;
  }
  /**
   * @param {unknown} o
   * @returns {boolean}
   */
  equals(o) {
    if (!(o instanceof _Dict) || this.size !== o.size) {
      return false;
    }
    let equal = true;
    this.forEach((v, k) => {
      equal = equal && isEqual(o.get(k, !v), v);
    });
    return equal;
  }
};

// build/dev/javascript/gleam_stdlib/gleam_stdlib.mjs
var Nil = void 0;
var NOT_FOUND = {};
function identity(x) {
  return x;
}
function parse_int(value2) {
  if (/^[-+]?(\d+)$/.test(value2)) {
    return new Ok(parseInt(value2));
  } else {
    return new Error(Nil);
  }
}
function to_string(term) {
  return term.toString();
}
function graphemes_iterator(string3) {
  if (Intl && Intl.Segmenter) {
    return new Intl.Segmenter().segment(string3)[Symbol.iterator]();
  }
}
function pop_grapheme(string3) {
  let first2;
  const iterator = graphemes_iterator(string3);
  if (iterator) {
    first2 = iterator.next().value?.segment;
  } else {
    first2 = string3.match(/./su)?.[0];
  }
  if (first2) {
    return new Ok([first2, string3.slice(first2.length)]);
  } else {
    return new Error(Nil);
  }
}
function lowercase(string3) {
  return string3.toLowerCase();
}
function less_than(a, b) {
  return a < b;
}
function concat(xs) {
  let result = "";
  for (const x of xs) {
    result = result + x;
  }
  return result;
}
function starts_with(haystack, needle) {
  return haystack.startsWith(needle);
}
function trim(string3) {
  return string3.trim();
}
function compile_regex(pattern, options) {
  try {
    let flags = "gu";
    if (options.case_insensitive)
      flags += "i";
    if (options.multi_line)
      flags += "m";
    return new Ok(new RegExp(pattern, flags));
  } catch (error) {
    const number = (error.columnNumber || 0) | 0;
    return new Error(new CompileError(error.message, number));
  }
}
function regex_scan(regex, string3) {
  const matches = Array.from(string3.matchAll(regex)).map((match) => {
    const content = match[0];
    const submatches = [];
    for (let n = match.length - 1; n > 0; n--) {
      if (match[n]) {
        submatches[n - 1] = new Some(match[n]);
        continue;
      }
      if (submatches.length > 0) {
        submatches[n - 1] = new None();
      }
    }
    return new Match(content, List.fromArray(submatches));
  });
  return List.fromArray(matches);
}
function map_get(map6, key) {
  const value2 = map6.get(key, NOT_FOUND);
  if (value2 === NOT_FOUND) {
    return new Error(Nil);
  }
  return new Ok(value2);
}
function classify_dynamic(data) {
  if (typeof data === "string") {
    return "String";
  } else if (typeof data === "boolean") {
    return "Bool";
  } else if (data instanceof Result) {
    return "Result";
  } else if (data instanceof List) {
    return "List";
  } else if (data instanceof BitArray) {
    return "BitArray";
  } else if (data instanceof Dict) {
    return "Dict";
  } else if (Number.isInteger(data)) {
    return "Int";
  } else if (Array.isArray(data)) {
    return `Tuple of ${data.length} elements`;
  } else if (typeof data === "number") {
    return "Float";
  } else if (data === null) {
    return "Null";
  } else if (data === void 0) {
    return "Nil";
  } else {
    const type = typeof data;
    return type.charAt(0).toUpperCase() + type.slice(1);
  }
}
function decoder_error(expected, got) {
  return decoder_error_no_classify(expected, classify_dynamic(got));
}
function decoder_error_no_classify(expected, got) {
  return new Error(
    List.fromArray([new DecodeError(expected, got, List.fromArray([]))])
  );
}
function decode_string(data) {
  return typeof data === "string" ? new Ok(data) : decoder_error("String", data);
}
function decode_int(data) {
  return Number.isInteger(data) ? new Ok(data) : decoder_error("Int", data);
}
function decode_list(data) {
  if (Array.isArray(data)) {
    return new Ok(List.fromArray(data));
  }
  return data instanceof List ? new Ok(data) : decoder_error("List", data);
}
function decode_field(value2, name) {
  const not_a_map_error = () => decoder_error("Dict", value2);
  if (value2 instanceof Dict || value2 instanceof WeakMap || value2 instanceof Map) {
    const entry = map_get(value2, name);
    return new Ok(entry.isOk() ? new Some(entry[0]) : new None());
  } else if (value2 === null) {
    return not_a_map_error();
  } else if (Object.getPrototypeOf(value2) == Object.prototype) {
    return try_get_field(value2, name, () => new Ok(new None()));
  } else {
    return try_get_field(value2, name, not_a_map_error);
  }
}
function try_get_field(value2, field3, or_else) {
  try {
    return field3 in value2 ? new Ok(new Some(value2[field3])) : or_else();
  } catch {
    return or_else();
  }
}
function inspect(v) {
  const t = typeof v;
  if (v === true)
    return "True";
  if (v === false)
    return "False";
  if (v === null)
    return "//js(null)";
  if (v === void 0)
    return "Nil";
  if (t === "string")
    return JSON.stringify(v);
  if (t === "bigint" || t === "number")
    return v.toString();
  if (Array.isArray(v))
    return `#(${v.map(inspect).join(", ")})`;
  if (v instanceof List)
    return inspectList(v);
  if (v instanceof UtfCodepoint)
    return inspectUtfCodepoint(v);
  if (v instanceof BitArray)
    return inspectBitArray(v);
  if (v instanceof CustomType)
    return inspectCustomType(v);
  if (v instanceof Dict)
    return inspectDict(v);
  if (v instanceof Set)
    return `//js(Set(${[...v].map(inspect).join(", ")}))`;
  if (v instanceof RegExp)
    return `//js(${v})`;
  if (v instanceof Date)
    return `//js(Date("${v.toISOString()}"))`;
  if (v instanceof Function) {
    const args = [];
    for (const i of Array(v.length).keys())
      args.push(String.fromCharCode(i + 97));
    return `//fn(${args.join(", ")}) { ... }`;
  }
  return inspectObject(v);
}
function inspectDict(map6) {
  let body2 = "dict.from_list([";
  let first2 = true;
  map6.forEach((value2, key) => {
    if (!first2)
      body2 = body2 + ", ";
    body2 = body2 + "#(" + inspect(key) + ", " + inspect(value2) + ")";
    first2 = false;
  });
  return body2 + "])";
}
function inspectObject(v) {
  const name = Object.getPrototypeOf(v)?.constructor?.name || "Object";
  const props = [];
  for (const k of Object.keys(v)) {
    props.push(`${inspect(k)}: ${inspect(v[k])}`);
  }
  const body2 = props.length ? " " + props.join(", ") + " " : "";
  const head = name === "Object" ? "" : name + " ";
  return `//js(${head}{${body2}})`;
}
function inspectCustomType(record) {
  const props = Object.keys(record).map((label2) => {
    const value2 = inspect(record[label2]);
    return isNaN(parseInt(label2)) ? `${label2}: ${value2}` : value2;
  }).join(", ");
  return props ? `${record.constructor.name}(${props})` : record.constructor.name;
}
function inspectList(list2) {
  return `[${list2.toArray().map(inspect).join(", ")}]`;
}
function inspectBitArray(bits) {
  return `<<${Array.from(bits.buffer).join(", ")}>>`;
}
function inspectUtfCodepoint(codepoint2) {
  return `//utfcodepoint(${String.fromCodePoint(codepoint2.value)})`;
}

// build/dev/javascript/gleam_stdlib/gleam/pair.mjs
function second(pair) {
  let a = pair[1];
  return a;
}

// build/dev/javascript/gleam_stdlib/gleam/list.mjs
function count_length(loop$list, loop$count) {
  while (true) {
    let list2 = loop$list;
    let count = loop$count;
    if (list2.atLeastLength(1)) {
      let list$1 = list2.tail;
      loop$list = list$1;
      loop$count = count + 1;
    } else {
      return count;
    }
  }
}
function length2(list2) {
  return count_length(list2, 0);
}
function do_reverse(loop$remaining, loop$accumulator) {
  while (true) {
    let remaining = loop$remaining;
    let accumulator = loop$accumulator;
    if (remaining.hasLength(0)) {
      return accumulator;
    } else {
      let item = remaining.head;
      let rest$1 = remaining.tail;
      loop$remaining = rest$1;
      loop$accumulator = prepend(item, accumulator);
    }
  }
}
function reverse(xs) {
  return do_reverse(xs, toList([]));
}
function contains(loop$list, loop$elem) {
  while (true) {
    let list2 = loop$list;
    let elem = loop$elem;
    if (list2.hasLength(0)) {
      return false;
    } else if (list2.atLeastLength(1) && isEqual(list2.head, elem)) {
      let first$1 = list2.head;
      return true;
    } else {
      let rest$1 = list2.tail;
      loop$list = rest$1;
      loop$elem = elem;
    }
  }
}
function first(list2) {
  if (list2.hasLength(0)) {
    return new Error(void 0);
  } else {
    let x = list2.head;
    return new Ok(x);
  }
}
function do_map(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list2 = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list2.hasLength(0)) {
      return reverse(acc);
    } else {
      let x = list2.head;
      let xs = list2.tail;
      loop$list = xs;
      loop$fun = fun;
      loop$acc = prepend(fun(x), acc);
    }
  }
}
function map3(list2, fun) {
  return do_map(list2, fun, toList([]));
}
function do_try_map(loop$list, loop$fun, loop$acc) {
  while (true) {
    let list2 = loop$list;
    let fun = loop$fun;
    let acc = loop$acc;
    if (list2.hasLength(0)) {
      return new Ok(reverse(acc));
    } else {
      let x = list2.head;
      let xs = list2.tail;
      let $ = fun(x);
      if ($.isOk()) {
        let y = $[0];
        loop$list = xs;
        loop$fun = fun;
        loop$acc = prepend(y, acc);
      } else {
        let error = $[0];
        return new Error(error);
      }
    }
  }
}
function try_map(list2, fun) {
  return do_try_map(list2, fun, toList([]));
}
function drop(loop$list, loop$n) {
  while (true) {
    let list2 = loop$list;
    let n = loop$n;
    let $ = n <= 0;
    if ($) {
      return list2;
    } else {
      if (list2.hasLength(0)) {
        return toList([]);
      } else {
        let xs = list2.tail;
        loop$list = xs;
        loop$n = n - 1;
      }
    }
  }
}
function do_append(loop$first, loop$second) {
  while (true) {
    let first2 = loop$first;
    let second2 = loop$second;
    if (first2.hasLength(0)) {
      return second2;
    } else {
      let item = first2.head;
      let rest$1 = first2.tail;
      loop$first = rest$1;
      loop$second = prepend(item, second2);
    }
  }
}
function append(first2, second2) {
  return do_append(reverse(first2), second2);
}
function reverse_and_prepend(loop$prefix, loop$suffix) {
  while (true) {
    let prefix = loop$prefix;
    let suffix = loop$suffix;
    if (prefix.hasLength(0)) {
      return suffix;
    } else {
      let first$1 = prefix.head;
      let rest$1 = prefix.tail;
      loop$prefix = rest$1;
      loop$suffix = prepend(first$1, suffix);
    }
  }
}
function do_concat(loop$lists, loop$acc) {
  while (true) {
    let lists = loop$lists;
    let acc = loop$acc;
    if (lists.hasLength(0)) {
      return reverse(acc);
    } else {
      let list2 = lists.head;
      let further_lists = lists.tail;
      loop$lists = further_lists;
      loop$acc = reverse_and_prepend(list2, acc);
    }
  }
}
function concat2(lists) {
  return do_concat(lists, toList([]));
}
function merge_up(loop$na, loop$nb, loop$a, loop$b, loop$acc, loop$compare) {
  while (true) {
    let na = loop$na;
    let nb = loop$nb;
    let a = loop$a;
    let b = loop$b;
    let acc = loop$acc;
    let compare4 = loop$compare;
    if (na === 0 && nb === 0) {
      return acc;
    } else if (nb === 0 && a.atLeastLength(1)) {
      let ax = a.head;
      let ar = a.tail;
      loop$na = na - 1;
      loop$nb = nb;
      loop$a = ar;
      loop$b = b;
      loop$acc = prepend(ax, acc);
      loop$compare = compare4;
    } else if (na === 0 && b.atLeastLength(1)) {
      let bx = b.head;
      let br = b.tail;
      loop$na = na;
      loop$nb = nb - 1;
      loop$a = a;
      loop$b = br;
      loop$acc = prepend(bx, acc);
      loop$compare = compare4;
    } else if (a.atLeastLength(1) && b.atLeastLength(1)) {
      let ax = a.head;
      let ar = a.tail;
      let bx = b.head;
      let br = b.tail;
      let $ = compare4(ax, bx);
      if ($ instanceof Gt) {
        loop$na = na;
        loop$nb = nb - 1;
        loop$a = a;
        loop$b = br;
        loop$acc = prepend(bx, acc);
        loop$compare = compare4;
      } else {
        loop$na = na - 1;
        loop$nb = nb;
        loop$a = ar;
        loop$b = b;
        loop$acc = prepend(ax, acc);
        loop$compare = compare4;
      }
    } else {
      return acc;
    }
  }
}
function merge_down(loop$na, loop$nb, loop$a, loop$b, loop$acc, loop$compare) {
  while (true) {
    let na = loop$na;
    let nb = loop$nb;
    let a = loop$a;
    let b = loop$b;
    let acc = loop$acc;
    let compare4 = loop$compare;
    if (na === 0 && nb === 0) {
      return acc;
    } else if (nb === 0 && a.atLeastLength(1)) {
      let ax = a.head;
      let ar = a.tail;
      loop$na = na - 1;
      loop$nb = nb;
      loop$a = ar;
      loop$b = b;
      loop$acc = prepend(ax, acc);
      loop$compare = compare4;
    } else if (na === 0 && b.atLeastLength(1)) {
      let bx = b.head;
      let br = b.tail;
      loop$na = na;
      loop$nb = nb - 1;
      loop$a = a;
      loop$b = br;
      loop$acc = prepend(bx, acc);
      loop$compare = compare4;
    } else if (a.atLeastLength(1) && b.atLeastLength(1)) {
      let ax = a.head;
      let ar = a.tail;
      let bx = b.head;
      let br = b.tail;
      let $ = compare4(bx, ax);
      if ($ instanceof Lt) {
        loop$na = na - 1;
        loop$nb = nb;
        loop$a = ar;
        loop$b = b;
        loop$acc = prepend(ax, acc);
        loop$compare = compare4;
      } else {
        loop$na = na;
        loop$nb = nb - 1;
        loop$a = a;
        loop$b = br;
        loop$acc = prepend(bx, acc);
        loop$compare = compare4;
      }
    } else {
      return acc;
    }
  }
}
function merge_sort(l, ln, compare4, down) {
  let n = divideInt(ln, 2);
  let a = l;
  let b = drop(l, n);
  let $ = ln < 3;
  if ($) {
    if (down) {
      return merge_down(n, ln - n, a, b, toList([]), compare4);
    } else {
      return merge_up(n, ln - n, a, b, toList([]), compare4);
    }
  } else {
    if (down) {
      return merge_down(
        n,
        ln - n,
        merge_sort(a, n, compare4, false),
        merge_sort(b, ln - n, compare4, false),
        toList([]),
        compare4
      );
    } else {
      return merge_up(
        n,
        ln - n,
        merge_sort(a, n, compare4, true),
        merge_sort(b, ln - n, compare4, true),
        toList([]),
        compare4
      );
    }
  }
}
function sort(list2, compare4) {
  return merge_sort(list2, length2(list2), compare4, true);
}
function do_repeat(loop$a, loop$times, loop$acc) {
  while (true) {
    let a = loop$a;
    let times = loop$times;
    let acc = loop$acc;
    let $ = times <= 0;
    if ($) {
      return acc;
    } else {
      loop$a = a;
      loop$times = times - 1;
      loop$acc = prepend(a, acc);
    }
  }
}
function repeat(a, times) {
  return do_repeat(a, times, toList([]));
}

// build/dev/javascript/gleam_stdlib/gleam/string.mjs
function lowercase2(string3) {
  return lowercase(string3);
}
function compare3(a, b) {
  let $ = a === b;
  if ($) {
    return new Eq();
  } else {
    let $1 = less_than(a, b);
    if ($1) {
      return new Lt();
    } else {
      return new Gt();
    }
  }
}
function starts_with2(string3, prefix) {
  return starts_with(string3, prefix);
}
function concat3(strings) {
  let _pipe = strings;
  let _pipe$1 = from_strings(_pipe);
  return to_string3(_pipe$1);
}
function trim2(string3) {
  return trim(string3);
}
function pop_grapheme2(string3) {
  return pop_grapheme(string3);
}
function inspect2(term) {
  let _pipe = inspect(term);
  return to_string3(_pipe);
}

// build/dev/javascript/gleam_stdlib/gleam/bool.mjs
function guard(requirement, consequence, alternative) {
  if (requirement) {
    return consequence;
  } else {
    return alternative();
  }
}

// build/dev/javascript/gleam_json/gleam_json_ffi.mjs
function decode(string3) {
  try {
    const result = JSON.parse(string3);
    return new Ok(result);
  } catch (err) {
    return new Error(getJsonDecodeError(err, string3));
  }
}
function getJsonDecodeError(stdErr, json) {
  if (isUnexpectedEndOfInput(stdErr))
    return new UnexpectedEndOfInput();
  return toUnexpectedByteError(stdErr, json);
}
function isUnexpectedEndOfInput(err) {
  const unexpectedEndOfInputRegex = /((unexpected (end|eof))|(end of data)|(unterminated string)|(json( parse error|\.parse)\: expected '(\:|\}|\])'))/i;
  return unexpectedEndOfInputRegex.test(err.message);
}
function toUnexpectedByteError(err, json) {
  let converters = [
    v8UnexpectedByteError,
    oldV8UnexpectedByteError,
    jsCoreUnexpectedByteError,
    spidermonkeyUnexpectedByteError
  ];
  for (let converter of converters) {
    let result = converter(err, json);
    if (result)
      return result;
  }
  return new UnexpectedByte("", 0);
}
function v8UnexpectedByteError(err) {
  const regex = /unexpected token '(.)', ".+" is not valid JSON/i;
  const match = regex.exec(err.message);
  if (!match)
    return null;
  const byte = toHex(match[1]);
  return new UnexpectedByte(byte, -1);
}
function oldV8UnexpectedByteError(err) {
  const regex = /unexpected token (.) in JSON at position (\d+)/i;
  const match = regex.exec(err.message);
  if (!match)
    return null;
  const byte = toHex(match[1]);
  const position = Number(match[2]);
  return new UnexpectedByte(byte, position);
}
function spidermonkeyUnexpectedByteError(err, json) {
  const regex = /(unexpected character|expected .*) at line (\d+) column (\d+)/i;
  const match = regex.exec(err.message);
  if (!match)
    return null;
  const line = Number(match[2]);
  const column = Number(match[3]);
  const position = getPositionFromMultiline(line, column, json);
  const byte = toHex(json[position]);
  return new UnexpectedByte(byte, position);
}
function jsCoreUnexpectedByteError(err) {
  const regex = /unexpected (identifier|token) "(.)"/i;
  const match = regex.exec(err.message);
  if (!match)
    return null;
  const byte = toHex(match[2]);
  return new UnexpectedByte(byte, 0);
}
function toHex(char) {
  return "0x" + char.charCodeAt(0).toString(16).toUpperCase();
}
function getPositionFromMultiline(line, column, string3) {
  if (line === 1)
    return column - 1;
  let currentLn = 1;
  let position = 0;
  string3.split("").find((char, idx) => {
    if (char === "\n")
      currentLn += 1;
    if (currentLn === line) {
      position = idx + column;
      return true;
    }
    return false;
  });
  return position;
}

// build/dev/javascript/gleam_json/gleam/json.mjs
var UnexpectedEndOfInput = class extends CustomType {
};
var UnexpectedByte = class extends CustomType {
  constructor(byte, position) {
    super();
    this.byte = byte;
    this.position = position;
  }
};
var UnexpectedFormat = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
function do_decode(json, decoder2) {
  return then$(
    decode(json),
    (dynamic_value) => {
      let _pipe = decoder2(dynamic_value);
      return map_error(
        _pipe,
        (var0) => {
          return new UnexpectedFormat(var0);
        }
      );
    }
  );
}
function decode2(json, decoder2) {
  return do_decode(json, decoder2);
}

// build/dev/javascript/lustre/lustre/effect.mjs
var Effect = class extends CustomType {
  constructor(all) {
    super();
    this.all = all;
  }
};
function from2(effect) {
  return new Effect(toList([(dispatch, _) => {
    return effect(dispatch);
  }]));
}
function none() {
  return new Effect(toList([]));
}

// build/dev/javascript/lustre/lustre/internals/vdom.mjs
var Text = class extends CustomType {
  constructor(content) {
    super();
    this.content = content;
  }
};
var Element = class extends CustomType {
  constructor(key, namespace, tag2, attrs, children, self_closing, void$) {
    super();
    this.key = key;
    this.namespace = namespace;
    this.tag = tag2;
    this.attrs = attrs;
    this.children = children;
    this.self_closing = self_closing;
    this.void = void$;
  }
};
var Attribute = class extends CustomType {
  constructor(x0, x1, as_property) {
    super();
    this[0] = x0;
    this[1] = x1;
    this.as_property = as_property;
  }
};
var Event = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};

// build/dev/javascript/lustre/lustre/attribute.mjs
function attribute(name, value2) {
  return new Attribute(name, from(value2), false);
}
function on(name, handler) {
  return new Event("on" + name, handler);
}
function class$(name) {
  return attribute("class", name);
}
function id(name) {
  return attribute("id", name);
}
function type_(name) {
  return attribute("type", name);
}
function placeholder(text3) {
  return attribute("placeholder", text3);
}

// build/dev/javascript/lustre/lustre/element.mjs
function element(tag2, attrs, children) {
  if (tag2 === "area") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "base") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "br") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "col") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "embed") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "hr") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "img") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "input") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "link") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "meta") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "param") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "source") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "track") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else if (tag2 === "wbr") {
    return new Element("", "", tag2, attrs, toList([]), false, true);
  } else {
    return new Element("", "", tag2, attrs, children, false, false);
  }
}
function text(content) {
  return new Text(content);
}

// build/dev/javascript/lustre/lustre/internals/runtime.mjs
var Debug = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Dispatch = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var Shutdown = class extends CustomType {
};
var ForceModel = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};

// build/dev/javascript/lustre/vdom.ffi.mjs
function morph(prev, next, dispatch, isComponent = false) {
  let out;
  let stack3 = [{ prev, next, parent: prev.parentNode }];
  while (stack3.length) {
    let { prev: prev2, next: next2, parent } = stack3.pop();
    if (next2.subtree !== void 0)
      next2 = next2.subtree();
    if (next2.content !== void 0) {
      if (!prev2) {
        const created = document.createTextNode(next2.content);
        parent.appendChild(created);
        out ??= created;
      } else if (prev2.nodeType === Node.TEXT_NODE) {
        if (prev2.textContent !== next2.content)
          prev2.textContent = next2.content;
        out ??= prev2;
      } else {
        const created = document.createTextNode(next2.content);
        parent.replaceChild(created, prev2);
        out ??= created;
      }
    } else if (next2.tag !== void 0) {
      const created = createElementNode({
        prev: prev2,
        next: next2,
        dispatch,
        stack: stack3,
        isComponent
      });
      if (!prev2) {
        parent.appendChild(created);
      } else if (prev2 !== created) {
        parent.replaceChild(created, prev2);
      }
      out ??= created;
    } else if (next2.elements !== void 0) {
      iterateElement(next2, (fragmentElement) => {
        stack3.unshift({ prev: prev2, next: fragmentElement, parent });
        prev2 = prev2?.nextSibling;
      });
    } else if (next2.subtree !== void 0) {
      stack3.push({ prev: prev2, next: next2, parent });
    }
  }
  return out;
}
function createElementNode({ prev, next, dispatch, stack: stack3 }) {
  const namespace = next.namespace || "http://www.w3.org/1999/xhtml";
  const canMorph = prev && prev.nodeType === Node.ELEMENT_NODE && prev.localName === next.tag && prev.namespaceURI === (next.namespace || "http://www.w3.org/1999/xhtml");
  const el2 = canMorph ? prev : namespace ? document.createElementNS(namespace, next.tag) : document.createElement(next.tag);
  let handlersForEl;
  if (!registeredHandlers.has(el2)) {
    const emptyHandlers = /* @__PURE__ */ new Map();
    registeredHandlers.set(el2, emptyHandlers);
    handlersForEl = emptyHandlers;
  } else {
    handlersForEl = registeredHandlers.get(el2);
  }
  const prevHandlers = canMorph ? new Set(handlersForEl.keys()) : null;
  const prevAttributes = canMorph ? new Set(Array.from(prev.attributes, (a) => a.name)) : null;
  let className = null;
  let style3 = null;
  let innerHTML = null;
  for (const attr of next.attrs) {
    const name = attr[0];
    const value2 = attr[1];
    if (attr.as_property) {
      if (el2[name] !== value2)
        el2[name] = value2;
      if (canMorph)
        prevAttributes.delete(name);
    } else if (name.startsWith("on")) {
      const eventName = name.slice(2);
      const callback = dispatch(value2);
      if (!handlersForEl.has(eventName)) {
        el2.addEventListener(eventName, lustreGenericEventHandler);
      }
      handlersForEl.set(eventName, callback);
      if (canMorph)
        prevHandlers.delete(eventName);
    } else if (name.startsWith("data-lustre-on-")) {
      const eventName = name.slice(15);
      const callback = dispatch(lustreServerEventHandler);
      if (!handlersForEl.has(eventName)) {
        el2.addEventListener(eventName, lustreGenericEventHandler);
      }
      handlersForEl.set(eventName, callback);
      el2.setAttribute(name, value2);
    } else if (name === "class") {
      className = className === null ? value2 : className + " " + value2;
    } else if (name === "style") {
      style3 = style3 === null ? value2 : style3 + value2;
    } else if (name === "dangerous-unescaped-html") {
      innerHTML = value2;
    } else {
      if (typeof value2 === "string")
        el2.setAttribute(name, value2);
      if (name === "value" || name === "selected")
        el2[name] = value2;
      if (canMorph)
        prevAttributes.delete(name);
    }
  }
  if (className !== null) {
    el2.setAttribute("class", className);
    if (canMorph)
      prevAttributes.delete("class");
  }
  if (style3 !== null) {
    el2.setAttribute("style", style3);
    if (canMorph)
      prevAttributes.delete("style");
  }
  if (canMorph) {
    for (const attr of prevAttributes) {
      el2.removeAttribute(attr);
    }
    for (const eventName of prevHandlers) {
      handlersForEl.delete(eventName);
      el2.removeEventListener(eventName, lustreGenericEventHandler);
    }
  }
  if (next.key !== void 0 && next.key !== "") {
    el2.setAttribute("data-lustre-key", next.key);
  } else if (innerHTML !== null) {
    el2.innerHTML = innerHTML;
    return el2;
  }
  let prevChild = el2.firstChild;
  let seenKeys = null;
  let keyedChildren = null;
  let incomingKeyedChildren = null;
  let firstChild = next.children[Symbol.iterator]().next().value;
  if (canMorph && firstChild !== void 0 && // Explicit checks are more verbose but truthy checks force a bunch of comparisons
  // we don't care about: it's never gonna be a number etc.
  firstChild.key !== void 0 && firstChild.key !== "") {
    seenKeys = /* @__PURE__ */ new Set();
    keyedChildren = getKeyedChildren(prev);
    incomingKeyedChildren = getKeyedChildren(next);
  }
  for (const child of next.children) {
    iterateElement(child, (currElement) => {
      if (currElement.key !== void 0 && seenKeys !== null) {
        prevChild = diffKeyedChild(
          prevChild,
          currElement,
          el2,
          stack3,
          incomingKeyedChildren,
          keyedChildren,
          seenKeys
        );
      } else {
        stack3.unshift({ prev: prevChild, next: currElement, parent: el2 });
        prevChild = prevChild?.nextSibling;
      }
    });
  }
  while (prevChild) {
    const next2 = prevChild.nextSibling;
    el2.removeChild(prevChild);
    prevChild = next2;
  }
  return el2;
}
var registeredHandlers = /* @__PURE__ */ new WeakMap();
function lustreGenericEventHandler(event2) {
  const target2 = event2.currentTarget;
  if (!registeredHandlers.has(target2)) {
    target2.removeEventListener(event2.type, lustreGenericEventHandler);
    return;
  }
  const handlersForEventTarget = registeredHandlers.get(target2);
  if (!handlersForEventTarget.has(event2.type)) {
    target2.removeEventListener(event2.type, lustreGenericEventHandler);
    return;
  }
  handlersForEventTarget.get(event2.type)(event2);
}
function lustreServerEventHandler(event2) {
  const el2 = event2.target;
  const tag2 = el2.getAttribute(`data-lustre-on-${event2.type}`);
  const data = JSON.parse(el2.getAttribute("data-lustre-data") || "{}");
  const include = JSON.parse(el2.getAttribute("data-lustre-include") || "[]");
  switch (event2.type) {
    case "input":
    case "change":
      include.push("target.value");
      break;
  }
  return {
    tag: tag2,
    data: include.reduce(
      (data2, property) => {
        const path = property.split(".");
        for (let i = 0, o = data2, e = event2; i < path.length; i++) {
          if (i === path.length - 1) {
            o[path[i]] = e[path[i]];
          } else {
            o[path[i]] ??= {};
            e = e[path[i]];
            o = o[path[i]];
          }
        }
        return data2;
      },
      { data }
    )
  };
}
function getKeyedChildren(el2) {
  const keyedChildren = /* @__PURE__ */ new Map();
  if (el2) {
    for (const child of el2.children) {
      iterateElement(child, (currElement) => {
        const key = currElement?.key || currElement?.getAttribute?.("data-lustre-key");
        if (key)
          keyedChildren.set(key, currElement);
      });
    }
  }
  return keyedChildren;
}
function diffKeyedChild(prevChild, child, el2, stack3, incomingKeyedChildren, keyedChildren, seenKeys) {
  while (prevChild && !incomingKeyedChildren.has(prevChild.getAttribute("data-lustre-key"))) {
    const nextChild = prevChild.nextSibling;
    el2.removeChild(prevChild);
    prevChild = nextChild;
  }
  if (keyedChildren.size === 0) {
    iterateElement(child, (currChild) => {
      stack3.unshift({ prev: prevChild, next: currChild, parent: el2 });
      prevChild = prevChild?.nextSibling;
    });
    return prevChild;
  }
  if (seenKeys.has(child.key)) {
    console.warn(`Duplicate key found in Lustre vnode: ${child.key}`);
    stack3.unshift({ prev: null, next: child, parent: el2 });
    return prevChild;
  }
  seenKeys.add(child.key);
  const keyedChild = keyedChildren.get(child.key);
  if (!keyedChild && !prevChild) {
    stack3.unshift({ prev: null, next: child, parent: el2 });
    return prevChild;
  }
  if (!keyedChild && prevChild !== null) {
    const placeholder2 = document.createTextNode("");
    el2.insertBefore(placeholder2, prevChild);
    stack3.unshift({ prev: placeholder2, next: child, parent: el2 });
    return prevChild;
  }
  if (!keyedChild || keyedChild === prevChild) {
    stack3.unshift({ prev: prevChild, next: child, parent: el2 });
    prevChild = prevChild?.nextSibling;
    return prevChild;
  }
  el2.insertBefore(keyedChild, prevChild);
  stack3.unshift({ prev: keyedChild, next: child, parent: el2 });
  return prevChild;
}
function iterateElement(element2, processElement) {
  if (element2.elements !== void 0) {
    for (const currElement of element2.elements) {
      processElement(currElement);
    }
  } else {
    processElement(element2);
  }
}

// build/dev/javascript/lustre/client-runtime.ffi.mjs
var LustreClientApplication2 = class _LustreClientApplication {
  #root = null;
  #queue = [];
  #effects = [];
  #didUpdate = false;
  #isComponent = false;
  #model = null;
  #update = null;
  #view = null;
  static start(flags, selector, init3, update3, view2) {
    if (!is_browser())
      return new Error(new NotABrowser());
    const root2 = selector instanceof HTMLElement ? selector : document.querySelector(selector);
    if (!root2)
      return new Error(new ElementNotFound(selector));
    const app = new _LustreClientApplication(init3(flags), update3, view2, root2);
    return new Ok((msg) => app.send(msg));
  }
  constructor([model, effects], update3, view2, root2 = document.body, isComponent = false) {
    this.#model = model;
    this.#update = update3;
    this.#view = view2;
    this.#root = root2;
    this.#effects = effects.all.toArray();
    this.#didUpdate = true;
    this.#isComponent = isComponent;
    window.requestAnimationFrame(() => this.#tick());
  }
  send(action) {
    switch (true) {
      case action instanceof Dispatch: {
        this.#queue.push(action[0]);
        this.#tick();
        return;
      }
      case action instanceof Shutdown: {
        this.#shutdown();
        return;
      }
      case action instanceof Debug: {
        this.#debug(action[0]);
        return;
      }
      default:
        return;
    }
  }
  emit(event2, data) {
    this.#root.dispatchEvent(
      new CustomEvent(event2, {
        bubbles: true,
        detail: data,
        composed: true
      })
    );
  }
  #tick() {
    this.#flush_queue();
    const vdom = this.#view(this.#model);
    const dispatch = (handler) => (e) => {
      const result = handler(e);
      if (result instanceof Ok) {
        this.send(new Dispatch(result[0]));
      }
    };
    this.#didUpdate = false;
    this.#root = morph(this.#root, vdom, dispatch, this.#isComponent);
  }
  #flush_queue(iterations = 0) {
    while (this.#queue.length) {
      const [next, effects] = this.#update(this.#model, this.#queue.shift());
      this.#didUpdate ||= !isEqual(this.#model, next);
      this.#model = next;
      this.#effects = this.#effects.concat(effects.all.toArray());
    }
    while (this.#effects.length) {
      this.#effects.shift()(
        (msg) => this.send(new Dispatch(msg)),
        (event2, data) => this.emit(event2, data)
      );
    }
    if (this.#queue.length) {
      if (iterations < 5) {
        this.#flush_queue(++iterations);
      } else {
        window.requestAnimationFrame(() => this.#tick());
      }
    }
  }
  #debug(action) {
    switch (true) {
      case action instanceof ForceModel: {
        const vdom = this.#view(action[0]);
        const dispatch = (handler) => (e) => {
          const result = handler(e);
          if (result instanceof Ok) {
            this.send(new Dispatch(result[0]));
          }
        };
        this.#queue = [];
        this.#effects = [];
        this.#didUpdate = false;
        this.#root = morph(this.#root, vdom, dispatch, this.#isComponent);
      }
    }
  }
  #shutdown() {
    this.#root.remove();
    this.#root = null;
    this.#model = null;
    this.#queue = [];
    this.#effects = [];
    this.#didUpdate = false;
    this.#update = () => {
    };
    this.#view = () => {
    };
  }
};
var start = (app, selector, flags) => LustreClientApplication2.start(
  flags,
  selector,
  app.init,
  app.update,
  app.view
);
var is_browser = () => window && window.document;

// build/dev/javascript/lustre/lustre.mjs
var App = class extends CustomType {
  constructor(init3, update3, view2, on_attribute_change) {
    super();
    this.init = init3;
    this.update = update3;
    this.view = view2;
    this.on_attribute_change = on_attribute_change;
  }
};
var ElementNotFound = class extends CustomType {
  constructor(selector) {
    super();
    this.selector = selector;
  }
};
var NotABrowser = class extends CustomType {
};
function application(init3, update3, view2) {
  return new App(init3, update3, view2, new None());
}
function start3(app, selector, flags) {
  return guard(
    !is_browser(),
    new Error(new NotABrowser()),
    () => {
      return start(app, selector, flags);
    }
  );
}

// build/dev/javascript/lustre/lustre/element/html.mjs
function text2(content) {
  return text(content);
}
function style(attrs, css) {
  return element("style", attrs, toList([text2(css)]));
}
function h1(attrs, children) {
  return element("h1", attrs, children);
}
function h2(attrs, children) {
  return element("h2", attrs, children);
}
function main(attrs, children) {
  return element("main", attrs, children);
}
function div(attrs, children) {
  return element("div", attrs, children);
}
function p(attrs, children) {
  return element("p", attrs, children);
}
function button(attrs, children) {
  return element("button", attrs, children);
}
function input(attrs) {
  return element("input", attrs, toList([]));
}

// build/dev/javascript/lustre_ui/lustre/ui/button.mjs
function button2(attributes, children) {
  return button(
    prepend(
      class$("lustre-ui-button"),
      prepend(type_("button"), attributes)
    ),
    children
  );
}
function soft() {
  return class$("soft");
}
function small() {
  return class$("small");
}
function primary() {
  return attribute("data-variant", "primary");
}

// build/dev/javascript/lustre_ui/lustre/ui/layout/stack.mjs
function of(element2, attributes, children) {
  return element2(
    prepend(class$("lustre-ui-stack"), attributes),
    children
  );
}
function stack(attributes, children) {
  return of(div, attributes, children);
}
function tight() {
  return class$("tight");
}

// build/dev/javascript/lustre_ui/lustre/ui/input.mjs
function input2(attributes) {
  return input(
    prepend(class$("lustre-ui-input"), attributes)
  );
}

// build/dev/javascript/lustre_ui/lustre/ui/layout/aside.mjs
function of2(element2, attributes, side, main3) {
  return element2(
    prepend(class$("lustre-ui-aside"), attributes),
    toList([side, main3])
  );
}
function aside(attributes, side, main3) {
  return of2(div, attributes, side, main3);
}

// build/dev/javascript/lustre_ui/lustre/ui/layout/box.mjs
function of3(element2, attributes, children) {
  return element2(
    prepend(class$("lustre-ui-box"), attributes),
    children
  );
}
function box(attributes, children) {
  return of3(div, attributes, children);
}

// build/dev/javascript/gleam_community_colour/gleam_community/colour.mjs
var Rgba = class extends CustomType {
  constructor(r, g, b, a) {
    super();
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
};
var light_red = new Rgba(
  0.9372549019607843,
  0.1607843137254902,
  0.1607843137254902,
  1
);
var red = new Rgba(0.8, 0, 0, 1);
var dark_red = new Rgba(0.6431372549019608, 0, 0, 1);
var light_orange = new Rgba(
  0.9882352941176471,
  0.6862745098039216,
  0.24313725490196078,
  1
);
var orange = new Rgba(0.9607843137254902, 0.4745098039215686, 0, 1);
var dark_orange = new Rgba(
  0.807843137254902,
  0.3607843137254902,
  0,
  1
);
var light_yellow = new Rgba(
  1,
  0.9137254901960784,
  0.30980392156862746,
  1
);
var yellow = new Rgba(0.9294117647058824, 0.8313725490196079, 0, 1);
var dark_yellow = new Rgba(
  0.7686274509803922,
  0.6274509803921569,
  0,
  1
);
var light_green = new Rgba(
  0.5411764705882353,
  0.8862745098039215,
  0.20392156862745098,
  1
);
var green = new Rgba(
  0.45098039215686275,
  0.8235294117647058,
  0.08627450980392157,
  1
);
var dark_green = new Rgba(
  0.3058823529411765,
  0.6039215686274509,
  0.023529411764705882,
  1
);
var light_blue = new Rgba(
  0.4470588235294118,
  0.6235294117647059,
  0.8117647058823529,
  1
);
var blue = new Rgba(
  0.20392156862745098,
  0.396078431372549,
  0.6431372549019608,
  1
);
var dark_blue = new Rgba(
  0.12549019607843137,
  0.2901960784313726,
  0.5294117647058824,
  1
);
var light_purple = new Rgba(
  0.6784313725490196,
  0.4980392156862745,
  0.6588235294117647,
  1
);
var purple = new Rgba(
  0.4588235294117647,
  0.3137254901960784,
  0.4823529411764706,
  1
);
var dark_purple = new Rgba(
  0.3607843137254902,
  0.20784313725490197,
  0.4,
  1
);
var light_brown = new Rgba(
  0.9137254901960784,
  0.7254901960784313,
  0.43137254901960786,
  1
);
var brown = new Rgba(
  0.7568627450980392,
  0.49019607843137253,
  0.06666666666666667,
  1
);
var dark_brown = new Rgba(
  0.5607843137254902,
  0.34901960784313724,
  0.00784313725490196,
  1
);
var black = new Rgba(0, 0, 0, 1);
var white = new Rgba(1, 1, 1, 1);
var light_grey = new Rgba(
  0.9333333333333333,
  0.9333333333333333,
  0.9254901960784314,
  1
);
var grey = new Rgba(
  0.8274509803921568,
  0.8431372549019608,
  0.8117647058823529,
  1
);
var dark_grey = new Rgba(
  0.7294117647058823,
  0.7411764705882353,
  0.7137254901960784,
  1
);
var light_gray = new Rgba(
  0.9333333333333333,
  0.9333333333333333,
  0.9254901960784314,
  1
);
var gray = new Rgba(
  0.8274509803921568,
  0.8431372549019608,
  0.8117647058823529,
  1
);
var dark_gray = new Rgba(
  0.7294117647058823,
  0.7411764705882353,
  0.7137254901960784,
  1
);
var light_charcoal = new Rgba(
  0.5333333333333333,
  0.5411764705882353,
  0.5215686274509804,
  1
);
var charcoal = new Rgba(
  0.3333333333333333,
  0.3411764705882353,
  0.3254901960784314,
  1
);
var dark_charcoal = new Rgba(
  0.1803921568627451,
  0.20392156862745098,
  0.21176470588235294,
  1
);
var pink = new Rgba(1, 0.6862745098039216, 0.9529411764705882, 1);

// build/dev/javascript/lustre_ui/lustre/ui.mjs
var aside2 = aside;
var box2 = box;
var button3 = button2;
var input3 = input2;
var stack2 = stack;

// build/dev/javascript/lustre_ui/lustre/ui/util/styles.mjs
var element_css = '\n*,:after,:before{border:0 solid;box-sizing:border-box}html{-webkit-text-size-adjust:100%;font-feature-settings:normal;font-family:ui-sans-serif,system-ui,-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Helvetica Neue,Arial,Noto Sans,sans-serif,Apple Color Emoji,Segoe UI Emoji,Segoe UI Symbol,Noto Color Emoji;font-variation-settings:normal;line-height:1.5;-moz-tab-size:4;-o-tab-size:4;tab-size:4}body{line-height:inherit;margin:0}hr{border-top-width:1px;color:inherit;height:0}abbr:where([title]){-webkit-text-decoration:underline dotted;text-decoration:underline dotted}h1,h2,h3,h4,h5,h6{font-size:inherit;font-weight:inherit}a{color:inherit;text-decoration:inherit}b,strong{font-weight:bolder}code,kbd,pre,samp{font-family:ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,Liberation Mono,Courier New,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}table{border-collapse:collapse;border-color:inherit;text-indent:0}button,input,optgroup,select,textarea{font-feature-settings:inherit;color:inherit;font-family:inherit;font-size:100%;font-variation-settings:inherit;font-weight:inherit;line-height:inherit;margin:0;padding:0}button,select{text-transform:none}[type=button],[type=reset],[type=submit],button{-webkit-appearance:button;background-color:transparent;background-image:none}:-moz-focusring{outline:auto}:-moz-ui-invalid{box-shadow:none}progress{vertical-align:baseline}::-webkit-inner-spin-button,::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}summary{display:list-item}blockquote,dd,dl,figure,h1,h2,h3,h4,h5,h6,hr,p,pre{margin:0}fieldset{margin:0}fieldset,legend{padding:0}menu,ol,ul{list-style:none;margin:0;padding:0}dialog{padding:0}textarea{resize:vertical}input::-moz-placeholder,textarea::-moz-placeholder{color:#9ca3af;opacity:1}input::placeholder,textarea::placeholder{color:#9ca3af;opacity:1}[role=button],button{cursor:pointer}:disabled{cursor:default}audio,canvas,embed,iframe,img,object,svg,video{display:block;vertical-align:middle}img,video{height:auto;max-width:100%}[hidden]{display:none}.bg-app{background-color:var(--app-background)}.bg-app-subtle{background-color:var(--app-background-subtle)}.bg-element{background-color:var(--element-background)}.bg-element-hover{background-color:var(--element-background-hover)}.bg-element-strong{background-color:var(--element-background-strong)}.bg-solid{background-color:var(--solid-background)}.bg-solid-hover{background-color:var(--solid-background-hover)}.border-app{border:1px solid var(--app-border)}.border-element-subtle{border:1px solid var(--element-border-subtle)}.border-element-strong{border:1px solid var(--element-border-strong)}.text-high-contrast{color:var(--text-high-contrast)}.text-low-contrast{color:var(--text-low-contrast)}.border-radius{border-radius:var(--border-radius)}.text-xs{font-size:var(--text-xs)}.text-sm{font-size:var(--text-sm)}.text-md{font-size:var(--text-md)}.text-lg{font-size:var(--text-lg)}.text-xl{font-size:var(--text-xl)}.text-2xl{font-size:var(--text-2xl)}.text-3xl{font-size:var(--text-3xl)}.text-4xl{font-size:var(--text-4xl)}.text-5xl{font-size:var(--text-5xl)}.p-2xs{padding:var(--space-2xs)}.p-xs{padding:var(--space-xs)}.p-sm{padding:var(--space-sm)}.p-md{padding:var(--space-md)}.p-lg{padding:var(--space-lg)}.p-xl{padding:var(--space-xl)}.p-2xl{padding:var(--space-2xl)}.p-3xl{padding:var(--space-3xl)}.p-4xl{padding:var(--space-4xl)}.p-5xl{padding:var(--space-5xl)}.px-2xs{padding-left:var(--space-2xs);padding-right:var(--space-2xs)}.px-xs{padding-left:var(--space-xs);padding-right:var(--space-xs)}.px-sm{padding-left:var(--space-sm);padding-right:var(--space-sm)}.px-md{padding-left:var(--space-md);padding-right:var(--space-md)}.px-lg{padding-left:var(--space-lg);padding-right:var(--space-lg)}.px-xl{padding-left:var(--space-xl);padding-right:var(--space-xl)}.px-2xl{padding-left:var(--space-2xl);padding-right:var(--space-2xl)}.px-3xl{padding-left:var(--space-3xl);padding-right:var(--space-3xl)}.px-4xl{padding-left:var(--space-4xl);padding-right:var(--space-4xl)}.px-5xl{padding-left:var(--space-5xl);padding-right:var(--space-5xl)}.py-2xs{padding-bottom:var(--space-2xs);padding-top:var(--space-2xs)}.py-xs{padding-bottom:var(--space-xs);padding-top:var(--space-xs)}.py-sm{padding-bottom:var(--space-sm);padding-top:var(--space-sm)}.py-md{padding-bottom:var(--space-md);padding-top:var(--space-md)}.py-lg{padding-bottom:var(--space-lg);padding-top:var(--space-lg)}.py-xl{padding-bottom:var(--space-xl);padding-top:var(--space-xl)}.py-2xl{padding-bottom:var(--space-2xl);padding-top:var(--space-2xl)}.py-3xl{padding-bottom:var(--space-3xl);padding-top:var(--space-3xl)}.py-4xl{padding-bottom:var(--space-4xl);padding-top:var(--space-4xl)}.py-5xl{padding-bottom:var(--space-5xl);padding-top:var(--space-5xl)}.pt-2xs{padding-top:var(--space-2xs)}.pt-xs{padding-top:var(--space-xs)}.pt-sm{padding-top:var(--space-sm)}.pt-md{padding-top:var(--space-md)}.pt-lg{padding-top:var(--space-lg)}.pt-xl{padding-top:var(--space-xl)}.pt-2xl{padding-top:var(--space-2xl)}.pt-3xl{padding-top:var(--space-3xl)}.pt-4xl{padding-top:var(--space-4xl)}.pt-5xl{padding-top:var(--space-5xl)}.pr-2xs{padding-right:var(--space-2xs)}.pr-xs{padding-right:var(--space-xs)}.pr-sm{padding-right:var(--space-sm)}.pr-md{padding-right:var(--space-md)}.pr-lg{padding-right:var(--space-lg)}.pr-xl{padding-right:var(--space-xl)}.pr-2xl{padding-right:var(--space-2xl)}.pr-3xl{padding-right:var(--space-3xl)}.pr-4xl{padding-right:var(--space-4xl)}.pr-5xl{padding-right:var(--space-5xl)}.pb-2xs{padding-bottom:var(--space-2xs)}.pb-xs{padding-bottom:var(--space-xs)}.pb-sm{padding-bottom:var(--space-sm)}.pb-md{padding-bottom:var(--space-md)}.pb-lg{padding-bottom:var(--space-lg)}.pb-xl{padding-bottom:var(--space-xl)}.pb-2xl{padding-bottom:var(--space-2xl)}.pb-3xl{padding-bottom:var(--space-3xl)}.pb-4xl{padding-bottom:var(--space-4xl)}.pb-5xl{padding-bottom:var(--space-5xl)}.m-2xs{margin:var(--space-2xs)}.m-xs{margin:var(--space-xs)}.m-sm{margin:var(--space-sm)}.m-md{margin:var(--space-md)}.m-lg{margin:var(--space-lg)}.m-xl{margin:var(--space-xl)}.m-2xl{margin:var(--space-2xl)}.m-3xl{margin:var(--space-3xl)}.m-4xl{margin:var(--space-4xl)}.m-5xl{margin:var(--space-5xl)}.mx-2xs{margin-left:var(--space-2xs);margin-right:var(--space-2xs)}.mx-xs{margin-left:var(--space-xs);margin-right:var(--space-xs)}.mx-sm{margin-left:var(--space-sm);margin-right:var(--space-sm)}.mx-md{margin-left:var(--space-md);margin-right:var(--space-md)}.mx-lg{margin-left:var(--space-lg);margin-right:var(--space-lg)}.mx-xl{margin-left:var(--space-xl);margin-right:var(--space-xl)}.mx-2xl{margin-left:var(--space-2xl);margin-right:var(--space-2xl)}.mx-3xl{margin-left:var(--space-3xl);margin-right:var(--space-3xl)}.mx-4xl{margin-left:var(--space-4xl);margin-right:var(--space-4xl)}.mx-5xl{margin-left:var(--space-5xl);margin-right:var(--space-5xl)}.my-2xs{margin-bottom:var(--space-2xs);margin-top:var(--space-2xs)}.my-xs{margin-bottom:var(--space-xs);margin-top:var(--space-xs)}.my-sm{margin-bottom:var(--space-sm);margin-top:var(--space-sm)}.my-md{margin-bottom:var(--space-md);margin-top:var(--space-md)}.my-lg{margin-bottom:var(--space-lg);margin-top:var(--space-lg)}.my-xl{margin-bottom:var(--space-xl);margin-top:var(--space-xl)}.my-2xl{margin-bottom:var(--space-2xl);margin-top:var(--space-2xl)}.my-3xl{margin-bottom:var(--space-3xl);margin-top:var(--space-3xl)}.my-4xl{margin-bottom:var(--space-4xl);margin-top:var(--space-4xl)}.my-5xl{margin-bottom:var(--space-5xl);margin-top:var(--space-5xl)}.mt-2xs{margin-top:var(--space-2xs)}.mt-xs{margin-top:var(--space-xs)}.mt-sm{margin-top:var(--space-sm)}.mt-md{margin-top:var(--space-md)}.mt-lg{margin-top:var(--space-lg)}.mt-xl{margin-top:var(--space-xl)}.mt-2xl{margin-top:var(--space-2xl)}.mt-3xl{margin-top:var(--space-3xl)}.mt-4xl{margin-top:var(--space-4xl)}.mt-5xl{margin-top:var(--space-5xl)}.mr-2xs{margin-right:var(--space-2xs)}.mr-xs{margin-right:var(--space-xs)}.mr-sm{margin-right:var(--space-sm)}.mr-md{margin-right:var(--space-md)}.mr-lg{margin-right:var(--space-lg)}.mr-xl{margin-right:var(--space-xl)}.mr-2xl{margin-right:var(--space-2xl)}.mr-3xl{margin-right:var(--space-3xl)}.mr-4xl{margin-right:var(--space-4xl)}.mr-5xl{margin-right:var(--space-5xl)}.mb-2xs{margin-bottom:var(--space-2xs)}.mb-xs{margin-bottom:var(--space-xs)}.mb-sm{margin-bottom:var(--space-sm)}.mb-md{margin-bottom:var(--space-md)}.mb-lg{margin-bottom:var(--space-lg)}.mb-xl{margin-bottom:var(--space-xl)}.mb-2xl{margin-bottom:var(--space-2xl)}.mb-3xl{margin-bottom:var(--space-3xl)}.mb-4xl{margin-bottom:var(--space-4xl)}.mb-5xl{margin-bottom:var(--space-5xl)}.ml-2xs{margin-left:var(--space-2xs)}.ml-xs{margin-left:var(--space-xs)}.ml-sm{margin-left:var(--space-sm)}.ml-md{margin-left:var(--space-md)}.ml-lg{margin-left:var(--space-lg)}.ml-xl{margin-left:var(--space-xl)}.ml-2xl{margin-left:var(--space-2xl)}.ml-3xl{margin-left:var(--space-3xl)}.ml-4xl{margin-left:var(--space-4xl)}.ml-5xl{margin-left:var(--space-5xl)}.font-base{font-family:var(--font-base)}.font-alt{font-family:var(--font-alt)}.font-mono{font-family:var(--font-mono)}.shadow-sm{box-shadow:var(--shadow-sm)}.shadow-md{box-shadow:var(--shadow-md)}.shadow-lg{box-shadow:var(--shadow-lg)}:root{--primary-app-background:#fdfdff;--primary-app-background-subtle:#fafaff;--primary-app-border:#d0d0fa;--primary-element-background:#f3f3ff;--primary-element-background-hover:#ebebfe;--primary-element-background-strong:#e0e0fd;--primary-element-border-subtle:#babbf5;--primary-element-border-strong:#9b9ef0;--primary-solid-background:#5b5bd6;--primary-solid-background-hover:#5353ce;--primary-text-high-contrast:#272962;--primary-text-low-contrast:#4747c2;--greyscale-app-background:#fcfcfd;--greyscale-app-background-subtle:#f9f9fb;--greyscale-app-border:#dddde3;--greyscale-element-background:#f2f2f5;--greyscale-element-background-hover:#ebebef;--greyscale-element-background-strong:#e4e4e9;--greyscale-element-border-subtle:#d3d4db;--greyscale-element-border-strong:#b9bbc6;--greyscale-solid-background:#8b8d98;--greyscale-solid-background-hover:#7e808a;--greyscale-text-high-contrast:#1c2024;--greyscale-text-low-contrast:#60646c;--error-app-background:#fffcfc;--error-app-background-subtle:#fff7f7;--error-app-border:#f9c6c6;--error-element-background:#ffefef;--error-element-background-hover:#ffe5e5;--error-element-background-strong:#fdd8d8;--error-element-border-subtle:#f3aeaf;--error-element-border-strong:#eb9091;--error-solid-background:#e5484d;--error-solid-background-hover:#d93d42;--error-text-high-contrast:#641723;--error-text-low-contrast:#c62a2f;--success-app-background:#fbfefc;--success-app-background-subtle:#f2fcf5;--success-app-border:#b4dfc4;--success-element-background:#e9f9ee;--success-element-background-hover:#ddf3e4;--success-element-background-strong:#ccebd7;--success-element-border-subtle:#92ceac;--success-element-border-strong:#5bb98c;--success-solid-background:#30a46c;--success-solid-background-hover:#299764;--success-text-high-contrast:#193b2d;--success-text-low-contrast:#18794e;--warning-app-background:#fdfdf9;--warning-app-background-subtle:#fffbe0;--warning-app-border:#ecdd85;--warning-element-background:#fff8c6;--warning-element-background-hover:#fcf3af;--warning-element-background-strong:#f7ea9b;--warning-element-border-subtle:#dac56e;--warning-element-border-strong:#c9aa45;--warning-solid-background:#fbe32d;--warning-solid-background-hover:#f9da10;--warning-text-high-contrast:#473b1f;--warning-text-low-contrast:#775f28;--info-app-background:#fbfdff;--info-app-background-subtle:#f5faff;--info-app-border:#b7d9f8;--info-element-background:#edf6ff;--info-element-background-hover:#e1f0ff;--info-element-background-strong:#cee7fe;--info-element-border-subtle:#96c7f2;--info-element-border-strong:#5eb0ef;--info-solid-background:#0091ff;--info-solid-background-hover:#0880ea;--info-text-high-contrast:#113264;--info-text-low-contrast:#0b68cb;--app-background:var(--primary-app-background);--app-background-subtle:var(--primary-app-background-subtle);--app-border:var(--primary-app-border);--element-background:var(--primary-element-background);--element-background-hover:var(--primary-element-background-hover);--element-background-strong:var(--primary-element-background-strong);--element-border-subtle:var(--primary-element-border-subtle);--element-border-strong:var(--primary-element-border-strong);--solid-background:var(--primary-solid-background);--solid-background-hover:var(--primary-solid-background-hover);--text-high-contrast:var(--primary-text-high-contrast);--text-low-contrast:var(--primary-text-low-contrast);--text-base:1.125rem;--text-ratio:1.215;--text-xs:calc(var(--text-base)/pow(var(--text-ratio), 2));--text-sm:calc(var(--text-base)/var(--text-ratio));--text-md:var(--text-base);--text-lg:calc(var(--text-base)*var(--text-ratio));--text-xl:calc(var(--text-md)*pow(var(--text-ratio), 2));--text-2xl:calc(var(--text-base)*pow(var(--text-ratio), 3));--text-3xl:calc(var(--text-base)*pow(var(--text-ratio), 4));--text-4xl:calc(var(--text-base)*pow(var(--text-ratio), 5));--text-5xl:calc(var(--text-base)*pow(var(--text-ratio), 6));--space-base:1rem;--space-ratio:1.618;--space-2xs:calc(var(--space-md)*0.25);--space-xs:calc(var(--space-md)*0.5);--space-sm:calc(var(--space-md)*0.75);--space-md:var(--space-base);--space-lg:calc(var(--space-md)*1.25);--space-xl:calc(var(--space-md)*2);--space-2xl:calc(var(--space-md)*3.25);--space-3xl:calc(var(--space-md)*5.25);--space-4xl:calc(var(--space-md)*8.5);--space-5xl:calc(var(--space-md)*13.75);--font-base:ui-sans-serif,system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";--font-alt:ui-serif,Georgia,Cambria,"Times New Roman",Times,serif;--font-mono:ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,"Liberation Mono","Courier New",monospace;--border-radius:4px;--shadow-sm:0 1px 2px 0 rgba(0,0,0,.05);--shadow-md:0 4px 6px -1px rgba(0,0,0,.1),0 2px 4px -2px rgba(0,0,0,.1);--shadow-lg:0 20px 25px -5px rgba(0,0,0,.1),0 8px 10px -6px rgba(0,0,0,.1);font-size:var(--text-md)}[data-variant=primary]{--app-background:var(--primary-app-background);--app-background-subtle:var(--primary-app-background-subtle);--app-border:var(--primary-app-border);--element-background:var(--primary-element-background);--element-background-hover:var(--primary-element-background-hover);--element-background-strong:var(--primary-element-background-strong);--element-border-subtle:var(--primary-element-border-subtle);--element-border-strong:var(--primary-element-border-strong);--solid-background:var(--primary-solid-background);--solid-background-hover:var(--primary-solid-background-hover);--text-high-contrast:var(--primary-text-high-contrast);--text-low-contrast:var(--primary-text-low-contrast)}[data-variant=greyscale]{--app-background:var(--greyscale-app-background);--app-background-subtle:var(--greyscale-app-background-subtle);--app-border:var(--greyscale-app-border);--element-background:var(--greyscale-element-background);--element-background-hover:var(--greyscale-element-background-hover);--element-background-strong:var(--greyscale-element-background-strong);--element-border-subtle:var(--greyscale-element-border-subtle);--element-border-strong:var(--greyscale-element-border-strong);--solid-background:var(--greyscale-solid-background);--solid-background-hover:var(--greyscale-solid-background-hover);--text-high-contrast:var(--greyscale-text-high-contrast);--text-low-contrast:var(--greyscale-text-low-contrast)}[data-variant=error]{--app-background:var(--error-app-background);--app-background-subtle:var(--error-app-background-subtle);--app-border:var(--error-app-border);--element-background:var(--error-element-background);--element-background-hover:var(--error-element-background-hover);--element-background-strong:var(--error-element-background-strong);--element-border-subtle:var(--error-element-border-subtle);--element-border-strong:var(--error-element-border-strong);--solid-background:var(--error-solid-background);--solid-background-hover:var(--error-solid-background-hover);--text-high-contrast:var(--error-text-high-contrast);--text-low-contrast:var(--error-text-low-contrast)}[data-variant=success]{--app-background:var(--success-app-background);--app-background-subtle:var(--success-app-background-subtle);--app-border:var(--success-app-border);--element-background:var(--success-element-background);--element-background-hover:var(--success-element-background-hover);--element-background-strong:var(--success-element-background-strong);--element-border-subtle:var(--success-element-border-subtle);--element-border-strong:var(--success-element-border-strong);--solid-background:var(--success-solid-background);--solid-background-hover:var(--success-solid-background-hover);--text-high-contrast:var(--success-text-high-contrast);--text-low-contrast:var(--success-text-low-contrast)}[data-variant=warning]{--app-background:var(--warning-app-background);--app-background-subtle:var(--warning-app-background-subtle);--app-border:var(--warning-app-border);--element-background:var(--warning-element-background);--element-background-hover:var(--warning-element-background-hover);--element-background-strong:var(--warning-element-background-strong);--element-border-subtle:var(--warning-element-border-subtle);--element-border-strong:var(--warning-element-border-strong);--solid-background:var(--warning-solid-background);--solid-background-hover:var(--warning-solid-background-hover);--text-high-contrast:var(--warning-text-high-contrast);--text-low-contrast:var(--warning-text-low-contrast)}[data-variant=info]{--app-background:var(--info-app-background);--app-background-subtle:var(--info-app-background-subtle);--app-border:var(--info-app-border);--element-background:var(--info-element-background);--element-background-hover:var(--info-element-background-hover);--element-background-strong:var(--info-element-background-strong);--element-border-subtle:var(--info-element-border-subtle);--element-border-strong:var(--info-element-border-strong);--solid-background:var(--info-solid-background);--solid-background-hover:var(--info-solid-background-hover);--text-high-contrast:var(--info-text-high-contrast);--text-low-contrast:var(--info-text-low-contrast)}.lustre-ui-alert,.use-lustre-ui .alert{--bg:var(--element-background);--border:var(--element-border-subtle);--text:var(--text-high-contrast);background-color:var(--bg);border:1px solid var(--border);border-radius:var(--border-radius);box-shadow:var(--shadow-sm);padding:var(--space-sm)}.clear:is(.use-lustre-ui .alert,.lustre-ui-alert){--bg:unsert}.lustre-ui-breadcrumbs,.use-lustre-ui .breadcrumbs{--gap:var(--space-sm);--align:center;align-items:var(--align);display:flex;flex-wrap:nowrap;gap:var(--gap);justify-content:start;overflow-x:auto}.tight:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--gap:var(--space-sm)}.loose:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--gap:var(--space-md)}.align-start:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--align:start}.align-center:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs),.align-centre:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--align:center}.align-end:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs){--align:end}:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs)>*{flex:0 0 auto}:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs):not(:has(.active))>:last-child,:is(.use-lustre-ui .breadcrumbs,.lustre-ui-breadcrumbs)>.active{color:var(--text-low-contrast)}.lustre-ui-button,.use-lustre-ui .button,.use-lustre-ui button{--bg-active:var(--element-background-strong);--bg-hover:var(--element-background-hover);--bg:var(--element-background);--border-active:var(--bg-active);--border:var(--bg);--text:var(--text-high-contrast);--padding-y:var(--space-xs);--padding-x:var(--space-sm);background-color:var(--bg);border:1px solid var(--border,var(--bg),var(--element-border-subtle));border-radius:var(--border-radius);color:var(--text);padding:var(--padding-y) var(--padding-x)}:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):focus-within,:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):hover{background-color:var(--bg-hover)}:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):focus-within:active,:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):hover:active{background-color:var(--bg-active);border-color:var(--border-active)}.small:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button){--padding-y:var(--space-2xs);--padding-x:var(--space-xs)}.solid:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button){--bg-active:var(--solid-background-hover);--bg-hover:var(--solid-background-hover);--bg:var(--solid-background);--border-active:var(--solid-background-hover);--border:var(--solid-background);--text:#fff}.solid:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):focus-within:active,.solid:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button):hover:active{--bg-active:color-mix(in srgb,var(--solid-background-hover) 90%,#000);--border-active:color-mix(in srgb,var(--solid-background-hover) 90%,#000)}.soft:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button){--bg-active:var(--element-background-strong);--bg-hover:var(--element-background-hover);--bg:var(--element-background);--border-active:var(--bg-active);--border:var(--bg);--text:var(--text-high-contrast)}.outline:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button){--bg:unset;--border:var(--element-border-subtle)}.clear:is(.use-lustre-ui button,.use-lustre-ui .button,.lustre-ui-button){--bg:unset;--border:unset}.lustre-ui-field,.use-lustre-ui .field{--label:var(--text-high-contrast);--label-align:start;--message:var(--text-low-contrast);--message-align:end;--text-size:var(--text-md)}.small:is(.use-lustre-ui .field,.lustre-ui-field){--text-size:var(--text-sm)}.label-start:is(.use-lustre-ui .field,.lustre-ui-field){--label-align:start}.label-center:is(.use-lustre-ui .field,.lustre-ui-field),.label-centre:is(.use-lustre-ui .field,.lustre-ui-field){--label-align:center}.label-end:is(.use-lustre-ui .field,.lustre-ui-field){--label-align:end}.message-start:is(.use-lustre-ui .field,.lustre-ui-field){--message-align:start}.message-center:is(.use-lustre-ui .field,.lustre-ui-field),.message-centre:is(.use-lustre-ui .field,.lustre-ui-field){--message-align:center}.message-end:is(.use-lustre-ui .field,.lustre-ui-field){--message-align:end}:is(.use-lustre-ui .field,.lustre-ui-field):has(input:disabled)>:is(.label,.message){opacity:.5}:is(.use-lustre-ui .field,.lustre-ui-field)>:not(input){color:var(--label);font-size:var(--text-size)}:is(.use-lustre-ui .field,.lustre-ui-field)>.label{display:inline-flex;justify-content:var(--label-align)}:is(.use-lustre-ui .field,.lustre-ui-field)>.message{color:var(--message);display:inline-flex;justify-content:var(--message-align)}.lustre-ui-icon,.use-lustre-ui .icon{--size:1em;display:inline;height:var(--size);width:var(--size)}.xs:is(.use-lustre-ui .icon,.lustre-ui-icon){--size:var(--text-xs)}.sm:is(.use-lustre-ui .icon,.lustre-ui-icon){--size:var(--text-sm)}.md:is(.use-lustre-ui .icon,.lustre-ui-icon){--size:var(--text-md)}.lg:is(.use-lustre-ui .icon,.lustre-ui-icon){--size:var(--text-lg)}.xl:is(.use-lustre-ui .icon,.lustre-ui-icon){--size:var(--text-xl)}.lustre-ui-input,.use-lustre-ui .input,.use-lustre-ui input:not([type~="checkbox file radio range"]){--border-active:var(--element-border-strong);--border:var(--element-border-subtle);--outline:var(--element-border-subtle);--text:var(--text-high-contrast);--text-placeholder:var(--text-low-contrast);--padding-y:var(--space-xs);--padding-x:var(--space-sm);border:1px solid var(--border,var(--bg),var(--element-border-subtle));border-radius:var(--border-radius);color:var(--text);padding:var(--padding-y) var(--padding-x)}:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input):hover{border-color:var(--border-active)}:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input):focus-within{border-color:var(--border-active);outline:1px solid var(--outline);outline-offset:2px}:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input)::-moz-placeholder{color:var(--text-placeholder)}:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input)::placeholder{color:var(--text-placeholder)}:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input):disabled{opacity:.5}.clear:is(.use-lustre-ui input:not([type~="checkbox file radio range"]),.use-lustre-ui .input,.lustre-ui-input){--border:unset}.lustre-ui-prose,.use-lustre-ui .prose{--width:60ch;width:var(--width)}.wide:is(.use-lustre-ui .prose,.lustre-ui-prose){--width:80ch}.full:is(.use-lustre-ui .prose,.lustre-ui-prose){--width:100%}:is(.use-lustre-ui .prose,.lustre-ui-prose) *+*{margin-top:var(--space-md)}:is(.use-lustre-ui .prose,.lustre-ui-prose) :not(h1,h2,h3,h4,h5,h6)+:is(h1,h2,h3,h4,h5,h6){margin-top:var(--space-xl)}:is(.use-lustre-ui .prose,.lustre-ui-prose) h1{font-size:var(--text-3xl)}:is(.use-lustre-ui .prose,.lustre-ui-prose) h2{font-size:var(--text-2xl)}:is(.use-lustre-ui .prose,.lustre-ui-prose) h3{font-size:var(--text-xl)}:is(.use-lustre-ui .prose,.lustre-ui-prose) :is(h4,h5,h6){font-size:var(--text-lg)}:is(.use-lustre-ui .prose,.lustre-ui-prose) img{border-radius:var(--border-radius);display:block;height:auto;-o-object-fit:cover;object-fit:cover;width:100%}:is(.use-lustre-ui .prose,.lustre-ui-prose) ul{list-style:disc}:is(.use-lustre-ui .prose,.lustre-ui-prose) ol{list-style:decimal}:is(.use-lustre-ui .prose,.lustre-ui-prose) :is(ul,ol,dl){padding-left:var(--space-xl)}:is(:is(.use-lustre-ui .prose,.lustre-ui-prose) :is(ul,ol,dl))>*+*{margin-top:var(--space-md)}:is(.use-lustre-ui .prose,.lustre-ui-prose) li::marker{color:var(--text-low-contrast)}:is(.use-lustre-ui .prose,.lustre-ui-prose) pre{background-color:var(--greyscale-element-background);border-radius:var(--border-radius);overflow-x:auto;padding:var(--space-sm) var(--space-md)}:is(.use-lustre-ui .prose,.lustre-ui-prose) pre>code{background-color:transparent;border-radius:0;color:inherit;font-size:var(--text-md);padding:0}:is(.use-lustre-ui .prose,.lustre-ui-prose) blockquote{border-left:4px solid var(--element-border-subtle);padding-left:var(--space-xl);quotes:"\\201C""\\201D""\\2018""\\2019"}:is(.use-lustre-ui .prose,.lustre-ui-prose) blockquote>*{font-style:italic}:is(:is(.use-lustre-ui .prose,.lustre-ui-prose) blockquote)>*+*{margin-top:var(--space-sm)}:is(.use-lustre-ui .prose,.lustre-ui-prose) blockquote>:first-child:before{content:open-quote}:is(.use-lustre-ui .prose,.lustre-ui-prose) blockquote>:last-child:after{content:close-quote}:is(.use-lustre-ui .prose,.lustre-ui-prose) a[href]{color:var(--text-low-contrast);text-decoration:underline}:is(.use-lustre-ui .prose,.lustre-ui-prose) a[href]:visited{color:var(--text-high-contrast)}:is(.use-lustre-ui .prose,.lustre-ui-prose) :is(code,kbd){background-color:var(--greyscale-element-background);border-radius:var(--border-radius)}:is(.use-lustre-ui .prose,.lustre-ui-prose) :not(pre) code{color:var(--text-high-contrast)}:is(.use-lustre-ui .prose,.lustre-ui-prose) :not(pre) code:after,:is(.use-lustre-ui .prose,.lustre-ui-prose) :not(pre) code:before{content:"\\`"}:is(.use-lustre-ui .prose,.lustre-ui-prose) kbd{border-color:var(--greyscale-element-border-strong);border-width:1px;font-weight:700;padding:0 var(--space-2xs)}.lustre-ui-tag,.use-lustre-ui .tag{--bg-active:var(--element-background-strong);--bg-hover:var(--element-background-hover);--bg:var(--element-background);--border-active:var(--bg-active);--border:var(--bg);--text:var(--text-high-contrast);background-color:var(--bg);border:1px solid var(--border,var(--bg),var(--element-border-subtle));border-radius:var(--border-radius);color:var(--text);font-size:var(--text-sm);padding:0 var(--space-xs)}:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]){cursor:pointer;-webkit-user-select:none;-moz-user-select:none;user-select:none}:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):focus-within,:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):hover{background-color:var(--bg-hover)}:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):focus-within:active,:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):hover:active{background-color:var(--bg-active);border-color:var(--border-active)}.solid:is(.use-lustre-ui .tag,.lustre-ui-tag){--bg-active:var(--solid-background-hover);--bg-hover:var(--solid-background-hover);--bg:var(--solid-background);--border-active:var(--solid-background-hover);--border:var(--solid-background);--text:#fff}.solid:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):focus-within:active,.solid:is(.use-lustre-ui .tag,.lustre-ui-tag):is(button,a,[tabindex]):hover:active{--bg-active:color-mix(in srgb,var(--solid-background-hover) 90%,#000);--border-active:color-mix(in srgb,var(--solid-background-hover) 90%,#000)}.soft:is(.use-lustre-ui .tag,.lustre-ui-tag){--bg-active:var(--element-background-strong);--bg-hover:var(--element-background-hover);--bg:var(--element-background);--border-active:var(--bg-active);--border:var(--bg);--text:var(--text-high-contrast)}.outline:is(.use-lustre-ui .tag,.lustre-ui-tag){--bg:unset;--border:var(--element-border-subtle)}.lustre-ui-aside,.use-lustre-ui .aside{--align:start;--gap:var(--space-md);--dir:row;--wrap:wrap;--min:60%;align-items:var(--align);display:flex;flex-direction:var(--dir);flex-wrap:var(--wrap);gap:var(--gap)}.content-first:is(.use-lustre-ui .aside,.lustre-ui-aside){--dir:row;--wrap:wrap}.content-last:is(.use-lustre-ui .aside,.lustre-ui-aside){--dir:row-reverse;--wrap:wrap-reverse}.align-start:is(.use-lustre-ui .aside,.lustre-ui-aside){--align:start}.align-center:is(.use-lustre-ui .aside,.lustre-ui-aside),.align-centre:is(.use-lustre-ui .aside,.lustre-ui-aside){--align:center}.align-end:is(.use-lustre-ui .aside,.lustre-ui-aside){--align:end}.stretch:is(.use-lustre-ui .aside,.lustre-ui-aside){--align:stretch}.packed:is(.use-lustre-ui .aside,.lustre-ui-aside){--gap:0}.tight:is(.use-lustre-ui .aside,.lustre-ui-aside){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .aside,.lustre-ui-aside){--gap:var(--space-md)}.loose:is(.use-lustre-ui .aside,.lustre-ui-aside){--gap:var(--space-lg)}:is(.use-lustre-ui .aside,.lustre-ui-aside)>:first-child{flex-basis:0;flex-grow:999;min-inline-size:var(--min)}:is(.use-lustre-ui .aside,.lustre-ui-aside)>:last-child{flex-grow:1;max-height:-moz-max-content;max-height:max-content}.lustre-ui-box,.use-lustre-ui .box{--gap:var(--space-sm);padding:var(--gap)}.packed:is(.use-lustre-ui .box,.lustre-ui-box){--gap:0}.tight:is(.use-lustre-ui .box,.lustre-ui-box){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .box,.lustre-ui-box){--gap:var(--space-md)}.loose:is(.use-lustre-ui .box,.lustre-ui-box){--gap:var(--space-lg)}.lustre-ui-center,.lustre-ui-centre,.use-lustre-ui .center,.use-lustre-ui .centre{--display:flex;align-items:center;display:var(--display);justify-content:center}.inline:is(.use-lustre-ui .centre,.use-lustre-ui .center,.lustre-ui-centre,.lustre-ui-center){--display:inline-flex}.lustre-ui-cluster,.use-lustre-ui .cluster{--gap:var(--space-md);--dir:flex-start;--align:center;align-items:var(--align);display:flex;flex-wrap:wrap;gap:var(--gap);justify-content:var(--dir)}.packed:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--gap:0}.tight:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--gap:var(--space-md)}.loose:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--gap:var(--space-lg)}.from-start:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--dir:flex-start}.from-end:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--dir:flex-end}.align-start:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--align:start}.align-center:is(.use-lustre-ui .cluster,.lustre-ui-cluster),.align-centre:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--align:center}.align-end:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--align:end}.stretch:is(.use-lustre-ui .cluster,.lustre-ui-cluster){--align:stretch}.lustre-ui-group,.use-lustre-ui .group{align-items:stretch;display:inline-flex}:is(.use-lustre-ui .group,.lustre-ui-group)>:first-child{border-radius:var(--border-radius) 0 0 var(--border-radius)!important}:is(.use-lustre-ui .group,.lustre-ui-group)>:not(:first-child):not(:last-child){border-radius:0!important}:is(.use-lustre-ui .group,.lustre-ui-group)>:last-child{border-radius:0 var(--border-radius) var(--border-radius) 0!important}.lustre-ui-sequence,.use-lustre-ui .sequence{--gap:var(--space-md);--break:30rem;display:flex;flex-wrap:wrap;gap:var(--gap)}.packed:is(.use-lustre-ui .sequence,.lustre-ui-sequence){--gap:0}.tight:is(.use-lustre-ui .sequence,.lustre-ui-sequence){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .sequence,.lustre-ui-sequence){--gap:var(--space-md)}.loose:is(.use-lustre-ui .sequence,.lustre-ui-sequence){--gap:var(--space-lg)}[data-split-at="3"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+3),[data-split-at="3"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+3)~*{flex-basis:100%}[data-split-at="4"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+4),[data-split-at="4"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+4)~*{flex-basis:100%}[data-split-at="5"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+5),[data-split-at="5"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+5)~*{flex-basis:100%}[data-split-at="6"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+6),[data-split-at="6"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+6)~*{flex-basis:100%}[data-split-at="7"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+7),[data-split-at="7"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+7)~*{flex-basis:100%}[data-split-at="8"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+8),[data-split-at="8"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+8)~*{flex-basis:100%}[data-split-at="9"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+9),[data-split-at="9"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+9)~*{flex-basis:100%}[data-split-at="10"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+10),[data-split-at="10"]:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>:nth-last-child(n+10)~*{flex-basis:100%}:is(.use-lustre-ui .sequence,.lustre-ui-sequence)>*{flex-basis:calc((var(--break) - 100%)*999);flex-grow:1}.lustre-ui-stack,.use-lustre-ui .stack{--gap:var(--space-md);display:flex;flex-direction:column;gap:var(--gap);justify-content:flex-start}.packed:is(.use-lustre-ui .stack,.lustre-ui-stack){--gap:0}.tight:is(.use-lustre-ui .stack,.lustre-ui-stack){--gap:var(--space-xs)}.relaxed:is(.use-lustre-ui .stack,.lustre-ui-stack){--gap:var(--space-md)}.loose:is(.use-lustre-ui .stack,.lustre-ui-stack){--gap:var(--space-lg)}\n';
function elements() {
  return style(toList([]), element_css);
}

// build/dev/javascript/gleam_stdlib/gleam/uri.mjs
var Uri = class extends CustomType {
  constructor(scheme, userinfo, host, port, path, query, fragment) {
    super();
    this.scheme = scheme;
    this.userinfo = userinfo;
    this.host = host;
    this.port = port;
    this.path = path;
    this.query = query;
    this.fragment = fragment;
  }
};
function regex_submatches(pattern, string3) {
  let _pipe = pattern;
  let _pipe$1 = compile(_pipe, new Options(true, false));
  let _pipe$2 = nil_error(_pipe$1);
  let _pipe$3 = map2(
    _pipe$2,
    (_capture) => {
      return scan(_capture, string3);
    }
  );
  let _pipe$4 = try$(_pipe$3, first);
  let _pipe$5 = map2(_pipe$4, (m) => {
    return m.submatches;
  });
  return unwrap2(_pipe$5, toList([]));
}
function noneify_query(x) {
  if (x instanceof None) {
    return new None();
  } else {
    let x$1 = x[0];
    let $ = pop_grapheme2(x$1);
    if ($.isOk() && $[0][0] === "?") {
      let query = $[0][1];
      return new Some(query);
    } else {
      return new None();
    }
  }
}
function noneify_empty_string(x) {
  if (x instanceof Some && x[0] === "") {
    return new None();
  } else if (x instanceof None) {
    return new None();
  } else {
    return x;
  }
}
function extra_required(loop$list, loop$remaining) {
  while (true) {
    let list2 = loop$list;
    let remaining = loop$remaining;
    if (remaining === 0) {
      return 0;
    } else if (list2.hasLength(0)) {
      return remaining;
    } else {
      let xs = list2.tail;
      loop$list = xs;
      loop$remaining = remaining - 1;
    }
  }
}
function pad_list(list2, size) {
  let _pipe = list2;
  return append(
    _pipe,
    repeat(new None(), extra_required(list2, size))
  );
}
function split_authority(authority) {
  let $ = unwrap(authority, "");
  if ($ === "") {
    return [new None(), new None(), new None()];
  } else if ($ === "//") {
    return [new None(), new Some(""), new None()];
  } else {
    let authority$1 = $;
    let matches = (() => {
      let _pipe = "^(//)?((.*)@)?(\\[[a-zA-Z0-9:.]*\\]|[^:]*)(:(\\d*))?";
      let _pipe$1 = regex_submatches(_pipe, authority$1);
      return pad_list(_pipe$1, 6);
    })();
    if (matches.hasLength(6)) {
      let userinfo = matches.tail.tail.head;
      let host = matches.tail.tail.tail.head;
      let port = matches.tail.tail.tail.tail.tail.head;
      let userinfo$1 = noneify_empty_string(userinfo);
      let host$1 = noneify_empty_string(host);
      let port$1 = (() => {
        let _pipe = port;
        let _pipe$1 = unwrap(_pipe, "");
        let _pipe$2 = parse(_pipe$1);
        return from_result(_pipe$2);
      })();
      return [userinfo$1, host$1, port$1];
    } else {
      return [new None(), new None(), new None()];
    }
  }
}
function do_parse(uri_string) {
  let pattern = "^(([a-z][a-z0-9\\+\\-\\.]*):)?(//([^/?#]*))?([^?#]*)(\\?([^#]*))?(#.*)?";
  let matches = (() => {
    let _pipe = pattern;
    let _pipe$1 = regex_submatches(_pipe, uri_string);
    return pad_list(_pipe$1, 8);
  })();
  let $ = (() => {
    if (matches.hasLength(8)) {
      let scheme2 = matches.tail.head;
      let authority_with_slashes = matches.tail.tail.head;
      let path2 = matches.tail.tail.tail.tail.head;
      let query_with_question_mark = matches.tail.tail.tail.tail.tail.head;
      let fragment2 = matches.tail.tail.tail.tail.tail.tail.tail.head;
      return [
        scheme2,
        authority_with_slashes,
        path2,
        query_with_question_mark,
        fragment2
      ];
    } else {
      return [new None(), new None(), new None(), new None(), new None()];
    }
  })();
  let scheme = $[0];
  let authority = $[1];
  let path = $[2];
  let query = $[3];
  let fragment = $[4];
  let scheme$1 = noneify_empty_string(scheme);
  let path$1 = unwrap(path, "");
  let query$1 = noneify_query(query);
  let $1 = split_authority(authority);
  let userinfo = $1[0];
  let host = $1[1];
  let port = $1[2];
  let fragment$1 = (() => {
    let _pipe = fragment;
    let _pipe$1 = to_result(_pipe, void 0);
    let _pipe$2 = try$(_pipe$1, pop_grapheme2);
    let _pipe$3 = map2(_pipe$2, second);
    return from_result(_pipe$3);
  })();
  let scheme$2 = (() => {
    let _pipe = scheme$1;
    let _pipe$1 = noneify_empty_string(_pipe);
    return map(_pipe$1, lowercase2);
  })();
  return new Ok(
    new Uri(scheme$2, userinfo, host, port, path$1, query$1, fragment$1)
  );
}
function parse2(uri_string) {
  return do_parse(uri_string);
}
function to_string6(uri) {
  let parts = (() => {
    let $ = uri.fragment;
    if ($ instanceof Some) {
      let fragment = $[0];
      return toList(["#", fragment]);
    } else {
      return toList([]);
    }
  })();
  let parts$1 = (() => {
    let $ = uri.query;
    if ($ instanceof Some) {
      let query = $[0];
      return prepend("?", prepend(query, parts));
    } else {
      return parts;
    }
  })();
  let parts$2 = prepend(uri.path, parts$1);
  let parts$3 = (() => {
    let $ = uri.host;
    let $1 = starts_with2(uri.path, "/");
    if ($ instanceof Some && !$1 && $[0] !== "") {
      let host = $[0];
      return prepend("/", parts$2);
    } else {
      return parts$2;
    }
  })();
  let parts$4 = (() => {
    let $ = uri.host;
    let $1 = uri.port;
    if ($ instanceof Some && $1 instanceof Some) {
      let port = $1[0];
      return prepend(":", prepend(to_string2(port), parts$3));
    } else {
      return parts$3;
    }
  })();
  let parts$5 = (() => {
    let $ = uri.scheme;
    let $1 = uri.userinfo;
    let $2 = uri.host;
    if ($ instanceof Some && $1 instanceof Some && $2 instanceof Some) {
      let s = $[0];
      let u = $1[0];
      let h = $2[0];
      return prepend(
        s,
        prepend(
          "://",
          prepend(u, prepend("@", prepend(h, parts$4)))
        )
      );
    } else if ($ instanceof Some && $1 instanceof None && $2 instanceof Some) {
      let s = $[0];
      let h = $2[0];
      return prepend(s, prepend("://", prepend(h, parts$4)));
    } else if ($ instanceof Some && $1 instanceof Some && $2 instanceof None) {
      let s = $[0];
      return prepend(s, prepend(":", parts$4));
    } else if ($ instanceof Some && $1 instanceof None && $2 instanceof None) {
      let s = $[0];
      return prepend(s, prepend(":", parts$4));
    } else if ($ instanceof None && $1 instanceof None && $2 instanceof Some) {
      let h = $2[0];
      return prepend("//", prepend(h, parts$4));
    } else {
      return parts$4;
    }
  })();
  return concat3(parts$5);
}

// build/dev/javascript/gleam_http/gleam/http.mjs
var Get = class extends CustomType {
};
var Post = class extends CustomType {
};
var Head = class extends CustomType {
};
var Put = class extends CustomType {
};
var Delete = class extends CustomType {
};
var Trace = class extends CustomType {
};
var Connect = class extends CustomType {
};
var Options2 = class extends CustomType {
};
var Patch = class extends CustomType {
};
var Http = class extends CustomType {
};
var Https = class extends CustomType {
};
function method_to_string(method) {
  if (method instanceof Connect) {
    return "connect";
  } else if (method instanceof Delete) {
    return "delete";
  } else if (method instanceof Get) {
    return "get";
  } else if (method instanceof Head) {
    return "head";
  } else if (method instanceof Options2) {
    return "options";
  } else if (method instanceof Patch) {
    return "patch";
  } else if (method instanceof Post) {
    return "post";
  } else if (method instanceof Put) {
    return "put";
  } else if (method instanceof Trace) {
    return "trace";
  } else {
    let s = method[0];
    return s;
  }
}
function scheme_to_string(scheme) {
  if (scheme instanceof Http) {
    return "http";
  } else {
    return "https";
  }
}
function scheme_from_string(scheme) {
  let $ = lowercase2(scheme);
  if ($ === "http") {
    return new Ok(new Http());
  } else if ($ === "https") {
    return new Ok(new Https());
  } else {
    return new Error(void 0);
  }
}

// build/dev/javascript/gleam_http/gleam/http/request.mjs
var Request = class extends CustomType {
  constructor(method, headers, body2, scheme, host, port, path, query) {
    super();
    this.method = method;
    this.headers = headers;
    this.body = body2;
    this.scheme = scheme;
    this.host = host;
    this.port = port;
    this.path = path;
    this.query = query;
  }
};
function to_uri(request) {
  return new Uri(
    new Some(scheme_to_string(request.scheme)),
    new None(),
    new Some(request.host),
    request.port,
    request.path,
    request.query,
    new None()
  );
}
function from_uri(uri) {
  return then$(
    (() => {
      let _pipe = uri.scheme;
      let _pipe$1 = unwrap(_pipe, "");
      return scheme_from_string(_pipe$1);
    })(),
    (scheme) => {
      return then$(
        (() => {
          let _pipe = uri.host;
          return to_result(_pipe, void 0);
        })(),
        (host) => {
          let req = new Request(
            new Get(),
            toList([]),
            "",
            scheme,
            host,
            uri.port,
            uri.path,
            uri.query
          );
          return new Ok(req);
        }
      );
    }
  );
}
function to(url) {
  let _pipe = url;
  let _pipe$1 = parse2(_pipe);
  return then$(_pipe$1, from_uri);
}

// build/dev/javascript/gleam_http/gleam/http/response.mjs
var Response = class extends CustomType {
  constructor(status, headers, body2) {
    super();
    this.status = status;
    this.headers = headers;
    this.body = body2;
  }
};

// build/dev/javascript/gleam_javascript/ffi.mjs
var PromiseLayer = class _PromiseLayer {
  constructor(promise) {
    this.promise = promise;
  }
  static wrap(value2) {
    return value2 instanceof Promise ? new _PromiseLayer(value2) : value2;
  }
  static unwrap(value2) {
    return value2 instanceof _PromiseLayer ? value2.promise : value2;
  }
};
function resolve(value2) {
  return Promise.resolve(PromiseLayer.wrap(value2));
}
function then(promise, fn) {
  return promise.then((value2) => fn(PromiseLayer.unwrap(value2)));
}
function map_promise(promise, fn) {
  return promise.then(
    (value2) => PromiseLayer.wrap(fn(PromiseLayer.unwrap(value2)))
  );
}
function rescue(promise, fn) {
  return promise.catch((error) => fn(error));
}

// build/dev/javascript/gleam_javascript/gleam/javascript/promise.mjs
function tap(promise, callback) {
  let _pipe = promise;
  return map_promise(
    _pipe,
    (a) => {
      callback(a);
      return a;
    }
  );
}
function try_await(promise, callback) {
  let _pipe = promise;
  return then(
    _pipe,
    (result) => {
      if (result.isOk()) {
        let a = result[0];
        return callback(a);
      } else {
        let e = result[0];
        return resolve(new Error(e));
      }
    }
  );
}

// build/dev/javascript/gleam_fetch/ffi.mjs
async function raw_send(request) {
  try {
    return new Ok(await fetch(request));
  } catch (error) {
    return new Error(new NetworkError(error.toString()));
  }
}
function from_fetch_response(response) {
  return new Response(
    response.status,
    List.fromArray([...response.headers]),
    response
  );
}
function to_fetch_request(request) {
  let url = to_string6(to_uri(request));
  let method = method_to_string(request.method).toUpperCase();
  let options = {
    headers: make_headers(request.headers),
    method
  };
  if (method !== "GET" && method !== "HEAD")
    options.body = request.body;
  return new globalThis.Request(url, options);
}
function make_headers(headersList) {
  let headers = new globalThis.Headers();
  for (let [k, v] of headersList)
    headers.append(k.toLowerCase(), v);
  return headers;
}
async function read_text_body(response) {
  let body2;
  try {
    body2 = await response.body.text();
  } catch (error) {
    return new Error(new UnableToReadBody());
  }
  return new Ok(response.withFields({ body: body2 }));
}

// build/dev/javascript/gleam_fetch/gleam/fetch.mjs
var NetworkError = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var UnableToReadBody = class extends CustomType {
};
function send(request) {
  let _pipe = request;
  let _pipe$1 = to_fetch_request(_pipe);
  let _pipe$2 = raw_send(_pipe$1);
  return try_await(
    _pipe$2,
    (resp) => {
      return resolve(new Ok(from_fetch_response(resp)));
    }
  );
}

// build/dev/javascript/lustre_http/lustre_http.mjs
var BadUrl = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var InternalServerError = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var JsonError = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var NetworkError2 = class extends CustomType {
};
var NotFound = class extends CustomType {
};
var OtherError = class extends CustomType {
  constructor(x0, x1) {
    super();
    this[0] = x0;
    this[1] = x1;
  }
};
var Unauthorized = class extends CustomType {
};
var ExpectTextResponse = class extends CustomType {
  constructor(run) {
    super();
    this.run = run;
  }
};
function do_send(req, expect, dispatch) {
  let _pipe = send(req);
  let _pipe$1 = try_await(_pipe, read_text_body);
  let _pipe$2 = map_promise(
    _pipe$1,
    (response) => {
      if (response.isOk()) {
        let res = response[0];
        return expect.run(new Ok(res));
      } else {
        return expect.run(new Error(new NetworkError2()));
      }
    }
  );
  let _pipe$3 = rescue(
    _pipe$2,
    (_) => {
      return expect.run(new Error(new NetworkError2()));
    }
  );
  tap(_pipe$3, dispatch);
  return void 0;
}
function get2(url, expect) {
  return from2(
    (dispatch) => {
      let $ = to(url);
      if ($.isOk()) {
        let req = $[0];
        return do_send(req, expect, dispatch);
      } else {
        return dispatch(expect.run(new Error(new BadUrl(url))));
      }
    }
  );
}
function response_to_result(response) {
  if (response instanceof Response && (200 <= response.status && response.status <= 299)) {
    let status = response.status;
    let body2 = response.body;
    return new Ok(body2);
  } else if (response instanceof Response && response.status === 401) {
    return new Error(new Unauthorized());
  } else if (response instanceof Response && response.status === 404) {
    return new Error(new NotFound());
  } else if (response instanceof Response && response.status === 500) {
    let body2 = response.body;
    return new Error(new InternalServerError(body2));
  } else {
    let code = response.status;
    let body2 = response.body;
    return new Error(new OtherError(code, body2));
  }
}
function expect_json(decoder2, to_msg) {
  return new ExpectTextResponse(
    (response) => {
      let _pipe = response;
      let _pipe$1 = then$(_pipe, response_to_result);
      let _pipe$2 = then$(
        _pipe$1,
        (body2) => {
          let $ = decode2(body2, decoder2);
          if ($.isOk()) {
            let json = $[0];
            return new Ok(json);
          } else {
            let json_error = $[0];
            return new Error(new JsonError(json_error));
          }
        }
      );
      return to_msg(_pipe$2);
    }
  );
}

// build/dev/javascript/pokedex/pokedex/types/pokemon.mjs
var Stats = class extends CustomType {
  constructor(hp, atk, def, sp_atk, sp_def, speed) {
    super();
    this.hp = hp;
    this.atk = atk;
    this.def = def;
    this.sp_atk = sp_atk;
    this.sp_def = sp_def;
    this.speed = speed;
  }
};
var Pokemon = class extends CustomType {
  constructor(id2, name, base_experience, base_stats) {
    super();
    this.id = id2;
    this.name = name;
    this.base_experience = base_experience;
    this.base_stats = base_stats;
  }
};
function stats_decoder() {
  return decode6(
    (var0, var1, var2, var3, var4, var5) => {
      return new Stats(var0, var1, var2, var3, var4, var5);
    },
    field("hp", int),
    field("atk", int),
    field("def", int),
    field("sp_atk", int),
    field("sp_def", int),
    field("speed", int)
  );
}
function pokemon_decoder() {
  return decode4(
    (var0, var1, var2, var3) => {
      return new Pokemon(var0, var1, var2, var3);
    },
    field("id", int),
    field("name", string),
    field("base_experience", int),
    field("base_stats", stats_decoder())
  );
}

// build/dev/javascript/pokedex/pokedex/types/msg.mjs
var UserSelectedPokemon = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var UserClickedSearchButton = class extends CustomType {
};
var ApiReturnedPokemon = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var ApiReturnedAllPokemon = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var AppRequestedAllPokemon = class extends CustomType {
};
var Loading = class extends CustomType {
};
var Loaded = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};
var LoadError = class extends CustomType {
  constructor(x0) {
    super();
    this[0] = x0;
  }
};

// build/dev/javascript/pokedex/pokedex/api.mjs
var api_root = "http://localhost:8000";
function fetch_pokemon(search) {
  let expect = expect_json(
    pokemon_decoder(),
    (var0) => {
      return new ApiReturnedPokemon(var0);
    }
  );
  return get2(
    api_root + "/pokemon/" + lowercase2(search),
    expect
  );
}
function fetch_all_pokemon() {
  let expect = expect_json(
    list(string),
    (var0) => {
      return new ApiReturnedAllPokemon(var0);
    }
  );
  return get2(api_root + "/pokemon", expect);
}

// build/dev/javascript/plinth/document_ffi.mjs
function querySelector(query) {
  let found = document.querySelector(query);
  if (!found) {
    return new Error();
  }
  return new Ok(found);
}

// build/dev/javascript/plinth/element_ffi.mjs
function value(element2) {
  let value2 = element2.value;
  if (value2 != void 0) {
    return new Ok(value2);
  }
  return new Error();
}

// priv/static/dom_ffi.mjs
function set_value(element2, value2) {
  element2.value = value2;
}

// build/dev/javascript/pokedex/pokedex/types/model.mjs
var Model = class extends CustomType {
  constructor(current_pokemon, all_pokemon) {
    super();
    this.current_pokemon = current_pokemon;
    this.all_pokemon = all_pokemon;
  }
};

// build/dev/javascript/lustre/lustre/event.mjs
function on2(name, handler) {
  return on(name, handler);
}
function on_click(msg) {
  return on2("click", (_) => {
    return new Ok(msg);
  });
}

// build/dev/javascript/lustre_ui/lustre/ui/util/cn.mjs
function bg_element() {
  return class$("bg-element");
}
function px_md() {
  return class$("px-md");
}

// build/dev/javascript/pokedex/pokedex/views.mjs
function header() {
  return box2(
    toList([bg_element()]),
    toList([
      h1(
        toList([class$("text-2xl font-bold")]),
        toList([text2("Pok\xE9dex")])
      )
    ])
  );
}
function pokemon_details(maybe_pokemon, all_pokemon) {
  let message = (() => {
    if (all_pokemon instanceof Loaded && all_pokemon[0].hasLength(0)) {
      return "Search for a Pok\xE9mon to view details";
    } else if (all_pokemon instanceof Loaded) {
      return "Select a Pok\xE9mon to view details";
    } else if (all_pokemon instanceof LoadError) {
      let err = all_pokemon[0];
      return "Error loading Pok\xE9mon: " + err;
    } else {
      return "Loading Pok\xE9mon selection...";
    }
  })();
  if (maybe_pokemon instanceof Loaded && maybe_pokemon[0] instanceof None) {
    return p(toList([]), toList([text2(message)]));
  } else if (maybe_pokemon instanceof Loaded && maybe_pokemon[0] instanceof Some) {
    let pokemon = maybe_pokemon[0][0];
    return div(
      toList([]),
      toList([
        h2(toList([]), toList([text2(pokemon.name)])),
        p(
          toList([]),
          toList([text2("HP: " + to_string2(pokemon.base_stats.hp))])
        ),
        p(
          toList([]),
          toList([
            text2("Attack: " + to_string2(pokemon.base_stats.atk))
          ])
        ),
        p(
          toList([]),
          toList([
            text2("Defense: " + to_string2(pokemon.base_stats.def))
          ])
        ),
        p(
          toList([]),
          toList([
            text2("Sp. Atk: " + to_string2(pokemon.base_stats.sp_atk))
          ])
        ),
        p(
          toList([]),
          toList([
            text2("Sp. Def: " + to_string2(pokemon.base_stats.sp_def))
          ])
        ),
        p(
          toList([]),
          toList([
            text2("Speed: " + to_string2(pokemon.base_stats.speed))
          ])
        )
      ])
    );
  } else if (maybe_pokemon instanceof LoadError) {
    let err = maybe_pokemon[0];
    return p(
      toList([]),
      toList([text2("Error loading Pok\xE9mon: " + err)])
    );
  } else {
    return p(toList([]), toList([text2("Loading Pok\xE9mon...")]));
  }
}
function pokemon_list(pokemon) {
  if (pokemon instanceof Loaded) {
    let pokemon$1 = pokemon[0];
    return map3(
      pokemon$1,
      (p2) => {
        return button3(
          toList([
            on_click(new UserSelectedPokemon(lowercase2(p2))),
            soft(),
            small(),
            class$("w-full text-left")
          ]),
          toList([text2(p2)])
        );
      }
    );
  } else if (pokemon instanceof LoadError) {
    let err = pokemon[0];
    return toList([
      p(
        toList([]),
        toList([text2("Error loading Pok\xE9mon: " + err)])
      )
    ]);
  } else {
    return toList([
      p(toList([]), toList([text2("Loading Pok\xE9mon...")]))
    ]);
  }
}
var pokemon_search_input_id = "pokemon-search-input";
function pokemon_search() {
  return div(
    toList([
      px_md(),
      class$("flex items-center flex-col sm:flex-row gap-2 sm:gap-4")
    ]),
    toList([
      input3(
        toList([
          id(pokemon_search_input_id),
          placeholder("Search Pok\xE9mon"),
          type_("search"),
          class$("w-full flex-grow")
        ])
      ),
      button3(
        toList([
          primary(),
          class$("w-full sm:w-fit"),
          on_click(new UserClickedSearchButton())
        ]),
        toList([text2("Search")])
      )
    ])
  );
}
function main_content(model) {
  return main(
    toList([]),
    toList([
      stack2(
        toList([]),
        toList([
          pokemon_search(),
          aside2(
            toList([px_md()]),
            pokemon_details(model.current_pokemon, model.all_pokemon),
            stack2(
              toList([tight(), class$("min-w-[20dvw]")]),
              pokemon_list(model.all_pokemon)
            )
          )
        ])
      )
    ])
  );
}

// build/dev/javascript/pokedex/pokedex/message_handlers.mjs
function handle_user_selected_pokemon(model, pokemon_name) {
  let default_return = [
    model.withFields({ current_pokemon: new Loading() }),
    fetch_pokemon(pokemon_name)
  ];
  let $ = model.current_pokemon;
  if ($ instanceof Loaded && $[0] instanceof Some) {
    let current_pokemon = $[0][0];
    let $1 = current_pokemon.name === pokemon_name;
    if ($1) {
      return [model, none()];
    } else {
      return default_return;
    }
  } else {
    return default_return;
  }
}
function handle_user_clicked_search_button(model) {
  let $ = querySelector("#" + pokemon_search_input_id);
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "pokedex/message_handlers",
      36,
      "handle_user_clicked_search_button",
      "Assignment pattern did not match",
      { value: $ }
    );
  }
  let search_element = $[0];
  let $1 = value(search_element);
  if (!$1.isOk()) {
    throw makeError(
      "assignment_no_match",
      "pokedex/message_handlers",
      38,
      "handle_user_clicked_search_button",
      "Assignment pattern did not match",
      { value: $1 }
    );
  }
  let pokemon_name = $1[0];
  let cleaned_pokemon_name = (() => {
    let _pipe = pokemon_name;
    let _pipe$1 = trim2(_pipe);
    return lowercase2(_pipe$1);
  })();
  let $2 = trim2(cleaned_pokemon_name);
  if ($2 === "") {
    return [model, none()];
  } else {
    let cleaned = $2;
    set_value(search_element, "");
    return handle_user_selected_pokemon(model, cleaned);
  }
}
function handle_api_returned_pokemon_ok(model, pokemon) {
  let default_return = [
    model.withFields({ current_pokemon: new Loaded(new Some(pokemon)) }),
    none()
  ];
  let $ = model.all_pokemon;
  if ($ instanceof Loaded) {
    let pokemon_names = $[0];
    let $1 = contains(pokemon_names, pokemon.name);
    if (!$1) {
      return [default_return[0], fetch_all_pokemon()];
    } else {
      return default_return;
    }
  } else {
    return default_return;
  }
}

// build/dev/javascript/pokedex/pokedex.mjs
function init2(_) {
  return [new Model(new Loaded(new None()), new Loading()), fetch_all_pokemon()];
}
function view(model) {
  return stack2(
    toList([]),
    toList([elements(), header(), main_content(model)])
  );
}
function update2(model, msg) {
  if (msg instanceof UserSelectedPokemon) {
    let pokemon_name = msg[0];
    return handle_user_selected_pokemon(model, pokemon_name);
  } else if (msg instanceof UserClickedSearchButton) {
    return handle_user_clicked_search_button(model);
  } else if (msg instanceof AppRequestedAllPokemon) {
    return [
      model.withFields({ all_pokemon: new Loading() }),
      fetch_all_pokemon()
    ];
  } else if (msg instanceof ApiReturnedPokemon && msg[0].isOk()) {
    let pokemon = msg[0][0];
    return handle_api_returned_pokemon_ok(model, pokemon);
  } else if (msg instanceof ApiReturnedPokemon && !msg[0].isOk()) {
    let err = msg[0][0];
    return [
      model.withFields({
        current_pokemon: new LoadError(
          "Error fetching Pokemon: " + inspect2(err)
        )
      }),
      none()
    ];
  } else if (msg instanceof ApiReturnedAllPokemon && msg[0].isOk()) {
    let pokemon_names = msg[0][0];
    return [
      model.withFields({
        all_pokemon: new Loaded(
          (() => {
            let _pipe = pokemon_names;
            return sort(_pipe, compare3);
          })()
        )
      }),
      none()
    ];
  } else {
    let err = msg[0][0];
    return [
      model.withFields({
        all_pokemon: new LoadError(
          "Error fetching Pokemon: " + inspect2(err)
        )
      }),
      none()
    ];
  }
}
function main2() {
  let app = application(init2, update2, view);
  let $ = start3(app, "#app", void 0);
  if (!$.isOk()) {
    throw makeError(
      "assignment_no_match",
      "pokedex",
      23,
      "main",
      "Assignment pattern did not match",
      { value: $ }
    );
  }
  return void 0;
}

// build/.lustre/entry.mjs
main2();
