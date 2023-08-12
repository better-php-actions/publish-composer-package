# Publish a composer package in one step

Complete workflow for publishing semantic-versioned composer packages to [packagist.org](https://packagist.org/), built on top of [semantic-release](https://github.com/semantic-release/semantic-release).

## Usage

Create a basic workflow in ``.github/workflows/release.yml``:

```yaml
name: CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Publish a composer package
      uses: better-php-actions/publish-composer-package@v1
        with:
          package_slug: "your-package-slug"
          package_name: "Your Package Name"
```
## Versioning

This action is versioned using [semantic versioning](https://semver.org/). You can specify a major version (e.g. `v1`) or a minor version (e.g. `v1.1`) in your workflow file to ensure that your workflow won't break when a new patch version is released.
If you want to pin to a specific version, you can also specify a full version tag (e.g. `v1.1.0`).

## Configuration options

| Options          | Description                                          | Default                                |
|------------------|------------------------------------------------------|----------------------------------------|
| `package_slug`   | Package slug                                         | None. **You must set this explicitly** |
| `package_name`   | Package name                                         | None. **You must set this explicitly** |
| `with_gpg`       | Whether to use GPG to sign the commit                | `false`                                |
| `gpg_key`        | GPG private key                                      | None                                   |
| `gpg_passphrase` | GPG passphrase                                       | None                                   |
| `release_token`  | GitHub token of the user who will author the release | `github.token`                         |

### GPG signing

If you want to use GPG to sign the commit, you need to set `with_gpg` to `true` and provide the private key and passphrase in `gpg_key` and `gpg_passphrase` respectively.
We also advise to set the `release_token` to a [personal access token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) of the user who will author the release, as the default github user might not be the same as the one who created the GPG key.
Due to limitations of the `semantic-release` package, you need to set the `release_token` to a personal access token if you want to use GPG signing.

### Node.js caveats

If you don't build assets in your package, this action will automatically copy the `package.json` and `package-lock.json` templates needed for `actions/setup-node` and `semantic release` to the root of your project. The files won't be committed to your repository, but they will be used by the action.

If you do have package.json in your project, you need to ensure that all the dependencies needed by `semantic-release` are installed. The action will copy the `.releaserc` file automatically.

```bash
$ npm install -D semantic-release \
  @semantic-release/git \
  @semantic-release/changelog \
  @semantic-release/exec \
  @semantic-release/github
```
## Example

With GPG signing and custom release token:

```yaml
name: CI
jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    - name: Publish a composer package
      uses: better-php-actions/publish-composer-package@v1
        with:
          package_slug: "your-package-slug"
          package_name: "Your Package Name"
          with_gpg: true
          gpg_key: ${{ secrets.GPG_PRIVATE_KEY }}
          gpg_passphrase: ${{ secrets.GPG_PASSPHRASE }}
          release_token: ${{ secrets.PERSONAL_ACCESS_TOKEN }}
```

**Note:** _This Action automatically updates itself via [renovate](https://github.com/apps/renovate)_

