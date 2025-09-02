## 2.1.3

- fix: illegal percent encoding


## 2.1.2

- refactor: `payjoin-flutter` is not compatible with hyphens `-` symbol defined in the latest payjoin specification. To ensure retrocompatibility with `payjoin-flutter`, `bip21_uri` is returning the pj field with `+` sign.


## 2.1.1

- fix: regression on uppercase

## 2.1.0

- If `pj` is passed among the options of the query parameters, the package now process it as a payjoin Uri specified in BIP77 supporting both percent encoded or not, `+` and `-`. Keep the `#` encoded as `%23` and the Uri is uppercase.
- Payjoin unit tests

## 2.0.1
- Empty amount is decoded as null
- Empty message or label is decoded/encoded as empty
- Empty options are encoded/decoded

## 2.0.0

### Breaking Changes
- **Package renamed**: `dart_bip21` → `bip21_uri`
- **Model renamed**: `BIP21` → `Bip21Uri`
- **Amount type changed**: `num?` → `double?`
- **API restructured**: Complete rewrite of the codebase with new file structure

## 1.0.0

- Initial version.
