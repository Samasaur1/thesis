At various points in the BitTorrent protocol, we need to translate conceptually structured information to binary data, whether it be for saving a file to disk or streaming data to the network. This is known as an encoding system, and the creators of BitTorrent came up with their own system, bencode. 

-- detail system

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
