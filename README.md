# ULID

[![Linux Build][travis-image]][travis-url]
[![Shards version][shards-image]][shards-url]

A **Crystal** port of [alizain/ulid][origin-lib-url].


![Logo][logo-image]


## Universally Unique Lexicographically Sortable Identifier

UUID can be suboptimal for many uses-cases because:

- It isn't the most character efficient way of encoding 128 bits of randomness
- The string format itself is apparently based on the original MAC & time version (UUIDv1 from Wikipedia)
- It provides no other information than randomness

Instead, herein is proposed ULID:

- 128-bit compatibility with UUID
- 1.21e+24 unique ULIDs per millisecond
- Lexicographically sortable!
- Canonically encoded as a 26 character string, as opposed to the 36 character UUID
- Uses Crockford's base32 for better efficiency and readability (5 bits per character)
- Case insensitive
- No special characters (URL safe)


--------------------------------------------------------------------------------

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  ulid:
    github: SuperPaintman/ulid
```


--------------------------------------------------------------------------------

## Usage

```crystal
require "ulid"

ULID.generate
# => "01B3EAF48P97R8MP9WS6MHDTZ3"
```


### Seed Time

You can also input a seed time which will consistently give you the same string for the time component. This is useful for migrating to ulid.

```crystal
ULID.generate Time.now + 5.second
# => "01ARYZ6S41TSV4RRFFQ69G5FAV"
```


--------------------------------------------------------------------------------

## Specification

Below is the current specification of ULID as implemented in this repository.


### Components

**Timestamp**
- 48 bit integer
- UNIX-time in milliseconds
- Won't run out of space till the year 10895 AD.

**Randomness**
- 80 bits
- Cryptographically secure source of randomness, if possible


### Sorting

The left-most character must be sorted first, and the right-most character
sorted last (lexical order). The default ASCII character set must be used.
Within the same millisecond, sort order is not guaranteed


### Encoding

Crockford's Base32 is used as shown. This alphabet excludes the letters I, L, O,
and U to avoid confusion and abuse.

```
0123456789ABCDEFGHJKMNPQRSTVWXYZ
```


### Binary Layout and Byte Order

The components are encoded as 16 octets. Each component is encoded with the Most
Significant Byte first (network byte order).

```
0                   1                   2                   3
 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                      32_bit_uint_time_low                     |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|     16_bit_uint_time_high     |       16_bit_uint_random      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       32_bit_uint_random                      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|                       32_bit_uint_random                      |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
```


### String Representation

```
 01AN4Z07BY      79KA1307SR9X4MV3
|----------|    |----------------|
 Timestamp           Entropy
  10 chars           16 chars
   48bits             80bits
   base32             base32
```


--------------------------------------------------------------------------------

## Test

```sh
crystal spec
```


--------------------------------------------------------------------------------

## Contributing

1. Fork it (<https://github.com/SuperPaintman/ulid/fork>)
2. Create your feature branch (`git checkout -b feature/<feature_name>`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin feature/<feature_name>`)
5. Create a new Pull Request


--------------------------------------------------------------------------------

## Contributors

- [SuperPaintman](https://github.com/SuperPaintman) SuperPaintman - creator, maintainer


--------------------------------------------------------------------------------

## API
[Docs][docs-url]


--------------------------------------------------------------------------------

## Changelog
[Changelog][changelog-url]


--------------------------------------------------------------------------------

## License

[MIT][license-url]


[license-url]: LICENSE
[changelog-url]: CHANGELOG.md
[docs-url]: https://superpaintman.github.io/ulid/
[logo-image]: README/logo.png
[origin-lib-url]: https://github.com/alizain/ulid
[travis-image]: https://img.shields.io/travis/SuperPaintman/ulid/master.svg?label=linux
[travis-url]: https://travis-ci.org/SuperPaintman/ulid
[shards-image]: https://img.shields.io/github/tag/superpaintman/ulid.svg?label=shards
[shards-url]: https://github.com/superpaintman/ulid

