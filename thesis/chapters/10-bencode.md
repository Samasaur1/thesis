# Bencode

At various points in the BitTorrent protocol, we need to translate conceptually structured information to binary data, whether it be for saving a file to disk or streaming data to the network. This is known as an encoding system, and the creators of BitTorrent came up with their own system, bencode. 

## the protocol

Here's the entire description of bencode from the original BitTorrent protocol specification:

> bencoding
>
> - Strings are length-prefixed base ten followed by a colon and the string. For example `4:spam` corresponds to 'spam'.
> - Integers are represented by an 'i' followed by the number in base 10 followed by an 'e'. For example `i3e` corresponds to 3 and `i-3e` corresponds to -3. Integers have no size limitation. `i-0e` is invalid. All encodings with a leading zero, such as `i03e`, are invalid, other than `i0e`, which of course corresponds to 0.
> - Lists are encoded as an 'l' followed by their elements (also bencoded) followed by an 'e'. For example `l4:spam4:eggse` corresponds to ['spam', 'eggs'].
> - Dictionaries are encoded as a 'd' followed by a list of alternating keys and their corresponding values followed by an 'e'. For example, `d3:cow3:moo4:spam4:eggse` corresponds to {'cow': 'moo', 'spam': 'eggs'} and `d4:spaml1:a1:bee` corresponds to {'spam': ['a', 'b']}. Keys must be strings and appear in sorted order (sorted as raw strings, not alphanumerics).

Bencode has four types:

1. Integers are encoded as `i<number in ASCII>e`
    
    For example, we would encode `5` as `i5e`, we would encode `-21` as `i-21e`, etc.

2. "byte strings" are encoded as `<length of string>:<data of string>`

    For example, we would encode `Hi` as `2:Hi`, we would encode `Hello, world!` as `13:Hello, world!`, etc.

    This type works for non-ASCII strings as well. We would encode `ü` as `2:ü`. Note that the length of this string is still 2, because the length is measured in bytes, not the more nebulous "characters", and `ü` in UTF-8 is represented using two bytes.

    This is also the type used for data that is not a valid string in any encoding scheme, such as `0x00 0x00 0x01 0x00 0x00`. This would be encoded as `0x35 0x3A 0x00 0x00 0x01 0x00 0x00` (`0x35` is the byte for `5` and `0x3A` is the byte for `:`).

3. Lists are encoded as `l<bencoded element><bencoded element><bencoded element><...>e`

    For example, we would encode `[1, 2, 3]` as `li1ei2ei3ee`.

4. Dictionaries are encoded as `d<bencoded key><bencoded value><bencoded key><bencoded value><bencoded key><bencoded value><...>e`

    For example, we would encode `{"a": 1, "c": 3, "b": 2}` as `d1:ai1e1:bi2e1:ci3ee`.

    The keys must be strings. They also must be sorted by their raw data (for example, sorting `aAbB=_~` gives `=AB_ab~`).

## examples

Here's an example. Let's say we have a `Person` type, which has a first name field, a last name field, and an age field:

```
Person
    firstName: string
    lastName: string
    age: int
```

For me, these fields are "Sam", "Gauck", and 21. If we encoded this object to JSON, we'd get:
```json
{
    "firstName": "Sam",
    "lastName": "Gauck",
    "age": 21
}
```

If we encode this object to bencode, however, we get:
```bencode
d3:agei21e9:firstName3:Sam8:lastName5:Gaucke
```

For ease of understanding, I'll format this like so:
```bencode
d
    3:age
        i21e
    9:firstName
        3:Sam
    8:lastName
        5:Gauck
e
```
though it is important to remember that this is not valid bencode.

Another example:

```
ExampleType
    key: string
    other: list<int>
```

```json
{
  "key": "value",
  "other": [5, 6, 7, 8]
}
```

```bencode
d3:key5:value5:otherli5ei6ei7ei8eee
```

```bencode
d
  3:key
    5:value
  5:other
    l
      i5e
      i6e
      i7e
      i8e
    e
e
```

# parsing
